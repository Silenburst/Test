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
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class LpCountryDao  extends DaoParent<LpCountry>{
	/**
	 * 查询所有的国家信息。
	 * @param strategy
	 * @return
	 */
	public List<LpCountry> findAll(String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery(LpCountry.class);
		query.setFilter("statuss==1");
		List<LpCountry> list = (List<LpCountry>)query.execute();
		return list;
	}
	
	
	public List<LpCountry> getByLpCountry(String cname ,String strategy){
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		String sql="select id,c_name from lp_country where statuss=1 and  c_name like '"+cname+"'";
		Query query = pm.newQuery("SQL",sql);
		List<Object[]> list= (List<Object[]>) query.execute();
		List<LpCountry> lpCountrylist = new ArrayList<LpCountry>();
		for(Object[] objs:list){
			LpCountry entity = new LpCountry();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setCname(objs[1].toString());
			}
			lpCountrylist.add(entity);
		}
		pm.close();
		return lpCountrylist;
	}
	
	
	public PageInfo findByPage(PageInfo page, String strategy){
			
			StringBuffer sbCondition = new StringBuffer(" where 1==1 ");
	
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			pm.getFetchPlan().setMaxFetchDepth(2);
			
			Query query = pm.newQuery("select count(id) from " + LpCountry.class.getName() + sbCondition.toString());
		//	query.setUnique(true);
			long records = (Long)query.execute();
			page.setRecords((int)records);
			
			String jdql = "select from " + LpCountry.class.getName() + sbCondition.toString();
			query = pm.newQuery(jdql);
			
			query.setRange((page.getPage()-1)*page.getRows(), page.getPage()*page.getRows());
			page.setGridModel((List<LpCountry>)query.execute());
			pm.close();
			return page;
		}
	/**
	 * 页面显示数据查询
	 * @param pager
	 * @param strategy
	 * @return
	 */
	public PageInfo findByPageInFo(Metro metro ,PageInfo pager){
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append(" select js.Qy_Name, ");
		sql.append(" js.id, ");
		sql.append(" sq.Sq_Name, ");
		sql.append(" sq.CreateDate, ");
		sql.append(" sq.ModifyDate, ");
		sql.append(" city.provinceid, ");
		sql.append(" (select city_name from xhj_jccity where id=js.cityid)cityname, ");
		sql.append(" sq.id , ");
		sql.append(" p.cid, ");
		sql.append(" sq.x, ");
		sql.append(" sq.y ");
		sqlcommon.append(" from  Xhj_JcSq sq, Xhj_JcStress js,xhj_jccity city,lp_province p,lp_country c ");
		sqlcommon.append("  where sq.qyid=js.id and js.cityid=city.id and city.provinceid=p.id and p.cid=c.id and sq.Statuss=1 ");
		//国家
		if(StringUtils.isNotEmpty(metro.getCountryId()) && !"0".equals(metro.getCountryId())){
			sqlcommon.append(" and c.id=").append(metro.getCountryId());
		}
		//省份
		if(StringUtils.isNotEmpty(metro.getPid()) && !"0".equals(metro.getPid())){
			sqlcommon.append(" and p.id=").append(metro.getPid());
		}
		//城市
		if(StringUtils.isNotEmpty(metro.getCityID()) && !"0".equals(metro.getCityID())){
			sqlcommon.append(" and city.id=").append(metro.getCityID());
		}
		//区域
		if(StringUtils.isNotEmpty(metro.getQyID()) &&!"0".equals( metro.getQyID())){
			sqlcommon.append(" and js.ID=").append(metro.getQyID());
		}
		//商圈
		if(StringUtils.isNotEmpty(metro.getSqName()) &&!"0".equals( metro.getSqName())){
			sqlcommon.append(" and sq.Sq_Name LIKE '%").append(metro.getSqName()).append("%'");
		}
		sqlcommon.append("  order by sq.id desc ");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}
	
	/**
	 * 添加一条数据
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public XhjJcsq addData(Metro metro,String strategy){
		String sql = "select from " + XhjJcsq.class.getName() + " where sqName=='" + metro.getSqName() + "' && status==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<XhjJcsq> countries = (List<XhjJcsq>)pm.newQuery(sql).execute();
		XhjJcsq xhjJcsq=null;
		if(countries!=null && countries.size()>0){
			xhjJcsq = countries.get(0);
		} else {
			xhjJcsq= new XhjJcsq();
		}
		xhjJcsq.setQyId(Integer.parseInt(metro.getQyID()));
		xhjJcsq.setSqName(metro.getSqName());
		xhjJcsq.setX(metro.getX());
		xhjJcsq.setY(metro.getY());
		xhjJcsq.setCreateDate(new Date());
		xhjJcsq.setStatus(1);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			pm.makePersistent(xhjJcsq);
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
		return xhjJcsq;
	}
	
	public long selectShangQuanData(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from xhj_jcsq where statuss =1 and Sq_Name = '"+metro.getSqName()+"'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	/**
	 * 添加国家
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public LpCountry addState(Metro metro,String strategy){
		String sql = "select from " + LpCountry.class.getName() + " where cname=='" + metro.getCname() + "' && statuss==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<LpCountry> countries = (List<LpCountry>)pm.newQuery(sql).execute();
		LpCountry lpCountry=null;
		if(countries!=null && countries.size()>0){
			lpCountry = countries.get(0);
		} else {
			lpCountry= new LpCountry();
		}
		lpCountry.setCname(metro.getCname());
		lpCountry.setNumber(metro.getCoding());
		lpCountry.setCreatedate(new Date());
		lpCountry.setStatuss(1);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			pm.makePersistent(lpCountry);
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
		return lpCountry;
	}
	//根据ID查询国家名称
	public List<Metro> selectState(Metro metro,String strategy){
		String sql = "select id,c_name,number from lp_country where statuss =1 and id = "+metro.getCountryId();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setCountryId(temp[0]+"");
			 metr.setCityName(temp[1]+"");
			 if(temp[2] != null && "" != temp[2]){
				 metr.setCoding(temp[2]+"");
			 } else {
				 metr.setCoding("");
			 }
			
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	//新增国家判断
	public long selectStateData(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from lp_country where statuss =1 and c_name = '"+metro.getCname()+"'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	/**
	 * 修改国家
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateState(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpCountry.class.getName() + " set cname=='" + metro.getCname() + "',number=='"+metro.getCoding()+"' where id==" + metro.getCountryId();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	
	
	/**
	 * 添加省份
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public LpProvince addProvince(Metro metro,String strategy){
		String sql = "select from " + LpProvince.class.getName() + " where pname=='" + metro.getPname() + "' && statuss==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<LpProvince> countries = (List<LpProvince>)pm.newQuery(sql).execute();
		LpProvince lpProvince=null;
		if(countries!=null && countries.size()>0){
			lpProvince = countries.get(0);
		} else {
			lpProvince= new LpProvince();
		}
		lpProvince.setPname(metro.getPname());
		lpProvince.setNumber(metro.getCoding());
		lpProvince.setCreatedate(new Date());
		lpProvince.setCid(Integer.parseInt(metro.getCountryId()));
		lpProvince.setStatuss(1);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    pm.makePersistent(lpProvince);
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
		return lpProvince;
	}
	//新增省份判断
	public long selectProvinceData(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from lp_province where statuss =1 and p_name = '"+metro.getPname()+"' and id = "+metro.getCountryId();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	public List<Metro> selectProvince(Metro metro,String strategy){
		String sql = "select id,p_name,number from lp_province where statuss =1 and id ="+metro.getPid();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setPid(temp[0]+"");
			 metr.setCityName(temp[1]+"");
			 if(temp[2] != null && "" != temp[2]){
				 metr.setCoding(temp[2]+"");
			 } else {
				 metr.setCoding("");
			 }
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 修改省份
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateProvince(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpProvince.class.getName() + " set pname=='" + metro.getPname() + "',number=='"+metro.getCoding()+"' where id==" + metro.getCountryId();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	
	/**
	 * 添加城市
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public XhjJccity addCity(Metro metro,String strategy){
		String sql = "select from " + XhjJccity.class.getName() + " where cityName=='" + metro.getCityName() + "' && statuss==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<XhjJccity> countries = (List<XhjJccity>)pm.newQuery(sql).execute();
		XhjJccity xhjJccity=null;
		if(countries!=null && countries.size()>0){
			xhjJccity = countries.get(0);
		} else {
			xhjJccity= new XhjJccity();
		}
		xhjJccity.setCityName(metro.getCityName());
		xhjJccity.setNumber(metro.getCoding());
		xhjJccity.setCreateDate(new Date());
		xhjJccity.setProvinceid(Integer.parseInt(metro.getPid()));
		xhjJccity.setStatuss(1);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    pm.makePersistent(xhjJccity);
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
		return xhjJccity;
	}
	//新增城市判断
	public long selectCityData(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from xhj_jccity where statuss =1 and City_Name = '"+metro.getCityName()+"' and provinceid="+metro.getPid();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		return number;
	}
	//根据城市ID获取名称
	public List<Metro> selectCity(Metro metro,String strategy){
		String sql = "select id,City_Name,number from xhj_jccity where statuss =1 and id ="+metro.getCityID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setCityID(temp[0]+"");
			 metr.setCityName(temp[1]+"");
			 if(temp[2] != null && "" != temp[2]){
				 metr.setCoding(temp[2]+"");
			 } else {
				 metr.setCoding("");
			 }
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 修改城市
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public 	int updateCity(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjJccity.class.getName() + " set cityName=='" + metro.getCityName() + "',number=='"+metro.getCoding()+"' where id==" + metro.getCityID();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	
	/**
	 * 添加区域
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public XhjJcstress addArea(Metro metro,String strategy){
		String sql = "select from " + XhjJcstress.class.getName() + " where qyName=='" + metro.getQyName() + "' && status==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<XhjJcstress> countries = (List<XhjJcstress>)pm.newQuery(sql).execute();
		XhjJcstress xhjJcstress=null;
		if(countries!=null && countries.size()>0){
			xhjJcstress = countries.get(0);
		} else {
			xhjJcstress= new XhjJcstress();
		}
		xhjJcstress.setCityId(Integer.parseInt(metro.getCityID()));
		xhjJcstress.setQyName(metro.getQyName());
		xhjJcstress.setNumber(metro.getCoding());
		xhjJcstress.setX(metro.getX());
		xhjJcstress.setY(metro.getY());
		xhjJcstress.setCreateDate(new Date());
		xhjJcstress.setStatus(1);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    pm.makePersistent(xhjJcstress);
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
		return xhjJcstress;
	}
	//新增区域判断
	public long selectDataArea(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from Xhj_JcStress where statuss =1 and Qy_Name = '"+metro.getQyName()+"' and id = " +metro.getCityID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	/**
	 * 根据区域ID查询出所属区域Name
	 * @param metro
	 * @return
	 */
	public List<Metro> selectAreaData(Metro metro,String strategy){
		String sql ="select id,Qy_Name,number,x,y from Xhj_JcStress where ID = " +metro.getQyID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setQyID(temp[0]+"");
			 metr.setQyName(temp[1]+"");
			 if(temp[2] != null && "" != temp[2]){
				 metr.setCoding(temp[2]+"");
			 } else {
				 metr.setCoding("");
			 }
			 metr.setX(temp[3]+"");
			 metr.setY(temp[4]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 修改区域
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateArea(Metro metro,String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    Query query  = pm.newQuery( XhjJcstress.class);
		    query.setFilter( "id=="+metro.getQyID());
		    List<XhjJcstress> execute = (List<XhjJcstress>)query.execute();
		    XhjJcstress xhjJcstress  =null;
		    if(execute.size()>0 && execute !=null)
		    {
		    	xhjJcstress = new XhjJcstress();
		    	xhjJcstress = execute.get(0);
		    	xhjJcstress.setQyName(metro.getQyName());
		    	xhjJcstress.setNumber(metro.getCoding());
		    	xhjJcstress.setX(metro.getX());
		    	xhjJcstress.setY(metro.getY());
		    	pm.makePersistent(xhjJcstress);
		    }
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
	
	/**
	 * 批量删除
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateBatchRemove(Metro metro,String strategy){
		String[] str = metro.getSqID().split(",");
		Long number = null;
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    for(String sqId:str){ 
			     String jdoql = "update " + XhjJcsq.class.getName() + " set status == 0 where id==" + sqId;
				 number =(Long) pm.newQuery(jdoql).execute();
			}
		   
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
	/**
	 * 获取所有所属城市的区域姓名，ID
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public String selectArea(Metro metro,String strategy){
		String sql ="select id,Qy_Name from Xhj_JcStress where CityID= "+metro.getCityID();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			pm.newQuery(sql.toString()).execute();
			tx.commit();
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
		return null;
	}
	
	/**
	 *根据ID查询出单条数据进行修改
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public List<Metro> selectData(Metro metro,String strategy){
		String sql ="select jcsq.id,jc.City_Name,js.Qy_Name,jcsq.Sq_Name  from xhj_jccity jc,Xhj_JcSq jcsq,Xhj_JcStress js where jc.id = js.CityID and js.id=jcsq.qyid and js.statuss=1 and jcsq.id="+metro.getSqID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setSqID(temp[0]+"");
			 metr.setCityName(temp[1]+"");
			 metr.setQyName(temp[2]+"");
			 metr.setSqName(temp[3]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 修改数据
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateData(Metro metro,String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    Query query  = pm.newQuery( XhjJcsq.class);
		    query.setFilter( "id=="+metro.getSqID());
		    List<XhjJcsq> execute = (List<XhjJcsq>)query.execute();
		    XhjJcsq xhjJcsq  =null;
		    if(execute.size()>0 && execute !=null)
		    {
		    	xhjJcsq = new XhjJcsq();
		    	xhjJcsq = execute.get(0);
		    	xhjJcsq.setModifyDate(new Date());
		    	xhjJcsq.setSqName(metro.getSqName());
		    	xhjJcsq.setX(metro.getX());
		    	xhjJcsq.setY(metro.getY());
		    	pm.makePersistent(xhjJcsq);
		    }
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
	/**
	 * 查询国家
	 * @param strategy
	 * @return
	 */
	public List<Metro> selectCountryData(String strategy){
		String sql ="select id,c_name from lp_country where statuss = 1";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setCountryId(temp[0]+"");
			 metr.setCname(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 查询省份
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public List<Metro> selectDataProvince(Metro metro ,String strategy){
		String sql ="select id,p_name from lp_province where statuss = 1 and cid = "+metro.getCountryId();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setPid(temp[0]+"");
			 metr.setPname(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	
	/**
	 * 查询城市的名称两级联动
	 * @return list
	 */
	public List<Metro> selectDataCity(Metro metro,String strategy){
		String sql = "select id,City_Name from Xhj_JcCity where statuss = 1 and provinceid = "+metro.getPid();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setCityID(temp[0]+"");
			 metr.setCityName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	/**
	 * 根据城市ID查询区域的名称两级联动
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public List<Metro> selectShuangQuan(Metro metro,String strategy){
		String sql = "select id,Qy_Name from Xhj_JcStress where statuss = 1 and cityID = "+metro.getCityID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setId(temp[0]+"");
			 metr.setQyName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	/**
	 * 删除国家
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateDataState(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpCountry.class.getName() + " set statuss ==0 where id==" + metro.getCountryId();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	/**
	 * 删除省份
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateDataProvince(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpProvince.class.getName() + " set statuss == 0 where id==" + metro.getCountryId();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	/**
	 * 删除城市
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public 	int updateDataCity(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjJccity.class.getName() + " set statuss == 0 where id==" + metro.getCityID();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
	/**
	 * 删除区域
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateDataArea(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjJcstress.class.getName() + " set status ==0 where id==" + metro.getQyID();
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    number =(Long) pm.newQuery(jdoql).execute();
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
}
