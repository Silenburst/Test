package com.newenv.lpzd.lp.dao;

import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.springframework.util.StringUtils;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.GeoUtils;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhan;
import com.newenv.lpzd.lp.domain.XhjLplinkxianlu;
import com.newenv.lpzd.lp.domain.XhjLpxx;

public class XhjLplinkxianluDao extends DaoParent<XhjLplinkxianlu>{
	
	public void saveLpZhan(String lpid, String zhanids, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			XhjLpxx lpxx = pm.getObjectById(XhjLpxx.class, Integer.valueOf(lpid));
			String[] ids = zhanids.split(",");
			for (int i = 0; i < ids.length; i++) {
				Query query =pm.newQuery(XhjLplinkxianlu.class);
				query.setFilter(" xhjLpxx.id =="+lpid+" && xhjLpjiaotongzhan.id ==" + Integer.parseInt(ids[i]));
				List<XhjLplinkxianlu> list = (List<XhjLplinkxianlu>)query.execute();
				if(list == null || list.size() == 0) {
					XhjLplinkxianlu lpxl = new XhjLplinkxianlu();
					XhjLpjiaotongzhan zhan = pm.getObjectById(XhjLpjiaotongzhan.class, Integer.valueOf(ids[i]));
					lpxl.setXhjLpxx(lpxx);
					lpxl.setXhjLpjiaotongzhan(zhan);
					lpxl.setDistance(computeLpToZhanDistance(pm, lpid, ids[i]));
					pm.makePersistent(lpxl);
				}
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw e;
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}

	public List<Object[]> showLpZhan(String lpid, String relational) {
		String sql = "select DISTINCT l.zhanid,zdname,x.XianLu_Name from XHJ_LpLinkXianlu l left join xhj_lpjiaotongzhan z on l.zhanid=z.ID "
				+ " left join xhj_lpjiaotongzhantoxian zs on zs.ZhanID=z.ID left join Xhj_LpJiaoTongXian x on zs.XianID=x.ID where lpid=" + lpid;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	/**
	 * 删除对应地铁线
	 * @param lpid
	 * @param zhanid
	 * @param relational
	 */
	public String showLpZhan(String lpid, String zhanid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query =pm.newQuery(XhjLplinkxianlu.class);
		query.setFilter(" xhjLpxx.id =="+lpid+" && xhjLpjiaotongzhan.id ==" + zhanid);
		List<XhjLplinkxianlu> list = (List<XhjLplinkxianlu>)query.execute();
		String zhanName = "";
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			XhjLplinkxianlu xhjLplinkxianlu = (XhjLplinkxianlu) iterator.next();
			if("".equals(zhanName)) {
				zhanName = xhjLplinkxianlu.getXhjLpjiaotongzhan().getZdName();
			}
			pm.deletePersistent(xhjLplinkxianlu);
		}
		pm.close();
		return zhanName;
	}
	
	/**
	 * 计算楼盘与站点的距离。
	 * @param pm
	 * @param lpid
	 * @param zhanid
	 * @return
	 */
	private Double computeLpToZhanDistance(PersistenceManager pm, String lpid, String zhanid){
		String lpXYSQL = "select x,y from xhj_lpxx where id=" + lpid;
		Query query = pm.newQuery("SQL", lpXYSQL);
		query.setUnique(true);
		Object[] lpXY = (Object[])query.execute();
		String schoolXYSQL = "select x,y from xhj_lpjiaotongzhan where id=" + zhanid;
		query = pm.newQuery("SQL", schoolXYSQL);
		query.setUnique(true);
		Object[] zhaoXY = (Object[])query.execute();
		if(lpXY!=null && lpXY[0]!=null && lpXY[1]!=null && zhaoXY!=null && zhaoXY[0]!=null && zhaoXY[1]!=null && !"".equals(lpXY[0]) && !"".equals(lpXY[1]) && !"".equals(zhaoXY[0]) && !"".equals(zhaoXY[1])){
			return GeoUtils.getDistance((Double)lpXY[0], (Double)lpXY[1], Double.parseDouble((String)zhaoXY[0]), Double.parseDouble((String)zhaoXY[1]));
		} else {
			return null;
		}
	}

}
