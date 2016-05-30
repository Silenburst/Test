package com.newenv.lpzd.base.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;


import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class MaintenanceDao extends DaoParent<LpMaintenanceUnit>{
	/**
	 * 页面数据分页显示
	 * @param pager
	 * @return
	 */
	public PageInfo findByPageInFo(Enetiy enetiy,PageInfo pager){
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select id,lpid,(select sc.name from lp_syscs_1 sc where sc.id=m_type) m_type,company_name,tel,address,remark,m_type as mantenanceType ");
		sqlcommon.append(" from lp_maintenance_unit where flag =1 and lpid = "+enetiy.getLpid());
		sqlcommon.append("  order by id desc ");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
		/**
		 * 新增维护单位
		 * @param enetiy
		 * @param strategy
		 * @return
		 */
		public LpMaintenanceUnit AddCBMU(Enetiy enetiy ,String strategy){
			String sqlcompanyName = "select from " + LpMaintenanceUnit.class.getName() + " where companyName=='" + enetiy.getCompanyName() + "' && flag==0 order by id desc ";
			
			String sql = "select from " + LpMaintenanceUnit.class.getName() + " where id==" + enetiy.getId() + " ";
			
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			List<LpMaintenanceUnit> countries = new ArrayList<LpMaintenanceUnit>();
			if(enetiy.getId()!=null&&enetiy.getId()!=0){
				countries= (List<LpMaintenanceUnit>)pm.newQuery(sql).execute();
			}else{
				countries= (List<LpMaintenanceUnit>)pm.newQuery(sqlcompanyName).execute();
			}
			
			LpMaintenanceUnit lpMaintenanceUnit=null;
			if(countries!=null && countries.size()>0){
				lpMaintenanceUnit = countries.get(0);
			} else {
				lpMaintenanceUnit= new LpMaintenanceUnit();
			}
			
			lpMaintenanceUnit.setLpid(enetiy.getLpid());
			if(enetiy.getmType() != null && enetiy.getmType() !=""){
				lpMaintenanceUnit.setMType(Integer.parseInt(enetiy.getmType()));
			}
			if(enetiy.getCompanyName() != null && enetiy.getCompanyName() !=""){
			lpMaintenanceUnit.setCompanyName(enetiy.getCompanyName());
			}
			if(enetiy.getTel() != null && enetiy.getTel() !=""){
				lpMaintenanceUnit.setTel(enetiy.getTel());
			}
			if(enetiy.getAddress() != null && enetiy.getAddress() !=""){
				lpMaintenanceUnit.setAddress(enetiy.getAddress());
			}
			if(enetiy.getRemark() != null && enetiy.getRemark() !=""){
				lpMaintenanceUnit.setRemark(enetiy.getRemark());
			}
			lpMaintenanceUnit.setCreatedate(new Date());
			lpMaintenanceUnit.setFlag(1);
			Transaction tx=pm.currentTransaction();
			try{
				tx.begin();
				pm.makePersistent(lpMaintenanceUnit);
				tx.commit();
			}catch(Exception e){
				tx.rollback();
				e.printStackTrace();
			}finally
			{
				if(tx.isActive())
				{
					tx.rollback();
				}
				pm.close();
			}
		
			return lpMaintenanceUnit;
		}
		/**
		 * 新增判断
		 * @param enetiy
		 * @param strategy
		 * @return
		 */
		public long update(Enetiy enetiy,String strategy){
			Integer number = null;
			String sql = "select count(*) from  lp_maintenance_unit where flag =1 and company_name = '" +enetiy.getCompanyName()+"'";
			PersistenceManager pm=getPersistenceManagerByStratey(strategy);
			Query query =pm.newQuery("SQL",sql.toString());
			List<Object> list =(List<Object>)query.execute();
			number=Integer.parseInt(list.get(0).toString());
			pm.close();
			return number;
		}
		
		public LpMaintenanceUnit  getById(Integer id,String strategy){
			PersistenceManager pm= this.getPersistenceManagerByStratey(strategy);
			LpMaintenanceUnit entity=pm.getObjectById(LpMaintenanceUnit.class,id);
			pm.close();
			return entity;
		}
		
		public int  deleteLPM(Integer id,String strategy){
			PersistenceManager pm= this.getPersistenceManagerByStratey(strategy);
			Transaction tx = pm.currentTransaction();
			try {
				tx.begin();
				LpMaintenanceUnit entity=pm.getObjectById(LpMaintenanceUnit.class,id);
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
		
		
		public int addType(String typeNames,String strategy){
			if(typeNames ==null || typeNames =="")
			{
				return -1;
			}
			String[] names = typeNames.split(",");
			String name = null;
			try{
				PersistenceManager pm = getPersistenceManagerByStratey(strategy);
				String sql = "select sid from lp_syscs where name like '%维护单位%'";
				Query query = pm.newQuery("SQL",sql);
				ForwardQueryResult queryResult = (ForwardQueryResult) query.execute();
				Integer  sid = Integer.valueOf(queryResult.get(0).toString());

				String sqlMax = "select max(id) from lp_syscs_1";
				Query queryMax = pm.newQuery("SQL",sqlMax);
				ForwardQueryResult queryResultMax = (ForwardQueryResult) queryMax.execute();
				Integer  idMax = Integer.valueOf(queryResultMax.get(0).toString());
				
				Transaction tx = pm.currentTransaction();
				tx.begin();
				
				LpSyscs1 newLpSyscs1 = null;
				for (int i = 0; i < names.length; i++) {
					idMax++;
					newLpSyscs1 = new LpSyscs1();
					name = names[i];
					newLpSyscs1.setId(idMax);
					newLpSyscs1.setName(name);
					newLpSyscs1.setSid(sid);
					newLpSyscs1.setStatus((byte) 1);
					newLpSyscs1.setCreateDate(new Date());
					pm.makePersistent(newLpSyscs1);
				}
				tx.commit();
				pm.close();
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}
