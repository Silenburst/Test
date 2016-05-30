package com.newenv.lpzd.base.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.XhjJcsq;

public class XhjJcsqDao  extends DaoParent<XhjJcsq>{

	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<XhjJcsq> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJcsq.class);
		query.setFilter("statuss==1");
		List<XhjJcsq> list = (List<XhjJcsq>)query.execute();
		pm.close();
		return list;
	}
	
	public List<XhjJcsq> findByQyid(String qyid,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJcsq.class);
		query.setFilter("qyId=="+qyid + " && status==1");
		List<XhjJcsq> list = (List<XhjJcsq>)query.execute();
		pm.close();
		return list;
	}
	
	/**
	 * 查询商圈名称
	 * 
	 * @param sqId
	 * @return Object
	 */
	public Object getShangQuanName(String sqId) {
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery(XhjJcsq.class);
		query.setUnique(true);
		query.setFilter("id == " + sqId);
		return query.execute();
	}
}
