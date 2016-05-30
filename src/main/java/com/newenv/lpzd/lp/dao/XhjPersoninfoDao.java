package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.XhjFangHaoUtil;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;

public class XhjPersoninfoDao extends DaoParent<XhjPersoninfo>{
	
	
	public String savePersoninfo(XhjPersoninfo xhjPersoninfo, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		String id = "";
		if(xhjPersoninfo.getId() == null || xhjPersoninfo.getId() == 0) {
			id = getNextSeqId(XhjPersoninfo.class);
			xhjPersoninfo.setId(Integer.valueOf(id));
			xhjPersoninfo.setCreateDate(new Timestamp(new Date().getTime()));
			xhjPersoninfo.setStatuss(1);
			Transaction tx = pm.currentTransaction();
			try {
				tx.begin();
				Query query = pm.newQuery(XhjPersoninfo.class);
				query.setFilter("name=='" + xhjPersoninfo.getName()+"' && cityId==" + xhjPersoninfo.getCityId());
				List<XhjPersoninfo> xhjPersoninfoList = (List<XhjPersoninfo>)query.execute();
				if(xhjPersoninfoList == null || xhjPersoninfoList.size() == 0) {
					pm.makePersistent(xhjPersoninfo);
				} else {
					throw new Exception("当前业主名已存在,请确认后在保存!");
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
		} else {
			id = xhjPersoninfo.getId().toString();
			XhjPersoninfo oldxhjPersoninfo = pm.getObjectById(XhjPersoninfo.class, xhjPersoninfo.getId());
			if(xhjPersoninfo.getName().equals(xhjPersoninfo.getName())) {
				oldxhjPersoninfo = oldLpxxPerNewLpxx(oldxhjPersoninfo, xhjPersoninfo);
				Transaction tx = pm.currentTransaction();
				try {
					tx.begin();
					pm.makePersistent(oldxhjPersoninfo);
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
				Query query = pm.newQuery(XhjPersoninfo.class);
				query.setFilter("name=='" + xhjPersoninfo.getName()+"' && cityId==" + xhjPersoninfo.getCityId());
				List<XhjPersoninfo> xhjPersoninfoList = (List<XhjPersoninfo>)query.execute();
				if(xhjPersoninfoList == null || xhjPersoninfoList.size() == 0) {
					oldxhjPersoninfo = oldLpxxPerNewLpxx(oldxhjPersoninfo, xhjPersoninfo);
					Transaction tx = pm.currentTransaction();
					try {
						tx.begin();
						pm.makePersistent(oldxhjPersoninfo);
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
					throw new Exception("当前业主名已存在,请确认后在修改!");
				}
			}
		}
		return id;
	}
	public XhjPersoninfo getXhjPersoninfo(Integer personId,String strategy){
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			XhjPersoninfo xhjPersoninfo=pm.getObjectById(XhjPersoninfo.class,personId);
			//getxhjPersoninfoValue(pm,xhjPersoninfo);
			return xhjPersoninfo;
	}
	
	public void getxhjPersoninfoValue(PersistenceManager pm,XhjPersoninfo xhjPersoninfo){
		String sql="select (select cc.id from xhj_jccity cc where cc.id=y.CityID) CityID,";
		sql+="(select sc.name from lp_syscs_1 sc where y.Nationality=sc.id ) Nationality, ";
		sql+="(select sc.name from lp_syscs_1 sc where y.ConsumptionConcept=sc.id ) ConsumptionConcept, ";
		sql+="(select sc.name from lp_syscs_1 sc where y.Education=sc.id ) Education ";
		sql +="from xhj_personinfo y  ";
		sql+=" where  y.id="+xhjPersoninfo.getId();
		
		Query  query = pm.newQuery("SQL",sql);
		ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();
		if(queryResult.size()>0 && queryResult!=null)
		{
			Object[] objs = (Object[])queryResult.get(0);
			if(objs[0]!=null&&!"".equals(objs[0])){
				xhjPersoninfo.setCityId(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[0])));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				xhjPersoninfo.setNationality(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[1])));
			}
			if(objs[2]!=null&&!"".equals(objs[2])){
				xhjPersoninfo.setConsumptionConcept(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[2])));
			}
			if(objs[3]!=null&&!"".equals(objs[3])){
				xhjPersoninfo.setEducation(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[3])));
			}
		}
		pm.close();
	}


	
	
	/**
	 * 
	 * @param old 更新对象
	 * @param news 更新前对象
	 */
	private XhjPersoninfo oldLpxxPerNewLpxx(XhjPersoninfo old, XhjPersoninfo news){
		old.setName(news.getName());
		old.setWeXin(news.getWeXin());
		old.setQq(news.getQq());
		old.setIdentityCode(news.getIdentityCode());
		old.setNationality(news.getNationality());
		old.setCityId(news.getCityId());
		old.setEmail(news.getEmail());
		old.setConsumptionConcept(news.getConsumptionConcept());
		old.setEducation(news.getEducation());
		old.setWorkType(news.getWorkType());
		old.setBirthday(news.getBirthday());
		old.setWorkPlace(news.getWorkPlace());
		old.setOfficeAddress(news.getOfficeAddress());
		old.setHomeAddress(news.getHomeAddress());
		old.setGender(news.getGender());
		return old;
		
	}
}
