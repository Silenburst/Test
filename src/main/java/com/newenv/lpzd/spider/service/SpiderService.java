package com.newenv.lpzd.spider.service;

import java.util.HashMap;
import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.spider.SpiderCoummunityEntity;
import com.newenv.lpzd.spider.dao.SpiderDao;
import com.newenv.pagination.PageInfo;

public class SpiderService
{
	private SpiderDao spiderDao;
	
	public SpiderDao getSpiderDao()
	{
		return spiderDao;
	}

	public void setSpiderDao(SpiderDao spiderDao)
	{
		this.spiderDao = spiderDao;
	}

	public Object[] queryCommunicationInfo(HashMap<String,String> hm)
	{
		return spiderDao.queryCommunicationInfo(hm,DAOConstants.RELATIONAL);
	}
	
	public PageInfo queryData(SpiderCoummunityEntity spiderCoummunityEntity, PageInfo pageInfo)
	{
		return spiderDao.queryData(spiderCoummunityEntity,pageInfo);
	}
	
	public PageInfo queryGatherData(SpiderCoummunityEntity spiderCoummunityEntity, PageInfo pageInfo)
	{
		return spiderDao.queryGatherData(spiderCoummunityEntity,pageInfo);
	}
	
	public Integer updateCrawlStatus(String idList)
	{
		return spiderDao.updateCrawlStatus(idList,DAOConstants.RELATIONAL);
	}
	
	public PageInfo imageQuery(String imgUrl, int imgType, PageInfo pageInfo)
	{
		return spiderDao.imageQuery(imgUrl,imgType,pageInfo);
	}
	
	public String queryFloorInfo(XhjLpxx lpxx) throws Exception
	{
		return spiderDao.queryFloorInfo(lpxx,DAOConstants.RELATIONAL);
	}
	
	public int queryProvinceId(int couId,String provinceValue)
	{
		return spiderDao.queryProvinceId(couId,provinceValue,DAOConstants.RELATIONAL);
	}
	
	public int queryCityId(int proId,String cityValue)
	{
		return spiderDao.queryProvinceId(proId,cityValue,DAOConstants.RELATIONAL);
	}
	
	public int queryStreeId(int cityId,String qyValue)
	{
		return spiderDao.queryStreeId(cityId,qyValue,DAOConstants.RELATIONAL);
	}
	
	public int querySqId(int qyId,String sqValue)
	{
		return spiderDao.queryStreeId(qyId,sqValue,DAOConstants.RELATIONAL);
	}
}
