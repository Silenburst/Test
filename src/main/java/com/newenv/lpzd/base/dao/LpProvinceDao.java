package com.newenv.lpzd.base.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.cloudplatform.InfoDirection;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.pagination.PageInfo;

public class LpProvinceDao  extends DaoParent<LpProvince>{

	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<LpProvince> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(LpProvince.class);
		query.setFilter("statuss==1");
		List<LpProvince> list = (List<LpProvince>)query.execute();
		pm.close();
		return list;
	}
	
	public List<LpProvince> findByCountryId(String cid,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(LpProvince.class);
		query.setFilter("cid=="+cid+ " && statuss==1");
		List<LpProvince> list = (List<LpProvince>)query.execute();
		pm.close();
		return list;
	}
	
	
	public PageInfo findByPage(PageInfo page, String strategy){
			
			StringBuffer sbCondition = new StringBuffer(" where 1==1 ");
	
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			pm.getFetchPlan().setMaxFetchDepth(2);
			
			Query query = pm.newQuery("select count(id) from " + LpProvince.class.getName() + sbCondition.toString());
		//	query.setUnique(true);
			long records = (Long)query.execute();
			page.setRecords((int)records);
			
			String jdql = "select from " + LpProvince.class.getName() + sbCondition.toString();
			query = pm.newQuery(jdql);
			
			query.setRange((page.getPage()-1)*page.getRows(), page.getPage()*page.getRows());
			page.setGridModel((List<LpProvince>)query.execute());
			pm.close();
			return page;
		}
	
	
	/**
	 * 查询省份名称
	 * 
	 * @param provinceId
	 * @return Object
	 */
	public Object getProvinceName(Integer provinceId) {
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery(LpProvince.class);
		query.setUnique(true);
		query.setFilter("id == " + provinceId);
		return query.execute();
	}
	
}
