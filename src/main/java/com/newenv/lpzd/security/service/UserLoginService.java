package com.newenv.lpzd.security.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSON;
import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.XhjJccityDao;
import com.newenv.lpzd.security.dao.TblDepartmentDao;
import com.newenv.lpzd.security.dao.TblUserLoginDao;
import com.newenv.lpzd.security.dao.TblUserProfileDao;
import com.newenv.lpzd.security.domain.HRPermission;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.domain.TblUserLogin;
import com.newenv.lpzd.security.domain.TblUserProfile;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.utils.NewenvCollectionUtil;
import com.opensymphony.xwork2.ActionContext;

public class UserLoginService {
	//hr 权限请求系统类型
	private  String sysType;
	//hr 权限请求地址
	private  String hrPermissionUrl;
	
	private TblUserLoginDao userLoginDao ;

	private TblUserProfileDao userProfileDao ;
	
	private TblDepartmentDao departmentDao;
	
	private XhjJccityDao xhjJccityDao;
	
	public void setUserLoginDao(TblUserLoginDao userLoginDao) {
		this.userLoginDao = userLoginDao;
	}
	
	public void setUserProfileDao(TblUserProfileDao userProfileDao) {
		this.userProfileDao = userProfileDao;
	}


	public void setDepartmentDao(TblDepartmentDao departmentDao) {
		this.departmentDao = departmentDao;
	}

	public 	TblUserLogin login(String userName) throws Exception{
		try{
			String strategy=DAOConstants.RELATIONAL;
			return userLoginDao.login(userName, strategy);
		}catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	}
	
	
	public 	TblDepartment findTblDepartmentById(Integer id) throws Exception{
		try{
			String strategy=DAOConstants.RELATIONAL;
			return departmentDao.getObjectById(id, strategy);
		}catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	}
	
	public 	TblUserProfile findTblUserProfileById(Integer tblUserProfileId) throws Exception{
		try{
			String strategy=DAOConstants.RELATIONAL;
			return userProfileDao.getObjectById(tblUserProfileId, strategy);
		}catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	}
	public Map<String, HRPermission> getHRPermissions (UserLogin u,TblUserLogin userLogin)throws Exception{
		try{
			String strategy=DAOConstants.RELATIONAL;
			List<HRPermission> permissions=userLoginDao.getHRPermissions(sysType,userLogin.getId(),strategy);
			if(!CollectionUtils.isEmpty(permissions)){
				u.resetPermissions();
					
				u.addHRPermissions(permissions);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return u.getPermissions();
	}
	
	public void setOrChangeTitle(String title,Integer departmentId, Integer titleId){
		String strategy = DAOConstants.RELATIONAL;
		TblDepartment department = departmentDao.getObjectById(departmentId, strategy);
		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
		userLogin.setDepartment(department);
		userLogin.setCityId(String.valueOf(department.getCityId()));
		Integer[] ids = xhjJccityDao.getCityParentInfo(department.getCityId(), strategy);
		userLogin.setCountryId(String.valueOf(ids[0]));
		userLogin.setProvinceId(String.valueOf(ids[1]));
		userLogin.resetPermissions();
		
		title = userLogin.getCityId() + "." + departmentId + "." + titleId;
		List<Object[]> findAllTitleNamesByUsername = userLoginDao.findAllTitleNamesByUsername(userLogin.getUserLogin().getUsername(),strategy);
		for (int i = 0; i < findAllTitleNamesByUsername.size(); i++) {
			Object[] objects = findAllTitleNamesByUsername.get(i);
			String valueOf = String.valueOf(objects[0]);
			if(valueOf.equals(title))
			{
				userLogin.setTitleName(String.valueOf(objects[1]));
				break;
			}
		}
		
		//获取该用户当前岗位的全部权限
		List<HRPermission> permissions = userLoginDao.getUserPermissions(userLogin.getUserLogin().getId(), titleId, strategy);
		
		userLogin.addHRPermissions(permissions);
	}
	
	/**
	 * 查询某个登录名的所有岗位。
	 * @param userName
	 * @return
	 */
	public List<Object[]> findAllTitleNamesByUsername(String userName){
		return userLoginDao.findAllTitleNamesByUsername(userName, DAOConstants.RELATIONAL);
	}

	public String getSysType() {
		return sysType;
	}

	public void setSysType(String sysType) {
		this.sysType = sysType;
	}

	public String getHrPermissionUrl() {
		return hrPermissionUrl;
	}

	public void setHrPermissionUrl(String hrPermissionUrl) {
		this.hrPermissionUrl = hrPermissionUrl;
	}

	public XhjJccityDao getXhjJccityDao() {
		return xhjJccityDao;
	}

	public void setXhjJccityDao(XhjJccityDao xhjJccityDao) {
		this.xhjJccityDao = xhjJccityDao;
	}
	
}
