package com.newenv.lpzd.lp.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.LpSyscs1;

public class LpSyscs1Dao extends DaoParent<LpSyscs1>{
	public List<LpSyscs1> getSyscs1es(int sid,String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery(LpSyscs1.class);
		query.setFilter(" sid == "+sid+" && status==1");
		List<LpSyscs1> objs = (List<LpSyscs1>)query.execute();
		pm.close();
		return objs;
	}
}
