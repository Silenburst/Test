package com.newenv.lpzd.base.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;
import org.mortbay.log.Log;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.LpSchoolOperationLog;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.base.domain.XhjLpschoolimg;
import com.newenv.lpzd.base.domain.pojo.BaseCondition;
import com.newenv.lpzd.base.domain.pojo.LpSchoolLog;
import com.newenv.lpzd.base.domain.pojo.SchoolArea;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.util.StringUtils;
import com.newenv.pagination.PageInfo;

public class XhjLpschoolDao  extends DaoParent<XhjLpschool>{
	/**
	 * 刪除學校  更改狀態 假刪
	 * @param id
	 * @param strategy
	 * @return
	 */
	public int delSchool(int id,String strategy) {
		Long number = null;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
			Query query1 = pm.newQuery(XhjLpschool.class);
			query1.setFilter(" id == "+id);
			List<XhjLpschool> schools = (List<XhjLpschool>)query1.execute();
			if(schools != null && schools.size()>0)
			{
				XhjLpschool xhjLpschool = schools.get(0);
			    setLog("删除","删除了"+ xhjLpschool.getSchoolName(),id,strategy);
			}
		    
			Query query = pm.newQuery("update "+XhjLpschool.class.getName()+" set statuss == 0 WHERE id =="+id);
			number = (Long) query.execute();
			
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
		return Integer.valueOf(number.toString());
	}
	
	public void setLog(String type,String message,Integer schoolid,String strategy)
	{
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
			LpSchoolOperationLog lg = new LpSchoolOperationLog();
			UserLogin currentUserLogin = com.newenv.lpzd.security.service.SecurityUserHolder.getCurrentUserLogin();
			lg.setDepartmentId(currentUserLogin.getDepartment().getId()==null?-1:currentUserLogin.getDepartment().getId());
			lg.setIpAddress(currentUserLogin.getUserLogin().getIp());
			lg.setIsPhone(1);
			lg.setMessage(message);
			lg.setOperationtype(type);
			lg.setOperatorId(currentUserLogin.getUserProfile().getId());
			lg.setRemark(currentUserLogin.getUserLogin().getTel());
			lg.setSchoolid(schoolid);
			lg.setOperateDate(new Timestamp(new Date().getTime()));
			pm.makePersistent(lg);
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
	}
	
	/**
	 * 刪除學校  更改狀態 假刪
	 * @param id
	 * @param strategy
	 * @return
	 */
	public int delImage(int lpschoolid,String strategy) {
		Long number = null;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
			Query query = pm.newQuery("delete from "+XhjLpschoolimg.class.getName()+" set statuss == 0 WHERE LPSchoolID =="+lpschoolid);
			number = (Long) query.execute();
			
			setLog("删除","删除了"+number+"条图片记录",lpschoolid,strategy);
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
		return Integer.valueOf(number.toString());
	}
	
	public int getMaxId(String name,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		String sqlMax = "select max(id) from "+name;
		Query queryMax = pm.newQuery("SQL",sqlMax);
		ForwardQueryResult queryResultMax = (ForwardQueryResult) queryMax.execute();
		Integer  idMax = Integer.valueOf(queryResultMax.get(0).toString());
		pm.close();
		return idMax;
	}
	/**
	 * 添加學校信息
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public String addSchool(BaseCondition condition,String strategy)
	{
		PersistenceManager pm=null;
		Transaction tx=null;
		try{
			if( null != condition  && condition.getXhjLpschool() !=null){
				pm=getPersistenceManagerByStratey(strategy);
				tx=pm.currentTransaction();
				tx.begin();
				String message = "";
				int maxId = equeasParams(condition.getSchoolid())==""?0:Integer.valueOf(condition.getSchoolid());
				if(maxId <= 0)
				{
					maxId = getMaxId("xhj_lpschool", strategy)+1;
				}
				
				Query query = pm.newQuery(XhjLpschool.class);
				query.setFilter("id=="+maxId);
				List<XhjLpschool> execute = (List<XhjLpschool>)query.execute();
				
				XhjLpschool xhjLpschool = null;
				if(execute != null && execute.size() >0)
				{
					xhjLpschool =execute.get(0);
					
				}else
				{
					xhjLpschool = condition.getXhjLpschool();
					xhjLpschool.setId(maxId);
				}
				xhjLpschool.setCreateDate(new Timestamp(new Date().getTime()));
				xhjLpschool.setMapXy(condition.getXxzbx()+","+condition.getXxzby());
				xhjLpschool.setStatuss(1);
				int userid = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
				xhjLpschool.setCreatorId(userid);
				condition.setSchoolid(equeasParams(xhjLpschool.getId()));
				pm.makePersistent(xhjLpschool);
				
				message+="添加了"+xhjLpschool.getSchoolName();
				//第三页//图片上传
				Query qimg=pm.newQuery(XhjLpschoolimg.class);
				qimg.setFilter("lpSchoolID =="+equeasParams(xhjLpschool.getId()));
				List<XhjLpschoolimg> ilist = (List<XhjLpschoolimg>)qimg.execute();
				pm.deletePersistentAll(ilist);
				
				List<XhjLpschoolimg> imageUrls = condition.getImageUrl();
				int maxId2 = 0;
				int number = 1;
				if( null != imageUrls  && imageUrls.size()>0 )
				{
					for (XhjLpschoolimg xhjLpschoolimg : imageUrls) {
						if(xhjLpschoolimg != null ) {
							//xhjLpschoolimg.setTime(new Timestamp(new Date().getTime()));
							maxId2 = getMaxId("xhj_lpschoolimg", strategy)+1;
							xhjLpschoolimg.setId(maxId2);
							xhjLpschoolimg.setLpSchoolID(maxId);
							xhjLpschoolimg.setStatuss(1);
							pm.makePersistent(xhjLpschoolimg);
							maxId2++;
							number++;
						}
					}
					message+=",添加了"+number+"张图片";
					setLog("添加",message,maxId,strategy);
				}
				tx.commit();
			}
		}catch(Exception e){
			e.printStackTrace();
			Log.info("error: add school fail!");
			return null;
		}finally
		{
		    if (tx.isActive())
		    {
		        tx.rollback();
		    }
		    pm.close();
		}
		return  condition.getSchoolid();
	}
	/**
	 * 批量刪除的學校
	 * @param ids
	 * @param strategy
	 * @return
	 */
	public int deleteAllSchool(String ids,String strategy)
	{
		if(ids ==null || ids =="")
		{
			return -1;
		}
		String[] names = ids.split(",");
		int count = 0;
//		getObjectsByIDs(names, strategy);
//		pm.deletePersistentAll(arg0)
		String id = null;
		for (int i = 0; i < names.length; i++) {
			count++;
			id = names[i];
			delSchool(Integer.valueOf(id), strategy);
		}
		return count;
	}
	/**
	 * 更新修改學校信息
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public int updateSchool(BaseCondition condition,String strategy)
	{
		
 		int result=0;
		PersistenceManager pm=null;
		Transaction tx=null;
		try{
			int id = condition.getXhjLpschool().getId();
			if(condition !=null && condition.getXhjLpschool() !=null && id > 0){
				pm=getPersistenceManagerByStratey(strategy);
				tx=pm.currentTransaction();
				tx.begin();
				
				String message = "";
				Query q=pm.newQuery(XhjLpschool.class);
				q.setFilter("id =="+id);
				List<XhjLpschool> tlist = (List<XhjLpschool>)q.execute();
				XhjLpschool newxhjLpschool = condition.getXhjLpschool();
				if(tlist!=null && tlist.size() >0){
					XhjLpschool xhjLpschool=tlist.get(0);
					xhjLpschool.setId(newxhjLpschool.getId());
					xhjLpschool.setCountryid(newxhjLpschool.getCountryid());
					xhjLpschool.setProvinceid(newxhjLpschool.getProvinceid());
					xhjLpschool.setCityID(newxhjLpschool.getCityID());
					xhjLpschool.setQyID(newxhjLpschool.getQyID());
					xhjLpschool.setSqid(newxhjLpschool.getSqid());
					xhjLpschool.setSchoolName(newxhjLpschool.getSchoolName());
					xhjLpschool.setSchoolLevel(newxhjLpschool.getSchoolLevel());
					xhjLpschool.setSchoolType(newxhjLpschool.getSchoolType());
					xhjLpschool.setKind(newxhjLpschool.getKind());
					xhjLpschool.setAddress(newxhjLpschool.getAddress());
					xhjLpschool.setMapXy(condition.getXxzbx()+","+condition.getXxzby());
					xhjLpschool.setPhone(newxhjLpschool.getPhone());
					xhjLpschool.setEmail(newxhjLpschool.getEmail());
					xhjLpschool.setSchoolWebsite(newxhjLpschool.getSchoolWebsite());
					xhjLpschool.setTeacherNum(newxhjLpschool.getTeacherNum());
					xhjLpschool.setStudentNum(newxhjLpschool.getStudentNum());
					xhjLpschool.setClassNum(newxhjLpschool.getClassNum());
					xhjLpschool.setSchoolRemark(newxhjLpschool.getSchoolRemark());
					xhjLpschool.setRecruitStudentsInfo(newxhjLpschool.getRecruitStudentsInfo());

					xhjLpschool.setStatuss(1);
					xhjLpschool.setCreateDate(new Timestamp(new Date().getTime()));
				//	xhjLpschool.setMapXy(condition.getXxzbx()+","+condition.getXxzby());
					int userid = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
					xhjLpschool.setCreatorId(userid);
					pm.makePersistent(xhjLpschool);
				}
				//第三页//图片上传
				Query qimg=pm.newQuery(XhjLpschoolimg.class);
				qimg.setFilter("lpSchoolID =="+id);
				List<XhjLpschoolimg> ilist = (List<XhjLpschoolimg>)qimg.execute();
				pm.deletePersistentAll(ilist);
				
				List<XhjLpschoolimg> imageUrls = condition.getImageUrl();
				int maxId2 = 0;
				if(null != imageUrls && imageUrls.size()>0 )
				{
					for (XhjLpschoolimg xhjLpschoolimg : imageUrls) {
						if(xhjLpschoolimg != null ) {
							//xhjLpschoolimg.setTime(new Timestamp(new Date().getTime()));
							XhjLpschoolimg xhjimg = new XhjLpschoolimg();
							maxId2 = getMaxId("xhj_lpschoolimg", strategy)+1;
							xhjimg.setId(maxId2);
							xhjimg.setLpSchoolID(id);
							xhjimg.setStatuss(xhjLpschoolimg.getStatuss());
							xhjimg.setType(xhjLpschoolimg.getType());
							xhjimg.setImg(xhjLpschoolimg.getImg());
							pm.makePersistent(xhjimg);
							maxId2++;
						}
					}
				}
				
				tx.commit();
				result=1;//1有数据  0 无数据
				message+="更新了"+condition.getXhjLpschool().getSchoolName()+"信息";
				setLog("更新",message,id,strategy);
				message+=",更新了图片信息";
				setLog("更新",message,id,strategy);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally
		{
		    if (tx.isActive())
		    {
		        tx.rollback();
		        Log.debug("事务回滚，修改错误！");
		    }
		    pm.close();
		}
		return  result;
	}
	
	/**
	 * 更新修改學校信息
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public BaseCondition updateDetail(int schoolid,String strategy)
	{
		BaseCondition condition = new BaseCondition();
		if(schoolid != 0){
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			Transaction tx = pm.currentTransaction();
			tx.begin();
			
			Query q=pm.newQuery(XhjLpschool.class);
			q.setFilter(" statuss==1 && id=="+schoolid);
			condition.setSchoolid(equeasParams(schoolid));
			List<XhjLpschool> slist = (List<XhjLpschool>)q.execute();
			if(slist!=null && slist.size() >0){
				XhjLpschool xhjLpschool=slist.get(0);
				condition.setXhjLpschool(xhjLpschool);
				String xy = xhjLpschool.getMapXy();
				if(xy != null && xy !="")
				{
					String[] split = xhjLpschool.getMapXy().split(",");
					condition.setXxzbx(split[0]);
					condition.setXxzby(split[1]);
				}else
				{
					condition.setXxzbx("");
					condition.setXxzby("");
				}
			//	String message="即将更新学校"+xhjLpschool.getSchoolName()+"信息";
			//	setLog("更新",message,schoolid,strategy);
			}
			//第三页//图片上传
			Query qimg=pm.newQuery(XhjLpschoolimg.class);
			qimg.setFilter(" statuss==1 && lpSchoolID =="+schoolid);
			List<XhjLpschoolimg> imageUrl = (List<XhjLpschoolimg>)qimg.execute();
			condition.setImageUrl(imageUrl);
			
			pm.close();
			return condition;
		}
		return  null;
	}
	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<XhjLpschool> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjLpschool.class);
		query.setFilter("statuss==1");
		List<XhjLpschool> list = (List<XhjLpschool>)query.execute();
		pm.close();
		return list;
	}
//	
//	public List<XhjLpschool> findByQyid(String qyid,String strategy){
//		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
//		Query query = pm.newQuery(XhjLpschool.class);
//		query.setFilter("QYID=="+qyid);
//		query.setFilter("statuss==1");
//		return (List<XhjLpschool>)query.execute();
//	}
	/**
	 * [\Type\]:School|this is school type manager----
	 * @author chenxiang
	 * @param typeNames
	 * @param strategy
	 * @return
	 */
	public int addType(String typeNames,String strategy){
		if(typeNames ==null || typeNames =="")
		{
			return -1;
		}
		String[] names = typeNames.split(",");
		String name = null;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try{
			String sql = "select sid from lp_syscs where name like '%学校类别%'";
			Query query = pm.newQuery("SQL",sql);
			ForwardQueryResult queryResult = (ForwardQueryResult) query.execute();
			Integer  sid = Integer.valueOf(queryResult.get(0).toString());

			String sqlMax = "select max(id) from lp_syscs_1";
			Query queryMax = pm.newQuery("SQL",sqlMax);
			ForwardQueryResult queryResultMax = (ForwardQueryResult) queryMax.execute();
			Integer  idMax = Integer.valueOf(queryResultMax.get(0).toString());
			
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
//				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(new Date
				newLpSyscs1.setCreateDate(new Date());
				pm.makePersistent(newLpSyscs1);
			}
			String message="添加了学校类型"+typeNames+"信息";
			setLog("添加",message,-1,strategy);
			
			tx.commit();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}finally
		{
		    if (tx.isActive())
		    {
		        tx.rollback();
		        Log.debug("事务回滚，修改错误！");
		    }
		    pm.close();
		}
		return -1;
	}
	/**
	 * 删除单个学校类型
	 * @param id
	 * @param strategy
	 * @return
	 */
	public int delType(int id,String strategy) {
		Long number = null;
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			Query query1 = pm.newQuery(LpSyscs1.class.getName());
			query1.setFilter("id =="+id);
			LpSyscs1 ls =  (LpSyscs1) query1.execute();
			
			String message="删除了学校类型"+ls.getName()+"的信息";
			setLog("删除",message,-1,strategy);
			
			Query query = pm.newQuery("update "+LpSyscs1.class.getName()+" set statuss == 0 WHERE id =="+id);
			number = (Long) query.execute();
			
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally
		{
		    if (tx.isActive())
		    {
		        tx.rollback();
		        Log.debug("事务回滚，修改错误！");
		    }
		    pm.close();
		}
		return Integer.valueOf(number.toString());
	}
	/**
	 * 批量更新学校类型
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public int updateType(BaseCondition condition,String strategy){
		int count = 0;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			List<LpSyscs1> names = condition.getNames();
			LpSyscs1 upLpSyscs1 = null;
			
			String ids = condition.getIds();
			if(ids.length()>0)
			{
				String[] split = ids.substring(1).split(",");
				String sql = "status==1  && (";
				for (int i =0;i< split.length ;i++) {
					sql+=" id == " + split[i];
					if(split.length-1 == i)
					{
						continue;
					}
					sql+=" || ";
				}
				sql+=")";
				Query query = pm.newQuery(LpSyscs1.class);
				query.setFilter(sql);
				List<LpSyscs1> lsList = (List<LpSyscs1>)query.execute();
				for (LpSyscs1 lpSyscs1 : lsList) {
					lpSyscs1.setStatus((byte)0);
					lpSyscs1.setCreateDate(new Date());
					pm.makePersistent(lpSyscs1);
					count++;
				}
				//pm.deletePersistentAll(lsList);
			}
			
			for (LpSyscs1 lpSyscs1 : names) {
				//获取页面删除的数据id
				Query query = pm.newQuery(LpSyscs1.class);
				query.setFilter("status==1 && id==" +lpSyscs1.getId());
				List<LpSyscs1> lsList = (List<LpSyscs1>)query.execute();
				if(lsList.size() > 0 && lsList.get(0) != null)
				{
					upLpSyscs1 = lsList.get(0);
					upLpSyscs1.setName(lpSyscs1.getName());
					upLpSyscs1.setStatus((byte) 1);
					upLpSyscs1.setCreateDate(new Date());
					pm.makePersistent(upLpSyscs1);
				}
			}
			
			String message="更新了学校类型的信息";
			setLog("更新",message,-1,strategy);
			tx.commit();
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally
		{
		    if (tx.isActive())
		    {
		        tx.rollback();
		        Log.debug("事务回滚，修改错误！");
		    }
		    pm.close();
		}
		return count;
	}
	/**
	 * 根据学校ID找到学校对象
	 * @param id
	 * @param strategy
	 * @return
	 */
	public BaseCondition findSchoolById(Integer id,String strategy){
		BaseCondition condition = new BaseCondition();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(XhjLpschool.class);
		query.setFilter(" statuss==1 && id=="+id);
		
		List<XhjLpschool> schoolList = (List<XhjLpschool>)query.execute();
		XhjLpschool xhjLpschool = null;
		
		if(schoolList.size()>0 && schoolList!=null)
		{
			xhjLpschool = schoolList.get(0);
			int schoolid = xhjLpschool.getId();
			
			String message="查询了"+xhjLpschool.getSchoolName()+"的详情";
			setLog("查询",message,id,strategy);
			
			/*学校图库*/
			Query query1 = pm.newQuery(XhjLpschoolimg.class);
			query1.setFilter(" statuss==1 && lpSchoolID=="+schoolid);
			List<XhjLpschoolimg> imageUrl = (List<XhjLpschoolimg>)query1.execute();
			condition.setImageUrl(imageUrl);
			
			condition.setXhjLpschool(xhjLpschool);
			//名字
			String sql = "select s.SchoolName,c.c_name,p.p_name,cc.city_name,qy.qy_name,sq.sq_name ,";
				   sql +=" (select name from lp_syscs_1 where id = s.kind) kind,";
				   sql+=" (select name from lp_syscs_1 where id = s.schoolType) typeName,";
				   sql+=" (select name from lp_syscs_1 where id = s.schoolLevel) levelname";
				   sql+=" from xhj_lpschool s,lp_country c,lp_province p ,xhj_jccity cc,xhj_jcstress qy,xhj_jcsq sq";
				   sql +=" where  s.countryid = c.id and s.provinceid = p.id ";
				   sql +=" and s.CityId = cc.id and s.qyid = qy.id and s.sqid = sq.id and s.id= "+schoolid;
			Query queryAll = pm.newQuery("SQL",sql);
			ForwardQueryResult queryResult = (ForwardQueryResult)queryAll.execute();
			if(queryResult.size()>0 && queryResult!=null)
			{
				Object[] objects = (Object[])queryResult.get(0);
				condition.setGuojia(equeasParams(objects[1]));
				condition.setShengfen(equeasParams(objects[2]));
				condition.setChengshi(equeasParams(objects[3]));
				condition.setQuyu(equeasParams(objects[4]));
				condition.setShangquan(equeasParams(objects[5]));
				condition.setSchoolxingzhi(equeasParams(objects[6]));
				condition.setSchoolType(equeasParams(objects[7]));
				condition.setSchooldengji(equeasParams(objects[8]));
			}
//			/*学校图库*/
//			String tukusql = "select *from xhj_lpschoolimg where statuss = 1 and lpschoolid = "+schoolid;
//			
//			Query tukuquery = pm.newQuery("SQL",tukusql);
//			List<XhjLpschoolimg> tukufqr = (List<XhjLpschoolimg>)tukuquery.execute();
//			if(tukufqr.size()>0 && tukufqr!=null)
//			{
//				condition.setImageUrl(tukufqr);
//			}
//			
			/*划片小区*/
			String huapiansql = "select ls.type,ls.dname ,(select lp_name from xhj_lpxx where id=ls.lpid ) lpname ,"
					+" (select name from lp_syscs_1 where id=ls.schooltype ) typeName ,"
					+" (select count(1) from xhj_lpfanghao fh where fh.fwzt = 0 and fh.lpid = ls.lpid)  kz_num ,"
					+" (select count(1) from xhj_lpfanghao fh where (fh.FWZT=1 or fh.FWZT=3)  and fh.lpid = ls.lpid)  cs_num ,"
					+" (select count(1) from xhj_lpfanghao fh where (fh.FWZT=2 or fh.FWZT=3) and fh.lpid = ls.lpid) cz_num ,"
					+" (select count(id) from  xhj_newhouseinfo xn where xn.ProjectID=ls.lpid) xf_num"
					+" from xhj_lplinkschool ls where  1=1  and ls.schoolid= "+schoolid;
			
			Query huapianquery = pm.newQuery("SQL",huapiansql);
			ForwardQueryResult queryResulthp = (ForwardQueryResult)huapianquery.execute();
			List<SchoolArea> schoolAreas =  new ArrayList<SchoolArea>();
			if(queryResulthp.size()>0 && queryResulthp!=null)
			{
				SchoolArea schoolArea = null;
				for (int i = 0;i<queryResulthp.size();i++) {
					Object[] objects = (Object[])queryResulthp.get(i);
					schoolArea = new SchoolArea();
					schoolArea.setType(equeasParams(objects[0])==""?0:Integer.valueOf(equeasParams(objects[0])));
					String equeasParams = equeasParams(objects[1]);
					String[] splits = equeasParams.split(",");
					List<String> list  =  new ArrayList<String>();
					for (String string : splits) {
						list.add(string);
					}
					schoolArea.setDnames(list);
					schoolArea.setLpname(equeasParams(objects[2]));
					schoolArea.setCount0(equeasParams(objects[4]));
					schoolArea.setCount1(equeasParams(objects[5]));
					schoolArea.setCount2(equeasParams(objects[6]));
					schoolArea.setCountNew(equeasParams(objects[7]));
					schoolAreas.add(schoolArea);
				}
				condition.setSchoolAreas(schoolAreas);
			}
//			UserLogin currentUserLogin = com.newenv.lpzd.security.service.SecurityUserHolder.getCurrentUserLogin();
			/*最新状态*/
			String sqllog = "select id,(select Department_Name from tbl_Department where id = ll.DepartmentID ) departmentName,"
					+" (select fullname from tbl_user_profile where id =ll.OperatorID) fullname,"
					+" operateDate,ipaddress,message,isphone,remark,schoolid,operationtype,"
					+" (select tel from tbl_user_profile where id =ll.OperatorID) tel "
					+" from lp_school_operation_log ll where schoolid = "+schoolid +" order by operateDate desc limit 0,5";
			Query queryLog = pm.newQuery("SQL",sqllog);
			ForwardQueryResult queryResultlplogs = (ForwardQueryResult)queryLog.execute();
			List<LpSchoolLog> lpSchoollogs =  new ArrayList<LpSchoolLog>();
			if(queryResultlplogs.size()>0 && queryResultlplogs!=null)
			{
				LpSchoolLog lplog = null;
				for (int i = 0;i<queryResultlplogs.size();i++) {
					Object[] objects = (Object[])queryResultlplogs.get(i);
					lplog = new LpSchoolLog();
					lplog.setId(equeasParams(objects[0])==""?0:Long.valueOf(equeasParams(objects[0])));
					lplog.setDepartmentName(equeasParams(objects[1]));
					lplog.setOperatorName(equeasParams(objects[2]));
					lplog.setOperateDate(equeasParams(objects[3]));
					lplog.setIpAddress(equeasParams(objects[4]));
					lplog.setMessage(equeasParams(objects[5]));
					lplog.setIsPhone(Integer.valueOf(equeasParams(objects[6])));
					lplog.setRemark(equeasParams(objects[7]));
					lplog.setOperationtype(equeasParams(objects[9]));
					lplog.setPhone(equeasParams(objects[10]));
					lpSchoollogs.add(lplog);
				}
				condition.setLpSchoolLogs(lpSchoollogs);
			}
		}
		pm.close();
		return condition;
	}
	/**
	 * 查询所有学校类型，展示页面学校类型条件
	 * @param name
	 * @param strategy
	 * @return
	 */
	public List<LpSyscs1> findBySchoolType(String name,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		String sql = "select id,name from lp_syscs_1  where sid in (select sid from lp_syscs where name like '%"+name+"%') and statuss = 1";
		Query query = pm.newQuery("SQL",sql);
		List<LpSyscs1> lpSyscs1List = (List<LpSyscs1>)query.execute();
		pm.close();
		if(lpSyscs1List.size()>0 && lpSyscs1List!=null)
		{
			return lpSyscs1List;
		}
		return null;
	}
	/***
	 * 页面列表展示
	 * @param page
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public PageInfo findSchoolByPage(PageInfo page, BaseCondition condition, String strategy){
		StringBuffer sb = new StringBuffer();
		Query  query=null;
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		String sql = "select id,cityid,qyid,schoolname,address,schoolArea,schoolwebsite,IF(recruitStudentsInfo = '','无简章','有简章') as sw, (select count(*) from xhj_lplinkschool where schoolid=s.id) lpcount from  xhj_lpschool s where  statuss=1 ";
	
		if(condition.getXhjLpschool().getCountryid() !=null && condition.getXhjLpschool().getCountryid()>0)
		{
			sb.append(" and ");
			sb.append("countryId").append("=").append(condition.getXhjLpschool().getCountryid());
		}
		
		
		if(condition.getXhjLpschool().getProvinceid() !=null && condition.getXhjLpschool().getProvinceid()>0)
		{
			sb.append(" and ");
			sb.append("provinceId").append("=").append(condition.getXhjLpschool().getProvinceid());
		}
		
		if(condition.getXhjLpschool().getCityID() !=null && condition.getXhjLpschool().getCityID()>0)
		{
			sb.append(" and ");
			sb.append("CityId").append("=").append(condition.getXhjLpschool().getCityID());
		}
		

		if(condition.getXhjLpschool().getQyID() !=null && condition.getXhjLpschool().getQyID()>0)
		{
			sb.append(" and ");
			sb.append("qyid").append("=").append(condition.getXhjLpschool().getQyID());
		}
		
		if(condition.getXhjLpschool().getSqid() !=null && condition.getXhjLpschool().getSqid()>0)
		{
			sb.append(" and ");
			sb.append("sqid").append("=").append(condition.getXhjLpschool().getSqid());
		}
		
		if(condition.getXhjLpschool().getSchoolType() !=null && condition.getXhjLpschool().getSchoolType()>0)
		{
			sb.append(" and ");
			sb.append("schoolType").append("=").append(condition.getXhjLpschool().getSchoolType());
		}
		
		if(condition.getXuequName() !=null && condition.getXuequName() !="")
		{
			sb.append(" and schoolname like '%").append(condition.getXuequName()).append("%'");
		}
		
		sb.append(" Order by CreateDate "+PageInfo.SORT_ORDER_DESC);
		String sqlCount =  "select count(s.id) from ("+sql+sb.toString()+") s";
		
		Query queryCount = pm.newQuery("SQL",sqlCount);
		ForwardQueryResult queryResultCount = (ForwardQueryResult)queryCount.execute();
		page.setRecords(Integer.valueOf(queryResultCount.toArray()[0].toString()));
		
		
        if (page.getRecords() == 0) {
        	page.setTotal(0);	//总共有多少页
        }else{
        	int total = (page.getRecords()+page.getRows()-1)/page.getRows();
        	page.setTotal(total);
        }
        sb.append(" LIMIT "+(page.getPage()-1)*page.getRows()+","+page.getRows());
//        sb.append(" limit "+  (page.getPage()-1)* 5 +","+page.getRows());
        
        sql +=sb.toString();
		
		query = pm.newQuery("SQL",sql);
		List<XhjLpschool> gridModel  = new ArrayList<XhjLpschool>();
		XhjLpschool xhjLpSchool = null;
		ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();

		Object[] objects = null;
		try{
			for (int i = 0; i < queryResult.size(); i++) {
				objects = (Object[]) queryResult.get(i);
				xhjLpSchool = new XhjLpschool();
				xhjLpSchool.setId(Integer.valueOf(equeasParams(objects[0]) != ""?objects[0].toString():"0"));
				xhjLpSchool.setLpcount(equeasParams(objects[8]));
				xhjLpSchool.setSchoolName(equeasParams(objects[3]));
				xhjLpSchool.setAddress(equeasParams(objects[4]));
				//xhjLpSchool.setSchoolArea(equeasParams(objects[5]));
				String recruitStudentsInfo = StringUtils.replaceBlank(equeasParams(objects[7]));
				xhjLpSchool.setRecruitStudentsInfo(recruitStudentsInfo);
				gridModel.add(xhjLpSchool);
			}
			page.setGridModel(gridModel);
			pm.close();
		}catch (Exception e )
		{
			e.printStackTrace();
		}
		
		String message="查看了学区管理信息";
		setLog("查询",message,-1,strategy);
		return page;
	}
	
	
	public static String equeasParams(Object obj)
	{
		String object = String.valueOf(obj);
		if(object.equals("") || object == null || object.equals("null") || object.equals("Null"))
		{
			return "";
		}
		return object.toString();
	}
}
