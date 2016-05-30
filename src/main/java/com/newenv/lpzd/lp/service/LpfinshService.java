package com.newenv.lpzd.lp.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.LpfinshDao;
import com.newenv.lpzd.lp.domain.LpFinsh;

public class LpfinshService {
	private LpfinshDao lpfinshDao;
	public void saveLpFinshs(Integer lpid, List<LpFinsh> lpFinsh){
		lpfinshDao.saveLpFinshs(lpid, lpFinsh, DAOConstants.RELATIONAL);
	}
	
	public List<LpFinsh> querylpFinshs(Integer lpid){
		return lpfinshDao.querylpFinshs(lpid, DAOConstants.RELATIONAL);
	}
	public LpfinshDao getLpfinshDao() {
		return lpfinshDao;
	}
	public void setLpfinshDao(LpfinshDao lpfinshDao) {
		this.lpfinshDao = lpfinshDao;
	}

}
