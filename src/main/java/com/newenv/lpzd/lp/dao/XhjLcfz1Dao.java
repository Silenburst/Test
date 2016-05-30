package com.newenv.lpzd.lp.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.springframework.util.StringUtils;

import com.newenv.lpzd.lp.domain.XhjLcfz;
import com.newenv.lpzd.lp.domain.XhjLcfz1;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.pagination.PageInfo;
import com.newenv.base.bigdata.dao.DaoParent;

/**
 * 划盘(维护盘、范围盘)。
 * @author chenky
 *
 */
public class XhjLcfz1Dao extends DaoParent<XhjLcfz1>{
	
	private LpIndexTimer lpIndexTimer;
	
	public void saveBatch(XhjLcfz1 lcfz1, int[] ids, String strategy){
		XhjLcfz1 lcfz1Temp = null;
		Date now = new Date();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		for(int i=ids.length-1;i>=0;i--){
			int lpId = ids[i];
			if(!this.isExist(pm, lcfz1.getBmid(), lpId, lcfz1.getSta())){	//不存在才添加
				lcfz1Temp = new XhjLcfz1(Integer.valueOf(super.getNextSeqId(XhjLcfz1.class)) , lcfz1.getBmid(), lpId, lcfz1.getSta(), now);
				pm.makePersistent(lcfz1Temp);
				lpIndexTimer.offer(lpId);	//更新楼盘下的房源索引
			}
		}
		pm.close();
	}
	
	public void deleteBatch(int[] ids, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		//ids中下标是偶数的数据是表的id,下标是奇数的数据是楼盘id
		for(int i=0;i<ids.length;i+=2){
			this.delete(pm, ids[i]);
		}
		for(int i=1;i<ids.length;i+=2){
			lpIndexTimer.offer(ids[i]);	//更新楼盘下的房源索引
		}
		pm.close();
	}
	
	/**
	 * 删除楼盘，只修改状态。
	 */
	private void delete(PersistenceManager pm, Integer id){
		pm.newQuery("update " + XhjLcfz1.class.getName() + " set sta==0 where id==" + id).execute();
	}
	
	/**
	 * 获取某个部门的维护盘或范围盘。
	 * @param bmid	部门id
	 * @param sta 2：维护盘3：范围盘
	 * @return
	 */
	public List<XhjLcfz1> getLcfz1OfBm(int bmid, short sta, String strategy){
		String jdoql = "select from " + XhjLcfz1.class.getName() + " where bmid==" + bmid + " && sta==" + sta;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<XhjLcfz1> objs = (List<XhjLcfz1>)pm.newQuery(jdoql).execute();
		pm.close();
		return objs;
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门的id列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public List<Integer> getBmidsOfLcfc(int lpid, short sta, String strategy){
		String jdoql = "select bmid from " + XhjLcfz1.class.getName() + " where lpid==" + lpid + " && sta<=" + sta;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<Integer> ids = (List<Integer>)pm.newQuery(jdoql).execute();
		pm.close();
		return ids;
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门的id列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public List<Integer> getBmidsOfLcfc1(int lpid, short sta, String strategy){
		String jdoql = "select bmid from " + XhjLcfz1.class.getName() + " where lpid==" + lpid + " && sta==" + sta;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<Integer> ids = (List<Integer>)pm.newQuery(jdoql).execute();
		pm.close();
		return ids;
	}
	
	/**
	 * 复制店组方式，将一个组的权责盘信息复制到另一个组。
	 * @param fromBmId
	 * @param fromSta
	 * @param toBmId
	 * @param toSta
	 */
	public void copy(int fromBmId, short fromSta, int toBmId, short toSta, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		String jdoql = "select from " + XhjLcfz1.class.getName() + " where bmid==" + fromBmId + " && sta==" + fromSta;
		List<XhjLcfz1> lcfz1List = (List<XhjLcfz1>)pm.newQuery(jdoql).execute();
		Date now = new Date();
		for(XhjLcfz1 lcfz1 : lcfz1List){
			if(!this.isExist(pm, toBmId, lcfz1.getLpid(), toSta)){
				pm.makePersistent(new XhjLcfz1(Integer.valueOf(super.getNextSeqId(XhjLcfz1.class)), toBmId, lcfz1.getLpid(), toSta, now));
				lpIndexTimer.offer(lcfz1.getLpid());	//更新楼盘下的房源索引
			}
		}
		pm.close();
	}
	
	/**
	 * 相同的划盘信息是否存在。
	 * @param bmid
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public boolean isExist(int bmid, int lpid, short sta, String strategy){
		return this.isExist(getPersistenceManagerByStratey(strategy), bmid, lpid, sta);
	}
	
	public boolean isExist(PersistenceManager pm, int bmid, int lpid, short sta){
		String stats = "2";
		if(sta==3){
			stats = "2,3";
		}
		
		String sql = "select count(id) from xhj_lcfz_1 where bmid=" + bmid + " and lpid=" + lpid + " and sta in(" + stats + ") ";
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		long count = (Long)query.execute();
		return (count>0);
	}
	
	/**
	 * 查询一个楼盘划分的店组信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo query(PageInfo pager, XhjLcfz1 lcfz1, String strategy){
		String sql = "select a.bmid,b.department_name,a.id from xhj_lcfz_1 a, tbl_department b ";
		String condition = " where a.bmid=b.id ";
		if(lcfz1.getLpid()!=null){
			condition += " and a.lpid=" + lcfz1.getLpid();
		}
		if(lcfz1.getSta()!=null){
			condition += " and a.sta=" + lcfz1.getSta();
		}
		if(StringUtils.hasText(lcfz1.getBmName())){
			condition += " and b.department_name like '%" + lcfz1.getBmName() + "%' ";
		}
		sql += condition + " order by b.department_name";
		String csql = "select count(*) from xhj_lcfz_1 a, tbl_department b " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息.
	 * @param pager
	 * @param lcfz1
	 * @return
	 */
	public PageInfo getLcfc1OfBmForCopy(PageInfo pager, XhjLcfz1 lcfz1, String strategy){
		String sql = "select a.id,a.lpid,b.lp_name,c.sq_Name from xhj_lcfz_1 a, xhj_lpxx b, xhj_jcsq c ";
		String condition = " where a.lpid=b.id and b.SQ_ID=c.id and bmid=" + lcfz1.getBmid() + " and a.sta=" + lcfz1.getSta();
		sql += condition;
		if(StringUtils.hasText(pager.getSidx())){
			sql += " order by " + pager.getSidx() + " " + pager.getSord();
		}
		String csql = "select count(*) from xhj_lcfz_1 a, xhj_lpxx b, xhj_jcsq c " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz1
	 * @return
	 */
	public PageInfo getLcfc1OfBm(PageInfo pager, XhjLcfz1 lcfz1, String strategy){
		String sql = "select a.id,a.lpid,b.lp_name from xhj_lcfz_1 a, xhj_lpxx b ";
		String condition = " where a.lpid=b.id and bmid=" + lcfz1.getBmid() + " and a.sta=" + lcfz1.getSta();
		if(StringUtils.hasText(lcfz1.getLpName())){
			condition += " and b.lp_name like '%" + lcfz1.getLpName() + "%' ";
		}
		sql += condition + " order by a.id desc ";
		String csql = "select count(*) from xhj_lcfz_1 a, xhj_lpxx b " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}

	public LpIndexTimer getLpIndexTimer() {
		return lpIndexTimer;
	}

	public void setLpIndexTimer(LpIndexTimer lpIndexTimer) {
		this.lpIndexTimer = lpIndexTimer;
	}

	public void saveWeih(String lpid, String sta, String source,
			String addZrService, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			Query query =pm.newQuery(XhjLcfz1.class);
			query.setFilter(" sta == " + sta+ " && lpid ==" + lpid + " && bmid==" + addZrService);
			List<XhjLcfz1> list = (List<XhjLcfz1>)query.execute();
			if(list == null || list.size() == 0) {
				XhjLcfz1 xhjLcfz = new XhjLcfz1();
				xhjLcfz.setLpid(Integer.valueOf(lpid));
				xhjLcfz.setBmid(Integer.valueOf(addZrService));
				xhjLcfz.setSta(Short.valueOf(sta));
				xhjLcfz.setSource(source);
				xhjLcfz.setCreateDate(new Date());
				pm.makePersistent(xhjLcfz);
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
	/**
	 * 修改维护盘信息
	 * @param relational
	 * @throws Exception 
	 */
	public void updWeih(String lpid, String bmid, String source, String lppid,
			String sta, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLcfz1 oldLcfz = pm.getObjectById(XhjLcfz1.class, Integer.parseInt(lppid));
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			if(!oldLcfz.getBmid().equals(bmid)) {
				Query query =pm.newQuery(XhjLcfz1.class);
				query.setFilter(" bmid =="+bmid+" && sta==1 && lpid ==" + Integer.parseInt(lpid));
				List<XhjLcfz1> list = (List<XhjLcfz1>)query.execute();
				if(list == null || list.size() == 0) {
					oldLcfz.setBmid(Integer.valueOf(bmid));
					oldLcfz.setSource(source);
					oldLcfz.setSta(Short.valueOf(sta));
					pm.makePersistent(oldLcfz);
				} else {
					String errorName = "";
					if("2".equals(sta)) {
						errorName = "维护盘";
					} else {
						errorName = "范围盘";
					}
					throw new Exception(errorName + "已存在当前店组,请重新选择!");
				}
			} else {
				oldLcfz.setSource(source);
				oldLcfz.setSta(Short.valueOf(sta));
				pm.makePersistent(oldLcfz);
			}
			tx.commit();
			lpIndexTimer.offer(Integer.valueOf(lpid));	//更新楼盘下的房源索引
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
	/**
	 * 删除
	 * @param lppid
	 * @param relational
	 */
	public void deleteLpFuzh(String lppid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLcfz1 oldLcfz = pm.getObjectById(XhjLcfz1.class, Integer.parseInt(lppid));
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			oldLcfz.setSta(Short.valueOf("0"));
			pm.makePersistent(oldLcfz);
			tx.commit();
			lpIndexTimer.offer(Integer.valueOf(lppid));	//更新楼盘下的房源索引
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
}
