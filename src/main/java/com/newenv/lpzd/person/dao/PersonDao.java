package com.newenv.lpzd.person.dao;


import java.util.ArrayList;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;

import java.util.Date;

import java.util.List;

import java.util.Map;


import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;
import org.datanucleus.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.lp.domain.LpHouseOperationLog;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;
import com.newenv.lpzd.person.Condition;
import com.newenv.lpzd.person.LpAssignment;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;

import diqu.Information;
public class PersonDao  extends DaoParent<LpCountry>{
	
	public int insertBatchFenpai(Condition condition)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Transaction tx = pm.currentTransaction();
		if(null!=condition && null != condition.getAssign())
		{
			String fhids = condition.getFhids();
			if(null  == fhids || fhids.length()<=0)
			{
				return 0;
			}
			try
			{
				JSONArray parseArray = JSON.parseArray(fhids);
				tx.begin();
				LpAssignment assign =  condition.getAssign();
				for (int i = 0; i < parseArray.size(); i++) {
					Object object = parseArray.get(i);
					String jsonString = JSON.toJSONString(object);
//					String sql = "select * from lp_assignment where fhid ="+jsonString;
					LpAssignment assignNew = null;
					//-----OBJECT INSETT---UPDATE--
					Query query = pm.newQuery(LpAssignment.class);
					query.setFilter("fhid =="+jsonString);
					List<LpAssignment> assignList = (List<LpAssignment>)query.execute();
					if(null != assignList && assignList.size()>0)
					{
						assignNew = assignList.get(0);
					}else
					{
						assignNew = new LpAssignment();
					}
					//-----OBJECT INSETT-----
					if(assign.getUserid() == 0)
					{
						assignNew.setUserid(null);
					}else
					{
						assignNew.setUserid(assign.getUserid());
					}
					assignNew.setBmid(assign.getBmid());
					assignNew.setAssignPerson(assign.getAssignPerson());
					assignNew.setFhid(Integer.valueOf(jsonString==""?"0":jsonString));
					assignNew.setCreatedate(new Timestamp(new Date().getTime()));
					pm.makePersistent(assignNew);
				}
				tx.commit();
			}catch(Exception e)
			{
				e.printStackTrace();
				return 0;
			}finally
			{
				if(tx.isActive())
				{
					tx.rollback();
				}
				pm.close();
			}
		}
		return 1;
	}
	/**
	 * 查询部门
	 * @return
	 */
	public List<String[]> queryBM(String dianzuName)
	{		
		String sql = "select id,department_name,last_updated_stamp from tbl_department  where tbl_organization_id = 88  and flag=1 and cityId=" + SecurityUserHolder.getCurrentUserLogin().getCityId()
				+ " AND department_name like '%"+dianzuName.trim()+"%'";
//		 and cityid=1
		List<String[]>  lists = new ArrayList<String[]>();
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL",sql);
		ForwardQueryResult result = (ForwardQueryResult)query.execute();
		for (int i = 0; i < result.size(); i++) {
			Object[] objs = (Object[])result.get(i);
			String[] strs =  new String[3];
			strs[0] = String.valueOf(objs[0]);
			strs[1] = String.valueOf(objs[1]);
			strs[2] = String.valueOf(objs[2]);
			lists.add(strs);
		}
		pm.close();
		return lists;
	}
	
	/**
	 * 查询部门经理
	 * @return
	 */
	public List<String[]> queryBMJL(String departmentId)
	{		
//		String sql = "select id,fullname,tel from tbl_user_profile where tbl_department_id = "+dzid;
		String sql = "select up.id,up.fullname from tbl_user_profile up, tbl_user_login ul ,tbl_position p, tbl_department d "
				+" where up.id=ul.tbl_user_profile_id and p.tbl_user_id=ul.id and p.tbl_department_id=d.id and d.id="+departmentId;
		List<String[]>  lists = new ArrayList<String[]>();
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL",sql);
		ForwardQueryResult result = (ForwardQueryResult)query.execute();
		for (int i = 0; i < result.size(); i++) {
			Object[] objs = (Object[])result.get(i);
			String[] strs =  new String[2];
			strs[0] = String.valueOf(objs[0]);
			strs[1] = String.valueOf(objs[1]);
			lists.add(strs);
		}
		pm.close();
		return lists;
	}
	
	/**
	 * 查询楼盘
	 * @return
	 */
	public List queryLpName()
	{		
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1";
		PersistenceManager pm=this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query=pm.newQuery("SQL",sql);
		List execute = (List)query.execute();
		pm.close();
		return execute;
	}
	
	
	/**
	 * 查询dogn
	 * @return
	 */
	public List<Object[]> queryDong(String id)
	{		
		String sql ="select ld.id,ld.Lpd_Name from  Xhj_LpDong ld  where ld.LPID="+id;
		PersistenceManager pm=this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list = (List<Object[]>) query.execute();
		pm.close();
		return list;
	}
	
	
	/**
	 * 查询danyuan
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public List<Object[]> queryDanyuan(String id)
	{		
		PersistenceManager pm=  this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		String sql ="select dy.id,dy.Dy_Name from  xhj_lpdanyuan dy    where dy.DZID="+id;
		Query query =pm.newQuery("SQL",sql);
		List<Object[]> list = (List<Object[]>) query.execute();
		pm.close();
		return list;
	}
	
	
	/**
	 * 查询huxing
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public List<Object[]> queryHuxing(String lpid,String dongid,String danyuanid)
	{		
		List<Object[]> lists = new ArrayList<Object[]>();
		PersistenceManager pm=  this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		if(null != lpid && null != dongid && null != danyuanid )
		{
			String sql =" select lf.id,right(lf.fanghao,2) as huxing,lf.ceng from xhj_lpfanghao lf ,xhj_lpdanyuan dy"
					+" where lf.dyid = dy.id and lf.dyid = "+danyuanid+" and lf.lpid = "+lpid+" and lf.buildingId = "+dongid+" and lf.shi <> 0 "
					+" and lf.ceng=(select  ceil(max(ceng)/2) from xhj_lpfanghao  where dyid = "+danyuanid+" and lpid = "+lpid+" and buildingId = "+dongid+" and shi <> 0 )";
			Query query =pm.newQuery("SQL",sql);
			lists = (List<Object[]>) query.execute();
		}
		pm.close();
		return lists;
	}
	
	/**
	 * 查询数据源
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo querySource(Condition condition ,PageInfo pager){
		StringBuffer sql = new StringBuffer();
//		CONCAT(lf.shi,'室',lf.ting,'厅',lf.chu,'厨',lf.wei,'卫',lf.yang,'阳台') as huxing 
		sql.append(" select lf.id,lf.fh_name,lf.fanghao,lf.shi");
		sql.append(" from  Xhj_LpFangHao lf ");
		sql.append(" where   1 = 1 ");
//		sql.append(" and lf.id in ");
		if(null != condition )
		{
//			String ids = condition.getIds();
//			if(null != ids && ids.length()>1)
//			{
//				ids = ids.substring(1,ids.length()-1);
//				sql.append("("+ids+")");
				if(null !=  condition.getDanyuan())
				{
					sql.append(" and lf.dyid= "+condition.getDanyuan().getId());
					if(null != condition.getFanghao())
					{
						sql.append(" and lf.fanghao like '%"+condition.getFanghao().getFangHao()+"'");
					}
//					sql.append(" group by huxing ");
					//总数sql
					StringBuffer countsql=new StringBuffer();
					countsql.append("select count(*) from ( ").append(sql.toString()).append(" ) s");
					
					pager = getEntitiesByPageWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
				}
//			}
		}
		return pager;
	}
	
	public PageInfo getEntitiesByPageWithSql(PageInfo pageInfo, String sql, String csql,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL",csql);
		List<Object> list=(List<Object>) query.execute();
		int records = Integer.parseInt(list.get(0).toString());
		pageInfo.setRecords(records);
        List result = null;
        Query q = pm.newQuery("SQL",sql);
        
        result = (List) q.execute();
        pm.close();
        pageInfo.setGridModel(result);
		return pageInfo;
	}
	/**
	 * 我的维护盘信息
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForMY(Condition condition ,PageInfo pager){
		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
		StringBuffer sql = new StringBuffer();
		sql.append("select lf.id,lf.ImagePath,lf.Number,xx.LP_Name,pf.`Name`,lf.UpdateDate ,lf.source ,lf.WTZT ,lf.FWZT ,lf.click_num,");
		sql.append("CONCAT(xx.LP_Name,(SELECT Lpd_name from xhj_lpdong where id=lf.BuildingID),(SELECT dy_name from xhj_lpdanyuan where id=lf.DYID) ,lf.fanghao,'号房') as lpname");
		sql.append(" from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		sql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID ");
		sql.append(" inner join  lp_assignment la  on la.fhid = lf.id ");
//		sql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID ");
//		sql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		sql.append(" where   1 = 1 and lf.YZID>0 and la.userid = ").append(userLogin.getUserProfile().getId());
		
		String sqlcommon = setCondition(condition);
		//查询sql
		sql.append(sqlcommon);
		//总数sql
		StringBuffer countsql=new StringBuffer();
		countsql.append("select count(1) from Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		countsql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID ");
		countsql.append(" inner join  lp_assignment la  on la.fhid = lf.id ");
//		countsql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID ");
//		countsql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		countsql.append(" where   1 = 1 and lf.YZID>0 and la.userid = ").append(userLogin.getUserProfile().getId());
		countsql.append(sqlcommon);
		
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	/**
	 * 信息
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForAssign(Condition condition ,PageInfo pager){
//		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
		//查询sql
		StringBuffer sql = new StringBuffer();
		sql.append("select lf.id,lf.ImagePath,lf.Number,xx.LP_Name,pf.`Name`,lf.UpdateDate ,lf.source ,lf.WTZT ,lf.FWZT ,lf.click_num,");
		sql.append("CONCAT(xx.LP_Name,(SELECT Lpd_name from xhj_lpdong where id=lf.BuildingID),(SELECT dy_name from xhj_lpdanyuan where id=lf.DYID) ,lf.fanghao,'号房') as lpname");
		sql.append(" from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		sql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID   ");
//		sql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID ");
//		sql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		sql.append(" where   1 = 1 ");
		
		//condition条件
		String sqlcommon = setCondition(condition);
		sql.append(sqlcommon);
		
		//总数sql
		StringBuffer countsql=new StringBuffer();
		countsql.append(" select count(1) from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID  ");
		countsql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID ");
//		countsql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID ");
//		countsql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		countsql.append(" where   1 = 1 ");
		countsql.append(sqlcommon);
		
		try{
			pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
			return pager;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 责任盘维护 xhj_lcfz  信息楼盘 以及栋座的信息栋数据 
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForZR(Condition condition ,PageInfo pager){
		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
		StringBuffer sql = new StringBuffer();
		String sqlcommon = setCondition(condition);
		sql.append("select lf.id,lf.ImagePath,lf.Number,xx.LP_Name,pf.`Name`,lf.UpdateDate ,lf.source ,lf.WTZT ,lf.FWZT ,lf.click_num,");
		sql.append("CONCAT(xx.LP_Name,(SELECT Lpd_name from xhj_lpdong where id=lf.BuildingID),(SELECT dy_name from xhj_lpdanyuan where id=lf.DYID) ,lf.fanghao,'号房') as lpname");
		sql.append(" from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		sql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID  ");
		sql.append(" inner join  xhj_lcfz xl  on xl.lpid = xx.id ");
//		sql.append("  inner join  xhj_lpdong ld on lf.BuildingID = ld.ID  ");
//		sql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		sql.append("  where   1 = 1 and lf.YZID>0 and xl.did=0 and xl.bmid= ").append(userLogin.getDepartment().getId());
		sql.append(sqlcommon);
		sql.append(" UNION ALL ");
		sql.append("select lf.id,lf.ImagePath,lf.Number,xx.LP_Name,pf.`Name`,lf.UpdateDate ,lf.source ,lf.WTZT ,lf.FWZT ,lf.click_num,");
		sql.append("CONCAT(xx.LP_Name,(SELECT Lpd_name from xhj_lpdong where id=lf.BuildingID),(SELECT dy_name from xhj_lpdanyuan where id=lf.DYID) ,lf.fanghao,'号房') as lpname");
		sql.append(" from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		sql.append(" INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID  ");
		sql.append("  inner join  xhj_lcfz xl  on xl.did = lf.BuildingID ");
//		sql.append("  inner join  xhj_lpdong ld on lf.BuildingID = ld.ID  ");
//		sql.append("  inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		sql.append("  where   1 = 1  and lf.YZID>0 and xl.did>0 and xl.bmid= ").append(userLogin.getDepartment().getId());;
		//查询sql
		sql.append(sqlcommon);
		//总数sql
		StringBuffer countsql=new StringBuffer();
		countsql.append("select count(1) from ( ").append(sql.toString()).append(" ) s");
		
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	
	/**
	 * 本组维护盘信息 根据部门，分配表lp_assignment
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForBZ(Condition condition ,PageInfo pager){
		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
		StringBuffer sql = new StringBuffer();
		sql.append("select lf.id,lf.ImagePath,lf.Number,xx.LP_Name,pf.`Name`,lf.UpdateDate ,lf.source ,lf.WTZT ,lf.FWZT ,lf.click_num,");
		sql.append("CONCAT(xx.LP_Name,(SELECT Lpd_name from xhj_lpdong where id=lf.BuildingID),(SELECT dy_name from xhj_lpdanyuan where id=lf.DYID) ,lf.fanghao,'号房') as lpname");
		sql.append(" from  Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		sql.append("INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID  ");
		sql.append(" inner join  lp_assignment  la  on la.fhid = lf.id ");
//		sql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID  ");
//		sql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		sql.append(" where   1 = 1 and lf.YZID>0 and  la.userid is null and la.bmid = ").append(userLogin.getDepartment().getId());
		
		String sqlcommon = setCondition(condition);
		//查询sql
		sql.append(sqlcommon);
		//总数sql
		StringBuffer countsql=new StringBuffer();
		countsql.append("select count(1) from Xhj_LpFangHao lf  INNER JOIN xhj_lpxx xx  on lf.Lpid = xx.ID ");
		countsql.append("INNER JOIN  xhj_personinfo pf on  lf.YZID = pf.ID  ");
		countsql.append(" inner join  lp_assignment  la  on la.fhid = lf.id ");
//		countsql.append(" inner join  xhj_lpdong ld on lf.BuildingID = ld.ID  ");
//		countsql.append(" inner join xhj_lpdanyuan ldy on lf.DYID = ldy.ID ");
		countsql.append(" where   1 = 1 and lf.YZID>0 and  la.userid is null and la.bmid = ").append(userLogin.getDepartment().getId());
		countsql.append(sqlcommon);
		
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	
	/**
	 *@description 列表数据展示条件搜索
	 *@base condition
	 *@author chenxiang
	 *@Date 2015/9/28
	 */
	private String setCondition(Condition condition)
	{
		StringBuffer sqlcommon=new StringBuffer();
		sqlcommon.append(" and lf.Statuss = 1  ");
		sqlcommon.append(" and xx.Statuss = 1  ");
		if(null != condition)
		{
			if(null != condition.getLpxx())
			{
				String lpName = condition.getLpxx().getLpName();
				if(StringUtils.notEmpty(lpName) && !"".equals(lpName)){
					sqlcommon.append(" and xx.lp_name like '%").append(lpName).append("%'");
				}
			}
			if(null != condition.getDong())
			{
				String lpdName = condition.getDong().getLpdName();
				if(StringUtils.notEmpty(lpdName) && !"".equals(lpdName)){
					sqlcommon.append(" and ld.Lpd_Name  like  '%").append(lpdName).append("%'");
				}
			}
			if(null != condition.getFanghao())
			{
				String fhName = condition.getFanghao().getFhName();
				if(StringUtils.notEmpty(fhName) && !"".equals(fhName)){
					sqlcommon.append(" and lf.FH_Name like '%").append(fhName).append("%'");
				}
			}
			if(null != condition.getDanyuan())
			{
				String dyName = condition.getDanyuan().getDyName();
				if(StringUtils.notEmpty(dyName) && !"".equals(dyName)){
					sqlcommon.append(" and ldy.Dy_Name  like  '%").append(dyName).append("%'");
					
				}
			}
			
			String smj = condition.getSmj();
			if(StringUtils.notEmpty(smj)){
				sqlcommon.append(" and lf.CQMJ >= ").append(smj);
			}
			
			String emj = condition.getEmj();
			if(StringUtils.notEmpty(emj)){
				sqlcommon.append(" and lf.CQMJ <= ").append(emj);
			}
			
			String sc = condition.getSc();
			if(StringUtils.notEmpty(sc)){
				sqlcommon.append(" and lf.Ceng >= ").append(sc);
			}
			
			String ec = condition.getEc();
			if(StringUtils.notEmpty(ec)){
				sqlcommon.append(" and lf.Ceng <= ").append(ec);
			}
			
			String sh = condition.getSh();
			if(StringUtils.notEmpty(sh)){
				sqlcommon.append(" and lf.Shi >= ").append(sh);
			}
			
			String eh = condition.getEh();
			if(StringUtils.notEmpty(eh)){
				sqlcommon.append(" and lf.Shi <= ").append(eh);
			}
			
			String sd = condition.getSd();
			if(null != sd &&  !"".equals(sd)){
				sqlcommon.append(" and lf.UpdateDate >= '").append(sd).append("'");
			}
			
			String ed = condition.getEd();
			if(null != ed &&  !"".equals(ed)){
				sqlcommon.append(" and lf.UpdateDate <= '").append(ed).append("'");
			}
		}
//		sqlcommon.append("  order by  lf.UpdateDate desc ");
		return sqlcommon.toString();
	}
	
	/**
	 * 查询房屋信息
	 * @return
	 */
	public XhjLpfanghao queryFanghao(Condition condition)
	{
		if(null != condition.getFanghao())
		{
			Integer ceng = condition.getFanghao().getCeng();
			String fh = condition.getFanghao().getFangHao();
			Integer buildingId = condition.getFanghao().getBuildingId();
			Integer dyId = condition.getFanghao().getDyId();
			Integer lpid = condition.getFanghao().getLpid();
			Integer cf = Integer.valueOf(ceng+fh);
			
//			String sql=" select * from xhj_lpfanghao where ceng="+condition.getFanghao().getCeng()
//					+" and fanghao like '%"+condition.getFanghao().getFangHao()
//					+"' and dyid = "+condition.getFanghao().getDyId()
//					+" and lpid = "+condition.getFanghao().getLpid()+" and buildingId = "+condition.getFanghao().getBuildingId()+" ";
			PersistenceManagerFactory pmf = this.getRelationalPersistenceManagerFactory();
			PersistenceManager pm = pmf.getPersistenceManager();
			Query q = pm.newQuery(XhjLpfanghao.class);
			q.setFilter("ceng=="+ceng+" && fangHao =='"+cf+"' && lpid =="+lpid+" && dyId =="+dyId+" && buildingId =="+buildingId);
			ForwardQueryResult result = (ForwardQueryResult)q.execute();
			if(null != result && result.size()>0)
			{
				return (XhjLpfanghao)result.get(0);
			}
			pm.close();
		}
		return null;
	}
	/**
	 * 查询房屋图片
	 * fhids 的id
	 * @return
	 */
	public List<XhjLpfanghaoimg> queryFanghaoImg(String fhids)
	{
		List<XhjLpfanghaoimg> fanghaoimgs = null;
		if(null != fhids)
		{
			PersistenceManagerFactory pmf = this.getRelationalPersistenceManagerFactory();
			PersistenceManager pm = pmf.getPersistenceManager();
			Query query = pm.newQuery(XhjLpfanghaoimg.class);
			JSONArray parseArray = JSON.parseArray(fhids);
			StringBuffer sb = new StringBuffer();
			sb.append(" ");
			for (int i = 0; i < parseArray.size(); i++) {
				Object object = parseArray.get(i);
				String jsonString = JSON.toJSONString(object);
				sb.append("fanghaoid == "+jsonString);
				if(i!=(parseArray.size()-1))
				{
					sb.append(" || ");
				}
			}
			query.setFilter(sb.toString());
			fanghaoimgs = (List<XhjLpfanghaoimg>)query.execute();
			pm.close();
		}
		return fanghaoimgs;
	}
	
	
	/**
	 * 批量修改
	 * @return
	 */
	public int batchUpdate(Condition condition )
	{
		PersistenceManager pm = null;
		String fhids = condition.getFhids();
		if(null ==condition || null == condition.getFanghao() || null  == fhids || fhids.length()<=0)
		{
			return 0;
		}
		pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Transaction tx = pm.currentTransaction();
		try
		{
			JSONArray parseArray = JSON.parseArray(fhids);
			XhjLpfanghao fanghaoNew =  condition.getFanghao();
			tx.begin();
			for (int i = 0; i < parseArray.size(); i++) {
				Object object = parseArray.get(i);
				String fanghaoid = JSON.toJSONString(object);
//					String sql = "select * from lp_assignment where fhid ="+jsonString;
				//-----save--fanghao-------start
				Query queryFanghao = pm.newQuery(XhjLpfanghao.class);
				queryFanghao.setFilter("id =="+fanghaoid);
				List<XhjLpfanghao> fanghaos = (List<XhjLpfanghao>)queryFanghao.execute();
				XhjLpfanghao fanghao = null;
				if(null != fanghaos && fanghaos.size() > 0)
				{
					fanghao = fanghaos.get(0);
					saveBatch(fanghao,fanghaoNew);
					pm.makePersistent(fanghao);
				}
//				tx.commit();
				//-----save--fanghao---------end
				//-----save img---------start
//				tx.begin();
				Query query = pm.newQuery(XhjLpfanghaoimg.class);
				query.setFilter("fanghaoid =="+fanghaoid);
				List<XhjLpfanghaoimg> fanghaoimgs2 = (List<XhjLpfanghaoimg>)query.execute();
				pm.deletePersistentAll(fanghaoimgs2);
				List<XhjLpfanghaoimg> fanghaoimgs1 = condition.getFanghaoImg();
				if(null != fanghaoimgs1 && fanghaoimgs1.size()>0)
				{
					for (int j = 0; j < fanghaoimgs1.size(); j++) {
						XhjLpfanghaoimg img = new XhjLpfanghaoimg();
						XhjLpfanghaoimg imgnew = fanghaoimgs1.get(j);
						img.setFanghaoid(Integer.valueOf(fanghaoid));
						img.setImgPath(imgnew.getImgPath());
						img.setStatuss(imgnew.getStatuss());
						img.setType(imgnew.getType());
						img.setOrderBy(imgnew.getOrderBy());
						pm.makePersistent(img);
					}
				}
				//-----save img----------end
			}
			tx.commit();
		
		}catch(Exception e)
		{
			e.printStackTrace();
			return 0;
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
	
	public void saveBatch(XhjLpfanghao fanghao,XhjLpfanghao fanghaoNew)
	{
		fanghao.setUpdateDate(new Date());
		fanghao.setShi(fanghaoNew.getShi());
		fanghao.setTing(fanghaoNew.getTing());
		fanghao.setChu(fanghaoNew.getChu());
		fanghao.setWei(fanghaoNew.getWei());
		fanghao.setYang(fanghaoNew.getYang());
		fanghao.setChaoXiang(fanghaoNew.getChaoXiang());
		fanghao.setCqxz(fanghaoNew.getCqxz());
		fanghao.setTnmj(Double.valueOf(fanghaoNew.getTnmj()));
		fanghao.setLeixing(fanghaoNew.getLeixing());
		fanghao.setPropertyAge(fanghaoNew.getPropertyAge());
		if(null != fanghaoNew.getCqmj() && fanghaoNew.getCqmj() >0)
		{
			fanghao.setCqmj(Double.valueOf(fanghaoNew.getCqmj()));
		}
	}
	/**
	 *@description 房屋信息-基本信息展示
	 *@base lfid 房号id 
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public Object queryByLFId(String lfid)
	{
//		clickNum
		
		String sql = "select CONCAT(CONVERT(lf.shi,char),'室',CONVERT(lf.ting,char),'厅',CONVERT(lf.chu,char),'厨',CONVERT(lf.wei,char),'卫',CONVERT(lf.yang,char),'阳台')  as huxing, ";
		sql+=" (select name from lp_syscs_1 where id = lf.chaoxiang) chaoxiang, ";
		sql+=" (select name from lp_syscs_1 where id = xx.yongtu) yongtu,lf.TNMJ,lf.cqmj,lf.PropertyAddress,(select name from lp_syscs_1 where id =lf.cqxz)cqxz,(select name from lp_syscs_1 where id =lf.PropertyAge)PropertyAge,lf.PropertyNumber ,lf.id, " ;
		sql+="lf.Number,xx.lp_name,xx.Address,lf.CengHao,lf.FangHao,(select imgpath from xhj_lpfanghaoimg where  fanghaoid=lf.id ORDER BY id desc  LIMIT 1),lf.yzid ";
		sql+=" from xhj_lpfanghao lf inner join xhj_lpxx xx where lf.lpid = xx.id  and lf.id = "+lfid; 
		PersistenceManagerFactory pmf = this.getRelationalPersistenceManagerFactory();
		PersistenceManager pm = pmf.getPersistenceManager();
		Query q = pm.newQuery("SQL",sql);
		XhjLpfanghao fanghao=	pm.getObjectById(XhjLpfanghao.class,Integer.parseInt(lfid));
		int index=0;
		if(fanghao.getClickNum()!=null){
			 index=fanghao.getClickNum();
		}
		fanghao.setClickNum(index+1);
		Transaction tx = pm.currentTransaction();
	
		try {
			tx.begin();
			pm.makePersistent(fanghao);
			tx.commit();
			ForwardQueryResult result = (ForwardQueryResult)q.execute();
			if(null != result && result.size()>0)
			{
				return result.get(0);
			}
			
		} catch (Exception e) {
			throw e;
		}finally
		{
			if(tx.isActive())
			{
				tx.rollback();
			}
			pm.close();
		}
	//	pm.newQuery("update " + XhjLpfanghao.class.getName() + " set clickNum==clickNum+1 where id==" + lfid).execute();
	
		
		return null;
	}
	
	
	/**
	 *@description 房屋信息--跟踪记录
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryUpdateRecord(String lfid,PageInfo pager)
	{
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select lp.* ,tbl.id tblid,tbl.fullname,tbl.tel,d.department_name ");
		sqlcommon.append(" from lp_updating_record  lp , tbl_user_profile tbl ,tbl_department d ");
		sqlcommon.append(" where lp.updator = tbl.id and lp.bmid=d.id and  fhid="+lfid); 
		sqlcommon.append(" order by lp.update_time desc");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	/**
	 *@description 房屋信息--动态
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryFHLog(String lfid,PageInfo pager)
	{
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select lp.* ,tbl.id tblid,tbl.fullname,tbl.tel,d.department_name " );
		sqlcommon.append(" from lp_house_operation_log lp,tbl_user_profile tbl ,tbl_department d ");
		sqlcommon.append(" where lp.operatorid = tbl.id and lp.DepartmentID = d.id and lp.houseinfoid = "+lfid); 
		sqlcommon.append(" order by lp.OperateDate desc");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	
	/**
	 *@description 房屋信息--历史委托记录
	 *@base lfid 房号id
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryWeiTuoJiLu(String lfid,PageInfo pager)
	{
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer();
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select h.* from  (");
		sql.append("select xhs.number,(SELECT fullname from tbl_user_profile where id=xhs.creatorid),(SELECT department_name from tbl_department where id=xhs.createdepartmentid), ");
		sql.append(" CASE xhs.housesourcestatus WHEN 0 THEN '无效' WHEN 1 THEN '有效' WHEN 2 THEN '定金' WHEN 3 THEN '签约未审核' WHEN 4 THEN '锁定' ");
		sql.append(" WHEN 5 THEN '签约已审核' WHEN 6 THEN '待店长审核' WHEN 7 THEN '店长预审核' WHEN 8 THEN '店长驳回' WHEN 9 THEN '待资源管控部审核'  ");
		sql.append(" WHEN 10 THEN '资源管控部预审核' WHEN 11 THEN '资源管控部驳回' END ,xhs.createdate,'售' ");
		sql.append(" from xhj_housesource xh inner join xhj_housesourceforsaling  xhs on xh.id = xhs.housesourceid  ");
		sql.append(" where xh.housenumberid = "+lfid);
		sql.append(" UNION ALL ");
		sql.append(" select xhs.number,(SELECT fullname from tbl_user_profile where id=xhs.creatorid),(SELECT department_name from tbl_department where id=xhs.createdepartmentid), ");
		sql.append(" CASE xhs.housesourcestatus WHEN 0 THEN '无效' WHEN 1 THEN '有效' WHEN 2 THEN '定金' WHEN 3 THEN '签约未审核' WHEN 4 THEN '锁定' ");
		sql.append(" WHEN 5 THEN '签约已审核' WHEN 6 THEN '待店长审核' WHEN 7 THEN '店长预审核' WHEN 8 THEN '店长驳回' WHEN 9 THEN '待资源管控部审核' ");
		sql.append(" WHEN 10 THEN '资源管控部预审核' WHEN 11 THEN '资源管控部驳回' END , ");
		sql.append(" xhs.createdate,'租' ");
		sql.append(" from xhj_housesource xh inner join xhj_houseinfoforrenting  xhs on xh.id = xhs.housesourceid  ");
		sql.append(" where xh.housenumberid = "+lfid);
		sql.append(" ) h");
		sql.append(" order by h.createdate desc");
		countsql.append("select count(*) from (").append(sql.toString()).append(") ss");
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	/**
	 * 查询所属房号的业主信息
	 * @param lfid
	 * @return
	 */
	public PageInfo queryData(String lfid,PageInfo pager)
	{
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select p.id ,name,c.telephone,qq,WeXin ,email,c.id ");
		sql.append("from  xhj_personinfo p ,xhj_communicator c where c.personid=p.id AND p.id="+lfid);
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	/**
	 * 业主数据查询
	 * @param lfid
	 * @param strategy
	 * @return
	 */
	public Information selectState(String lfid,String strategy){
		String sql ="select p.id ,name,(SELECT telephone from xhj_communicator where personid=p.id LIMIT 1),email,qq,WeXin , (SELECT name from lp_syscs_1 where id=Nationality) Nationality,(SELECT city_name from xhj_jccity where id=CityID) CityID ,HomeAddress ,IdentityCode ," +
				"Birthday ,WorkPlace ,OfficeAddress,(SELECT name from lp_syscs_1 where id=WorkType)WorkType ,(SELECT name from lp_syscs_1 where id=Education) Education ,(SELECT name from lp_syscs_1 where id=ConsumptionConcept) ConsumptionConcept " +
				"from xhj_personinfo p,xhj_communicator c where c.personid=p.id AND c.id="+lfid;
			PersistenceManager pm=getPersistenceManagerByStratey(strategy);
			Query query = pm.newQuery("SQL",sql.toString());
			List<Object[]> listObjects = (List<Object[]>) query.execute();
			pm.close();
			Information information = null;
			List<Information> list = new ArrayList<Information>();
			for(Object[] temp : listObjects){
				information = new Information();
				if(temp[0]!=null&& !"".equals(temp[0])){
					information.setId(temp[0].toString());
				}
				if(temp[1] !=null && !"".equals(temp[1])){
					information.setName(temp[1].toString());
				}
				if(temp[2] !=null && !"".equals(temp[2])){
					information.setTelephone(temp[2].toString());
				}
				if(temp[3] !=null && !"".equals(temp[3])){
					information.setEmail(temp[3].toString());
				}
				if(temp[4] !=null && !"".equals(temp[4])){
					information.setQq(temp[4].toString());
				}
				if(temp[5] !=null && !"".equals(temp[5])){
					information.setWeXin(temp[5].toString());
				}
				if(temp[6] !=null && !"0".equals(temp[6])){
					information.setNationality(temp[6].toString());
				}
				if(temp[7] !=null && !"".equals(temp[7])){
					information.setCityID(temp[7].toString());
				}
				if(temp[8] !=null && !"".equals(temp[8])){
					information.setHomeAddress(temp[8].toString());
				}
				if(temp[9] !=null && !"".equals(temp[9])){
					information.setIdentityCode(temp[9].toString());
				}
				if(temp[10] !=null && !"".equals(temp[10])){
					information.setBirthday(temp[10].toString());
				}
				if(temp[11] !=null && !"".equals(temp[11])){
					information.setWorkPlace(temp[11].toString());
				}
				if(temp[12] !=null && !"".equals(temp[12])){
					information.setOfficeAddress(temp[12].toString());
				}
				if(temp[13] !=null && !"".equals(temp[13])){
					information.setWorkType(temp[13].toString());
				}
				if(temp[14] !=null && !"0".equals(temp[14])){
					information.setEducation(temp[14].toString());
				}
				if(temp[15] !=null && !"0".equals(temp[15])){
					information.setConsumptionConcept(temp[15].toString());
				}
			}
			return information;
	}
	 
	 public Information selectLpfanghao(String lfid,String strategy){
			String sql ="select  p.id ,name ,(SELECT telephone from xhj_communicator where personid=p.id LIMIT 1) ,email,QQ, WeXin from xhj_personinfo p  where id = "+lfid;
			PersistenceManager pm=getPersistenceManagerByStratey(strategy);
			Query query = pm.newQuery("SQL",sql.toString());
			List<Object[]> listObjects = (List<Object[]>) query.execute();
			Information information = null;
			for(Object[] temp : listObjects){
				information = new Information();
				information.setId(temp[0].toString());
				information.setName(temp[1].toString());
				if(temp[2] != null && !"".equals(temp[2])){
					information.setTelephone(temp[2].toString());
				}
				if(temp[3] != null &&! "".equals(temp[3])){
					information.setEmail(temp[3].toString());
				}
				if(temp[4] != null && !"".equals(temp[4])){
					information.setQq(temp[4].toString());
				}
				if(temp[5] != null && !"".equals(temp[5])){
					information.setWeXin(temp[5].toString());
				}
			}
			pm.close();
		return information;
	 }
}
