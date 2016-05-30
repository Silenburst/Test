package com.newenv.lpzd.base.action;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.service.LpMetroManagerServices;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhan;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class LpMetroManagerAction extends BaseAction{
	private PageInfo pageInfo;
	private LpMetroManagerServices lpMetroManagerServices;
	private XhjLpjiaotongzhan pojo;
	private XhjLpjiaotongxian xhjLpjiaotongxian;
	private Metro metro;
	private String jtzName;
	private Integer jtzid;
	private String xianLuName;
	private int[] xianluId;
	private String zdName;
	private String cityID;
	private String zdXian;
	private String leiBeiID;	//类别ID
	private String leiBeiName;	//类别名称
	private String zhanID;		//站点ID
	private String xianID;	   //线Id
	private String x;
	private String y;
	private String pid;			//省份ID
	/**
	 * 交通类别
	 * 地铁，公交
	 * @return
	 */
	public String getJiaoTong(){
		metro = new Metro();
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.getJiaoTongSelect(metro)));
	}
	public String selectDataZD(){
		metro = new Metro();
		metro.setZdName(zdName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectDataZD(metro)));
	}
	/**
	 * 线路
	 * @return
	 */
	public String getXianLu(){
		metro = new Metro();
		metro.setCityID(cityID);
		metro.setLeibeiID(leiBeiID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.getXiLuSelect(metro)));
	}
	/*
	 *修改地铁站点详细信息 
	 */
	public String updateStation(){
		metro = new Metro();
		metro.setZhanid(zhanID);
		metro.setZdName(zdName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.getUpdateStation(metro)));
	}
	/*
	 *修改地铁线路详细信息 
	 */
	public String updateSiteLine(){
		metro = new Metro();
		metro.setXianID(xianID);
		metro.setXianLuName(xianLuName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.getupdateSiteLine(metro)));
	}
	
	public void selectXianLu_Name(){
		metro = new Metro();
		metro.setCityID(cityID);
		this.bindParam("metros", lpMetroManagerServices.getSelectXianLu_Name(metro));
	}
	
	/**
	 * 页面数据查询
	 * @return
	 */
	public String pageList(){
		if (pageInfo == null) {	
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		
		pageInfo = lpMetroManagerServices.findByPageInfo(metro,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	/**
	 * 根据ID查询
	 */
	public String selectData(){
		metro = new Metro();
		metro.setZhanid(zhanID);
		metro.setLeibeiID(leiBeiID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectData(metro)));
	}
	
	
	//新增数据的三级联动
	public String selectCity(){
		metro = new Metro();
		metro.setPid(pid);
 		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectCity(metro)));
	}
	public String selectLeiBei(){
		cityID = this.getRequest().getParameter("CityID");
		metro = new Metro();
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectLeiBei(metro)));
	}
	public String selectXianLu(){
		String leiBeiID = this.getRequest().getParameter("LeiBei_ID");
		cityID = this.getRequest().getParameter("cityID");
		metro = new Metro();
		metro.setId(leiBeiID);
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectXianLu(metro)));
	}
	
	/**
	 * 新增交通数据
	 * @return
	 */
	public String insertDataZD (){
		metro = new Metro();
		metro.setCityID(cityID);
		if(leiBeiID!=null&&!"".equals(leiBeiID)){
			leiBeiID=leiBeiID.substring(0,leiBeiID.indexOf("-"));
		}
		metro.setLeibeiID(leiBeiID);
		metro.setZdName(zdName);
		metro.setXianID(xianID);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.insertDataZD(metro)));
	}
	
	/**
	 * 批量删除
	 * @return
	 */
	public String batchRemoveData(){
		metro = new Metro();
		metro.setZhanid(zhanID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateData(metro)));
	}
	/**
	 * 新增类别
	 * @return
	 */
	public String addLeiBei(){
		metro = new Metro();
		metro.setLeibeiName(leiBeiName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.addLeiBei(metro)));
	}
	public String selectLeiBeiData(){
		metro = new Metro();
		metro.setLeibeiID(leiBeiID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectLeiBeiData(metro)));
	}
	public String selectDataLeiBei(){
		metro = new Metro();
		metro.setLeibeiName(leiBeiName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectDataLeiBei(metro)));
	}
	/**
	 * 修改类别
	 * @return
	 */
	public String updateLeiBei(){
		metro = new Metro();
		metro.setLeibeiName(leiBeiName);
		metro.setLeibeiID(leiBeiID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateLeiBei(metro)));
	}
	/**
	 * 新增线路
	 * @return
	 */
	public String addXianLu(){
		metro = new Metro();
		metro.setXianLuName(xianLuName);
		metro.setLeibeiID(leiBeiID);
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.addXianLu(metro)));
	}
	public String selectXianluData(){
		metro = new Metro();
		metro.setXianLuName(xianLuName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectXianluData(metro)));
	}
	public String selectDateXianlu(){
		metro = new Metro();
		metro.setXianID(xianID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.selectDateXianlu(metro)));
	}
	/**
	 * 修改线路
	 * @return
	 */
	public String updateXianLu(){
		metro = new Metro();
		metro.setXianID(xianID);
		metro.setXianLuName(xianLuName);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateXianLu(metro)));
	}
	/**
	 * 修改线路
	 * @return
	 */
	public String updateDataXianLu(){
		metro = new Metro();
		metro.setXianID(xianID);
		metro.setZdName(zdName);
		metro.setCityID(cityID);
		metro.setZhanid(zhanID);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateDataXianLu(metro)));
	}
	/**
	 * 删除类别
	 * @return
	 */
	public String updateDataLeiBei(){
		metro = new Metro();
		metro.setLeibeiID(leiBeiID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateDataLeiBei(metro)));
	}
	/**
	 * 删除线路
	 * @return
	 */
	public String updateXianLuData(){
		metro = new Metro();
		metro.setXianID(xianID);
		return jsonAjaxResult(JSON.toJSONString(lpMetroManagerServices.updateXianLuData1(metro)));
	}
	
	public String getZdName() {
		return zdName;
	}

	public void setZdName(String zdName) {
		this.zdName = zdName;
	}

	public String getCityID() {
		return cityID;
	}

	public void setCityID(String cityID) {
		this.cityID = cityID;
	}

	public Metro getMetro() {
		return metro;
	}

	public void setMetro(Metro metro) {
		this.metro = metro;
	}

		
	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public LpMetroManagerServices getLpMetroManagerServices() {
		return lpMetroManagerServices;
	}
	public void setLpMetroManagerServices(
			LpMetroManagerServices lpMetroManagerServices) {
		this.lpMetroManagerServices = lpMetroManagerServices;
	}
	public XhjLpjiaotongzhan getPojo() {
		return pojo;
	}
	public void setPojo(XhjLpjiaotongzhan pojo) {
		this.pojo = pojo;
	}
	public XhjLpjiaotongxian getXhjLpjiaotongxian() {
		return xhjLpjiaotongxian;
	}
	public void setXhjLpjiaotongxian(XhjLpjiaotongxian xhjLpjiaotongxian) {
		this.xhjLpjiaotongxian = xhjLpjiaotongxian;
	}
	
	public String getJtzName() {
		return jtzName;
	}
	public void setJtzName(String jtzName) {
		this.jtzName = jtzName;
	}

	public Integer getJtzid() {
		return jtzid;
	}

	public void setJtzid(Integer jtzid) {
		this.jtzid = jtzid;
	}
	
	public String getXianLuName() {
		return xianLuName;
	}

	public void setXianLuName(String xianLuName) {
		this.xianLuName = xianLuName;
	}

	public int[] getXianluId() {
		return xianluId;
	}

	public void setXianluId(int[] xianluId) {
		this.xianluId = xianluId;
	}

	public String getZdXian() {
		return zdXian;
	}

	public void setZdXian(String zdXian) {
		this.zdXian = zdXian;
	}
	
	public String getLeiBeiID() {
		return leiBeiID;
	}

	public void setLeiBeiID(String leiBeiID) {
		this.leiBeiID = leiBeiID;
	}

	public String getZhanID() {
		return zhanID;
	}
	public void setZhanID(String zhanID) {
		this.zhanID = zhanID;
	}

	public String getXianID() {
		return xianID;
	}

	public void setXianID(String xianID) {
		this.xianID = xianID;
	}

	public String getLeiBeiName() {
		return leiBeiName;
	}

	public void setLeiBeiName(String leiBeiName) {
		this.leiBeiName = leiBeiName;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	
}