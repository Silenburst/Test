package com.newenv.lpzd.lp.service;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.LpOperationLogDao;
import com.newenv.lpzd.lp.dao.XhjLpWuYeDao;
import com.newenv.lpzd.lp.domain.XhjLpwuye;

public class XhjLpWuYeService {
	private XhjLpWuYeDao xhjLpWuYeDao;
	private LpOperationLogDao operationLogDao; 

	public XhjLpWuYeDao getXhjLpWuYeDao() {
		return xhjLpWuYeDao;
	}

	public void setXhjLpWuYeDao(XhjLpWuYeDao xhjLpWuYeDao) {
		this.xhjLpWuYeDao = xhjLpWuYeDao;
	}

	public LpOperationLogDao getOperationLogDao() {
		return operationLogDao;
	}

	public void setOperationLogDao(LpOperationLogDao operationLogDao) {
		this.operationLogDao = operationLogDao;
	}

	public String saveWuye(XhjLpwuye wyxx) {
		boolean flag = false;
		if(wyxx.getId() == null) {
			flag = true;
		}
		String wyid = xhjLpWuYeDao.saveWuye(wyxx,DAOConstants.RELATIONAL);
		if(flag) {
			String message = "新增[" + wyxx.getWyName() + "]物业信息";
			setLog("LP20001", message, wyxx.getXhjLpxx().getId().toString());
		} else {
			String message = "修改[" + wyxx.getWyName() + "]物业信息";
			setLog("LP20002", message, wyxx.getXhjLpxx().getId().toString());
		}
		return wyid;
	}

	public XhjLpwuye queryWuyeInfo(Integer lpid) {
		return xhjLpWuYeDao.queryWuyeInfo(lpid, DAOConstants.RELATIONAL);
	}
	
	//操作日志
	private void setLog(String type, String message, String lpid){
		operationLogDao.addLpLog(type, message, lpid);
	};
}
