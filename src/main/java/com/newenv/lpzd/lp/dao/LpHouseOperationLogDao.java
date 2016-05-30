package com.newenv.lpzd.lp.dao;

import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpHouseOperationLog;
import com.newenv.lpzd.security.domain.UserLogin;


public class LpHouseOperationLogDao extends DaoParent<LpHouseOperationLog>{
	public void addLpLog(String type, String message,  String fanghid){
		PersistenceManager pm = getPersistenceManagerByStratey( DAOConstants.RELATIONAL);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    LpHouseOperationLog lg = new LpHouseOperationLog();
			Integer departmentId = 1;
			Integer operatorId = 1;
			String ip = "";
			String tel = "";
			UserLogin currentUserLogin = com.newenv.lpzd.security.service.SecurityUserHolder.getCurrentUserLogin();
			if(currentUserLogin!=null){
				departmentId = currentUserLogin.getDepartment().getId()==null?-1:currentUserLogin.getDepartment().getId();
				operatorId = currentUserLogin.getUserProfile().getId();
				tel = currentUserLogin.getUserLogin().getTel();
			}
			lg.setDepartmentId(departmentId);
			lg.setIpAddress(ip);
			lg.setIsPhone(1);
			lg.setMessage(message);
			lg.setOperationtype(type);
			lg.setOperatorId(operatorId);
			lg.setHouseinfoid(Integer.valueOf(fanghid));
			lg.setRemark(tel);
			lg.setOperateDate(new Date());
			pm.makePersistent(lg);
			tx.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(tx.isActive())
			{
				tx.rollback();
			}
			pm.close();
		}
	}
}
