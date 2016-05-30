package com.newenv.lpzd.lp.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.DateUtils;
import com.newenv.lpzd.lp.domain.XhjNewhouseinfo;

public class XhjNewhouseinfoDao extends DaoParent<XhjNewhouseinfo> {
	private LpOperationLogDao operationLogDao;

	public XhjNewhouseinfo getByXhjNewhouseinfo(Integer id, String strategy) {
		PersistenceManager pm = this.getPersistenceManagerByStratey(strategy);
		XhjNewhouseinfo xhjNewhouseinfo = pm.getObjectById(
				XhjNewhouseinfo.class, id);
		this.Parameterxfinfo(pm, xhjNewhouseinfo);
		String message = "查看[" + xhjNewhouseinfo.getLpName() + "]新房信息";
		operationLogDao.addLpLog("LP10005", message,String.valueOf(xhjNewhouseinfo.getProjectId()));
		pm.close();
		return xhjNewhouseinfo;
	}

	private void Parameterxfinfo(PersistenceManager pm,
			XhjNewhouseinfo xhjNewhouseinfo) {
		if (xhjNewhouseinfo.getProjectId() != null
				&& xhjNewhouseinfo.getProjectId() != 0) {
			String sql = "select lp.LP_Name,lp.x,lp.y,"
					+ "(select  name  from lp_syscs_1 sc where sc.id=xf.Usages) Usages, "
					+ "(select  name  from lp_syscs_1 sc where sc.id=xf.Decoration) Decoration, "
					+ "(select  name  from lp_syscs_1 sc where sc.id=xf.SalesStatus) SalesStatus "
					+ " from xhj_lpxx lp inner join xhj_newhouseinfo xf on lp.id=xf.ProjectID "
					+ " where lp.id=" + xhjNewhouseinfo.getProjectId();
			Query query = pm.newQuery("SQL", sql);
			List<Object[]> list = (List<Object[]>) query.execute();
			for (Object[] objs : list) {
				if (objs[0] != null && !"".equals(objs[0])) {
					xhjNewhouseinfo.setLpName(objs[0].toString());
				} else {
					xhjNewhouseinfo.setLpName("");
				}
				if (objs[1] != null && !"".equals(objs[1])) {
					xhjNewhouseinfo
							.setX(Double.parseDouble(objs[1].toString()));
				} else {
					xhjNewhouseinfo.setX(null);
				}
				if (objs[2] != null && !"".equals(objs[2])) {
					xhjNewhouseinfo
							.setY(Double.parseDouble(objs[2].toString()));
				} else {
					xhjNewhouseinfo.setY(null);
				}
				if (objs[3] != null && !"".equals(objs[3])) {
					xhjNewhouseinfo.setUsagesStr(objs[3].toString());
				}
				if (objs[4] != null && !"".equals(objs[4])) {
					xhjNewhouseinfo.setDecorationStr(objs[4].toString());
				}
				if (objs[5] != null && !"".equals(objs[5])) {
					xhjNewhouseinfo.setSalesStatusStr(objs[5].toString());
				}
			}
		}

		if (xhjNewhouseinfo.getStartDate() != null
				&& !"".equals(xhjNewhouseinfo.getStartDate())) {
			xhjNewhouseinfo.setStartDateStr(DateUtils
					.getDateStrYMR(xhjNewhouseinfo.getStartDate()));
		}
		if (xhjNewhouseinfo.getStopDate() != null
				&& !"".equals(xhjNewhouseinfo.getStopDate())) {
			xhjNewhouseinfo.setStopDateStr(DateUtils
					.getDateStrYMR(xhjNewhouseinfo.getStopDate()));
		}
		if (xhjNewhouseinfo.getOpenDate() != null
				&& !"".equals(xhjNewhouseinfo.getOpenDate())) {
			xhjNewhouseinfo.setOpenDateStr(DateUtils
					.getDateStrYMR(xhjNewhouseinfo.getOpenDate()));
		}
		if (xhjNewhouseinfo.getSubmitHouseDate() != null
				&& !"".equals(xhjNewhouseinfo.getSubmitHouseDate())) {
			xhjNewhouseinfo.setSubmitHouseDateStr(DateUtils
					.getDateStrYMR(xhjNewhouseinfo.getSubmitHouseDate()));
		}
		if (xhjNewhouseinfo.getCreateDate() != null
				&& !"".equals(xhjNewhouseinfo.getCreateDate())) {
			xhjNewhouseinfo.setCreateDateStr(DateUtils
					.getDateStrYMR(xhjNewhouseinfo.getCreateDate()));
		}

	}

	public LpOperationLogDao getOperationLogDao() {
		return operationLogDao;
	}

	public void setOperationLogDao(LpOperationLogDao operationLogDao) {
		this.operationLogDao = operationLogDao;
	}

}
