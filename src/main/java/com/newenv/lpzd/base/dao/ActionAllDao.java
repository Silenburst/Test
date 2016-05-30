package com.newenv.lpzd.base.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.apache.commons.lang.StringUtils;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.ChanQuan;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.pagination.PageInfo;
public class ActionAllDao  extends DaoParent<LpCountry>{
	
	/**
	 * 页面显示数据查询
	 * @param pager
	 * @param strategy
	 * @return
	 */
	public PageInfo findByPageInFo(ChanQuan chanquan ,PageInfo pager){
		StringBuffer sql = new StringBuffer(" select * from lp_info ");
		StringBuffer countsql=new StringBuffer("select count(*) from lp_info ");
		StringBuffer sqlcommon=new StringBuffer();
		sqlcommon.append("  where 1=1 ");
		if(StringUtils.isNotEmpty(chanquan.getQuyu()) && !"0".equals(chanquan.getQuyu())){
			sqlcommon.append(" and quyu like '%").append(chanquan.getQuyu()).append("%'");
		}
		if(StringUtils.isNotEmpty(chanquan.getAddress())){
			sqlcommon.append(" and address like '%").append(chanquan.getAddress()).append("%'");
		}
		if(StringUtils.isNotEmpty(chanquan.getYongtu())&& !"0".equals(chanquan.getYongtu())){
			sqlcommon.append(" and yongtu  like '%").append(chanquan.getYongtu()).append("%'");
		}
		if(StringUtils.isNotEmpty(chanquan.getMianjistarts())){
			sqlcommon.append(" and mianji >= ").append(chanquan.getMianjistarts());
		}
		if(StringUtils.isNotEmpty(chanquan.getMianjisend())){
			sqlcommon.append(" and mianji <= ").append(chanquan.getMianjisend());
		}
		sqlcommon.append("  order by address desc ");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
}
