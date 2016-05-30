package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.LpProvinceDao;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.pagination.PageInfo;

public class LpProvinceService {

	private LpProvinceDao lpProvinceDao;

	public List<LpProvince> findAll(){
		return lpProvinceDao.findAll(DAOConstants.RELATIONAL);
	}
	
	public List<LpProvince> findByCountryId(String cid){
		return lpProvinceDao.findByCountryId(cid, DAOConstants.RELATIONAL);
	}
	
	public LpProvinceDao getLpProvinceDao() {
		return lpProvinceDao;
	}

	public void setLpProvinceDao(LpProvinceDao LpProvinceDao) {
		this.lpProvinceDao = LpProvinceDao;
	}
	
	public PageInfo findByPage(PageInfo pageInfo){
		pageInfo=lpProvinceDao.findByPage( pageInfo, DAOConstants.RELATIONAL);
		return pageInfo;
		
	}
	
}
