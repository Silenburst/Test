package com.newenv.lpzd.base.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class HousingCostDao extends DaoParent<LpCostLiving>{
	/**
	 * 页面数据分页显示
	 * @param pager
	 * @return
	 */
	public PageInfo findByPageInFo(Enetiy enetiy,PageInfo pager){
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select id,lpid,(select sc.name  from lp_syscs_1 sc where sc.id=c_type ) c_type,(select sc.name  from lp_syscs_1 sc where sc.id=paying_way ) paying_way,price,unit,remark,c_type as cType, paying_way as payingWay ");
		sqlcommon.append(" from lp_cost_living where flag =1 and lpid = "+enetiy.getLpid());
		sqlcommon.append("  order by id desc ");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	/**
	 * 新增
	 * @param enetiy
	 * @return
	 */
	public LpCostLiving addData(Enetiy enetiy,String strategy){
		String sql = "select from " + LpCostLiving.class.getName() + " where id==" + enetiy.getId() + " ";
		String sqlpayingWay = "select from " + LpCostLiving.class.getName() + " where payingWay== " + enetiy.getPayingWay() + " && flag==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<LpCostLiving> countries   =  new ArrayList<LpCostLiving>();
		if(enetiy.getId()!=null&&enetiy.getId()!=0){
			countries = (List<LpCostLiving>)pm.newQuery(sql).execute();
		}else{
			countries = (List<LpCostLiving>)pm.newQuery(sqlpayingWay).execute();
		}
		LpCostLiving lpCostLiving=null;
		if(countries!=null && countries.size()>0){
			lpCostLiving = countries.get(0);
		} else {
			lpCostLiving= new LpCostLiving();
		}
		lpCostLiving.setLpid(enetiy.getLpid());
		lpCostLiving.setCType(enetiy.getCtype());
		if(enetiy.getPayingWay() != 0 && enetiy.getPayingWay() != null){
			lpCostLiving.setPayingWay(enetiy.getPayingWay());
		}
		if(enetiy.getPrice() != null && enetiy.getPrice() != 0){
			lpCostLiving.setPrice(enetiy.getPrice());
		}
		if(enetiy.getUnit() != null && enetiy.getUnit() != ""){
			lpCostLiving.setUnit(enetiy.getUnit());
		}
		if(enetiy.getRemark() != null && enetiy.getRemark() != ""){
			lpCostLiving.setRemark(enetiy.getRemark());
		}
		lpCostLiving.setCreatedate(new Date());
		lpCostLiving.setFlag(1);
		Transaction tx=pm.currentTransaction();
		try{
			tx.begin();
			pm.makePersistent(lpCostLiving);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally
		{
			if(tx.isActive())
			{
				tx.rollback();
			}
			pm.close();
		}
		return lpCostLiving;
	}
	
	public LpCostLiving  getById(Integer id,String strategy){
		PersistenceManager pm= this.getPersistenceManagerByStratey(strategy);
		LpCostLiving entity=pm.getObjectById(LpCostLiving.class,id);
		pm.close();
		return entity;
	}
	
	public int  deleteCost(Integer id,String strategy){
		PersistenceManager pm= this.getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			LpCostLiving entity=pm.getObjectById(LpCostLiving.class,id);
			entity.setFlag(0);
			pm.makePersistent(entity);
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally
		{
			if(tx.isActive())
			{
				tx.rollback();
			}
			pm.close();
		}
		return 1;
	}
}
