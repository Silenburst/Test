package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.XhjJcstressDao;
import com.newenv.lpzd.base.domain.XhjJcstress;

public class XhjJcstressService {

	private XhjJcstressDao xhjJcstressDao;
	
	public List<XhjJcstress> findByCityId(String cityId){
		List<XhjJcstress> xhjJcStressList= xhjJcstressDao.findByCityId(cityId, DAOConstants.RELATIONAL);
		return xhjJcStressList;
	}

	public XhjJcstressDao getXhjJcstressDao() {
		return xhjJcstressDao;
	}

	public void setXhjJcstressDao(XhjJcstressDao xhjJcstressDao) {
		this.xhjJcstressDao = xhjJcstressDao;
	}

	
}
