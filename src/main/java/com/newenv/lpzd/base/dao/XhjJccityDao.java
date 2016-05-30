package com.newenv.lpzd.base.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;

public class XhjJccityDao  extends DaoParent<XhjJccity>{

	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<XhjJccity> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJccity.class);
		query.setFilter("statuss==1");
		List<XhjJccity> list =  (List<XhjJccity>)query.execute();
		pm.close();
		return list;
	}
	
	public List<XhjJccity> findByProvinceId(String provinceid,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjJccity.class);
		if(provinceid!=null&&!"".equals(provinceid)){
			query.setFilter("provinceid=="+provinceid + " && statuss==1");
		}else{
			query.setFilter("statuss==1");
		}
		List<XhjJccity> list =  (List<XhjJccity>)query.execute();
		pm.close();
		return list;
	}
	
	/**
	 * 获取城市的国家、省份信息。
	 * @param cityId
	 * @return
	 */
	public Integer[] getCityParentInfo(Integer cityId, String strategy){
		String sql = "select b.id cid,c.id pid from xhj_jccity a, lp_country b, lp_province c where a.provinceid=c.id and c.cid=b.id and a.id=" + cityId;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Integer[] ids = new Integer[2];
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		Object[] info = (Object[])query.execute();
		ids[0] = (Integer)info[0];
		ids[1] = (Integer)info[1];
		pm.close();
		return ids;
	}
	
	/**
	 * 查询某城市的交通线。
	 * @param cityId
	 * @param strategy
	 * @return
	 */
	public List<XhjLpjiaotongxian> jiaotongxian(Integer cityId, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjLpjiaotongxian.class); 
		query.setFilter(" cityID==" + cityId + " && statuss==1 ");
		List<XhjLpjiaotongxian> jtxs = (List<XhjLpjiaotongxian>)query.execute();
		pm.close();
		return jtxs;
	}
	
	
	/**
	 * 查询城市名称
	 * 
	 * @param cityId
	 * @return Object
	 */
	public Object getCityName(String cityId) {
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery(XhjJccity.class);
		query.setUnique(true);
		query.setFilter("id == " + cityId);
		return query.execute();
	}
}
