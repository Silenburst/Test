package com.newenv.lpzd.security.action;

import java.util.List;

import org.apache.log4j.Logger;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.security.domain.TblUserProfile;
import com.newenv.lpzd.security.service.TblUserProfileService;

public class UserProfileAction extends BaseAction{

	private Integer departmentId;
	
	private static Logger log = Logger.getLogger(UserProfileAction.class);
	
	private TblUserProfileService userProfileService;
	
	public TblUserProfileService getUserProfileService() {
		return userProfileService;
	}
	public void setUserProfileService(TblUserProfileService userProfileService) {
		this.userProfileService = userProfileService;
	}
	
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	
	private TblUserProfile userProfile;
	
	/**
	 * 获取某个部门下的人员信息。
	 * @return
	 */
	public String getUserProfilesByDepartmentId(){
		List<TblUserProfile> userProfiles = userProfileService.getUserProfilesByDepartmentId(departmentId);	
		String json = "";
		for(TblUserProfile u : userProfiles){
			json += ",{\"id\":" + u.getId() + ",\"fullname\":\"" + u.getFullname() + "\"}"; 
		}
		if(json.length()>0)json=json.substring(1);
		json = "[" + json + "]";
		return this.jsonAjaxResult(json);
	}
	
	public TblUserProfile getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(TblUserProfile userProfile) {
		this.userProfile = userProfile;
	}
	
	
}
