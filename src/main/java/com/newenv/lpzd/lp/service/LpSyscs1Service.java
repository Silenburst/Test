package com.newenv.lpzd.lp.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.lp.dao.LpSyscs1Dao;

public class LpSyscs1Service {
	private LpSyscs1Dao lpSyscs1Dao;
	public List<LpSyscs1> getSyscs1es(int sid){
		List<LpSyscs1> lpSyscs1es= lpSyscs1Dao.getSyscs1es(sid, DAOConstants.RELATIONAL);
		return lpSyscs1es;
	}
	public LpSyscs1Dao getLpSyscs1Dao() {
		return lpSyscs1Dao;
	}
	public void setLpSyscs1Dao(LpSyscs1Dao lpSyscs1Dao) {
		this.lpSyscs1Dao = lpSyscs1Dao;
	}
	
}
