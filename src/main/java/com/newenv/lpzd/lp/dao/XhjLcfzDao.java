package com.newenv.lpzd.lp.dao;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.springframework.util.StringUtils;

import com.newenv.lpzd.lp.domain.XhjLcfz;
import com.newenv.lpzd.lp.domain.XhjLcfz1;
import com.newenv.lpzd.lp.domain.XhjLplinkshool;
import com.newenv.pagination.PageInfo;
import com.newenv.base.bigdata.dao.DaoParent;

/**
 * 划盘(责任盘)。
 * @author chenky
 *
 */
public class XhjLcfzDao extends DaoParent<XhjLcfz> {

	private LpIndexTimer lpIndexTimer;
	private XhjLcfz1Dao xhjLcfz1Dao;
	
	/**
	 * 复制店组方式，将一个组的权责盘信息复制到另一个组。
	 * @param fromBmId
	 * @param toBmId
	 */
	public void copy(int fromBmId, int toBmId, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		String jdoql = "select from " + XhjLcfz.class.getName() + " where bmid==" + fromBmId + " && sta==1 order by lpid, did ";
		Query query = pm.newQuery(jdoql);
		List<XhjLcfz> lcfzList = (List<XhjLcfz>)query.execute();
		Date now = new Date();
		int lastLpId = 0;
		for(XhjLcfz lcfz : lcfzList){
			if(!this.isExist(toBmId, lcfz.getLpid(), lcfz.getDid(), strategy)){
				this.save(pm, new XhjLcfz(toBmId, lcfz.getLpid(), (short)1, lcfz.getDid(), now), lastLpId!=lcfz.getLpid());
				lastLpId = lcfz.getLpid();
			}
		}
		pm.close();
	}
	
	/**
	 * 批量划盘。
	 * @param lcfz
	 * @param ldIds
	 */
	public void saveBatch(XhjLcfz lcfz, String[] ldIds, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLcfz lcfzTemp = null;
		Date now = new Date();
		int[] lds = null;
		int lastLpid = 0;	//最后一次处理的楼盘ID,用于判断是否在处理一个新楼盘
		for(int i=ldIds.length-1;i>=0;i--){
			lds = parseLpAndDid(ldIds[i]);
			if(!this.isExist(lcfz.getBmid(), lds[0], lds[1], strategy)){	//不存在才添加
				lcfzTemp = new XhjLcfz(lcfz.getBmid(), lds[0], lcfz.getSta(), lds[1], now);
				this.save(pm, lcfzTemp, lastLpid!=lds[0]);
				if(lastLpid!=lds[0])
					lpIndexTimer.offer(lds[0]);	//更新楼盘下的房源索引
			}
			lastLpid = lds[0];
		}
		pm.close();
	}
	
	/**
	 * 添加划盘信息。
	 * @param lcfz
	 * @param isNewLp　此标识用于判断是否需要向房源划分表中插入数据
	 * @return
	 */
	public Serializable save(XhjLcfz lcfz, boolean isNewLp, String strategy){
		super.save(lcfz, strategy);
		return lcfz.getId();
	}
	
	/**
	 * 保存所选责任盘小区栋座 id到责任盘表 xhj_lcfz,同时保存小区id至维范维盘表 xhj_lcfz_1作为所选店组维护盘（判断是否重复）.
	 * @param lcfz
	 * @param isNewLp　此标识用于判断是否需要向房源划分表中插入数据
	 * @return
	 */
	private Serializable save(PersistenceManager pm, XhjLcfz lcfz, boolean isNewLp){
		if(isNewLp && !xhjLcfz1Dao.isExist(pm, lcfz.getBmid(), lcfz.getLpid(), (short)2)){
			XhjLcfz1 ccfz1 = new XhjLcfz1(lcfz.getBmid(), lcfz.getLpid(), (short)2, lcfz.getCreateDate());
			pm.makePersistent(ccfz1);
		}
		pm.makePersistent(lcfz);
		return lcfz.getId();
	}
	
	/**
	 * 获取责任盘下的责任栋。
	 * @param bmid
	 * @param lpid
	 * @return
	 */
	public List<Object[]> getLcfzDongOfLp(int bmid, int lpid, String strategy){
		String sql = "select id,lpd_name from xhj_lpdong where id in(select did from xhj_lcfz where bmid=" + bmid + " and lpid=" + lpid + " and sta=1)";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		return (List<Object[]>)pm.newQuery("SQL",sql).execute();
	}
	
	/**
	 * 获取对栋座具有责任权限的部门列表。
	 * @param dids  
	 * @return [[did, bmid],[did, bmid],..]
	 */
	public List<Integer[]> getBmidsOfLcfc(Integer[] dids, String strategy){
		String sdids = "";
		for(Integer id : dids){
			sdids += "," + id;
		}
		String sql = "select did, bmid from xhj_lcfz where did in( " + sdids.substring(1) + " ) and sta=1";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<Integer[]> ids = (List<Integer[]>)pm.newQuery("SQL",sql).execute();
		pm.close();
		return ids;
	}
	
	/**
	 * 相同的划盘信息是否存在。
	 * @param bmid
	 * @param lpid
	 * @param did
	 * @return
	 */
	public boolean isExist(int bmid, int lpid, int did, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		boolean exist = this.isExist(pm, bmid, lpid, did);
		pm.close();
		return exist;
	}
	
	/**
	 * 相同的划盘信息是否存在。
	 * @param bmid
	 * @param lpid
	 * @param did
	 * @return
	 */
	private boolean isExist(PersistenceManager pm, int bmid, int lpid, int did){
		String jdoql = "select count(id) from " + XhjLcfz.class.getName() + " where bmid==" + bmid + " && lpid==" + lpid + " && did==" + did + " && sta==1 ";
		Query query = pm.newQuery(jdoql);
		query.setUnique(true);
		long count = (Long)query.execute();
		return (count>0);
	}
	
	/**
	 * 移除某个部门针对某个楼盘的责任。
	 * @param bmid
	 * @param lpid
	 */
	public void delete(int bmid, int lpid, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		this.delete(pm, bmid, lpid);
		pm.close();
	}
	
	/**
	 * 移除某个部门针对某个楼盘的责任。
	 * @param bmid
	 * @param lpid
	 */
	private void delete(PersistenceManager pm, int bmid, int lpid){
		String jdoql = "update " + XhjLcfz.class.getName() + " set sta==0 where bmid==" + bmid + " && lpid==" + lpid;
		pm.newQuery(jdoql).execute();
	}
	
	public void deleteBatch(XhjLcfz lcfz, Integer[] ids, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		for(int lpId : ids){
			this.delete(pm, lcfz.getBmid(), lpId);
			lpIndexTimer.offer(lpId);	//更新楼盘下的房源索引
		}
		pm.close();
	}
	
	public void deleteBatch(Integer lpId, Integer[] ids, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		for(int bmId : ids){
			this.delete(pm, bmId, lpId);
		}
		lpIndexTimer.offer(lpId);	//更新楼盘下的房源索引 
		pm.close();
	}
	
	/**
	 * 查询一个楼盘划分的店组信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo query(PageInfo pager, XhjLcfz lcfz, String strategy){
		String sql = "select distinct b.id,b.department_name from xhj_lcfz a, tbl_department b ";
		String condition = " where a.bmid=b.id and a.sta=1 and b.flag=1 ";
		if(lcfz.getLpid()!=null){
			condition += " and a.lpid=" + lcfz.getLpid();
		}
		if(StringUtils.hasText(lcfz.getBmName())){
			condition += " and b.department_name like '%" + lcfz.getBmName() + "%' ";
		}
		sql += condition + " order by b.department_name";
		String csql = "select count(*) from from xhj_lcfz a, tbl_department b " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo getLcfcOfBmForCopy(PageInfo pager, XhjLcfz lcfz, String strategy){
		String sql = "select distinct b.id,b.lp_name,a.bmid,c.sq_Name from xhj_lcfz a, xhj_lpxx b, xhj_jcsq c where a.lpid=b.id and b.SQ_ID=c.id and bmid=" + lcfz.getBmid() + " and a.sta=" + lcfz.getSta();
		if(StringUtils.hasText(pager.getSidx())){
			sql += " order by " + pager.getSidx() + " " + pager.getSord();
		}
		String csql = "select count(distinct b.id,b.lp_name,a.bmid,c.sq_Name) from xhj_lcfz a, xhj_lpxx b, xhj_jcsq c where a.lpid=b.id and b.SQ_ID=c.id and bmid=" + lcfz.getBmid() + " and a.sta=" + lcfz.getSta();
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo getLcfcOfBm(PageInfo pager, XhjLcfz lcfz, String strategy){
		String sql = "select distinct b.id,b.lp_name,a.bmid from xhj_lcfz a, xhj_lpxx b " ;
		String condition = " where a.lpid=b.id and bmid=" + lcfz.getBmid() + " and a.sta=" + lcfz.getSta();
		if(StringUtils.hasText(lcfz.getLpName())){
			condition += " and b.lp_name like '%" + lcfz.getLpName() + "%' ";
		}
		sql += condition + " order by a.id desc ";
		String csql = "select count(distinct b.id,b.lp_name,a.bmid) from xhj_lcfz a, xhj_lpxx b " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	/**
	 * 
	 * @param ld
	 * @return
	 */
	private int[] parseLpAndDid(String ld){
		String[] lds = ld.split("#");
		int[] result = new int[2];
		result[0] = Integer.parseInt(lds[0]);
		result[1] = Integer.parseInt(lds[1]);
		return result;
	}

	public LpIndexTimer getLpIndexTimer() {
		return lpIndexTimer;
	}

	public void setLpIndexTimer(LpIndexTimer lpIndexTimer) {
		this.lpIndexTimer = lpIndexTimer;
	}

	public void saveZeren(String lpid, String sta, String source, String addZrService,
			String dongIds, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			String[] dids = dongIds.split(",");
			for (int i = 0; i < dids.length; i++) {
				Query query =pm.newQuery(XhjLcfz.class);
				query.setFilter(" sta == 1 && did ==" + dids[i] + " && lpid ==" + lpid + " && bmid==" + addZrService+ "&& source =="+source);
				List<XhjLcfz> list = (List<XhjLcfz>)query.execute();
				if(list == null || list.size() == 0) {
					XhjLcfz xhjLcfz = new XhjLcfz();
					xhjLcfz.setLpid(Integer.valueOf(lpid));
					xhjLcfz.setBmid(Integer.valueOf(addZrService));
					xhjLcfz.setDid(Integer.valueOf(dids[i]));
					xhjLcfz.setSource(source);
					xhjLcfz.setSta(Short.valueOf(sta));
					xhjLcfz.setCreateDate(new Date());
					pm.makePersistent(xhjLcfz);
				}
			};
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
	 * 修改责任盘
	 * @param relational
	 */
	public void updZeren(String lpid, String bmid, String source,
			String dongIds, String lppid, String relational) throws Exception{
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			String[] dids = dongIds.split(",");
			XhjLcfz oldLcfz = pm.getObjectById(XhjLcfz.class, Integer.parseInt(lppid));
			
			Query query =pm.newQuery(XhjLcfz.class);
			query.setFilter(" sta == 1 && lpid ==" + oldLcfz.getLpid() + " && bmid==" + oldLcfz.getBmid());
			List<XhjLcfz> list = (List<XhjLcfz>)query.execute();
			pm.deletePersistentAll(list);
//			if(list != null && list.size() > 0) {
//				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
//					XhjLcfz xhjLcfz = (XhjLcfz) iterator.next();
//					pm.deletePersistent(xhjLcfz);
//				}
//			}
			for (int i = 0; i < dids.length; i++) {
					XhjLcfz xhjLcfz = new XhjLcfz();
					xhjLcfz.setLpid(Integer.valueOf(lpid));
					xhjLcfz.setBmid(Integer.valueOf(bmid));
					xhjLcfz.setDid(Integer.valueOf(dids[i]));
					xhjLcfz.setSource(source);
					xhjLcfz.setSta(Short.valueOf("1"));
					xhjLcfz.setCreateDate(new Date());
					pm.makePersistent(xhjLcfz);
			};
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
	 * 删除责任盘信息
	 * @param lpid
	 * @param bmid
	 * @param lppid
	 * @param relational
	 */
	public void deleteLpFuzh(String lpid, String bmid, String relational) throws Exception{
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			Query query =pm.newQuery(XhjLcfz.class);
			query.setFilter(" sta == 1 && lpid ==" + lpid + " && bmid==" + bmid);
			List<XhjLcfz> list = (List<XhjLcfz>)query.execute();
			if(list != null && list.size() > 0) {
				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					XhjLcfz xhjLcfz = (XhjLcfz) iterator.next();
					xhjLcfz.setSta(Short.valueOf("0"));
					pm.makePersistent(xhjLcfz);
				}
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

	public XhjLcfz1Dao getXhjLcfz1Dao() {
		return xhjLcfz1Dao;
	}

	public void setXhjLcfz1Dao(XhjLcfz1Dao xhjLcfz1Dao) {
		this.xhjLcfz1Dao = xhjLcfz1Dao;
	}
	
}
