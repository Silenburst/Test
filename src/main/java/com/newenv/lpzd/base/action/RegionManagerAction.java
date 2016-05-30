package com.newenv.lpzd.base.action;

import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.service.LpCountryService;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class RegionManagerAction extends BaseAction {
	private PageInfo pageInfo;
	private LpCountryService lpCountryService;
	private Metro metro;
	private String cityID;		//城市ID
	private String qyName;		//区域名称
	private String cname;		//国家
	private String cid;			//国家ID
	private String pname;		//省份
	private String pid;			//省份ID
	private String sqname;		//商圈
	private String sqID;		//商圈ID
	private String qyID;		//区域ID
	private String cityname;	//城市Name
	private String cnameCoding;		//国家编码
	private String x;
	private String y;
	
	public String execute(){
		this.bindParam("countryList", lpCountryService.findAll());
		return SUCCESS;
	}
	
	
	public void getCountrySelect() {
		try {
			String options = lpCountryService.getCountrySelect(getRequest());
			HttpServletResponse response = getResponse();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			Writer out = response.getWriter();
			out.write(options);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 分页显示
	 * @return
	 */
	public String pageInFo(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = lpCountryService.findByPageInFo(metro,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	/**
	 * 新增数据的判断
	 * @return
	 */
	public String selectShangQuanData(){
		metro = new Metro();
		metro.setSqName(sqname);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectShangQuanData(metro)));
	}
	
	/**
	 * 新增数据
	 * @return
	 */
	public String addData(){
		metro = new Metro();
		metro.setQyID(qyID);
		metro.setSqName(sqname);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.addData(metro)));
	}
	/**
	 * 新增国家
	 * @return 
	 */
	public String addState(){
		metro = new Metro();
		metro.setCname(cname);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.addState(metro)));
	}
	public String selectState(){
		metro = new Metro();
		metro.setCountryId(cid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectState(metro)));
	}
	/**
	 * 新增国家判断
	 * @return
	 */
	public String selectStateData(){
		metro = new Metro();
		metro.setCname(cname);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectStateData(metro)));
	}
	/**
	 * 修改国家
	 * @return
	 */
	public String updateState(){
		metro = new Metro();
		metro.setCname(cname);
		metro.setCountryId(cid);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateState(metro)));
	}
	/**
	 * 添加省份
	 * @return
	 */
	public String addProvince(){
		metro = new Metro();
		metro.setPname(pname);
		metro.setCountryId(cid);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.addProvince(metro)));
	}
	/**
	 * 新增省份判断
	 * @return
	 */
	public String selectProvinceData(){
		metro = new Metro();
		metro.setPname(pname);
		metro.setCountryId(cid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectProvinceData(metro)));
	}
	public String selectProvince(){
		metro = new Metro();
		metro.setPid(pid);
		List<Metro> list = lpCountryService.selectProvince(metro);
		for(Metro entity :list){
			System.out.println(entity.getCityName());
		}
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectProvince(metro)));
	}
	/**
	 * 修改省份
	 * @return
	 */
	public String updateProvince(){
		metro = new Metro();
		metro.setPname(pname);
		metro.setCountryId(pid);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateProvince(metro)));
	}
	/**
	 * 添加城市
	 * @return
	 */
	public String addCity(){
		metro = new Metro();
		metro.setCityName(cityname);
		metro.setPid(pid);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.addCity(metro)));
	}
	/**
	 * 新增城市判断
	 * @return
	 */
	public String selectCityData(){
		metro = new Metro();
		metro.setCityName(cityname);
		metro.setPid(pid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectCityData(metro)));
	}
	
	//根据城市ID获取名称
	public String selectCityName(){
		metro = new Metro();
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectCity(metro)));
	}
	/**
	 * 修改城市
	 * @return
	 */
	public String updateCity(){
		metro = new Metro();
		metro.setCityName(cityname);
		metro.setCityID(cityID);
		metro.setCoding(cnameCoding);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateCity(metro)));
	}
	/**
	 * 新增区域
	 * @return
	 */
	public String addArea(){
		metro = new Metro();
		metro.setQyName(qyName);
		metro.setCityID(cityID);
		metro.setCoding(cnameCoding);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.addArea(metro)));
	}
	/**
	 * 新增区域判断
	 * @return
	 */
	public String selectDataArea(){
		metro = new Metro();
		metro.setQyName(qyName);
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectDataArea(metro)));
	}
	/**
	 * 根据区域ID查询出所属区域Name
	 * @return
	 */
	public String selectAreaData(){
		metro = new Metro();
		metro.setQyID(qyID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectAreaData(metro)));
	}
	/**
	 * 修改区域
	 * @return
	 */
	public String updateArea(){
		metro = new Metro();
		metro.setQyID(qyID);
		metro.setQyName(qyName);
		metro.setCoding(cnameCoding);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateArea(metro)));
	}
	/**
	 * 批量删除
	 * @return
	 */
	public String updateBatchRemove(){
			metro= new Metro();
			metro.setSqID(sqID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateBatchRemove(metro)));
	}
	/**
	 * 修改页面的数据查询
	 * @return
	 */
	public String selectData(){
		qyID= this.getRequest().getParameter("qyID");
		metro = new Metro();
		metro.setSqID(sqID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectData(metro)));
	}
	/**
	 * 修改数据
	 * @return
	 */
	public String updateData(){
		metro = new Metro();
		metro.setSqName(sqname);
		metro.setSqID(sqID);
		metro.setX(x);
		metro.setY(y);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateData(metro)));
	}
	
	public LpCountryService getLpCountryService() {
		return lpCountryService;
	}

	public void setLpCountryService(LpCountryService lpCountryService) {
		this.lpCountryService = lpCountryService;
	}
	
	/**
	 * 查询所有国家
	 * @return
	 */
	public String selectCountryData(){
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectCountryData()));
	}
	/**
	 * 根据国家ID查询所属国家的省份名称
	 * @return
	 */
	public String selectDataProvince(){
		metro = new Metro();
		metro.setCountryId(cid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectDataProvince(metro)));
	}
	/**
	 * 城市名称的查询
	 * @return
	 */
	public String selectCity(){
		metro = new Metro();
		//获取省份id
		metro.setPid(pid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectDataCity(metro)));
	}
	
	/**
	 * 根据城市ID查询所有的区域
	 * @return
	 */
	public String selectShuangQuan(){
		metro = new Metro();
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.selectShuangQuan(metro)));
	}
	
	
	/**
	 * 删除国家
	 * @return
	 */
	public String updateDataState(){
		metro = new Metro();
		metro.setCountryId(cid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateDataState(metro)));
	}
	
	/**
	 * 删除省份
	 * @return
	 */
	public String updateDataProvince(){
		metro = new Metro();
		metro.setCountryId(pid);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateDataProvince(metro)));
	}
	
	/**
	 * 删除城市
	 * @return
	 */
	public String updateDataCity(){
		metro = new Metro();
		metro.setCityID(cityID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateDataCity(metro)));
	}
	
	/**
	 * 删除区域
	 * @return
	 */
	public String updateDataArea(){
		metro = new Metro();
		metro.setQyID(qyID);
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.updateDataArea(metro)));
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public Metro getMetro() {
		return metro;
	}

	public void setMetro(Metro metro) {
		this.metro = metro;
	}

	public String getCityID() {
		return cityID;
	}

	public void setCityID(String cityID) {
		this.cityID = cityID;
	}

	public String getQyName() {
		return qyName;
	}

	public void setQyName(String qyName) {
		this.qyName = qyName;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getSqname() {
		return sqname;
	}

	public void setSqname(String sqname) {
		this.sqname = sqname;
	}

	

	public String getCityname() {
		return cityname;
	}

	public void setCityname(String cityname) {
		this.cityname = cityname;
	}

	public String getQyID() {
		return qyID;
	}

	public void setQyID(String qyID) {
		this.qyID = qyID;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getSqID() {
		return sqID;
	}

	public void setSqID(String sqID) {
		this.sqID = sqID;
	}


	public String getCnameCoding() {
		return cnameCoding;
	}


	public void setCnameCoding(String cnameCoding) {
		this.cnameCoding = cnameCoding;
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
	
}
