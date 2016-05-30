package com.newenv.lpzd.base.service;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.HousingCostDao;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class HousingCostService{
		private HousingCostDao housingCostDao;
		public PageInfo findByPageInFo(Enetiy enetiy,PageInfo pager){
			return housingCostDao.findByPageInFo(enetiy,pager);
		}
		/**
		 * 新增数据
		 * @param enetiy
		 * @return
		 */
		public LpCostLiving addData(Enetiy enetiy){
			return housingCostDao.addData(enetiy, DAOConstants.RELATIONAL);
		}
		
		public HousingCostDao getHousingCostDao() {
			return housingCostDao;
		}

		public void setHousingCostDao(HousingCostDao housingCostDao) {
			this.housingCostDao = housingCostDao;
		}
		public LpCostLiving getById(Integer id){
			return this.housingCostDao.getById(id, DAOConstants.RELATIONAL);
		}
		public int deleteCost(Integer id){
			return this.housingCostDao.deleteCost(id,DAOConstants.RELATIONAL);
		}
}
