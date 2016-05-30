package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.datanucleus.store.query.cache.QueryResultsCache;
import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.XhjFangHaoUtil;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLptp;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.lpzd.lp.domain.vo.XhjLpxxVo;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class XhjLpxxDao extends DaoParent<XhjLpxx>{
	
	public XhjLpxx getById(Integer id, String strategy){
		return (XhjLpxx)this.getPersistenceManagerByStratey(strategy).getObjectById(XhjLpxx.class,id);
	}
	
	public XhjLpxxVo getById2(Integer id, String strategy){
		XhjLpxxVo xhjLpxxVo = new  XhjLpxxVo();
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
		XhjLpxx xhjLpxx=pm.getObjectById(XhjLpxx.class,id);
		xhjLpxxVo.setXhjLpxx(xhjLpxx);
		this.getPropertyNameValue(pm,xhjLpxxVo);
		pm.close();
		return xhjLpxxVo;
	}
	
	private void getPropertyNameValue(PersistenceManager pm,XhjLpxxVo xhjLpxxVo){
		XhjLpxx xhjLpxx= xhjLpxxVo.getXhjLpxx();
		StringBuilder  sql = new StringBuilder("select ");
		sql.append("(select cc.City_Name from xhj_jccity cc where cc.id=lp.CityID) City_Name, ");
		sql.append("(select qy.Qy_Name from xhj_jcstress qy where qy.id=lp.StressID) Qy_Name, ");
		sql.append("(select sq.Sq_Name from xhj_jcsq sq  where sq.id=lp.SQ_ID) Sq_Name, ");
		sql.append("(select sc.name from lp_syscs_1 sc where lp.YongTu=sc.id ) YongTu, ");
		sql.append("(select sc.name from lp_syscs_1 sc where lp.PropertyInfo=sc.id ) PropertyInfo  , ");// 权属性质
		sql.append("(select sc.name from lp_syscs_1 sc where lp.air_supply =sc.id ) air_supply , ");// 供气方式
		sql.append("(select sc.name from lp_syscs_1 sc where lp.heating_way  =sc.id ) heating_way  , ");//取暖方式
		sql.append("(select sc.name from lp_syscs_1 sc where lp.power_supply =sc.id ) power_supply , ");//供电方式
		sql.append("(select sc.name from lp_syscs_1 sc where lp.configuration  =sc.id ) configuration  , ");// 通讯配置
		sql.append("(select sc.name from lp_syscs_1 sc where lp.community_safety   =sc.id ) community_safety ,");//社区安全设置
		sql.append("(select sc.name from lp_syscs_1 sc where lp.materials    =sc.id ) materials  ,");//门窗材料
		sql.append("(select sc.name from lp_syscs_1 sc where lp.brand =sc.id ) brand   ,");//电梯品牌
		sql.append("(select sc.name from lp_syscs_1 sc where lp.facades_processing  =sc.id ) facades_processing ,");// 外墙处理方
		sql.append("(select sc.name from lp_syscs_1 sc where lp.BuildingType   =sc.id ) BuildingType,  ");//建筑类型
		sql.append("(select sc.name from lp_syscs_1 sc where lp.l_type   =sc.id ) l_type,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where lp.link_location   =sc.id ) link_location,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where lp.water_supply   =sc.id ) water_supply  ,  ");//供水方式 
		sql.append("(select sc.name from lp_syscs_1 sc where lp.buildingAge   =sc.id ) buildingAge   , ");//建筑年代
		sql.append("(select sc.name from lp_syscs_1 sc where lp.propertyAge   =sc.id ) propertyAgeStr ,    ");//土地使用年限
		sql.append("(select sc.name from lp_syscs_1 sc where lp.building_structure   =sc.id ) buildingStructure    ");//
		sql.append(" from xhj_lpxx lp where lp.id=").append(xhjLpxx.getId());
		Query  query = pm.newQuery("SQL",sql.toString());
		ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();
		if(queryResult.size()>0 && queryResult!=null){
			Object[] objs = (Object[])queryResult.get(0);
			xhjLpxxVo.setCityName(XhjFangHaoUtil.equeasParams(objs[0]));
			xhjLpxxVo.setQyName(XhjFangHaoUtil.equeasParams(objs[1]));
			xhjLpxxVo.setSqName(XhjFangHaoUtil.equeasParams(objs[2]));
			xhjLpxxVo.setYongTuStr(XhjFangHaoUtil.equeasParams(objs[3]));
			xhjLpxxVo.setPropertyInfoStr(XhjFangHaoUtil.equeasParams(objs[4]));
			xhjLpxxVo.setAirSupplyStr(XhjFangHaoUtil.equeasParams(objs[5]));
			xhjLpxxVo.setHeatingWayStr(XhjFangHaoUtil.equeasParams(objs[6]));
			xhjLpxxVo.setPowerSupplyStr(XhjFangHaoUtil.equeasParams(objs[7]));
			xhjLpxxVo.setConfigurationStr(XhjFangHaoUtil.equeasParams(objs[8]));
			xhjLpxxVo.setCommunitySafetyStr(XhjFangHaoUtil.equeasParams(objs[9]));
			xhjLpxxVo.setMaterialsStr(XhjFangHaoUtil.equeasParams(objs[10]));
			xhjLpxxVo.setBrandStr(XhjFangHaoUtil.equeasParams(objs[11]));
			xhjLpxxVo.setFacadesProcessingStr(XhjFangHaoUtil.equeasParams(objs[12]));
			xhjLpxxVo.setBuildingTypeStr(XhjFangHaoUtil.equeasParams(objs[13]));
			xhjLpxxVo.setLtypeStr(XhjFangHaoUtil.equeasParams(objs[14]));
			xhjLpxxVo.setLinkLocAtionStr(XhjFangHaoUtil.equeasParams(objs[15]));
			xhjLpxxVo.setWaterSupplyStr(XhjFangHaoUtil.equeasParams(objs[16]));
			xhjLpxxVo.setBuildingAgeStr(XhjFangHaoUtil.equeasParams(objs[17]));
			xhjLpxxVo.setPropertyAgeStr(XhjFangHaoUtil.equeasParams(objs[18]));
			xhjLpxxVo.setBuildingStructure(XhjFangHaoUtil.equeasParams(objs[19]));
		}
		
		if(StringUtils.isNotEmpty(xhjLpxx.getPropertySupporting())){
			String sql1="select name from  lp_syscs_1 where id in("+xhjLpxx.getPropertySupporting()+")";
			Query  query1 = pm.newQuery("SQL",sql1.toString());
			ForwardQueryResult queryResult1 = (ForwardQueryResult)query1.execute();
			
			if(queryResult.size()>0 && queryResult!=null){
				String propertySupportingStr="";
				for(int i=0;i<queryResult1.size();i++){
					Object objs = queryResult1.get(i);
					propertySupportingStr +=XhjFangHaoUtil.equeasParams(objs)+",";
				}
				if(propertySupportingStr!=null&&!"".equals(propertySupportingStr)){
					xhjLpxxVo.setPropertySupporting(propertySupportingStr.substring(0, propertySupportingStr.length()-1));
				}
				
			}
		}
		if(xhjLpxx.getStatuss()!=null&&xhjLpxx.getStatuss()!=0){
			if(xhjLpxx.getStatuss()==2){
				xhjLpxxVo.setSpStr("是");
			}else if(xhjLpxx.getStatuss()==1){
				xhjLpxxVo.setSpStr("否");
			}
		}
		
		if(xhjLpxx.getRenChe()!=null){
			if(xhjLpxx.getRenChe()==1){
				xhjLpxxVo.setRenCheStr("是");
			}else{
				xhjLpxxVo.setRenCheStr("否");
			}
		}
		
	}
	
	public List<XhjLpxx> fianAll(String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery(XhjLpxx.class);
		query.setFilter(" statuss ==1");
		return (List<XhjLpxx>)query.execute();
	}
	
	public List<XhjLpxx> getByLpName(String lpName,String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp.LP_Name like '%"+lpName.trim()+"%'";
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	public List<XhjLpxx> findByLpName(Integer cityId, String lpName,String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp.CityID=" + cityId + " and lp.LP_Name like '%"+lpName.trim()+"%'";
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	/**
	 * 查询楼盘根据名称
	 * @return
	 */
	public List<XhjLpxx> queryLpByName(Integer bmid,Integer cityId,String name)
	{		
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp_name like '%"+name+"%' "
				+" and departmentid = " +bmid
				+" and cityid = "+ cityId;
		PersistenceManager pm=this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	
	public List<XhjLpxx> findByCity(Integer cityId,String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp.CityID="+cityId;
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	public List<XhjLpxx> findByStress(Integer stressId,String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp.StressID="+stressId;
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	public List<XhjLpxx> findBySq(Integer sqId,String strategy){
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1 and lp.SQ_ID="+sqId;
		Query query=pm.newQuery("SQL",sql);
		List<Object[]> list=(List<Object[]>) query.execute();
		List<XhjLpxx> xhjLpxxList = new ArrayList<XhjLpxx>(); 
		for(Object[] objs:list){
			XhjLpxx entity= new XhjLpxx();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setLpName(objs[1].toString());
			}
			xhjLpxxList.add(entity);
		}
		pm.close();
		return xhjLpxxList;
	}
	
	public List getByXhjLpxx(String strategy){
		String sql ="select lp.ID, lp.LP_Name from xhj_lpxx lp where lp.Statuss=1";
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL",sql);
		List lpxxs = (List) query.execute();
		pm.close();
		return lpxxs;
	}
	
	public List getByXhjLptp(Integer lpid,String strategy){
		String sql ="select tp.ID, tp.ImgName, tp.IMG,tp.ImgType from xhj_lptp tp where tp.Statuss=1 and tp.LPID="+lpid;
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL",sql);
		List tps = (List) query.execute();
		pm.close();
		return tps;
	}
	public PageInfo queryData(XhjLpxx xhjLpxx, PageInfo pageInfo){
		StringBuilder sql = new StringBuilder();
		StringBuilder sqlCount = new StringBuilder();
		sql.append("select (select jj.qy_name from Xhj_JcStress jj where jj.id = lp.StressID and jj.statuss = '1') as qyname,");
		sql.append("(select sq.Sq_Name from xhj_jcsq sq where sq.id = lp.SQ_ID and sq.statuss = '1') as sqname,lp.LP_Name,");
		sql.append("(select sc.Name from lp_syscs_1 sc where sc.id = lp.yongtu) as yongtu,lp.Address,lp.isend,lp.Statuss,lp.id,");
		sql.append(" (select GROUP_CONCAT(finshName order by finshName) from lp_finsh where lpid =lp.id and finshNumber=100) as finname ,");
		sql.append("(select sc.Name from lp_syscs_1 sc where sc.id = lp.level) as dengji ");
		sql.append(" from xhj_lpxx lp where statuss > 0 ");
		//国家
		if(StringUtils.isNotEmpty(xhjLpxx.getCountryid().toString()) && xhjLpxx.getCountryid() != 0){
			sql.append(" and countryid=").append(xhjLpxx.getCountryid());
		}
		//省份
		if(StringUtils.isNotEmpty(xhjLpxx.getProvinceid().toString()) && xhjLpxx.getProvinceid() != 0){
			sql.append(" and provinceid=").append(xhjLpxx.getProvinceid());
		}
		//城市
		if(StringUtils.isNotEmpty(xhjLpxx.getCityId().toString()) && xhjLpxx.getCityId() != 0){
			sql.append(" and cityId=").append(xhjLpxx.getCityId());
		}
		//区域
		if(StringUtils.isNotEmpty(xhjLpxx.getStressId().toString()) && xhjLpxx.getStressId() != 0){
			sql.append(" and stressId=").append(xhjLpxx.getStressId());
		}
		//商圈
		if(StringUtils.isNotEmpty(xhjLpxx.getSqId().toString()) && xhjLpxx.getSqId() != 0){
			sql.append(" and sq_id=").append(xhjLpxx.getSqId());
		}
		if(StringUtils.isNotEmpty(xhjLpxx.getLpName().toString())) {
			sql.append(" and lp_name like '%").append(xhjLpxx.getLpName()).append("%'");
		}
		sql.append(" order by  checkDate desc ");
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		return pageInfo;
	}
 	
	public PageInfo querySimpleLpxx(PageInfo pager, XhjLpxx lpxx, int[] sqIds, String strategy){
		String sql = "select a.id,a.lp_name,b.sq_name from xhj_lpxx a, xhj_jcsq b ";
		
		String condition = " where a.sq_id=b.id and a.statuss=1 and a.cityid=" + lpxx.getCityId();
		
		if(sqIds!=null){	//这里的ids是指商圈ids
			condition += " and sq_id in("+ arrayToString(sqIds) +")";
			ArrayUtils.toString(sqIds);
		}
		if(lpxx!=null){
			if(lpxx.getStressId()!=null){
				condition += " and stressid=" + lpxx.getStressId();
			}
			if(lpxx.getSqId()!=null){
				condition += " and sq_id=" + lpxx.getSqId();
			}
			if(StringUtils.isNotEmpty(lpxx.getLpName())){
				condition += " and lp_name like '%" + lpxx.getLpName() + "%' ";
			}
		}
		
		sql += condition;
		if(StringUtils.isNotEmpty(pager.getSidx())){
			sql += " order by " + pager.getSidx() + " " + pager.getSord();
		}
		String csql = "select count(*) from xhj_lpxx a, xhj_jcsq b " + condition;
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	public List<Object[]> getDongOfLp(int lpid, String strategy){
		String sql = "select id,lpd_name from xhj_lpdong where lpid=" + lpid +" order by lpd_name";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	
	public XhjLpdong getDongId(int dzid, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLpdong dong = pm.getObjectById(XhjLpdong.class, dzid);
		pm.close();
		return dong;
	}
	
	public XhjLpdanyuan getDyyuanId(int dYid, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLpdanyuan danyuan = pm.getObjectById(XhjLpdanyuan.class, dYid);
		pm.close();
		return danyuan;
	}
	
	public List<Object[]> getDanYuan(Integer dzid, String relational) {
		String sql = "select id,dy_name from Xhj_LpDanyuan where dzid=" + dzid;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}

	public List<Object[]> getCeng(Integer dyid, String relational) {
		String sql = "select id,ceng from Xhj_LpFangHao where dyid="+dyid+" group by ceng ORDER BY  ceng  desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	//获得学校层
	public List<Object[]> getSchoolCeng(Integer dyid, String relational) {
		String sql = "select CONCAT_WS('&',CONVERT(dyid,char),CONVERT(ceng,char)),ceng from Xhj_LpFangHao where dyid="+dyid+" group by ceng";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	public List<Object[]> getFanghao(Integer dyId, Integer ceng, String relational) {
		String sql = "select id,fanghao from Xhj_LpFangHao where dyid="+dyId;
		if(ceng != null && !"".equals(ceng)) {
			sql += " and ceng="+ceng;
		}
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	public List<Object[]> findMotors(String relational) {
		String sql = "select x.id,concat(c.City_Name,'-',x.xianlu_name) from Xhj_LpJiaoTongXian x left join xhj_jccity c on x.CityID=c.ID";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	public List<Object[]> findLoadZhan(String xid, String relational) {
		String sql = "select z.id,z.ZdName from xhj_lpjiaotongzhantoxian zs left join xhj_lpjiaotongzhan z on zs.ZhanID=z.id where xianid=" + xid;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	public List<Object[]> getSyscs(String sid ,String relational) {
		String sql = "select id,name from lp_syscs_1 where sid=" + sid + " and statuss=1";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	//供
	public List<Object[]> getSyscsParams(String syscsName ,String relational) {
		String sql = "select id,name from lp_syscs_1 where sid in (select sid from lp_syscs where name like '%" + syscsName + "%' and statuss=1) and statuss = 1";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	public List<Object[]> showSchoolDetail(String schoolType, String relational) {
		String sql = "select id,schoolName from xhj_lpschool where schoolType=" + schoolType 
						+ " and cityId=" + SecurityUserHolder.getCurrentUserLogin().getDepartment().getCityId() + " and statuss=1 ";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	public List<Object> getLpBmFuzhInfo(Integer lpid, String bmid,
			String relational) {
		String sql = "select did from xhj_lcfz where lpid=" + lpid + " and sta=1 and  bmid=" + bmid;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object> objs = (List<Object>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	public List<Object[]> showCorHouseInit(String fanghId, String relational) {
		StringBuffer sql = new StringBuffer("");
		sql.append("select lf.FangHao,hir.Number,'售',(SELECT fullname from tbl_user_profile where id=hir.BelongerID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.DepartmentID),");
		sql.append("(SELECT fullname from tbl_user_profile where id=hir.CreatorID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.CreateDepartmentID),hir.HouseSourceStatus,");
		sql.append("(SELECT `Name` from xhj_personinfo where id=hir.OwnerID) as yzname,");
		sql.append("(SELECT mobilephone from xhj_personinfo where id=hir.OwnerID),date_format(hir.CreateDate,'%Y-%m-%d %H:%i:%s')");
		sql.append(" from xhj_housesource h JOIN xhj_housesourceforsaling hir ON h.id=hir.housesourceid ");
		sql.append(" JOIN xhj_lpfanghao lf ON h.housenumberid=lf.id");
		sql.append(" where lf.id in (").append(fanghId).append(") ");
		sql.append("UNION ALL");
		sql.append(" select lf.FangHao,hir.Number,'租',(SELECT fullname from tbl_user_profile where id=hir.BelongerID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.DepartmentID),");
		sql.append("(SELECT fullname from tbl_user_profile where id=hir.CreatorID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.CreateDepartmentID),hir.HouseSourceStatus,");
		sql.append("(SELECT `Name` from xhj_personinfo where id=hir.OwnerID) as yzname,");
		sql.append("(SELECT mobilephone from xhj_personinfo where id=hir.OwnerID),date_format(hir.CreateDate,'%Y-%m-%d %H:%i:%s')");
		sql.append(" from xhj_housesource h JOIN xhj_houseinfoforrenting hir ON h.id=hir.housesourceid ");
		sql.append(" JOIN xhj_lpfanghao lf ON h.housenumberid=lf.id");
		sql.append(" where lf.id in(").append(fanghId).append(") ");
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return objs;
	}
	/**
	 * 根据单元ID查询所有的房源
	 * @param danyuanID
	 * @param relational
	 * @return
	 */
	public 	List<Object[]> showCorHouseInitDanYan(String danyuanID, String relational)
	{
		StringBuffer sql = new StringBuffer("");
		sql.append("select lf.FangHao,hir.Number,'售',(SELECT fullname from tbl_user_profile where id=hir.BelongerID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.DepartmentID),");
		sql.append("(SELECT fullname from tbl_user_profile where id=hir.CreatorID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.CreateDepartmentID),hir.HouseSourceStatus,");
		sql.append("(SELECT `Name` from xhj_personinfo where id=hir.OwnerID) as yzname,");
		sql.append("(SELECT mobilephone from xhj_personinfo where id=hir.OwnerID),date_format(hir.CreateDate,'%Y-%m-%d %H:%i:%s')");
		sql.append(" from xhj_housesource h JOIN xhj_housesourceforsaling hir ON h.id=hir.housesourceid ");
		sql.append(" JOIN xhj_lpfanghao lf ON h.housenumberid=lf.id");
		sql.append(" where h.unitid  in (").append(danyuanID).append(") ");
		sql.append("UNION ALL");
		sql.append(" select lf.FangHao,hir.Number,'租',(SELECT fullname from tbl_user_profile where id=hir.BelongerID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.DepartmentID),");
		sql.append("(SELECT fullname from tbl_user_profile where id=hir.CreatorID),");
		sql.append("(select department_name from tbl_department WHERE id=hir.CreateDepartmentID),hir.HouseSourceStatus,");
		sql.append("(SELECT `Name` from xhj_personinfo where id=hir.OwnerID) as yzname,");
		sql.append("(SELECT mobilephone from xhj_personinfo where id=hir.OwnerID),date_format(hir.CreateDate,'%Y-%m-%d %H:%i:%s')");
		sql.append(" from xhj_housesource h JOIN xhj_houseinfoforrenting hir ON h.id=hir.housesourceid ");
		sql.append(" JOIN xhj_lpfanghao lf ON h.housenumberid=lf.id");
		sql.append(" where h.unitid  in(").append(danyuanID).append(") ");
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return objs;
	}
	
	
	
	/**
	 * 获取当前楼盘下选中的学区栋数
	 * 
	 * @param lpid
	 * @param relational
	 * @return
	 */
	public String getLpSchoolXqUpd(String id, String col, String relational) {
		String sql = "select " + col + " from XHJ_LpLinkSchool where id=" + id;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		String result = ((List<Object>)pm.newQuery("SQL", sql).execute()).get(0).toString() + ",";
		pm.close();
		return result;
	}
	/**
	 * 获取楼盘对应的
	 * @param lpid
	 * @param relational
	 * @return
	 */
	public List<Object[]> loadLpSchoolInfo(Integer lpid, String relational) {
		String sql = "select id,(select name from lp_syscs_1 where id=s.schooltype),"
				+ "(select schoolName from xhj_lpschool where id=s.schoolid),dName,type,schooltype,schoolid from XHJ_LpLinkSchool s where lpid=" + lpid;
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object[]> objs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	public PageInfo getLpmanagexx(PageInfo pager, CheckCondition condition, String strategy) {
		StringBuffer sql=new StringBuffer("select l.id,l.CheckStatus,c.Name,q.Qy_Name,s.Sq_Name,l.LP_Name,u.fullname,b.department_name,l.R_Time from xhj_lpxx l,xhj_jcstress q,xhj_jcsq s,lp_syscs_1 c,tbl_user_profile u,tbl_department b ");
		StringBuffer where = new StringBuffer(" where l.YongTu=c.id and l.StressID=q.ID and l.SQ_ID=s.ID and l.UserID=u.id and l.DepartmentID=b.id and l.checkstatus is not null and l.checkstatus<>-1");
		where.append(" and l.UserID="+SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
		if(condition!=null){
			if(condition.getStressId()!=null){
				where.append(" and l.StressID="+condition.getStressId());
			}
			if(condition.getSqId()!=null){
				where.append(" and l.SQ_ID="+condition.getSqId());
			}
			if(condition.getLpName()!=null&&!"".equals(condition.getLpName())){
				where.append(" and LP_Name like '%"+condition.getLpName()+"%'");
			}
			if(condition.getCheckStatus()!=null){
				where.append(" and CheckStatus="+condition.getCheckStatus());
			}
		}
		sql.append(where).append(" order by l.id desc");
		String csql = "select count(*) from xhj_lpxx l,xhj_jcstress q,xhj_jcsq s,lp_syscs_1 c,tbl_user_profile u,tbl_department b " + where.toString();
		return this.getEntitiesByPaginationWithSql(pager, sql.toString(), csql, strategy);
	}
	
	public PageInfo queryCheckList(PageInfo pager, CheckCondition condition, String strategy){
		String sql = "select a.id,a.checkstatus,cs.name,s.qy_name,b.sq_name,a.lp_name,u.fullname,d.department_name,a.r_time, a.userId,a.CheckDate,u.tel,(select fullname from tbl_user_profile where id=a.checkerid) checkername from xhj_lpxx a, xhj_jcstress s, xhj_jcsq b, tbl_department d, tbl_user_profile u,lp_syscs_1 cs ";
		StringBuffer where = new StringBuffer(" where a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + " and a.stressid=s.id and a.sq_id=b.id and a.departmentid=d.id and a.userid=u.id and a.yongtu=cs.id ");
		if(condition!=null){
			if(condition.getStressId()!=null){
				where.append(" and a.stressid=" + condition.getStressId());
			}
			if(condition.getSqId()!=null){
				where.append(" and a.sq_id=" + condition.getSqId());
			}
			if(StringUtils.isNotEmpty(condition.getLpName())){
				where.append(" and a.lp_name like '%" + condition.getLpName() + "%' ");
			}
			if(condition.getDepartmentId()!=null){
				where.append(" and a.departmentid=" + condition.getDepartmentId());
			}
			if(condition.getUserId()!=null){
				where.append(" and a.userid=" + condition.getUserId());
			}
			if(condition.getCheckStatus()!=null){
				where.append(" and a.checkstatus=" + condition.getCheckStatus());
			} else {
				where.append(" and a.checkstatus in(1,2,3)");
			}
			if(StringUtils.isNotEmpty(condition.getTimeFrom())){
				where.append(" and r_time>='" + condition.getTimeFrom() + " 00:00:00'");
			}
			if(StringUtils.isNotEmpty(condition.getTimeTo())){
				where.append(" and r_time<='" + condition.getTimeTo() + " 23:59:59'");
			}
		} else {
			where.append(" and a.checkstatus in(1,2,3)");
		}
		sql += where.toString() + " order by Checkstatus, id desc";
		String csql = "select count(*) from xhj_lpxx a, xhj_jcstress s, xhj_jcsq b, tbl_department d, tbl_user_profile u,lp_syscs_1 cs " + where.toString();
		return super.getEntitiesByPaginationWithSql(pager, sql, csql, strategy);
	}
	
	private String arrayToString(int[] array){
		String s = "";
		if(array!=null){
			for(int i=0; i<array.length; i++){
				s += (i==0?"":",") + array[i];
			}
		}
		return s;
	}
	
	public String saveLpxx(XhjLpxx lpxx, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		String id = "";
		if(lpxx.getId() == null || lpxx.getId() == 0) {
			id = getNextSeqId(XhjLpxx.class);
			lpxx.setId(Integer.valueOf(id));
			lpxx.setDepartmentId(SecurityUserHolder.getCurrentUserLogin().getDepartment().getId());
			lpxx.setUserId(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
			lpxx.setRTime(new Timestamp(new Date().getTime()));
			lpxx.setXTime(new Timestamp(new Date().getTime()));
			Transaction tx = pm.currentTransaction();
			try {
				tx.begin();
				Query query = pm.newQuery(XhjLpxx.class);
				query.setFilter("lpName=='" + lpxx.getLpName()+"' && cityId==" + lpxx.getCityId());
				List<XhjLpxx> lpxxList = (List<XhjLpxx>)query.execute();
				if(lpxxList == null || lpxxList.size() == 0) {
					pm.makePersistent(lpxx);
				} else {
					throw new Exception("当前楼盘名已存在,请确认后在保存!");
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
			id = lpxx.getId().toString();
			XhjLpxx oldLpxx = pm.getObjectById(XhjLpxx.class, lpxx.getId());
			if(lpxx.getLpName().equals(oldLpxx.getLpName())) {
				oldLpxx = oldLpxxPerNewLpxx(oldLpxx, lpxx);
				Transaction tx = pm.currentTransaction();
				try {
					tx.begin();
					pm.makePersistent(oldLpxx);
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
				Query query = pm.newQuery(XhjLpxx.class);
				query.setFilter("lpName=='" + lpxx.getLpName() + "' && cityId==" + lpxx.getCityId());
				List<XhjLpxx> lpxxList = (List<XhjLpxx>)query.execute();
				if(lpxxList == null || lpxxList.size() == 0) {
					oldLpxx = oldLpxxPerNewLpxx(oldLpxx, lpxx);
					Transaction tx = pm.currentTransaction();
					try {
						tx.begin();
						pm.makePersistent(oldLpxx);
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
					throw new Exception("当前楼盘名已存在,请确认后在修改!");
				}
			}
		}
		return id;
	}
	
	/**
	 * 
	 * @param old 更新对象
	 * @param news 更新前对象
	 */
	private XhjLpxx oldLpxxPerNewLpxx(XhjLpxx old, XhjLpxx news){
		old.setCountryid(news.getCountryid());
		old.setProvinceid(news.getProvinceid());
		old.setProvinceid(news.getProvinceid());
		old.setCityId(news.getCityId());
		old.setStressId(news.getStressId());
		old.setSqId(news.getSqId());
		old.setYongTu(news.getYongTu());
		old.setLpName(news.getLpName());
		old.setAddress(news.getAddress());
		old.setX(news.getX());
		old.setY(news.getY());
		old.setPropertyAddress(news.getPropertyAddress());
		old.setBieMing(news.getBieMing());
		old.setRjl(news.getRjl());
		old.setLhl(news.getLhl());
		old.setSumJz(news.getSumJz());
		old.setSumZd(news.getSumZd());
		old.setStatuss(news.getStatuss());
		old.setHjs(news.getHjs());
		old.setJieDao(news.getJieDao());
		old.setXsdl(news.getXsdl());
		old.setDjs(news.getDjs());
		old.setSgdw(news.getSgdw());
		old.setLpJiangX(news.getLpJiangX());
		old.setBuildingAge(news.getBuildingAge());
		old.setQq(news.getQq());
		old.setKaiFa(news.getKaiFa());
		old.setRenChe(news.getRenChe());
		old.setRoomRate(news.getRoomRate());
		old.setKaiFaPhone(news.getKaiFaPhone());
		old.setLpTag(news.getLpTag());
		old.setPropertySupporting(news.getPropertySupporting());
		old.setMore(news.getMore());
		old.setPNum(news.getPNum());
		old.setLeixing(news.getLeixing());
		old.setEndComplete(news.getEndComplete());
		old.setOpeningAvgPrice(news.getOpeningAvgPrice());
		old.setPrice(news.getPrice());
		old.setOpeningPrice(news.getOpeningPrice());
		old.setFacadesProcessing(news.getFacadesProcessing());
		old.setBrand(news.getBrand());
		old.setMaterials(news.getMaterials());
		old.setCommunitySafety(news.getCommunitySafety());
		old.setConfiguration(news.getConfiguration());
		old.setPowerSupply(news.getPowerSupply());
		old.setPropertyInfo(news.getPropertyInfo());
		old.setPropertyAge(news.getPropertyAge());
		old.setYears(news.getYears());
		old.setMonths(news.getMonths());
		old.setRzhs(news.getRzhs());
		old.setLinkLocAtion(news.getLinkLocAtion());
		old.setAvgPrice(news.getAvgPrice());
		old.setBuildingAge(news.getBuildingAge());
		old.setXzgx(news.getXzgx());
		old.setBeiZ(news.getBeiZ());
		old.setLtype(news.getLtype());
		old.setLinkLocAtion(news.getLinkLocAtion());
		
		old.setAirSupply(news.getAirSupply());
		old.setHeatingWay(news.getHeatingWay());
		old.setWaterSupply(news.getWaterSupply());
		old.setPowerSupply(news.getPowerSupply());
		old.setConfiguration(news.getConfiguration());
		old.setCommunitySafety(news.getCommunitySafety());
		old.setMaterials(old.getMaterials());
		old.setBrand(news.getBrand());
		old.setFacadesProcessing(news.getFacadesProcessing());
		old.setBuildingType(news.getBuildingType());
		old.setBuildingStructure(news.getBuildingStructure());
		old.setLevel(news.getLevel());
		old.setXTime(new Timestamp(new Date().getTime()));
		return old;
		
	}
	
	/**
	 * 删除申请的楼盘采集记录。
	 * @param id
	 */
	public void deleteByCheckStatus(Integer id, String strategy) {
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		pm.newQuery("update " + XhjLpxx.class.getName() + " set checkStatus==-1 where id==" + id).execute();
		pm.close();
	}
	
	/**
	 * 审核通过楼盘采集。
	 * @param old
	 */
	public void shenhe(XhjLpxx old, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLpxx lpxx = pm.getObjectById(XhjLpxx.class, old.getId());
		lpxx.setCheckStatus(2);
		lpxx.setStatuss(1);
		lpxx.setCheckDate(new Date());
		lpxx.setCheckerId(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
		lpxx.setCheckRemark(old.getCheckRemark());
		lpxx.setXTime(new Timestamp(new Date().getTime()));
		pm.makePersistent(lpxx);
		pm.close();
	}
	
	/**
	 * 驳回楼盘采集。
	 * @param old
	 * @param strategy
	 */
	public void bohui(XhjLpxx old, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLpxx lpxx = pm.getObjectById(XhjLpxx.class, old.getId());
		lpxx.setCheckStatus(3);
		lpxx.setCheckDate(new Date());
		lpxx.setCheckerId(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
		lpxx.setCheckRemark(old.getCheckRemark());
		lpxx.setXTime(new Timestamp(new Date().getTime()));
		pm.makePersistent(lpxx);
		pm.close();
	}
	
	/**
	 * 获取某楼盘下的所有划分盘
	 * @param lpid
	 * @return
	 */
	public PageInfo loadLpFuzh(PageInfo pageInfo, String lpid, String findsta, String bmid, String relational) {
		StringBuffer sql = new StringBuffer("");
		StringBuilder sqlCount = new StringBuilder("");
		sql.append("select DISTINCT l.id,sta,source,department_name,(select address from tbl_department where id=d.parent_id), ");
		sql.append("(select telephone from tbl_department where id=d.parent_id),lpid,bmid");
		sql.append(" from xhj_lcfz l left join tbl_department d on d.id=l.bmid where lpid=").append(lpid);
		if(findsta!= null && !"null".equals(findsta) && !"".equals(findsta) && !"0".equals(findsta)) {
			sql.append(" and sta=" + findsta);
		} else {
			sql.append(" and sta>0");
		}
		if(bmid!= null && !"null".equals(bmid) && !"".equals(bmid) && !"0".equals(bmid)) {
			sql.append(" and bmid=" + bmid);
		}
		sql.append(" group by bmid,source union all select DISTINCT l.id,sta,source,department_name,(select address from tbl_department where id=d.parent_id), ");
		sql.append("(select telephone from tbl_department where id=d.parent_id),lpid,bmid ");
		sql.append(" from xhj_lcfz_1 l left join tbl_department d on d.id=l.bmid");
		sql.append(" where lpid=").append(lpid);
		if(findsta!= null && !"".equals(findsta) && !"0".equals(findsta)) {
			sql.append(" and sta=" + findsta);
		} else {
			sql.append(" and sta>0");
		}
		if(bmid!= null && !"null".equals(findsta) && !"null".equals(bmid) && !"".equals(bmid) && !"0".equals(bmid)) {
			sql.append(" and bmid=" + bmid);
		}
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}
	/**
	 * 查询最新动态
	 * @param pageInfo
	 * @return
	 */
	public PageInfo findByLpLog(PageInfo pageInfo, int lpid, String relational) {
		StringBuffer sql = new StringBuffer("");
		StringBuilder sqlCount = new StringBuilder("");
		sql.append("select t.fullname,(select department_name from tbl_department where id=t.tbl_department_id),t.tel,l.message,date_format(l.operatedate,'%Y-%m-%d %H:%i') ");
		sql.append("from Lp_Operation_Log l left join tbl_user_profile t on l.OperatorID=t.id where lpid=").append(lpid).append(" order by operatedate desc ");
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}
	/**
	 * 删除楼盘信息
	 * @param lpid
	 * @param relational
	 */
	public void delLpxx(Integer lpid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpxx oldLpd = pm.getObjectById(XhjLpxx.class, lpid);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			oldLpd.setStatuss(0);
			pm.makePersistent(oldLpd);
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
	}
	/**
	 * 房号统计
	 * @param relational
	 * @return
	 */
	public List<Object> queryCount(Integer lpid, String relational) {
		StringBuffer sql = new StringBuffer("");
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where (h.fwzt= 1 or h.fwzt=3) and d.lpid=").append(lpid);
		sql.append(" union all ");
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append("  where (h.fwzt= 2 or h.fwzt=3) and d.lpid=").append(lpid);
		sql.append(" union all ");
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where h.fwzt=0 and d.lpid=").append(lpid);
		sql.append(" union all ");
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where d.lpid=").append(lpid);
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object> obj = (List<Object>)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return obj;
	}
	/**
	 * 房号统计
	 * @param relational
	 * @return
	 */
	public List<Object> queryCount2(Integer lpid, String relational) {
		StringBuffer sql = new StringBuffer("");
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and (h.fwzt= 1 or h.fwzt=3) and d.lpid=").append(lpid);  //在售总数
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and  (h.fwzt= 1 or h.fwzt=3)  and h.source=1 and d.lpid=").append(lpid); //内部系统
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and  (h.fwzt= 1 or h.fwzt=3)  and h.source=2 and d.lpid=").append(lpid);//外部
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') and (h.fwzt= 1 or h.fwzt=3) ");
		sql.append("and d.lpid=").append(lpid);//上个月在售
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and (h.fwzt= 1 or h.fwzt=3)   ");
		sql.append(" and d.lpid=").append(lpid);//本月在售
		sql.append(" union all ");
		
		sql.append("select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append("  where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and (h.fwzt= 2 or h.fwzt=3) and d.lpid=").append(lpid);//小区在租总数
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and  (h.fwzt= 2 or h.fwzt=3)  and h.source=1 and d.lpid=").append(lpid);//内部
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and (h.fwzt= 2 or h.fwzt=3)  and h.source=2 and d.lpid=").append(lpid);//外部
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') and (h.fwzt= 2 or h.fwzt=3) ");
		sql.append(" and d.lpid=").append(lpid);//上个月在租
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and (h.fwzt= 2 or h.fwzt=3) ");
		sql.append("and d.lpid=").append(lpid);//本月在租
		
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and h.fwzt=0 and d.lpid=").append(lpid);//小区空房总数
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and  h.fwzt=0 and h.source=1  and d.lpid=").append(lpid);//内部系统
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and h.fwzt=0 and h.source=2  and d.lpid=").append(lpid);//外部系统
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') and  h.fwzt=0");
		sql.append(" and d.lpid=").append(lpid);//上个月空置
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and  h.fwzt=0 ");
		sql.append(" and d.lpid=").append(lpid);//本月空置
		sql.append(" union all ");
		sql.append(" select count(1) from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and d.lpid=").append(lpid);
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object> objs = (List<Object>)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return objs;
	}
	/*
	 * 查询房号数据
	 */
	public PageInfo queryFanghaoInfo(PageInfo pageInfo, String lpid,
			String dzid, String dyid, String ceng, String fwzt, String source,String relational) {
		StringBuffer sql = new StringBuffer("");
		StringBuilder sqlCount = new StringBuilder("");
		sql.append("select DISTINCT h.fwzt,h.fanghao,h.shi,h.ting,h.wei,h.tnmj,IFNULL((select name from lp_syscs_1 where id=h.chaoxiang),''), ");
		sql.append("IFNULL((SELECT `Name` from xhj_personinfo where id=h.yzid),''),IFNULL((SELECT mobilephone from xhj_personinfo where id=h.yzid),'')");
		sql.append(",h.source, date_format(h.UpdateDate ,'%Y-%m-%d %H:%i:%s'),h.id ");
		sql.append(" from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where d.lpid=").append(lpid);
		if(dzid != null && !"".equals(dzid) && !"0".equals(dzid)) {
			sql.append(" and d.id=").append(dzid);
		}
		if(dyid != null && !"".equals(dyid) && !"0".equals(dyid)) {
			sql.append(" and y.id=").append(dyid);
		}
		if(ceng != null && !"".equals(ceng) && !"0".equals(ceng)) {
			sql.append(" and h.ceng=").append(ceng);
		}
		if(fwzt != null && !"".equals(fwzt)) {
			sql.append(" and h.fwzt=").append(fwzt);
		}
		if(source != null && !"".equals(source) && !"0".equals(source)) {
			sql.append(" and h.source=").append(source);
		}
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}

	
	/*
	 * 查询房号数据
	 */
	public PageInfo queryLpdongInfo(PageInfo pageInfo, String lpid,String relational) {
		StringBuffer sql = new StringBuffer("");
		StringBuilder sqlCount = new StringBuilder("");
		sql.append("select  DISTINCT d.Lpd_Name,  count(1) zs_num,");
		sql.append("(SELECT count(1) FROM xhj_lpfanghao fh ,xhj_lpdanyuan dy where fh.FWZT=1 and date_format(fh.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and fh.dyid=dy.id and dy.DZID=d.id ) cs_num ,");
		sql.append("(SELECT count(1) FROM xhj_lpfanghao fh ,xhj_lpdanyuan dy where fh.FWZT=2 and date_format(fh.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and fh.dyid=dy.id and dy.DZID=d.id ) cz_num ,");
		sql.append("(SELECT count(1) FROM xhj_lpfanghao fh ,xhj_lpdanyuan dy where fh.FWZT=0 and date_format(fh.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and fh.dyid=dy.id and dy.DZID=d.id ) kz_num   ");
		sql.append("  from xhj_lpdong d left join xhj_lpdanyuan y on d.id=y.dzid  ");
		sql.append(" left join xhj_lpfanghao h on h.dyid=y.id ");
		sql.append(" where date_format(h.CreateDate,'%Y-%m')=date_format(now(),'%Y-%m') and d.lpid=").append(lpid);
		sql.append("  GROUP BY  d.Lpd_Name  ");
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}
	
	
	
	public void batchLock(String ids, String relational) {
		PersistenceManager pm=getPersistenceManagerByStratey(relational);
		Transaction tx=pm.currentTransaction();
		try {
		    tx.begin();
		    String[] id = ids.split(",");
		    for (int i = 0; i < id.length; i++) {
		    	Query query = pm.newQuery("update "+XhjLpxx.class.getName()+" set statuss == 2 WHERE id ==" + id[i]);
				query.execute();
			}
			tx.commit();
			pm.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}

	public void saveDzRemark(Integer lpid, String dzRemark, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpxx oldLpd = pm.getObjectById(XhjLpxx.class, lpid);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			oldLpd.setDzRemark(dzRemark);
			pm.makePersistent(oldLpd);
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
	}
	
	//栋座资料全部曲线图数据
	public List<Object> fangwquxian(Integer years,Integer lpid,Integer shi,String relational){
		String sql="SELECT date_format(cr.contract_date,'%m') ,count(1)";
		sql +="FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ";
		sql +="where fh.Lpid="+lpid+"   and  date_format(cr.contract_date,'%Y')="+years+"  ";
		
		if(shi!=null&&shi!=0){
			
			if(shi>3){
				sql +="and fh.shi>"+shi+" ";
			}else{
				sql +="and fh.shi="+shi+" ";
				
			}
		}
		
		sql +="GROUP BY date_format(cr.contract_date,'%Y-%m')";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query=pm.newQuery("SQL",sql);
		ForwardQueryResult results= (ForwardQueryResult)query.execute();
		String[] str =  new String[12];
		List<Object>  list =  new ArrayList<Object>(); 
		for (int i =0; i <=12; i++) {
			boolean isexist=false;
			for (int j = 0; j < results.size(); j++) {
				Object[] obj = (Object[])results.get(j);
				Object object = obj[0];
				Object object2 = obj[1];
				if(Integer.valueOf(String.valueOf(object)) == i )
				{
					System.out.println(i);
					list.add(Integer.valueOf(String.valueOf(object2)));
					isexist=true;
				}
				
			}
			if(!isexist){
				list.add(0);
			}
		}
		pm.close();
		return list;
	}
	//栋座资料在售曲线图数据
	public List<Object> fangcsquxian(Integer years,Integer lpid,Integer shi,Integer contype, String relational){
		String sql="SELECT date_format(cr.contract_date,'%m') ,count(1)";
		sql +="FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ";
		sql +="where fh.Lpid="+lpid+" and cr.con_type="+contype+"   and  date_format(cr.contract_date,'%Y')="+years+"  ";
		if(shi!=null&&shi!=0){
			if(shi>3){
				sql +="and fh.shi>"+shi+" ";
			}else{
				sql +="and fh.shi="+shi+" ";
				
			}
		}
		sql +="GROUP BY date_format(cr.contract_date,'%Y-%m')";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query=pm.newQuery("SQL",sql);
		ForwardQueryResult results= (ForwardQueryResult)query.execute();
		String[] str =  new String[12];
		List<Object>  list =  new ArrayList<Object>(); 
		for (int i =0; i <=12; i++) {
			boolean isexist=false;
			for (int j = 0; j < results.size(); j++) {
				Object[] obj = (Object[])results.get(j);
				Object object = obj[0];
				Object object2 = obj[1];
				if(Integer.valueOf(String.valueOf(object)) == i )
				{
					list.add(Integer.valueOf(String.valueOf(object2)));
					isexist=true;
				}
				
			}
			if(!isexist){
				list.add(0);
			}
		}
		pm.close();
		return list;
	}
	//栋座资料在租曲线图数据
	public List<Object> fangczquxian(Integer years,Integer lpid,Integer shi,String relational){
		String sql="SELECT date_format(cr.contract_date,'%m') ,count(1)";
		sql +="FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ";
		sql +="where fh.Lpid="+lpid+" and cr.con_type=2    and  date_format(cr.contract_date,'%Y')="+years+"  ";
		if(shi!=null&&shi!=0){
			if(shi>3){
				sql +="and fh.shi>"+shi+" ";
			}else{
				sql +="and fh.shi="+shi+" ";
				
			}
		}
		sql +="GROUP BY date_format(cr.contract_date,'%Y-%m')";
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query=pm.newQuery("SQL",sql);
		ForwardQueryResult results= (ForwardQueryResult)query.execute();
		String[] str =  new String[12];
		List<Object>  list =  new ArrayList<Object>(); 
		for (int i =1; i <=12; i++) {
			boolean isexist=false;
			for (int j = 0; j < results.size(); j++) {
				Object[] obj = (Object[])results.get(j);
				Object object = obj[0];
				Object object2 = obj[1];
				if(Integer.valueOf(String.valueOf(object)) == i )
				{
					list.add(Integer.valueOf(String.valueOf(object2)));
					isexist=true;
				}
				
			}
			if(!isexist){
				list.add(0);
			}
		}
		pm.close();
		return list;
	}
	
	//小区成交数
	public List<Object> querycjCount(Integer lpid, String relational) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT count(1)  FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sql.append(" where  cr.con_type=1  and date_format(contract_date,'%Y-%m')=date_format(now(),'%Y-%m')");
		sql.append(" and fh.Lpid=").append(lpid);
		
		sql.append(" union all  ");
		sql.append("SELECT count(1)  FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sql.append(" where  cr.con_type=1  and date_format(contract_date,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')");
		sql.append(" and fh.Lpid=").append(lpid);
		
		sql.append(" union all  ");
		sql.append("SELECT count(1)  FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sql.append(" where  cr.con_type=2  and date_format(contract_date,'%Y-%m')=date_format(now(),'%Y-%m')");
		sql.append(" and fh.Lpid=").append(lpid);
		sql.append(" union all  ");
		
		sql.append("SELECT count(1)  FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sql.append(" where  cr.con_type=2  and date_format(contract_date,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')");
		sql.append(" and fh.Lpid=").append(lpid);
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object> objs = (List<Object>)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return objs;
		
	}
	
	//小区成交均价
	public List<Object> queryjunjiaCount(Integer lpid, String relational) {
		StringBuffer sqlbycs = new StringBuffer("");
		sqlbycs.append("SELECT sum(cr.price)/count(1) FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sqlbycs.append(" where  con_type=1 and date_format(contract_date,'%Y-%m')=date_format(now(),'%Y-%m')");
		sqlbycs.append(" and fh.Lpid=").append(lpid);
		sqlbycs.append("  GROUP BY date_format(cr.contract_date,'%Y-%m') ");
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		List<Object> objectList = new ArrayList<Object>();
		List<Object> objectlbycs=(List<Object>) pm.newQuery("SQL",sqlbycs.toString()).execute();
		
		if(objectlbycs.size()!=0&&objectlbycs!=null){
			objectList.add(objectlbycs.get(0));
		}else{
			objectList.add(0);
		}
		
		StringBuffer sqlbycz = new StringBuffer("");
		sqlbycz.append("SELECT sum(cr.price)/count(1) FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sqlbycz.append(" where  con_type=2 and date_format(contract_date,'%Y-%m')=date_format(now(),'%Y-%m')");
		sqlbycz.append(" and fh.Lpid=").append(lpid);
		sqlbycz.append("  GROUP BY date_format(cr.contract_date,'%Y-%m') ");
		List<Object> objectlbycz=(List<Object>) pm.newQuery("SQL",sqlbycz.toString()).execute();
		if(objectlbycz.size()!=0&&objectlbycz!=null){
			objectList.add(objectlbycz.get(0));
		}else{
			objectList.add(0);
		}
		
		StringBuffer sqlsycs = new StringBuffer("");
		sqlsycs.append("SELECT sum(cr.price)/count(1) FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sqlsycs.append(" where  con_type=1 and date_format(createDate,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') ");
		sqlsycs.append(" and fh.Lpid=").append(lpid);
		sqlsycs.append("  GROUP BY date_format(cr.contract_date,'%Y-%m') ");
		List<Object> objectlsycs=(List<Object>) pm.newQuery("SQL",sqlsycs.toString()).execute();
		if(objectlsycs.size()!=0&&objectlsycs!=null){
			objectList.add(objectlsycs.get(0));
		}else{
			objectList.add(0);
		}
		
		StringBuffer sqlsycz = new StringBuffer("");
		sqlsycz.append("SELECT sum(cr.price)/count(1) FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID ");
		sqlsycz.append(" where  con_type=2 and date_format(createDate,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') ");
		sqlsycz.append(" and fh.Lpid=").append(lpid);
		sqlsycz.append("  GROUP BY date_format(cr.contract_date,'%Y-%m') ");
		List<Object> objectlsycz=(List<Object>) pm.newQuery("SQL",sqlsycz.toString()).execute();
		if(objectlsycz.size()!=0&&objectlsycz!=null){
			objectList.add(objectlsycz.get(0));
		}else{
			objectList.add(0);
		}
		pm.close();
		return objectList;
	}
	
	
	//均价曲线图数据
		public List<Object> cjjunjiaquxian(Integer years,Integer lpid,Integer shi,Integer contype,String relational){
			String sql="SELECT date_format(cr.contract_date,'%m') ,sum(cr.price)/count(1) ";
			sql +=" FROM `lp_contract_record` cr INNER JOIN xhj_lpfanghao fh ON cr.houseinfoid=fh.ID  ";
			sql +="where fh.Lpid="+lpid+"   and cr.con_type="+contype+"   and  date_format(cr.contract_date,'%Y')="+years+"  ";
			
			if(shi!=null&&shi!=0){
				if(shi>3){
					sql +="and fh.shi>"+shi+" ";
				}else{
					sql +="and fh.shi="+shi+" ";
					
				}
			}
			
			sql +="GROUP BY date_format(cr.contract_date,'%Y-%m')";
			PersistenceManager pm = getPersistenceManagerByStratey(relational);
			Query query=pm.newQuery("SQL",sql);
			ForwardQueryResult results= (ForwardQueryResult)query.execute();
			String[] str =  new String[12];
			List<Object>  list =  new ArrayList<Object>(); 
			for (int i =0; i <=12; i++) {
				boolean isexist=false;
				for (int j = 0; j < results.size(); j++) {
					Object[] obj = (Object[])results.get(j);
					Object object = obj[0];
					Object object2 = obj[1];
					if(Integer.valueOf(String.valueOf(object)) == i )
					{
						list.add(Double.valueOf(String.valueOf(object2)));
						isexist=true;
					}
					
				}
				if(!isexist){
					list.add(0);
				}
			}
			pm.close();
			return list;
		}
	
		public  PageInfo queryLpzj(PageInfo pageInfo,Integer lpid ){
			StringBuilder sql = new StringBuilder();
			StringBuilder sqlCount = new StringBuilder();
			sql.append("SELECT tr.crate_date, d.department_name,u.fullname ,u.tel,d.address,tr.remark ");
			sql.append("FROM hr_title_relation tr INNER JOIN hr_title_relation_sub trs  ON tr.trid=trs.trid  ");
			sql.append("INNER JOIN tbl_user_profile u on u.id=tr.usxxid  ");
			sql.append("INNER JOIN tbl_user_login ul ON u.id=ul.tbl_user_profile_id  ");
			sql.append("INNER JOIN tbl_position p ON ul.id=p.tbl_user_id  ");
			sql.append("INNER JOIN tbl_department d ON p.tbl_department_id=d.id  ");
			sql.append(" WHERE  tr_type=1429 and  trs.relation_id="+lpid+"  AND tr.flag=1  ");
			sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
			pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
			return pageInfo;
		}
		
		public List<Metro> queryCtype(String ctype,String relational){
			String sql ="select id,VALUE from lp_syscs_1 where id = "+ctype;
			PersistenceManager pm = getPersistenceManagerByStratey(relational);
			Query query=pm.newQuery("SQL",sql);
			List<Object[]> objects=  (List<Object[]>) query.execute();
			Metro metro = null;
			List<Metro> list = new ArrayList<Metro>();
			for(Object[] temp : objects){
				metro = new Metro();
				metro.setId(temp[0].toString());
				metro.setName(temp[1].toString());
				list.add(metro);
			}
			pm.close();
			return list;
		}
		
		
}
