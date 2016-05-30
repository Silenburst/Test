package com.newenv.lpzd.lp.dao;

import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpOperationLog;
import com.newenv.lpzd.security.domain.UserLogin;


public class LpOperationLogDao extends DaoParent<LpOperationLog>{
	public void addLpLog(String type, String message,  String lpid){
		PersistenceManager pm = getPersistenceManagerByStratey( DAOConstants.RELATIONAL);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    LpOperationLog lg = new LpOperationLog();
			UserLogin currentUserLogin = com.newenv.lpzd.security.service.SecurityUserHolder.getCurrentUserLogin();
			lg.setDepartmentId(currentUserLogin.getDepartment().getId()==null?-1:currentUserLogin.getDepartment().getId());
			lg.setIpAddress(currentUserLogin.getUserLogin().getIp());
			lg.setIsPhone(1);
			String name = currentUserLogin.getUserProfile().getFullname() == null ? "" : currentUserLogin.getUserProfile().getFullname();
			lg.setMessage(name+":"+message);
			lg.setOperationtype(type);
			lg.setOperatorId(currentUserLogin.getUserProfile().getId());
			lg.setLpid(Integer.valueOf(lpid));
			lg.setRemark(currentUserLogin.getUserLogin().getTel());
			lg.setOperateDate(new Date());
			pm.makePersistent(lg);
			tx.commit();
			pm.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	};
}
