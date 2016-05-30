package com.newenv.lpzd.lp.service;

import com.newenv.lpzd.lp.dao.LpMaintenanceUnitDao;
import com.newenv.pagination.PageInfo;

public class LpMaintenanceUnitService {
	private LpMaintenanceUnitDao lpMaintenanceUnitDao;

	public LpMaintenanceUnitDao getLpMaintenanceUnitDao() {
		return lpMaintenanceUnitDao;
	}

	public void setLpMaintenanceUnitDao(LpMaintenanceUnitDao lpMaintenanceUnitDao) {
		this.lpMaintenanceUnitDao = lpMaintenanceUnitDao;
	}
	
	public PageInfo queryLpMaintenanceUnit(PageInfo pageInfo,Integer lpid){
		return this.lpMaintenanceUnitDao.queryLpMaintenanceUnit(pageInfo, lpid);
	}
}
