package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjCommunicator;
import com.newenv.lpzd.lp.domain.XhjCommunicator;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;

public class XhjCommunicatorDao extends DaoParent<XhjCommunicator>{
	public void saveXhjCommunicator(Integer personId, List<XhjCommunicator> communicators, String relational){
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjPersoninfo xhjPersoninfo = pm.getObjectById(XhjPersoninfo.class, personId);
		Transaction tx = pm.currentTransaction();
		try {
			Query query = pm.newQuery(XhjCommunicator.class);
			query.setFilter("personId==" + xhjPersoninfo.getId());
			List<XhjCommunicator> communicatorList = (List<XhjCommunicator>)query.execute();
			tx.begin();
			pm.deletePersistentAll(communicatorList);
			if(communicators != null && communicators.size() > 0) {
				for (int i = 0; i < communicators.size(); i++) {
					if(communicators.get(i) != null) {
						XhjCommunicator xhjCommunicator = communicators.get(i);
						xhjCommunicator.setPersonId(xhjPersoninfo.getId());
						xhjCommunicator.setCreateDate(new Timestamp(new Date().getTime()));
						xhjCommunicator.setStatuss("1");
						pm.makePersistent(xhjCommunicator);
					}
				}
			}
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
	/**
	 * 获取业主联系电话
	 * @param relational
	 * @return
	 */
	public List<XhjCommunicator> queryXhjCommunicator(Integer personId,  String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query = pm.newQuery(XhjCommunicator.class);
		
		query.setFilter("personId==" + personId);
		
		return (List<XhjCommunicator>)query.execute();
	};
}
