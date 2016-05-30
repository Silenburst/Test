package com.newenv.lpzd.lp.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.springframework.util.StringUtils;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.GeoUtils;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLplinkshool;

public class XhjLplinkshoolDao extends DaoParent<XhjLplinkshool>{

	public void saveLpSchool(String lpid, String dongIds, String dongNames, 
			String ids, String names, String schoolid, String schoolType, String relational) throws Exception{
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			if(dongIds != null && !"".equals(dongIds)) {
				Query query =pm.newQuery(XhjLplinkshool.class);
				query.setFilter(" type == 1 && schoolid ==" + Integer.valueOf(schoolid) + " && lpid ==" + Integer.parseInt(lpid));
				List<XhjLplinkshool> list = (List<XhjLplinkshool>)query.execute();
				if(list == null || list.size() == 0) {
					XhjLplinkshool lplinkshool = new XhjLplinkshool();
					lplinkshool.setLpid(Integer.valueOf(lpid));
					lplinkshool.setFhid(dongIds);
					lplinkshool.setSchoolid(Integer.valueOf(schoolid));
					lplinkshool.setSchooltype(Integer.valueOf(schoolType));
					lplinkshool.setDname(dongNames);
					lplinkshool.setType((short) 1);
					lplinkshool.setDistance(computeLpToSchoolDistance(pm, lpid, schoolid));
					pm.makePersistent(lplinkshool);
				} else {
					throw new Exception("该学校已存在学区房记录,请在修改页面进行操作!");
				}
			};
			if(ids != null && !"".equals(ids)) {
				Query query =pm.newQuery(XhjLplinkshool.class);
				query.setFilter(" type == 2 && schoolid ==" + Integer.valueOf(schoolid) + " && lpid ==" + Integer.parseInt(lpid));
				List<XhjLplinkshool> list = (List<XhjLplinkshool>)query.execute();
				if(list == null || list.size() == 0) {
					XhjLplinkshool lplinkshool = new XhjLplinkshool();
					lplinkshool.setLpid(Integer.valueOf(lpid));
					lplinkshool.setSchoolid(Integer.valueOf(schoolid));
					lplinkshool.setSchooltype(Integer.valueOf(schoolType));
					lplinkshool.setFhid(ids);
					lplinkshool.setDname(names);
					lplinkshool.setType((short) 2);
					lplinkshool.setDistance(computeLpToSchoolDistance(pm, lpid, schoolid));
					pm.makePersistent(lplinkshool);
				} else {
					throw new Exception("该学校已存在学位房记录,请在修改页面进行操作!");
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

	public void updLpSchool(String id, String schoolid, String schoolType,String dongIds, String dongNames, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLplinkshool school = pm.getObjectById(XhjLplinkshool.class, Integer.valueOf(id));
		school.setSchoolid(Integer.valueOf(schoolid));
		school.setSchooltype(Integer.valueOf(schoolType));
		school.setFhid(dongIds);
		school.setDname(dongNames);
		school.setDistance(computeLpToSchoolDistance(pm, String.valueOf(school.getLpid()), schoolid));
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			pm.makePersistent(school);
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
	 * 删除某学校划分记录
	 * @param lpsid
	 * @param relational
	 */
	public void deleteLpSchool(Integer lpsid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLplinkshool dany = pm.getObjectById(XhjLplinkshool.class, Integer.valueOf(lpsid));
		if(dany != null) {
			pm.deletePersistent(dany);
		}
		pm.close();
	}
	
	/**
	 * 计算楼盘与学校的距离。
	 * @param pm
	 * @param lpid
	 * @param schoolid
	 * @return
	 */
	private Double computeLpToSchoolDistance(PersistenceManager pm, String lpid, String schoolid){
		String lpXYSQL = "select x,y from xhj_lpxx where id=" + lpid;
		Query query = pm.newQuery("SQL", lpXYSQL);
		query.setUnique(true);
		Object[] lpXY = (Object[])query.execute();
		String schoolXYSQL = "select mapXY from xhj_lpschool where id=" + schoolid;
		query = pm.newQuery("SQL", schoolXYSQL);
		query.setUnique(true);
		String schoolXY = (String)query.execute();
		if(lpXY!=null && lpXY[0]!=null && lpXY[1]!=null && StringUtils.hasText(schoolXY)){
			String[] arraySchoolXY = schoolXY.split(",");
			return GeoUtils.getDistance((Double)lpXY[0], (Double)lpXY[1], Double.parseDouble(arraySchoolXY[0]), Double.parseDouble(arraySchoolXY[1]));
		} else {
			return null;
		}
	}
}
