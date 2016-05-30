package com.newenv.lpzd.lp.service;

import com.newenv.lpzd.lp.dao.LpCostLivingDao;
import com.newenv.pagination.PageInfo;

public class LpCostLivingService {
	private LpCostLivingDao lpCostLivingDao;

	public LpCostLivingDao getLpCostLivingDao() {
		return lpCostLivingDao;
	}

	public void setLpCostLivingDao(LpCostLivingDao lpCostLivingDao) {
		this.lpCostLivingDao = lpCostLivingDao;
	}
	
	public PageInfo queryLpCostLiving(PageInfo pageInfo,Integer lpid){
		return this.lpCostLivingDao.queryLpCostLiving(pageInfo, lpid);
	}
}
