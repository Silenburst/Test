package com.newenv.lpzd.base.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;
import org.apache.commons.lang.StringUtils;
import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhan;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhantoxian;
import com.newenv.pagination.PageInfo;

import diqu.Metro;



public class LpMetroManagerDao extends DaoParent<XhjJccity>{
	/**
	 * 地铁交通线
	 * @param strategy
	 * @return  List<XhjLpjiaotongzhantoxian>集合
	 */
	public List finAll(Metro metro,String strategy){
		StringBuffer sql = new StringBuffer();
		sql.append("select jtx.xianLu_Name,sys.id ,jtx.id from Xhj_Lpjiaotongxian jtx, Lp_Syscs_1 sys where jtx.statuss=1 and jtx.LeiBie_ID = sys.id  and jtx.cityId = "+metro.getCityID()+" and jtx.LeiBie_ID = "+metro.getLeibeiID()+" ");
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL",sql.toString());
		List<Object[]> objects=  (List<Object[]>) query.execute();
		Metro metr = null;
		List<Metro> list = new ArrayList<Metro>();
		for(Object[] temp : objects){
			metr = new Metro();
			if(temp[0]!=null&&!"".equals(temp[0])){
				metr.setXianLuName(temp[0].toString());
			}
			if(temp[1]!=null&&!"".equals(temp[1])){
				metr.setId(temp[1].toString());
			}
			if(temp[2]!=null&&!"".equals(temp[2])){
				metr.setXianID(temp[2].toString());
			}
			list.add(metr);
		}
		pm.close();
		return list;
	}
	
	public long selectDataZD(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from xhj_lpjiaotongzhan where ZdName = '"+metro.getZdName()+"'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	
	/**
	 * 交通类别
	 * @param strategy
	 * @return List<LpSyscs1> 集合
	 */
	public List findAll(Metro metro,String strategy){
		StringBuffer sql = new StringBuffer("select  id,Name from Lp_Syscs_1 where Statuss=1 and sid = 361");
		PersistenceManager pm=this.getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		 List<Object[]> listObjects = (List<Object[]>) query.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp : listObjects){
			 metr = new Metro();
			if(temp[0]!=null&&!"".equals(temp[0])){
				metr.setId(temp[0]+"");
			}
			if(temp[1]!=null&&!"".equals(temp[1])){
				metr.setName(temp[1]+"");
			}
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	public PageInfo findByPage (Metro metro,PageInfo pager){
		StringBuffer sql = new StringBuffer();
		StringBuffer countsql=new StringBuffer("select count(*) ");
		StringBuffer sqlcommon=new StringBuffer();
		sql.append("select city.city_Name, ");
		sql.append(" jtx.xianLu_Name, ");
		sql.append(" jtz.zdName, ");
		sql.append(" jtz.id,");
		sql.append(" jtx.ID, ");
		sql.append(" jtx.LeiBie_ID, ");
		sql.append(" city.ID, ");
		sql.append(" jtz.x, ");
		sql.append(" jtz.y ");
		sqlcommon.append("  from lp_country country , lp_province lpro,xhj_jccity city, xhj_lpjiaotongxian jtx,xhj_lpjiaotongzhantoxian jtzx,xhj_lpjiaotongzhan jtz , lp_syscs_1 sys");
		sqlcommon.append(" where jtz.Statuss=1  and country.id = lpro.cid and lpro.id = city.provinceid and city.id = jtzx.cityId and jtx.cityID = jtzx.cityID and jtx.id = jtzx.XianID and jtzx.ZhanID  = jtz.id and sys.id = jtx.LeiBie_ID");
		//国家
		if(StringUtils.isNotEmpty(metro.getCountryId()) && !"0".equals(metro.getCountryId())){
			sqlcommon.append(" and country.id=").append(metro.getCountryId());
		}
		//省份
		if(StringUtils.isNotEmpty(metro.getPid()) && !"0".equals(metro.getPid())){
			sqlcommon.append(" and lpro.id=").append(metro.getPid());
		}
		//城市
		if(StringUtils.isNotEmpty(metro.getCityID()) && !"0".equals(metro.getCityID())){
			sqlcommon.append(" and city.id=").append(metro.getCityID());
		}
		//交通类别
		if(StringUtils.isNotEmpty(metro.getLeibeiID()) && !"0".equals(metro.getLeibeiID())){
			sqlcommon.append(" and sys.ID=").append(metro.getLeibeiID());
		}
		//线路
		if(StringUtils.isNotEmpty(metro.getXianID()) && !"0".equals(metro.getXianID())){
			sqlcommon.append(" and jtx.id=").append(metro.getXianID());
		}
		//线路
		if(StringUtils.isNotEmpty(metro.getZdName()) && !"0".equals(metro.getZdName())){
			sqlcommon.append(" and jtz.zdName LIKE '%").append(metro.getZdName()).append("%'");
		}
		sqlcommon.append("  order by jtx.id desc ");
		sql.append(sqlcommon);
		countsql.append(sqlcommon);
		pager = super.getEntitiesByPaginationWithSql(pager, sql.toString(),countsql.toString(), DAOConstants.RELATIONAL);
		return pager;
	}

	/**
	 * 修改信息
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateStation( Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjLpjiaotongzhan.class.getName() + " set zdName == '"+metro.getZdName()+"' where id ==" + metro.getZhanid();
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
	
	public int  updateSiteLine(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjLpjiaotongxian.class.getName() + " set xianLuName == '"+metro.getXianLuName()+"' where id ==" + metro.getXianID();
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
	 *查询
	 */
	public List<Metro> selectXianLu_Name(Metro metro,String strategy){
		StringBuffer sqlcont = new StringBuffer("select id ,xianLu_Name from xhj_lpjiaotongxian where CityID = "+metro.getCityID());
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sqlcont.toString());
		 List<Object[]> listObjects = (List<Object[]>) query.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr= new Metro();
			 //线路ID
			 metr.setId(temp[0]+"");
			 //线路名称
			 metr.setXianLuName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	 }
	//根据id查询页面单条数据
	public List<Metro> selectData(Metro metro,String strategy){
		String sql = "select id,name from lp_syscs_1 where id = "+metro.getLeibeiID();
		String sqlcont = "select id,XianID from xhj_lpjiaotongzhantoxian where ZhanID = "+metro.getZhanid();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		Query query2 = pm.newQuery("SQL",sqlcont.toString());
		 List<Object[]> listObjects = (List<Object[]>) query.execute();
		 List<Object[]> listObject = (List<Object[]>)query2.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 String str="";
		 for(Object[] temp: listObject){
			 if(temp[1]!=null&&!"".equals(temp[1])){
				 str+=temp[1].toString()+",";
			 }
			
		 }
		 str=str.substring(0, str.length()-1);
		 for(Object[] temp: listObjects){
			 metr= new Metro();
			 metr.setLeibeiID(temp[0]+"");
			 metr.setLeibeiName(temp[1]+"");
			 metr.setXianID(str);
			 list.add(metr);
		 }
		 pm.close();
		return list;
	} 
	
	//获取有效城市
	public List selectCity(Metro metro,String strategy){
		StringBuffer sql = new StringBuffer("select id ,City_Name  from Xhj_JcCity where Statuss =1  and provinceid ="+metro.getPid());
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr= new Metro();
			 //城市ID
			 metr.setCityID(temp[0]+"");
			 //城市名称
			 metr.setCityName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	//类别
	public List selectLeiBei(Metro metro ,String strategy){
		StringBuffer sql = new StringBuffer("select id,Name from Lp_Syscs_1 where  Statuss=1  and sid=361");
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr= new Metro();
			 //站点类别ID
			 metr.setId(temp[0]+"");
			 //站点类别
			 metr.setName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	//线路
	public List<Metro> selectXianLu(Metro metro,String strategy){
		StringBuffer sql = new StringBuffer("select DISTINCT id ,xianLu_Name from xhj_lpjiaotongxian t  where t.statuss=1 and t.LeiBie_ID="+metro.getId() +" and t.CityID= "+metro.getCityID());
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		 Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr= new Metro();
			 //线路ID
			 metr.setXianID(temp[0]+"");
			 //线路Name
			 metr.setXianLuName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		return list;
	}
	
	/**
	 * 新增交通数据
	 * @param metro
	 * @param strategy
	 * @return null
	 */
	public XhjLpjiaotongzhantoxian insertDataZD(Metro metro ,String strategy){
		XhjLpjiaotongzhan xhjLpjiaotongzhan = new XhjLpjiaotongzhan();
		int maxId = getMaxId("Xhj_LpJiaoTongZhan", strategy)+1;
		xhjLpjiaotongzhan.setId(maxId);
		xhjLpjiaotongzhan.setZdName(metro.getZdName());
		xhjLpjiaotongzhan.setX(metro.getX());
		xhjLpjiaotongzhan.setY(metro.getY());
		xhjLpjiaotongzhan.setStatuss((short)1);
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		pm.makePersistent(xhjLpjiaotongzhan);
		XhjLpjiaotongzhantoxian xhjLpjiaotongzhantoxian = new XhjLpjiaotongzhantoxian();
		xhjLpjiaotongzhantoxian.setCityID(Integer.parseInt(metro.getCityID()));
		xhjLpjiaotongzhantoxian.setZhanID(maxId);
		String[] str = metro.getXianID().split(",");
		for(String s:str){
		xhjLpjiaotongzhantoxian.setXianID(Integer.parseInt(s));
		}
		xhjLpjiaotongzhantoxian.setCreateDate(new Date());
		xhjLpjiaotongzhantoxian.setStatuss(1);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
			pm.makePersistent(xhjLpjiaotongzhantoxian);
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
		return xhjLpjiaotongzhantoxian;
	}
	/**
	 * 批量删除
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateData(Metro metro,String strategy){
		Long number = null;
		String[] str = metro.getZhanid().split(",");
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		try
		{
		    tx.begin();
		    for(String zhanId:str){
				String jdoql = "update " + XhjLpjiaotongzhan.class.getName() + " set statuss==0  where id ==" + zhanId;
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
	
	
	//获取数据库id的最大值
	public int selectDatabase (String strategy){
		String sql = "select max(id) from lp_syscs_1";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object> list=(List<Object>) query.execute();
		int maxId=0;
		if(list.get(0).toString()!=null&&!"".equals(list.get(0).toString())){
			maxId = Integer.parseInt(list.get(0).toString());
		}
		pm.close();
		return 0;
	}
	/**
	 * 新增线路
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public XhjLpjiaotongxian addXianLu(Metro metro,String strategy){
		String sql = "select from " + XhjLpjiaotongxian.class.getName() + " where xianLuName=='" + metro.getXianLuName() + "' && statuss==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<XhjLpjiaotongxian> countries = (List<XhjLpjiaotongxian>)pm.newQuery(sql).execute();
		XhjLpjiaotongxian xhjLpjiaotongxian=null;
		if(countries!=null && countries.size()>0){
			xhjLpjiaotongxian = countries.get(0);
		} else {
			xhjLpjiaotongxian= new XhjLpjiaotongxian();
		}
		xhjLpjiaotongxian.setCityID(Integer.parseInt(metro.getCityID()));
		xhjLpjiaotongxian.setXianLuName(metro.getXianLuName());
		xhjLpjiaotongxian.setLeiBieId(Integer.parseInt(metro.getLeibeiID()));
		xhjLpjiaotongxian.setCreateDate(new Date());
		xhjLpjiaotongxian.setStatuss(1);
		pm.makePersistent(xhjLpjiaotongxian);
		pm.close();
		return xhjLpjiaotongxian;
	}
	
	public long selectXianluData(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from xhj_lpjiaotongxian where statuss =1 and XianLu_Name= '"+metro.getXianLuName()+"'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	public List<Metro> selectDateXianlu(Metro metro,String strategy){
		String sql = "select id, XianLu_Name from xhj_lpjiaotongxian where id = "+metro.getXianID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setXianID(temp[0]+"");
			 metr.setXianLuName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	/**
	 * 修改线路
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateXianLu(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjLpjiaotongxian.class.getName() + " set xianLuName == '"+metro.getXianLuName()+"' where id ==" + metro.getXianID();
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
	 * 新增类别
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public LpSyscs1 addLeiBei(Metro metro,String strategy){
		String sql = "select from " + LpSyscs1.class.getName() + " where name=='" + metro.getLeibeiName() + "' && status==0 order by id desc ";
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		List<LpSyscs1> countries = (List<LpSyscs1>)pm.newQuery(sql).execute();
		LpSyscs1 lpSyscs1=null;
		if(countries!=null && countries.size()>0){
			lpSyscs1 = countries.get(0);
		} else {
			lpSyscs1= new LpSyscs1();
		}
		lpSyscs1.setSid(361);
		lpSyscs1.setName(metro.getLeibeiName());
		lpSyscs1.setStatus((byte)1);
		lpSyscs1.setCreateDate(new Date());
		pm.makePersistent(lpSyscs1);
		pm.close();
		return lpSyscs1;
	}
	public List<Metro> seleLeiBeiData(Metro metro,String strategy){
		String sql = "select id, Name from lp_syscs_1 where id = "+metro.getLeibeiID();
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL",sql.toString());
		List<Object[]> listObjects = (List<Object[]>) query.execute();
		Metro metr = null;
		 List<Metro> list = new ArrayList<Metro>();
		 for(Object[] temp: listObjects){
			 metr = new Metro();
			 metr.setLeibeiID(temp[0]+"");
			 metr.setLeibeiName(temp[1]+"");
			 list.add(metr);
		 }
		 pm.close();
		 return list;
	}
	public long selectDataLeiBei(Metro metro,String strategy){
		Integer number = null;
		String sql = "select count(*) from lp_syscs_1 where statuss =1 and Name= '"+metro.getLeibeiName()+"'";
		PersistenceManager pm=getPersistenceManagerByStratey(strategy);
		Query query =pm.newQuery("SQL",sql.toString());
		List<Object> list =(List<Object>)query.execute();
		number=Integer.parseInt(list.get(0).toString());
		pm.close();
		return number;
	}
	/**
	 * 修改类别
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateLeiBei(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpSyscs1.class.getName() + " set name == '"+metro.getLeibeiName()+"' where id ==" + metro.getLeibeiID();
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
	 * 修改单条线路
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateDataXianLu(Metro metro,String strategy){
		Integer number = null;
		String[] str = metro.getXianID().split(",");
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx=pm.currentTransaction();
		XhjLpjiaotongzhan xhjLpjiaotongzhan=pm.getObjectById(XhjLpjiaotongzhan.class,Integer.parseInt(metro.getZhanid()));
		try
		{
			Query q2=pm.newQuery(XhjLpjiaotongzhantoxian.class);
			q2.setFilter(" zhanID =="+Integer.parseInt(metro.getZhanid())+"");
			List<XhjLpjiaotongzhantoxian> list = (List<XhjLpjiaotongzhantoxian>)q2.execute();
			if(list!=null && list.size() >0 ){
				pm.deletePersistentAll(list);
			}
		    tx.begin();
		    xhjLpjiaotongzhan.setZdName(metro.getZdName());
		    xhjLpjiaotongzhan.setX(metro.getX());
		    xhjLpjiaotongzhan.setY(metro.getY());
		    pm.makePersistent(xhjLpjiaotongzhan);
		    for(String s:str){
		    	XhjLpjiaotongzhantoxian entity = new XhjLpjiaotongzhantoxian();
		    	entity.setCityID(Integer.parseInt(metro.getCityID()));
		    	entity.setZhanID(Integer.parseInt(metro.getZhanid()));
		    	entity.setXianID(Integer.parseInt(s));
		    	entity.setCreateDate(new Date());
		    	entity.setStatuss(1);
		    	pm.makePersistent(entity);
		    }
		    number=1;
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			number=0;
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
	 * 删除类别
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateDataLeiBei(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + LpSyscs1.class.getName() + " set status==0 where id ==" + metro.getLeibeiID();
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
	 * 删除线路
	 * @param metro
	 * @param strategy
	 * @return
	 */
	public int updateXianLuData(Metro metro,String strategy){
		Long number = null;
		String jdoql = "update " + XhjLpjiaotongxian.class.getName() + " set statuss==0 where id ==" + metro.getXianID();
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
