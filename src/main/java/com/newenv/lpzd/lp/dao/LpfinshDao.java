package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpFinsh;
import com.newenv.lpzd.lp.domain.XhjLptp;
import com.newenv.lpzd.lp.domain.XhjLpxx;

public class LpfinshDao extends DaoParent<LpFinsh>{
	public void saveLpFinshs(Integer lpid, List<LpFinsh> lpFinsh, String relational){
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpxx lpxx = pm.getObjectById(XhjLpxx.class, lpid);
		Transaction tx = pm.currentTransaction();
		try {
			Query query = pm.newQuery(LpFinsh.class);
			query.setFilter("lpid==" + lpxx.getId());
			List<LpFinsh> lpFinshs = (List<LpFinsh>)query.execute();
			tx.begin();
			pm.deletePersistentAll(lpFinshs);
			if(lpFinsh != null && lpFinsh.size() > 0) {
				for (int i = 0; i < lpFinsh.size(); i++) {
					if(lpFinsh.get(i) != null) {
						LpFinsh entity = lpFinsh.get(i);
						Integer finshNumber =entity.getFinshNumber();
						if(finshNumber==null){
							entity.setFinshNumber(0);
						}
						entity.setLpid(lpid);
						entity.setFlag(1);
						entity.setCreatedate(new Timestamp(new Date().getTime()));
						pm.makePersistent(entity);
					}
				}
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			if(tx.isActive())
			{
				tx.rollback();
			}
			pm.close();
		}
	}
	
	/**
	 * 获取完成度信息
	 * @param relational
	 * @return
	 */
	public List<LpFinsh> querylpFinshs(Integer lpid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query = pm.newQuery(LpFinsh.class);
		query.setFilter("lpid=="+ lpid );
		List<LpFinsh> fls = (List<LpFinsh>)query.execute();
		pm.close();
		return fls;
	};
}
