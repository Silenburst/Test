package com.newenv.lpzd.lp.action;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.Utils.ConfigReader;
import com.newenv.lpzd.Utils.DateUtils;
import com.newenv.lpzd.Utils.FanghaoForRentVo;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.base.service.LpCountryService;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.LpDelegation;
import com.newenv.lpzd.lp.domain.LpFacilityofhouse;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.XhjNewhouseinfo;
import com.newenv.lpzd.lp.service.LpSyscs1Service;
import com.newenv.lpzd.lp.service.XhjLpfanghaoService;
import com.newenv.lpzd.lp.service.XhjLpxxService;
import com.newenv.pagination.PageInfo;

import diqu.Metro;




public class XhjLpfanghaoAction extends BaseAction{
	private XhjLpfanghaoService  xhjLpfanghaoService;
	private PageInfo pageInfo;
	private XhjNewhouseinfo xhjNewhouseinfo;
	private XhjLpfanghao xhjLpfanghao = new XhjLpfanghao();;
	private LpSyscs1Service lpSyscs1Service;
	private XhjJcstressService xhjJcStressService;
	private FanghaoForRentVo fanghaoForRentVo;
	private LpCountryService lpCountryService;
	private XhjLpxxService xhjLpxxService;
	private String startmj;
	private String endmj;
	private String lpTag;
	private XhjLpschool xhjLpschool;
	private XhjLpxx xhjLpxx;
	private List<LpFacilityofhouse>  pt;
	private String schoolid;
	private String type;
	private Integer ltype;
	private String egerendAvgprice;
	private String startAvgprice;
	private String avgprice;
	private Metro metro;
	private String lpName;
	private String cname;
	public String xhjLpfanghao(){
		return "xhjLpfanghao";
	}
	
	public String getByLpCountry(){
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.getByLpCountry(cname)));
	}
	/**
	 * 获取楼盘名称
	 * @return
	 */
	public String getxhjLpxx(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.getByXhjLpxx()));
	}
	
	public String getByLpName(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.getByLpName(lpName)));
	}
	
	
	/**
	 * 获取楼盘图片
	 * @return
	 */
	public String getxhjLptp(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.getByXhjLptp(
				Integer.parseInt(this.getRequest().getParameter("lpid")))));
	}
	/**
	 * 获取栋名称
	 * @return
	 */
	public String getBYLpId(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.getBYLpId(
				Integer.parseInt(this.getRequest().getParameter("lpid")))));
	}
	/**
	 * 获取单元
	 */
	
	public String getBYdzId(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.getBYdzId(
				Integer.parseInt(this.getRequest().getParameter("dzId")))));
	}
	
	/**
	 * 线路
	 * @return
	 */
	public String getXianLu(){
		metro = new Metro();
		metro.setCityID(this.getRequest().getParameter("cid"));
		metro.setLeibeiID(this.getRequest().getParameter("sid"));
		return jsonAjaxResult(JSON.toJSONString(xhjLpfanghaoService.getXiLuSelect(metro)));
	}
	
	//全部房屋
	public String XhjLpfanghaoPage(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		
		if(startmj!=null&&!"".equals(startmj)&&startmj.indexOf("-")>=0&&!"-1".equals(startmj)){
			endmj=startmj.substring(startmj.indexOf("-")+1,startmj.length());
			startmj=startmj.substring(0, startmj.indexOf("-"));
		}
		
		try{
			pageInfo=xhjLpfanghaoService.findByPage(xhjLpfanghao,pageInfo,startmj,endmj);
			this.getRequest().getSession().setAttribute("rows", pageInfo.getRows());
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return "";
	}
	
	public String queryFanghaoInfo(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		try{
			String lpid = this.getRequest().getParameter("lpid");
			String dzid = this.getRequest().getParameter("dzid");
			String dyid = this.getRequest().getParameter("dyid");
			String ceng = this.getRequest().getParameter("ceng");
			String fwzt = this.getRequest().getParameter("fwzt");
			String source = this.getRequest().getParameter("source");
			pageInfo = xhjLpxxService.queryFanghaoInfo(pageInfo, lpid, dzid, dyid, ceng, fwzt, source);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	};
	
	//地铁
		public String XhjLpfanghadt(){
			if(pageInfo==null){
				pageInfo= new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			if(startmj!=null&&!"".equals(startmj)&&startmj.indexOf("-")>=0&&!"-1".equals(startmj)){
				endmj=startmj.substring(startmj.indexOf("-")+1,startmj.length());
				startmj=startmj.substring(0, startmj.indexOf("-"));
			
			}
			
			try{
				pageInfo=xhjLpfanghaoService.findBydtPage(xhjLpfanghao,pageInfo,startmj,endmj);
				this.getRequest().setAttribute("pager", pageInfo);
				return jsonAjaxResult(JSON.toJSONString(pageInfo));
			}catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
			
			return "";
		}
		
		//学区
		public String XhjLpfanghaxq(){
			if(pageInfo==null){
				pageInfo= new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			
			try{
				pageInfo=xhjLpfanghaoService.findByxqPage(xhjLpschool,pageInfo);
				this.getRequest().setAttribute("pager", pageInfo);
				return jsonAjaxResult(JSON.toJSONString(pageInfo));
			}catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
			
			return "";
		}
		
		
//	新房
	public String XhjLpfanghaoxf(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		
		if(avgprice!=null&&!"".equals(avgprice)&&avgprice.indexOf("-")>=0){
			 egerendAvgprice=avgprice.substring(avgprice.indexOf("-")+1,avgprice.length());
			 startAvgprice =avgprice.substring(0, avgprice.indexOf("-"));
		}
		try{
			pageInfo=xhjLpfanghaoService.findByxfPage(xhjNewhouseinfo,pageInfo,startAvgprice,egerendAvgprice);
			this.getRequest().setAttribute("pager", pageInfo);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return "";
	}
	public String dt(){
		return "fanghaodt";
	}
	public String xq(){
		this.bindParam("csType",ConfigReader.readString(ConfigReader.CS_TYPE));
		this.bindParam("czType",ConfigReader.readString(ConfigReader.CZ_TYPE));
		return "fanghaoxq";
	}
	public String xf(){
		return "fanghaoxf";
	}
	
	public String xfType(){
		return "xfType";
	}
	public String weituo(){
		List<LpDelegation>  lpDelegationlist =xhjLpfanghaoService.getByHouseInfoId(Integer.parseInt(this.getRequest().getParameter("houseInfoId")));
		for(LpDelegation lpDelegation:lpDelegationlist){
			if(lpDelegation.getDelegateType()==2){
				this.bindParam("wt", lpDelegation);
				this.bindParam("delegateDate1", lpDelegation.getDelegateDate()!=null&&!"".equals(lpDelegation.getDelegateDate())?DateUtils.getDateStrYMR(lpDelegation.getDelegateDate()):"");
				this.bindParam("occupancyTime1", lpDelegation.getOccupancyTime()!=null&&!"".equals(lpDelegation.getOccupancyTime())?DateUtils.getDateStrYMR(lpDelegation.getOccupancyTime()):"");
			}
			if(lpDelegation.getDelegateType()==1){
				this.bindParam("cs", lpDelegation);
				this.bindParam("delegateDate2", lpDelegation.getDelegateDate()!=null&&!"".equals(lpDelegation.getDelegateDate())?DateUtils.getDateStrYMR(lpDelegation.getDelegateDate()):"");
				this.bindParam("occupancyTime2", lpDelegation.getOccupancyTime()!=null&&!"".equals(lpDelegation.getOccupancyTime())?DateUtils.getDateStrYMR(lpDelegation.getOccupancyTime()):"");
			}
			
		}
		return "weituo";
	}
	/**
	 * 获取房屋信息
	 * @return
	 */
	public String getById(){
		xhjLpfanghao=xhjLpfanghaoService.getById(Integer.parseInt(this.getRequest().getParameter("id")));
		return "detail";
	}
	public String getByIdXf(){
		xhjNewhouseinfo=xhjLpfanghaoService.getByxhjNewhouseinfo(Integer.parseInt(this.getRequest().getParameter("id")));
		return  "xfdetail";
	}
	
	public String fianByxq(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		int lpid=Integer.parseInt(this.getRequest().getParameter("lpid"));
		try{
			pageInfo=xhjLpfanghaoService.fianByxq(pageInfo, lpid);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return "";
	}
	
	
	public String getXhjPersoninfo(){
		return jsonAjaxResult(JSON.toJSONString(xhjLpfanghaoService.getXhjPersoninfo(Integer.parseInt(this.getRequest().getParameter("yzid")))));
	}
	public String getPtJson(){
		XhjLpfanghao xhjLpfanghao1 = xhjLpfanghaoService.getByfangHao(Integer.parseInt(this.getRequest().getParameter("id")));
		return jsonAjaxResult(JSON.toJSONString(xhjLpfanghao1));
	}
	public String getshi(){
	Integer sid = Integer.parseInt(this.getRequest().getParameter("sid"));
		return jsonAjaxResult(JSON.toJSONString(lpSyscs1Service.getSyscs1es(sid)));
		
	}
	
	public String getmianji(){
		Integer sid = Integer.parseInt(this.getRequest().getParameter("sid"));
		return jsonAjaxResult(JSON.toJSONString(lpSyscs1Service.getSyscs1es(sid)));
		
	}
	
	public String houselog(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		int houseinfoid=Integer.parseInt(this.getRequest().getParameter("houseinfoid"));
		try{
			pageInfo=xhjLpfanghaoService.fianhouselog(pageInfo, houseinfoid);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return "";
	}
	
	public String xfzxdt(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		int lpid=Integer.parseInt(this.getRequest().getParameter("lpid"));
		try{
			pageInfo=xhjLpfanghaoService.fianxfhouselog(pageInfo, lpid);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return "";
	}
	
	
	public String  queryLpdongInfo(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		try{
			pageInfo.setRows(5);
			String lpid = this.getRequest().getParameter("lpid");
			pageInfo=xhjLpxxService.queryLpdongInfo(pageInfo, lpid);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
		
	}
	
	
	public String getStartmj() {
		return startmj;
	}
	public void setStartmj(String startmj) {
		this.startmj = startmj;
	}
	public String getEndmj() {
		return endmj;
	}
	public void setEndmj(String endmj) {
		this.endmj = endmj;
	}
	public String getLpTag() {
		return lpTag;
	}
	public void setLpTag(String lpTag) {
		this.lpTag = lpTag;
	}
	public XhjLpschool getXhjLpschool() {
		return xhjLpschool;
	}
	public void setXhjLpschool(XhjLpschool xhjLpschool) {
		this.xhjLpschool = xhjLpschool;
	}
	public XhjLpxx getXhjLpxx() {
		return xhjLpxx;
	}
	public void setXhjLpxx(XhjLpxx xhjLpxx) {
		this.xhjLpxx = xhjLpxx;
	}
	public XhjLpxxService getXhjLpxxService() {
		return xhjLpxxService;
	}
	public void setXhjLpxxService(XhjLpxxService xhjLpxxService) {
		this.xhjLpxxService = xhjLpxxService;
	}
	public FanghaoForRentVo getFanghaoForRentVo() {
		return fanghaoForRentVo;
	}
	public void setFanghaoForRentVo(FanghaoForRentVo fanghaoForRentVo) {
		this.fanghaoForRentVo = fanghaoForRentVo;
	}
	
	public XhjLpfanghao getXhjLpfanghao() {
		return xhjLpfanghao;
	}
	public void setXhjLpfanghao(XhjLpfanghao xhjLpfanghao) {
		this.xhjLpfanghao = xhjLpfanghao;
	}
	public LpSyscs1Service getLpSyscs1Service() {
		return lpSyscs1Service;
	}
	public void setLpSyscs1Service(LpSyscs1Service lpSyscs1Service) {
		this.lpSyscs1Service = lpSyscs1Service;
	}


	public XhjJcstressService getXhjJcStressService() {
		return xhjJcStressService;
	}
	public void setXhjJcStressService(XhjJcstressService xhjJcStressService) {
		this.xhjJcStressService = xhjJcStressService;
	}
	public XhjLpfanghaoService getXhjLpfanghaoService() {
		return xhjLpfanghaoService;
	}
	public void setXhjLpfanghaoService(XhjLpfanghaoService xhjLpfanghaoService) {
		this.xhjLpfanghaoService = xhjLpfanghaoService;
	}
	public PageInfo getPageInfo() {
		return pageInfo;
	}
	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}
	
	public LpCountryService getLpCountryService() {
		return lpCountryService;
	}
	public void setLpCountryService(LpCountryService lpCountryService) {
		this.lpCountryService = lpCountryService;
	}
	public List<LpFacilityofhouse> getPt() {
		return pt;
	}
	public void setPt(List<LpFacilityofhouse> pt) {
		this.pt = pt;
	}
	public String getSchoolid() {
		return schoolid;
	}
	public void setSchoolid(String schoolid) {
		this.schoolid = schoolid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getLtype() {
		return ltype;
	}
	public void setLtype(Integer ltype) {
		this.ltype = ltype;
	}
	public XhjNewhouseinfo getXhjNewhouseinfo() {
		return xhjNewhouseinfo;
	}
	public void setXhjNewhouseinfo(XhjNewhouseinfo xhjNewhouseinfo) {
		this.xhjNewhouseinfo = xhjNewhouseinfo;
	}
	public String getEgerendAvgprice() {
		return egerendAvgprice;
	}
	public void setEgerendAvgprice(String egerendAvgprice) {
		this.egerendAvgprice = egerendAvgprice;
	}
	public String getStartAvgprice() {
		return startAvgprice;
	}
	public void setStartAvgprice(String startAvgprice) {
		this.startAvgprice = startAvgprice;
	}
	public String getAvgprice() {
		return avgprice;
	}
	public void setAvgprice(String avgprice) {
		this.avgprice = avgprice;
	}
	public Metro getMetro() {
		return metro;
	}
	public void setMetro(Metro metro) {
		this.metro = metro;
	}
	public String getLpName() {
		return lpName;
	}
	public void setLpName(String lpName) {
		this.lpName = lpName;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

}





