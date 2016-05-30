package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.XhjLpschoolDao;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.base.domain.pojo.BaseCondition;
import com.newenv.pagination.PageInfo;

public class XhjLpschoolService {

	private XhjLpschoolDao xhjLpschoolDao;

	public List<XhjLpschool> findAll(){
		return xhjLpschoolDao.findAll(DAOConstants.RELATIONAL);
	}

	public PageInfo findSchoolByPage(PageInfo page, BaseCondition condition, String strategy ){
		return xhjLpschoolDao.findSchoolByPage(page, condition, strategy );
	}

	public BaseCondition findSchoolById(int id){
		return xhjLpschoolDao.findSchoolById(id,  DAOConstants.RELATIONAL);
	}
	
	public List<LpSyscs1> findBySchoolType(String name){
		return xhjLpschoolDao.findBySchoolType(name,DAOConstants.RELATIONAL);
	}
	public int addType(String typeNames){
		return xhjLpschoolDao.addType(typeNames,DAOConstants.RELATIONAL);
	}
	
	public String addSchool(BaseCondition condition){
		return xhjLpschoolDao.addSchool(condition,DAOConstants.RELATIONAL);
	}
	
	public int delSchool(String id){
		Integer idd = Integer.valueOf(id);
		return xhjLpschoolDao.delSchool(idd,DAOConstants.RELATIONAL);
	}
	
	public int delImage(String id){
		Integer idd = Integer.valueOf(id);
		return xhjLpschoolDao.delImage(idd,DAOConstants.RELATIONAL);
	}
	public int deleteAllSchool(String id){
		return xhjLpschoolDao.deleteAllSchool(id,  DAOConstants.RELATIONAL);
	}
	
	public int updateType(BaseCondition condition)
	{
		int	count = xhjLpschoolDao.updateType(condition, DAOConstants.RELATIONAL);
		return count;
	}
	
	public int updateSchool(BaseCondition condition)
	{
		return xhjLpschoolDao.updateSchool(condition, DAOConstants.RELATIONAL);
	}
	
	public BaseCondition updateDetail(int id)
	{
		return xhjLpschoolDao.updateDetail(id, DAOConstants.RELATIONAL);
	}
	
	public XhjLpschoolDao getXhjLpschoolDao() {
		return xhjLpschoolDao;
	}

	public void setXhjLpschoolDao(XhjLpschoolDao xhjLpschoolDao) {
		this.xhjLpschoolDao = xhjLpschoolDao;
	}
	
	
}
