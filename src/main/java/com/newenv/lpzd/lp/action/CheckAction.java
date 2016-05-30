package com.newenv.lpzd.lp.action;

import java.util.List;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.security.service.SecurityUserHolder;

public class CheckAction extends BaseAction {

	private XhjJcstressService xhjJcstressService;
	
	public String execute(){
		List<XhjJcstress> stressList = xhjJcstressService.findByCityId(SecurityUserHolder.getCurrentUserLogin().getCityId());
		this.bindParam("stressList", stressList);
		return SUCCESS;
	}

	public XhjJcstressService getXhjJcstressService() {
		return xhjJcstressService;
	}

	public void setXhjJcstressService(XhjJcstressService xhjJcstressService) {
		this.xhjJcstressService = xhjJcstressService;
	}
	
}
