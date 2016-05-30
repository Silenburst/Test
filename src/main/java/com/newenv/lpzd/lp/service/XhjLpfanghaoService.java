package com.newenv.lpzd.lp.service;



import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.lp.dao.LpDelegationDao;
import com.newenv.lpzd.lp.dao.LpFanghaoInfoSyncTimer;
import com.newenv.lpzd.lp.dao.XhjLpfanghaoDao;
import com.newenv.lpzd.lp.dao.XhjNewhouseinfoDao;
import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.domain.LpDelegation;
import com.newenv.lpzd.lp.domain.TaskData;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjNewhouseinfo;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;
import com.newenv.pagination.PageInfo;

import diqu.Metro;


public class XhjLpfanghaoService {
	private XhjLpfanghaoDao xhjLpfanghaoDao;
	private LpDelegationDao lpDelegationDao;
	private LpFanghaoInfoSyncTimer lpFanghaoInfoSyncTimer;
	private XhjNewhouseinfoDao xhjNewhouseinfoDao;
	
	//全部
	public PageInfo findByPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String startmj,String endmj){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findByPage(xhjLpfanghao,pageInfo,startmj,endmj);//查询结果集
		
		return pageInfoRs;
		
}	
	//地铁
	public PageInfo findBydtPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String startmj,String endmj ){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findBydtPage(xhjLpfanghao,pageInfo,startmj,endmj);//查询结果集
		
		return pageInfoRs;
		
}	
	
	public PageInfo findByxqPage(XhjLpschool xhjLpschool, PageInfo pageInfo){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findByxqPage(xhjLpschool,pageInfo);//查询结果集
		
		return pageInfoRs;
		
}	
	
	public PageInfo findByxfPage(XhjNewhouseinfo xhjNewhouseinfo, PageInfo pageInfo,String startAvgprice, String egerendAvgprice){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findByxfPage(xhjNewhouseinfo,pageInfo,startAvgprice,egerendAvgprice);//查询结果集
		
		return pageInfoRs;
		
}	
	
	//学区房
	public PageInfo getxqcsPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String lpTag,Integer delegateType ){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findxqcsPage(xhjLpfanghao,pageInfo,lpTag,delegateType);//查询结果集
		
		return pageInfoRs;
		
	}
	//空置
	public PageInfo getxqkzPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String lpTag,Integer delegateType,Integer ltype ){
		//构造实体
		PageInfo pageInfoRs = xhjLpfanghaoDao.findkzPage(xhjLpfanghao,pageInfo,lpTag,delegateType,ltype);//查询结果集
		
		return pageInfoRs;
		
	}
	/**
	 * 地铁线路
	 * @param request
	 * @return
	 */
	public List<Metro> getXiLuSelect(Metro metro){
		return xhjLpfanghaoDao.finAll(metro,DAOConstants.RELATIONAL);
	}
	
	
	public XhjNewhouseinfo getByxhjNewhouseinfo(Integer id){
		return xhjNewhouseinfoDao.getByXhjNewhouseinfo(id, DAOConstants.RELATIONAL);
	}
	public XhjLpfanghao  getById(Integer id){
	  return	xhjLpfanghaoDao.getById(id,DAOConstants.RELATIONAL);
	}
	
	public XhjLpfanghao  getByfangHao(Integer id){
		  return	xhjLpfanghaoDao.getByfangHao(id,DAOConstants.RELATIONAL);
		}
	public void syncInfo(HouseSourceKey houseSourceKey){
		lpFanghaoInfoSyncTimer.offer(new TaskData(1,houseSourceKey));
	}

	public XhjLpfanghaoDao getXhjLpfanghaoDao() {
		return xhjLpfanghaoDao;
	}


	public LpDelegationDao getLpDelegationDao() {
		return lpDelegationDao;
	}

	public void setLpDelegationDao(LpDelegationDao lpDelegationDao) {
		this.lpDelegationDao = lpDelegationDao;
	}

	public void setXhjLpfanghaoDao(XhjLpfanghaoDao xhjLpfanghaoDao) {
		this.xhjLpfanghaoDao = xhjLpfanghaoDao;
	}

	
	public List<LpDelegation> getByHouseInfoId(Integer houseInfoId){
		return lpDelegationDao.getByHouseInfoId(houseInfoId, DAOConstants.RELATIONAL);
	}
	public PageInfo fianByxq(PageInfo pageInfo,Integer lpid){
		return xhjLpfanghaoDao.fianByxq(pageInfo, lpid, DAOConstants.RELATIONAL);
	}
	
	public XhjPersoninfo getXhjPersoninfo(Integer yzid){
		return xhjLpfanghaoDao.getXhjPersoninfo(yzid,  DAOConstants.RELATIONAL);
	}
	
	public PageInfo fianhouselog(PageInfo pageInfo,Integer houseinfoid){
		return xhjLpfanghaoDao.fianhouselog(pageInfo, houseinfoid, DAOConstants.RELATIONAL);
	}
	public PageInfo fianxfhouselog(PageInfo pageInfo,Integer lpid){
		return xhjLpfanghaoDao.fianxfhouselog(pageInfo, lpid, DAOConstants.RELATIONAL);
	}
	public LpFanghaoInfoSyncTimer getLpFanghaoInfoSyncTimer() {
		return lpFanghaoInfoSyncTimer;
	}
	public void setLpFanghaoInfoSyncTimer(
			LpFanghaoInfoSyncTimer lpFanghaoInfoSyncTimer) {
		this.lpFanghaoInfoSyncTimer = lpFanghaoInfoSyncTimer;
	}
	public PageInfo findByLpChengjiao(PageInfo pageInfo, int lpid, String type) {
		return xhjLpfanghaoDao.findByLpChengjiao(pageInfo, lpid, type, DAOConstants.RELATIONAL);
	}
	public XhjNewhouseinfoDao getXhjNewhouseinfoDao() {
		return xhjNewhouseinfoDao;
	}
	public void setXhjNewhouseinfoDao(XhjNewhouseinfoDao xhjNewhouseinfoDao) {
		this.xhjNewhouseinfoDao = xhjNewhouseinfoDao;
	}

}
