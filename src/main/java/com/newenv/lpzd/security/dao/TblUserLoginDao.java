package com.newenv.lpzd.security.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.security.domain.HRPermission;
import com.newenv.lpzd.security.domain.TblUserLogin;

public class TblUserLoginDao extends DaoParent<TblUserLogin>{
	
	/**
	 * @param userName
	 * @param strategy
	 * @return
	 */
	public 	TblUserLogin login(String userName,String strategy)  {
		TblUserLogin userLogin=null;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		//Query q =pm.newQuery(clazz);
		//q.setFilter(" username=='"+userName+"' && status==1 ");
		
		String sql=" select id ,username ,tbl_User_profile_id ,password from tbl_user_login where status=1 and username=? ";
		Query q =pm.newQuery("SQL",sql);
		//q.setFilter(" id=="+id);
		List<Object[]> list =(List<Object[]>) q.execute(userName);
		if(list!=null && list.size() >0){
			userLogin=new TblUserLogin();
			userLogin.setId(Integer.valueOf(list.get(0)[0]+""));
			userLogin.setUsername(list.get(0)[1]+"");
			userLogin.setTblUserProfileId(Integer.valueOf(list.get(0)[2]+""));
			userLogin.setPassword(list.get(0)[3]+"");
		}
		pm.close();
		return userLogin;
	}
	
	public List<HRPermission> getHRPermissions(String sysType,Integer userLoginId,String strategy){
		 List<HRPermission> list=new ArrayList<HRPermission>();
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL","SELECT  DISTINCT TBL_PERMISSION_ID  FROM TBL_HR_USER_HAS_TBL_PERMISSION WHERE (TBL_USER_ID = "+userLoginId+" AND SYS_TYPE = '"+sysType+"')");
		List<Integer> permIdList=(List<Integer>) query.execute();
		if(permIdList!=null && permIdList.size()>0){
			String permIds="";
			for(int i=0;i<permIdList.size();i++){
				permIds+=",'"+permIdList.get(i)+"'";
			}
			
			Query query2=pm.newQuery("SQL","" +
					"SELECT DISTINCT mn.SYS_TYPE, mn.CATEGORY, perm.PERMISSION_TYPE, perm.ID, mn.MENU_NAME FROM TBL_MENU mn "+
						" INNER JOIN TBL_MENU_RELATION_TBL_PERMISSION rel ON mn.ID = rel.TBL_MENU_ID "+
						" INNER JOIN TBL_PERMISSION perm ON rel.TBL_PERMISSION_ID = perm.ID "+
						" WHERE ((perm.ID IN ("+permIds.substring(1)+"))) ");
			
			List<Object[]> menuList=(List<Object[]>) query2.execute();
			if(menuList!=null && menuList.size()>0){
				for(int j=0;j<menuList.size();j++){
					HRPermission permission=new HRPermission();
					permission.setSysType(menuList.get(j)[0]+"");
					permission.setCategory(Integer.valueOf(menuList.get(j)[1]+""));
					permission.setPermType(menuList.get(j)[2]+"");
					permission.setPermId(Integer.valueOf(menuList.get(j)[3]+""));
					permission.setMenuName(menuList.get(j)[4]+"");
					list.add(permission);
				}
			}
		}
		pm.close();
		return list;
	}
	
	/**
	 * 获取某用户某岗位的权限。
	 * @param userId
	 * @param titleId
	 * @param strategy
	 * @return
	 */
	public List<HRPermission> getUserPermissions(Integer userId, Integer titleId, String strategy){
		String sql = "select p.id,p.permission_name from tbl_permission p,tbl_hr_user_has_tbl_permission up where p.id=up.tbl_Permission_id and up.tbl_user_id=? and p.sys_type='LPZD' "
					+ " union ALL " 
					+ " select p.id,p.permission_name from tbl_permission p,tbl_hr_title_has_tbl_permission tp where p.id=tp.tbl_Permission_id and tp.tbl_Title_id=? and p.sys_type='LPZD' "
					+ " union ALL " 
					+ " select p.id,p.permission_name from tbl_permission p,tbl_group_has_tbl_permission gp,tbl_group_has_tbl_user gu,tbl_group g where p.id=gp.tbl_Permission_id and gp.tbl_group_id=gu.tbl_group_id and gu.tbl_group_id=g.id and g.statuss=1 and gu.tbl_user_id=?" ;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL", sql);
		List<Object[]> objs = (List<Object[]>)query.execute(userId, titleId, userId);
		List<HRPermission> permissions=new ArrayList<HRPermission>();
		if(objs!=null){
			for(Object[] obj : objs){
				HRPermission permission=new HRPermission();
				permission.setPermId((Integer)obj[0]);
				permission.setMenuName((String)obj[1]);
				permissions.add(permission);
			}
		}
		pm.close();
		return permissions;
	}
	
	public List<Object[]> findAllTitleNamesByUsername(String userName, String strategy){
		String sql = "select cast(CONCAT(city.id,'.',dpt.id,'.',ttl.id) as char(50)),CONCAT(city.city_name,'.',dpt.department_name,'.',ttl.title_name) from xhj_jccity city, tbl_department dpt, tbl_title ttl, tbl_position pstn, tbl_user_Login ulogin where pstn.tbl_user_id=ulogin.id and pstn.tbl_title_id=ttl.id and city.id=dpt.CityID and dpt.id=pstn.tbl_department_id and ulogin.status=1 and ulogin.username=?";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL", sql);
		List<Object[]> objs = (List<Object[]>)query.execute(userName);
		pm.close();
		return objs;
	}
	
}
