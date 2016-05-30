package com.newenv.lpzd.base.service;

import java.util.HashMap;
import java.util.Map;

import com.newenv.lpzd.Utils.HttpClientUtil;
import com.newenv.lpzd.security.service.SecurityUserHolder;

public class MessageService {

	private String bmsBaseUrl = "";
	
	/**
	 * 发送消息。
	 * @param receiverId
	 * @param actionType
	 * @param actionName
	 * @param guestCode
	 * @param message
	 */
	public void sendMessage(Integer receiverId, String actionType, String actionName, String guestCode,String message){
		Map<String, String> params = new HashMap<String, String>();
		params.put("cityID", SecurityUserHolder.getCurrentUserLogin().getCityId());
		params.put("senderId", String.valueOf(SecurityUserHolder.getCurrentUserLogin().getUserLogin().getId()));
		params.put("senderName", SecurityUserHolder.getCurrentUserLogin().getUserProfile().getFullname());
		params.put("senderDeptName", SecurityUserHolder.getCurrentUserLogin().getDepartment().getDepartmentName());
		params.put("receiverId", String.valueOf(receiverId));
		params.put("actionType", actionType);
		params.put("actionName", actionName);
		params.put("guestCode", guestCode);
		params.put("message", message);
		try {
			HttpClientUtil.getInstance().httpPost(bmsBaseUrl + "/doMain/service.sendMessage.action", "UTF-8", params);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public String getBmsBaseUrl() {
		return bmsBaseUrl;
	}

	public void setBmsBaseUrl(String bmsBaseUrl) {
		this.bmsBaseUrl = bmsBaseUrl;
	}
	
}
