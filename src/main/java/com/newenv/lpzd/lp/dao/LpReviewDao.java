package com.newenv.lpzd.lp.dao;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpReview;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.pagination.PageInfo;

public class LpReviewDao extends DaoParent<LpReview>{
	public void saveLpReview(LpReview lpReview,String strategy) {
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		int  id = getMaxId("lp_review", pm)+1;;
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			lpReview.setId(id);
			pm.makePersistent(lpReview);
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			//throw e;
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}
	private  int getMaxId(String name,PersistenceManager pm)
	{
		String sqlMax = "select max(id) from "+name;
		Query queryMax = pm.newQuery("SQL",sqlMax);
		ForwardQueryResult queryResultMax = (ForwardQueryResult) queryMax.execute();
		Integer  idMax=0;
		if(queryResultMax.get(0)!=null&&!"".equals(queryResultMax.get(0))){
			  idMax = Integer.valueOf(queryResultMax.get(0).toString());
		}
		return idMax;
	}
	
	
	public PageInfo queryLpReview(PageInfo pageInfo ,Integer lpid){
		StringBuilder sql =  new  StringBuilder();
		StringBuilder sqlfrom = new StringBuilder();
		StringBuilder sqlCount = new StringBuilder("select count(*) ");
		sql.append(" select (select  fullname from tbl_user_login l INNER JOIN tbl_user_profile p on l.tbl_User_profile_id=p.id where  l.id=lp.userid ) fullname , ");
		sql.append("(select  d.department_name from tbl_user_login l INNER JOIN tbl_user_profile p on l.tbl_User_profile_id=p.id INNER JOIN tbl_department d on p.tbl_department_id=d.id     where  l.id=lp.userid  ) department_name,");
		sql.append("  lp.content , lp.createdate ");
		sqlfrom.append(" from  lp_review lp  where  lp.lpid=").append(lpid);
		sql.append(sqlfrom);
		sqlCount.append(sqlfrom);
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}
}
