package com.newenv.lpzd.lp.dao;



import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.pagination.PageInfo;

public class LpCostLivingDao extends DaoParent<LpCostLiving>{
	/**
	 *  查询居住成本
	 * @param pageInfo
	 * @param lpid
	 * @return
	 */
	public PageInfo queryLpCostLiving(PageInfo pageInfo,Integer lpid){
		StringBuilder sql = new StringBuilder();
		StringBuilder sqlCount = new StringBuilder();
		sql.append("select (select sc.name  from lp_syscs_1 sc where sc.id=c_type )c_type,(select sc.name  from lp_syscs_1 sc where sc.id=paying_way )paying_way ,price ,unit ,remark  from lp_cost_living  where flag=1  and   lpid = ");
		sql.append(lpid);
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		return pageInfo;
	}

}
