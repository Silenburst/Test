package com.newenv.lpzd.spider.dao;

import java.util.HashMap;
import java.util.List;

import javax.jdo.PersistenceManager;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.XiaoQu;
import com.newenv.lpzd.spider.SpiderCoummunityEntity;
import com.newenv.pagination.PageInfo;

public class SpiderDao extends DaoParent<XhjLpxx>
{
	public Object[] queryCommunicationInfo(HashMap<String,String> hm,String strategy)
	{
		String sql = "";
		String select = "";
		String where = "";
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		
		try
		{
			String lpName=hm.get("lpName");
			String cityValue=hm.get("cityValue");
			if(lpName!=null && lpName.length()>0 && cityValue!=null && cityValue.length()>0)
			{
				List<Object[]> als=null;
				sql=
					" select t1.countryid as countryid,t1.provinceid as provinceid," + 
					" t1.cityid as cityid,t1.stressid as stressid,t1.sq_id as sqid, " + 
					" t1.id as id from xhj_lpxx t1,xhj_jccity t2 where 1=1 and " + 
					" t1.CityID=t2.id and t1.lp_name='"+lpName+"' "	+ 
					" and t2.City_Name='"+cityValue+"' ";
				
				als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
				if(als!=null && als.size()>0)
				{
					// 选择第一行作为查询统一数据.
					objs=als.get(0);
				}
				else
				{
					sql=
					" select t1.countryid as countryid,t1.provinceid as provinceid," + 
					" t1.cityid as cityid,t1.stressid as stressid,t1.sq_id as sqid, " + 
					" t1.id as id from xhj_lpxx t1,xhj_jccity t2 where 1=1 and " + 
					" t1.CityID=t2.id and t1.lp_name like '%"+lpName+"%' "	+ 
					" and t2.City_Name='"+cityValue+"' ";
					
					als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
					if(als!=null && als.size()>0)
					{
						// 选择第一行作为查询统一数据.
						objs=als.get(0);
					}
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return objs;
	}
	
	/**
	 * 采集数据分组查询.
	 * @param spiderCoummunityEntity
	 * @param pageInfo
	 * @return
	 */
	public PageInfo queryData(SpiderCoummunityEntity spiderCoummunityEntity, PageInfo pageInfo)
	{
		String where=" 1=1 ";
		String sql = "";
		String sqlCount = "";
		
		// 国家
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getCountryValue().toString()))
		{
			where=where+" and countryid='"+spiderCoummunityEntity.getCountryValue()+"' ";
		}
		// 省份
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getProvinceValue().toString()))
		{
			where=where+" and provinceid='"+spiderCoummunityEntity.getProvinceValue()+"' ";
		}
		// 城市
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getCityValue().toString()))
		{
			where=where+" and cityid='"+spiderCoummunityEntity.getCityValue()+"' ";
		}
		// 区域
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getStressValue().toString()))
		{
			String qy=spiderCoummunityEntity.getStressValue();
			qy=qy.replace("区", "");
			qy=qy.replace("县", "");
			
			where=where+" and qyid like '%"+qy+"%' ";
		}
		// 商圈
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getSqValue().toString()))
		{
			where=where+" and sqid like '%"+spiderCoummunityEntity.getSqValue()+"%' ";
		}
		// 楼盘
		if (StringUtils.isNotEmpty(spiderCoummunityEntity.getLpName().toString()))
		{
			where=where+" and lpname like '%"+spiderCoummunityEntity.getLpName()+"%' ";
		}
		
		try
		{
			if(spiderCoummunityEntity.getStatuss()==1)
				sql=sql+" select t1.countryid,t1.provinceid,t1.cityid,t1.qyid,t1.sqid,t1.lpname from (select t.countryid,t.provinceid,t.cityid,t.qyid,t.sqid,t.lpname,sum(t.CrawlStatus) as csnum from (select countryid,provinceid,cityid,qyid,sqid,lpname,ifnull(CrawlStatus,0) as CrawlStatus from xiaoqu where "+where+" ) t group by t.countryid,t.provinceid,t.cityid,t.qyid,t.sqid,t.lpname) t1 where t1.csnum>0 ";
			else
				sql=sql+" select t1.countryid,t1.provinceid,t1.cityid,t1.qyid,t1.sqid,t1.lpname from (select t.countryid,t.provinceid,t.cityid,t.qyid,t.sqid,t.lpname,sum(t.CrawlStatus) as csnum from (select countryid,provinceid,cityid,qyid,sqid,lpname,ifnull(CrawlStatus,0) as CrawlStatus from xiaoqu where "+where+" ) t group by t.countryid,t.provinceid,t.cityid,t.qyid,t.sqid,t.lpname) t1 where t1.csnum=0 ";
			System.out.println(sql);
			
			sqlCount="select count(*) from ("+sql+") tbl ";
			pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return pageInfo;
	}

	
	/**
	 * 查采集到的数据.
	 * @param spiderCoummunityEntity
	 * @param pageInfo
	 * @return
	 */
	public PageInfo queryGatherData(SpiderCoummunityEntity spiderCoummunityEntity, PageInfo pageInfo)
	{
		String sql = "";
		String select = "";
		String where = "";
		
		select=" qyid,sqid,yongtu,lpName,bieMing,lType,address,xxzbx,xxzby,xzgx, ";
		select=select + " linkLocAtion,propertyAddress,statuss,beiZ,sumZd,sumJz,buildingAge,rjl,lhl,djs, ";
		select=select + " hjs,rzhs,lpJiangX,qq,roomRate,jieDao,renChe,propertySupporting,more,PNum, ";
		select=select + " propertyAge,propertyInfo,airSupply,heatingWay,waterSupply,powerSupply,configuration,communitySafety,materials,brand, ";
		select=select + " facadesProcessing,buildingType,buildingStructure,openingPrice,price,openingAvgPrice,avgPrice,wy,wyPhone,wyAdress, ";
		select=select + " wuyePayingWay,wuyePrice,wuyeUnit,kaifa,kaifaPhone,tzs,cjs,dls,huapian,";
		
		select=select + " source,url,id ";
		where=" 1=1 ";
		
		try
		{
			// 国家
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getCountryValue().toString()))
			{
				where=where+" and countryid='"+spiderCoummunityEntity.getCountryValue()+"' ";
			}
			// 省份
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getProvinceValue().toString()))
			{
				where=where+" and provinceid='"+spiderCoummunityEntity.getProvinceValue()+"' ";
			}
			// 城市
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getCityValue().toString()))
			{
				where=where+" and cityid='"+spiderCoummunityEntity.getCityValue()+"' ";
			}
			// 区域
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getStressValue().toString()))
			{
				String qy=spiderCoummunityEntity.getStressValue();
				qy=qy.replace("区", "");
				qy=qy.replace("县", "");
				where=where+" and qyid like '%"+spiderCoummunityEntity.getStressValue()+"%' ";
			}
			// 商圈
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getSqValue().toString()))
			{
				where=where+" and sqid like '%"+spiderCoummunityEntity.getSqValue()+"%' ";
			}
			// 楼盘
			if (StringUtils.isNotEmpty(spiderCoummunityEntity.getLpName().toString()))
			{
				where=where+" and lpname like '%"+spiderCoummunityEntity.getLpName()+"%' ";
			}
			
			sql=sql+" select t0.* from ((select "+select+" from xiaoqu where "+where+" and source='搜房' limit 0,1) ";
			sql=sql+" union all (select "+select+" from xiaoqu where "+where+" and source='安居客' limit 0,1) ";
			sql=sql+" union all (select "+select+" from xiaoqu where "+where+" and source='0731新房网' limit 0,1)) t0 ";
			
			String sqlCount="select count(*) from ("+sql+") tbl ";
			pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
			System.out.println(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return pageInfo;
	}
	
	
	public Integer updateCrawlStatus(String idList,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		int num=0;
		
		try
		{
			if(idList.length()>0)
			{
				String[] ids=idList.split(",");
				if(ids!=null && ids.length>0)
				{
					for(int i=0;i<ids.length;i++)
					{
						//XiaoQu xiaoQu=(XiaoQu) pm.getObjectById(ids[i]);
						XiaoQu xiaoQu=(XiaoQu)pm.getObjectById(XiaoQu.class, Integer.valueOf(ids[i]));
						
						if(xiaoQu!=null)
						{
							xiaoQu.setCrawlStatus(1);
							pm.makePersistent(xiaoQu);
						}
					}
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
	
	/**
	 * 查图片.
	 * @param url
	 * @param pageInfo
	 * @return
	 */
	public PageInfo imageQuery(String imgUrl, int imgType, PageInfo pageInfo)
	{
		String sql = "";
		String where="";
		
		String[] urls=null;
		if(imgUrl!=null && imgUrl.length()>0)
			urls=imgUrl.split("~");
		
		if(urls!=null && urls.length>0)
		{
			for(int i=0;i<urls.length;i++)
			{
				String sign=DigestUtils.md5Hex(urls[i]);
				where=where+" or sign='"+sign+"' ";
			}
		}
		sql=" select id,type,url,source from xiaoqu_img where ( 0=1 "+where+" ) and type = "+imgType;
		
		try
		{
			System.out.println(sql);
			String sqlCount="select count(*) from ("+sql+") tbl ";
			pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return pageInfo;
	}
	
	
	/**
	 * 查询省份id.
	 * @param cityId
	 * @param strategy
	 * @return
	 */
	public Integer queryProvinceId(int province,String provinceValue, String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		int num=0;
		
		try
		{
			String sql="";
			List<Object[]> als=null;
			
			sql=" select id from lp_province where cid="+province+" and p_name='"+province+"' ";
			als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			if(als==null || als.size()<1)
			{
				sql=" select id from lp_province where cid="+province+" and p_name like '%"+province+"%' ";
				als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			}
			
			if(als!=null && als.size()>0)
			{
				objs=als.get(0);
				if(objs!=null && objs.length>0)
				{
					num=(int)objs[0];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
	
	/**
	 * 查询城市id.
	 * @param city
	 * @param strategy
	 * @return
	 */
	public int queryCityId(int proId,String cityValue, String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		int num=0;

		try
		{
			String sql="";
			List<Object[]> als=null;
			
			sql=" select id from xhj_jccity where provinceid="+proId+" and city_name='"+cityValue+"' ";
			als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			if(als==null || als.size()<1)
			{
				sql=" select id from xhj_jccity where provinceid="+proId+" and city_name like '%"+cityValue+"%' ";
				als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			}
			if(als!=null && als.size()>0)
			{
				objs=als.get(0);
				if(objs!=null && objs.length>0)
				{
					num=(int)objs[0];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
	
	public int queryStreeId(int cityId,String qyValue,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		int num=0;

		try
		{
			String sql="";
			List<Object[]> als=null;

			sql=" select id from xhj_jcstress where cityid="+cityId+" and qy_name = '"+qyValue+"' ";
			als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			if(als==null || als.size()<1)
			{
				sql=" select id from xhj_jcstress where cityid="+cityId+" and qy_name like '%"+qyValue+"%' ";
				als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			}
			if(als!=null && als.size()>0)
			{
				objs=als.get(0);
				if(objs!=null && objs.length>0)
				{
					num=(int)objs[0];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
	
	public int querySqId(int qyId,String sqValue,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		int num=0;

		try
		{
			String sql="";
			List<Object[]> als=null;

			sql=" select id from xhj_jcsq where qyid="+qyId+" and sq_name = '"+sqValue+"' ";
			als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			if(als!=null && als.size()>0)
			{
				objs=als.get(0);
				if(objs!=null && objs.length>0)
				{
					num=(int)objs[0];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
	
	
	/**
	 * 查采集到的数据.
	 * @param spiderCoummunityEntity
	 * @param pageInfo
	 * @return
	 */
	public String queryFloorInfo(XhjLpxx lpxx,String strategy)
	{
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Object[] objs=null;
		String num="";

		try
		{
			String sql=" select count(1) as num from xhj_lpxx "
					+ " where cityid="+lpxx.getCityId()+" and streeid="+lpxx.getStressId()+" "
					+ " and sq_id="+lpxx.getSqId()+" and lp_name like '%"+lpxx.getLpName()+"%' ";
			List<Object[]> als=(List<Object[]>)pm.newQuery("SQL", sql).execute();
			if(als!=null && als.size()>0)
			{
				objs=als.get(0);
				if(objs!=null && objs.length>0)
				{
					num=(String)objs[0];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(pm!=null)
				pm.close();
		}
		
		return num;
	}
}
