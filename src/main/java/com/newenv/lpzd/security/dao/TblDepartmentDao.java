package com.newenv.lpzd.security.dao;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import org.springframework.util.StringUtils;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.service.SecurityUserHolder;

public class TblDepartmentDao extends DaoParent<TblDepartment>{

	public TblDepartment getObjectById(Integer id, String strategy){
			TblDepartment userProfile=null;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		String sql=" select id ,department_name ,CityID from tbl_department where id="+id;
		Query q =pm.newQuery("SQL",sql);
		q.setUnique(true);
		Object[] obj = (Object[])q.execute();
		if(obj!=null){
			userProfile=new TblDepartment();
			userProfile.setId(Integer.valueOf(obj[0]+""));
			userProfile.setDepartmentName(obj[1]+"");
			userProfile.setCityId(Integer.valueOf(obj[2]+""));
		}
		pm.close();
		return userProfile;
	}
	
	public List<TblDepartment> findDepartmentByOrgIdAndBlurDeparmentQuery(Integer organizationId, String departmentStr, String strategy) {
		String sql = "select id,department_name from tbl_department where flag=1 and cityId=" + SecurityUserHolder.getCurrentUserLogin().getCityId();
		if(organizationId!=null)
			sql += " and tbl_organization_id="+organizationId;
		if(StringUtils.hasText(departmentStr))
			sql += " and department_name like '%"+departmentStr+"%'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		
		List<TblDepartment> list = new ArrayList<TblDepartment>();
		for(Object[] obj : objs){
			list.add(new TblDepartment((Integer)obj[0], (String)obj[1]));
		}
		pm.close();
		return list;
	}
	
	public List<TblDepartment> findDepartmentByOrgIdAndDeparmentIDs(int organizationId, List<Integer> departmentIDs, String strategy) {
		String sids = "";
		for(Integer id : departmentIDs){
			sids += "," + id;
		}
		String sql = "select id,department_name from tbl_department where tbl_organization_id="+organizationId + " and id in(" + sids.substring(1) + ") ";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		
		 
		List<TblDepartment> list = new ArrayList<TblDepartment>();
		for(Object[] obj : objs){
			list.add(new TblDepartment((Integer)obj[0], (String)obj[1]));
		}
		pm.close();
		return list;
	}

	public List<Object[]> queryDepartAddress(Integer deptId, String relational) {
		String sql = "select parent_id from tbl_department where id=" + deptId;
		String parentid = ((List<Object>)getPersistenceManagerByStratey(relational).newQuery("SQL", sql).execute()).get(0).toString();
		sql = "select address,telephone from tbl_department where id=" + parentid;
		PersistenceManager pm=getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
}
