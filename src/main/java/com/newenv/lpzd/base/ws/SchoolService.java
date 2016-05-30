package com.newenv.lpzd.base.ws;

import javax.ws.rs.Path;

import com.newenv.lpzd.base.service.XhjLpschoolService;
@Path("/schoolService")
public class SchoolService {
	//private  BaseCondition condition;
	private XhjLpschoolService xhjLpschoolService;
	
	public XhjLpschoolService getXhjLpschoolService() {
		return xhjLpschoolService;
	}

	public void setXhjLpschoolService(XhjLpschoolService xhjLpschoolService) {
		this.xhjLpschoolService = xhjLpschoolService;
	}

}
