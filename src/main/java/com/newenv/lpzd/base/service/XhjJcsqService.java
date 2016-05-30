package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.XhjJcsqDao;
import com.newenv.lpzd.base.domain.XhjJcsq;

public class XhjJcsqService {

	private XhjJcsqDao xhjJcsqDao;

	public List<XhjJcsq> findAll(){
		return xhjJcsqDao.findAll(DAOConstants.RELATIONAL);
	}
	
	public List<XhjJcsq> findByQyid(String qyid){
		return xhjJcsqDao.findByQyid(qyid, DAOConstants.RELATIONAL);
	}
	
	public XhjJcsqDao getXhjJcsqDao() {
		return xhjJcsqDao;
	}

	public void setXhjJcsqDao(XhjJcsqDao XhjJcsqDao) {
		this.xhjJcsqDao = XhjJcsqDao;
	}
	
}
