package com.newenv.lpzd.base.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.pagination.PageInfo;

public class XhjJcstressDao  extends DaoParent<XhjJcstress>{

	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<XhjJcstress> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJcstress.class);
		query.setFilter("status==1");
		List<XhjJcstress> list = (List<XhjJcstress>)query.execute();
		pm.close();
		return list;
	}
	
	public List<XhjJcstress> findByCityId(String cityId,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJcstress.class);
		query.setFilter("status ==1 && cityId=="+cityId);
		List<XhjJcstress> list = (List<XhjJcstress>)query.execute();
		pm.close();
		return list;
	}
	
	/**
	 * 查询区域名称
	 * 
	 * @param qyId
	 * @return Object
	 */
	public Object getQuYuName(String qyId) {
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery(XhjJcstress.class);
		query.setUnique(true);
		query.setFilter("id == " + qyId);
		return query.execute();
	}
}
