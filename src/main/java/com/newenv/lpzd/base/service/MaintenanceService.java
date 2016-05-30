package com.newenv.lpzd.base.service;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.MaintenanceDao;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class MaintenanceService {
		private MaintenanceDao maintenanceDao;
		
		/**
		 * 分页显示
		 * @param pager
		 * @return
		 */
		public PageInfo findByPageInFo(Enetiy enetiy,PageInfo pager){
			return maintenanceDao.findByPageInFo(enetiy,pager);
		}
		/**
		 * 新增维护单位
		 * @return
		 */
		public LpMaintenanceUnit AddCBMU(Enetiy enetiy){
			return maintenanceDao.AddCBMU(enetiy, DAOConstants.RELATIONAL);
		}
		
		public LpMaintenanceUnit getById(Integer id){
			return this.maintenanceDao.getById(id, DAOConstants.RELATIONAL);
		}
		public int deleteLPM(Integer id){
			return this.maintenanceDao.deleteLPM(id,DAOConstants.RELATIONAL);
		}
		public long update(Enetiy enetiy){
			return maintenanceDao.update(enetiy, DAOConstants.RELATIONAL);
		}
		
		public MaintenanceDao getMaintenanceDao() {
			return maintenanceDao;
		}

		public void setMaintenanceDao(MaintenanceDao maintenanceDao) {
			this.maintenanceDao = maintenanceDao;
		}
		
}
