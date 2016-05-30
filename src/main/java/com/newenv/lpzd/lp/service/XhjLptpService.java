package com.newenv.lpzd.lp.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.XhjLptpDao;
import com.newenv.lpzd.lp.domain.XhjLptp;

public class XhjLptpService {
	private XhjLptpDao xhjLptpDao;
	
	public XhjLptpDao getXhjLptpDao() {
		return xhjLptpDao;
	}

	public void setXhjLptpDao(XhjLptpDao xhjLptpDao) {
		this.xhjLptpDao = xhjLptpDao;
	}

	public void saveLpimges(Integer lpid, String imgName, List<XhjLptp> img) {
		 xhjLptpDao.saveLpimges(lpid, imgName, img, DAOConstants.RELATIONAL);
	}

	public List<XhjLptp> queryLptpInfo(Integer lpid,Integer shi,Integer fengge) {
		return xhjLptpDao.queryLptpInfo(lpid,shi,fengge, DAOConstants.RELATIONAL);
	}
}
