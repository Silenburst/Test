package com.newenv.lpzd.base.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.ActionAllDao;
import com.newenv.lpzd.base.dao.LpCountryDao;
import com.newenv.lpzd.base.domain.ChanQuan;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class ActionAllService {

	private ActionAllDao actionAllDao;
	
	public ActionAllDao getActionAllDao() {
		return actionAllDao;
	}

	public void setActionAllDao(ActionAllDao actionAllDao) {
		this.actionAllDao = actionAllDao;
	}

	/**
	 * 列表页数据的分页显示
	 * @param pager
	 * @return
	 */
	public PageInfo findByPageInFo(ChanQuan chanquan ,PageInfo pager){
		pager = actionAllDao.findByPageInFo(chanquan,pager);
		return pager;
	}
	
}
