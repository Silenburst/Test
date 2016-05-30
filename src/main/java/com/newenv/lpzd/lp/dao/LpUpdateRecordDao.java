package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.person.LpUpdatingRecord;

public class LpUpdateRecordDao extends DaoParent<LpUpdatingRecord>{
	public String savelpUpdateRecord(LpUpdatingRecord lpUpdateRecord, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		String id = "";
		if (lpUpdateRecord.getId() == null || lpUpdateRecord.getId() == 0) {
			Transaction tx = pm.currentTransaction();
			lpUpdateRecord.setUpdateTime(new Timestamp(new Date().getTime()));
			try {
				tx.begin();
				pm.makePersistent(lpUpdateRecord);
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				if (tx.isActive()) {
					tx.rollback();
				}
				pm.close();
			}
		} else {
			Transaction tx = pm.currentTransaction();
			id = lpUpdateRecord.getId().toString();
			LpUpdatingRecord oldlpUpdateRecord = pm.getObjectById(
					LpUpdatingRecord.class, lpUpdateRecord.getId());
			oldlpUpdateRecord.setUtpye(lpUpdateRecord.getUtpye());
			oldlpUpdateRecord.setMessages(lpUpdateRecord.getMessages());
			try {
				tx.begin();
				pm.makePersistent(oldlpUpdateRecord);
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			} finally {
				if (tx.isActive()) {
					tx.rollback();
				}
				pm.close();
			}
		}

		return id;
	}
	
	
	
}
