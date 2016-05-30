package com.newenv.lpzd.lp.dao;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

public class LpMaintenanceUnitDao extends DaoParent<LpMaintenanceUnit>{
	public PageInfo queryLpMaintenanceUnit(PageInfo pageInfo,Integer lpid){
		StringBuilder sql = new StringBuilder();
		StringBuilder sqlCount = new StringBuilder();
		sql.append("select (select sc.name  from lp_syscs_1 sc where sc.id=m_type )m_type,company_name,tel,address,remark   from lp_maintenance_unit   where  flag=1  and  lpid = ");
		sql.append(lpid);
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		return pageInfo;
	}
	
	
}
