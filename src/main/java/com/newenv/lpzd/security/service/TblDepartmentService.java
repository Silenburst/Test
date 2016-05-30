package com.newenv.lpzd.security.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.security.dao.TblDepartmentDao;
import com.newenv.lpzd.security.domain.TblDepartment;

public class TblDepartmentService {
	
	private TblDepartmentDao tblDepartmentDao;
	
	public TblDepartment getById(Integer id){
		return tblDepartmentDao.getObjectById(id, DAOConstants.RELATIONAL);
	}
	
	public List<TblDepartment> findDepartmentByOrgIdAndBlurDeparmentQuery(Integer organizationId, String departmentStr) {
		return tblDepartmentDao.findDepartmentByOrgIdAndBlurDeparmentQuery(organizationId, departmentStr, DAOConstants.RELATIONAL);
	}
	
	public List<TblDepartment> findDepartmentByOrgIdAndDeparmentIDs(int organizationId, List<Integer> departmentIDs){
		return tblDepartmentDao.findDepartmentByOrgIdAndDeparmentIDs(organizationId, departmentIDs, DAOConstants.RELATIONAL);
	}

	public TblDepartmentDao getTblDepartmentDao() {
		return tblDepartmentDao;
	}

	public void setTblDepartmentDao(TblDepartmentDao tblDepartmentDao) {
		this.tblDepartmentDao = tblDepartmentDao;
	}

	public List<Object[]> queryDepartAddress(Integer deptId) {
		return tblDepartmentDao.queryDepartAddress(deptId, DAOConstants.RELATIONAL);
	}
}
