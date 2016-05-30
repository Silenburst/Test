package com.newenv.lpzd.security.dao;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.security.domain.TblUserProfile;

public class TblUserProfileDao extends DaoParent<TblUserProfile>{
	
	public TblUserProfile getObjectById(Integer id, String strategy){
		TblUserProfile userProfile=null;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		//Query q =pm.newQuery(clazz);
		//q.setFilter(" id=="+id+"  &&  status==1 ");
		String sql=" select id ,fullname ,tbl_department_id, tbl_title from tbl_user_profile where id="+id;
		Query q =pm.newQuery("SQL",sql);
		q.setUnique(true);
		Object[] obj = (Object[])q.execute();
		if(obj!=null){
			userProfile=new TblUserProfile();
			userProfile.setId(Integer.valueOf(obj[0]+""));
			userProfile.setFullname(obj[1]+"");
			userProfile.setTblDepartmentId(Integer.valueOf(obj[2]+""));
			userProfile.setTblTitle(Integer.valueOf(obj[3]+""));
		}
		pm.close();
		return userProfile;
	}
	
	public List<TblUserProfile> getUserProfilesByDepartmentId(int departmentId, String strategy) {
		String sql = "select up.id,up.fullname from tbl_user_profile up, tbl_user_login ul ,tbl_position p, tbl_department d where up.id=ul.tbl_user_profile_id and p.tbl_user_id=ul.id and p.tbl_department_id=d.id and d.id="+departmentId;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		
		List<TblUserProfile> users = new ArrayList<TblUserProfile>();
		if(objs!=null){
			TblUserProfile u = null;
			for(Object[] obj : objs){
				u = new TblUserProfile();
				u.setId((Integer)obj[0]);
				u.setFullname((String)obj[1]);
				users.add(u);
			}
		}
		pm.close();
		return users;
	}
	
}