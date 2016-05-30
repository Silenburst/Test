package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.XhjJccityDao;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;

public class XhjJccityService {

	private XhjJccityDao xhjJccityDao;

	public List<XhjJccity> findAll(){
		return xhjJccityDao.findAll(DAOConstants.RELATIONAL);
	}
	
	public List<XhjJccity> findByProvinceId(String provinceid){
		return xhjJccityDao.findByProvinceId(provinceid, DAOConstants.RELATIONAL);
	}
	
	public Integer[] getCityParentInfo(Integer cityId){
		return xhjJccityDao.getCityParentInfo(cityId, DAOConstants.RELATIONAL);
	}
	
	public List<XhjLpjiaotongxian> jiaotongxian(Integer cityId){
		return xhjJccityDao.jiaotongxian(cityId, DAOConstants.RELATIONAL);
	}
	
	public XhjJccityDao getXhjJccityDao() {
		return xhjJccityDao;
	}


	public void setXhjJccityDao(XhjJccityDao xhjJccityDao) {
		this.xhjJccityDao = xhjJccityDao;
	}
	
}
