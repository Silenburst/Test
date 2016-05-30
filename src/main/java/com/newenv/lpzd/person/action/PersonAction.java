package com.newenv.lpzd.person.action;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.Utils.DateUtils;
import com.newenv.lpzd.lp.domain.XhjCommunicator;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;
import com.newenv.lpzd.lp.domain.XhjPersonimg;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;
import com.newenv.lpzd.person.Condition;
import com.newenv.lpzd.person.LpUpdatingRecord;
import com.newenv.lpzd.person.services.PersonServices;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;


public class PersonAction extends BaseAction {
	private PageInfo pageInfo;
	private PersonServices personServices;
	private Condition condition;
	private XhjLpfanghao  fanghao;
	private XhjPersoninfo  yezhu;
	private List<XhjCommunicator> contact;
	private List<XhjPersonimg> imgs;
	private List<XhjLpfanghaoimg> fanghaoImg;
	private LpUpdatingRecord lpUpdatingRecord;
	
	public LpUpdatingRecord getLpUpdatingRecord() {
		return lpUpdatingRecord;
	}

	public void setLpUpdatingRecord(LpUpdatingRecord lpUpdatingRecord) {
		this.lpUpdatingRecord = lpUpdatingRecord;
	}

	public PersonServices getPersonServices() {
		return personServices;
	}

	public void setPersonServices(PersonServices personServices) {
		this.personServices = personServices;
	}

	public Condition getCondition() {
		return condition;
	}

	public void setCondition(Condition condition) {
		this.condition = condition;
	}

	
	/**
	 * 我的维护盘信息
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public String queryForMY(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = personServices.queryForMY(condition,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	/**
	 * 房屋分派
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public String queryForAssign(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = personServices.queryForAssign(condition,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}

	/**
	 * 查询楼盘名称
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public String  queryLpName()
	{
//		String ids = this.getRequest().getParameter("ids");
		return jsonAjaxResult(JSON.toJSONString( personServices.queryLpName()));
	}
	
	/**
	 * 查询栋名称
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public String  queryDong()
	{
		String id = this.getRequest().getParameter("id");
//		String ids = this.getRequest().getParameter("ids");
		List<Object[]> lists = personServices.queryDong(id);
		return jsonAjaxResult(JSON.toJSONString(lists));
	}
	
	
	/**
	 * 查询danyuan名称
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public String  queryDanyuan()
	{
		String id = this.getRequest().getParameter("id");
//		String ids = this.getRequest().getParameter("ids");
		List<Object[]> lists =  personServices.queryDanyuan(id);
		return jsonAjaxResult(JSON.toJSONString(lists));
	}
	
	
	
	/**
	 * 查询huxing
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public String queryHuxing()
	{	
		String lpid = this.getRequest().getParameter("lpid");
		String dongid = this.getRequest().getParameter("dongid");
		String danyuanid =  this.getRequest().getParameter("danyuanid");
		return jsonAjaxResult(JSON.toJSONString(personServices.queryHuxing(lpid, dongid, danyuanid)));
	}
	
	/**
	 * 查询部门
	 * @return
	 */
	public String queryBM()
	{
		return jsonAjaxResult(JSON.toJSONString(personServices.queryBM(condition.getDianzuName())));
	}
	
	
	
	/**
	 * 批量分派
	 * @return
	 */
	public String insertBatchFenpai()
	{
		return jsonAjaxResult(JSON.toJSONString(personServices.insertBatchFenpai(condition)));
	}
	
	/**
	 * 查询部门经理
	 * @param dzid  店组id
	 * @return
	 */
	public String queryBMJL()
	{
		String dzid = this.getRequest().getParameter("dzid");
		return jsonAjaxResult(JSON.toJSONString(personServices.queryBMJL(dzid)));

	}
	
	/**
	 * 查询房屋信息
	 * @return
	 */
	public String queryFanghao()
	{
		String fhs = this.getRequest().getParameter("fhs");
		JSONObject parseObject = JSON.parseObject(fhs);
		String ceng = (String)parseObject.get("ceng");
		String  lpid = (String)parseObject.get("lpid");
		String  buildingId = (String)parseObject.get("buildingId");
		String  fangHao = (String)parseObject.get("fangHao");
		String  dyId = (String)parseObject.get("dyId");
		String  zuoyous = (String)parseObject.get("zuoyous");
		condition = new Condition();
		XhjLpfanghao lpfanghao = new XhjLpfanghao();
		condition.setFhids(zuoyous);
		lpfanghao.setFangHao(fangHao);
		lpfanghao.setDyId(Integer.valueOf(dyId));
		lpfanghao.setBuildingId(Integer.valueOf(buildingId));
		lpfanghao.setLpid(Integer.valueOf(lpid));
		lpfanghao.setCeng(Integer.valueOf(ceng));
		condition.setFanghao(lpfanghao);
		
		XhjLpfanghao queryFanghao = personServices.queryFanghao(condition);
		List<XhjLpfanghaoimg> fanghaoImgs = personServices.queryFanghaoImg(zuoyous);
		condition.setFanghaoImg(fanghaoImgs);
		condition.setFanghao(queryFanghao);
		this.bindParam("fanghaoImgs", fanghaoImgs);
		this.bindParam("xhjfanghao", queryFanghao);
		this.bindParam("condition", condition);
		this.getRequest().setAttribute("xhjfanghao", queryFanghao);
		return "xhjfanghao";

	}
	
	
	
	/**
	 * 批量修改
	 * @return
	 */
	public String batchUpdate()
	{
		int i = personServices.batchUpdate(condition);
		return jsonAjaxResult(JSON.toJSONString(i));
	}
	
	/**
	 * 查询
	 * @param condition
	 * @return
	 */
	public String  querySource()
	{
		if (pageInfo == null) {
			pageInfo = new PageInfo();
		}
		pageInfo = personServices.querySource(condition,pageInfo);
		Integer records = pageInfo.getRecords();
		List<? extends Object> gridModel = pageInfo.getGridModel();
		this.getRequest().setAttribute("getRecords", records);
		this.getRequest().setAttribute("getGridModel", gridModel);
		String str = "{\"getRecords\":"+records+",\"getGridModel\":"+JSON.toJSONString(gridModel)+"}";
		return jsonAjaxResult(str);
	}
	
	/**
	 * 责任盘维护 xhj_lcfz  信息楼盘 以及栋座的信息栋数据 
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public String queryForZR(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = personServices.queryForZR(condition,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}

	
	/**
	 * 本组维护盘信息 根据部门，分配表lp_assignment
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public String queryForBZ(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = personServices.queryForBZ(condition,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}

	
	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}
	
	
	/**
	 *@description 房屋信息-基本信息展示
	 *@base lfid 房号id 
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public String queryByLFId()
	{
		String lfid  = this.getRequest().getParameter("lfid");
		try{
			Object queryByLFId = personServices.queryByLFId(lfid);
			Object[] ss = (Object[]) queryByLFId;
			this.getRequest().setAttribute("fangwubase", ss);
			yezhu=personServices.getXhjPersoninfo(Integer.parseInt(ss[16].toString()));
			String birthday="";
			if(yezhu.getBirthday()!=null){
				 birthday = DateUtils.getDateStr(yezhu.getBirthday());
			}
			this.bindParam("birthday", birthday);
//			return jsonAjaxResult(JSON.toJSONString(queryByLFId));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "success1";
	}
		
		
	
	/**
	 *@description 房屋信息--跟踪记录
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public String queryUpdateRecord()
	{
		if (pageInfo == null) {	
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		String lfid  = this.getRequest().getParameter("lfid");
		pageInfo= personServices.queryUpdateRecord(lfid,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	
	/**
	 *@description 房屋信息--动态
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public String queryFHLog()
	{
		if (pageInfo == null) {	
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		String lfid  = this.getRequest().getParameter("lfid");
		pageInfo= personServices.queryFHLog(lfid,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	
	/**
	 *@description 房屋信息--历史委托记录
	 *@base lfid 房号id
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public String queryWeiTuoJiLu()
	{
		if (pageInfo == null) {	
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		String lfid  = this.getRequest().getParameter("lfid");
		pageInfo= personServices.queryWeiTuoJiLu(lfid,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	/**
	 * 查询所有业主信息
	 * @return
	 */
	public String queryYeZXX()
	{
		if (pageInfo == null) {	
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		String lfid  = this.getRequest().getParameter("lfid");
		pageInfo= personServices.queryData(lfid,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	/**
	 * 业主数据查询
	 * @return
	 */
	public String selectState()
	{
		String lfid  = this.getRequest().getParameter("id");
		return jsonAjaxResult(JSON.toJSONString(personServices.selectState(lfid)));
	}
	public String selectLpfanghao()
	{
		String lfid  = this.getRequest().getParameter("id");
		return jsonAjaxResult(JSON.toJSONString(personServices.selectLpfanghao(lfid)));
	}
	public String tosavefanghao(){
		  fanghao = new XhjLpfanghao();
		  yezhu= new XhjPersoninfo();
		  this.bindParam("fanghao", fanghao);
		  this.bindParam("yezhu", yezhu);
		  return "fanghaoadd";
	}
	
	/**
	 * 保存房号信息并返回房号ID
	 * @return
	 */
	public String saveFanghao(){
		String json = "";
		try {
			
			String personId= personServices.savePersoninfo(yezhu);
			fanghao.setYzid(Integer.parseInt(personId));
			String sid = personServices.saveFangHao(fanghao);
			personServices.savefanghaoimg(Integer.parseInt(sid),fanghaoImg);
			personServices.saveXhjPersonimg(Integer.parseInt(personId), imgs);
			personServices.saveXhjCommunicator(Integer.parseInt(personId), contact);
			json = "{\"data\" : \"success\",\"id\": \""+sid+"\"}";
		} catch (Exception e) {
			e.printStackTrace();
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 获取单个房号 与业主的信息
	 * @return
	 */
	public String getxhjFangHao(){
		String fanghaoId  = this.getRequest().getParameter("fanghaoId");
		fanghao=personServices.getxhjFangHao(Integer.parseInt(fanghaoId));
		yezhu=personServices.getXhjPersoninfo(fanghao.getYzid());
		String birthday="";
		if(yezhu.getBirthday()!=null){
			 birthday = DateUtils.getDateStr(yezhu.getBirthday());
		}
		this.bindParam("birthday", birthday);
		return "fanghaoadd"; 
	}
	/**
	 * 获取房号图片
	 * @return
	 */
	
	public String fanghaotp(){
		Integer fanghaoId = Integer.valueOf(this.getRequest().getParameter("fanghaoId"));
		 List<XhjLpfanghaoimg>  fanghaoImgs = personServices.queryXhjLpfanghaoimg(fanghaoId);
		String jsonString = JSON.toJSONString(fanghaoImgs);
		return jsonAjaxResult(jsonString);
	}
	
	/**
	 * 获取业主图片
	 * @return
	 */
	
	public String persontp(){
		Integer personId = Integer.valueOf(this.getRequest().getParameter("personId"));
		List<XhjPersonimg>   personImgs = personServices.queryXhjPersonimg(personId);
		String jsonString = JSON.toJSONString(personImgs);
		return jsonAjaxResult(jsonString);
	}
	
	/**
	 * 获取业主联系号码
	 * @return
	 */
	
	public String communicators(){
		Integer personId = Integer.valueOf(this.getRequest().getParameter("personId"));
		List<XhjCommunicator>   communicators = personServices.queryXhjCommunicator(personId);
		String jsonString = JSON.toJSONString(communicators);
		return jsonAjaxResult(jsonString);
	}
	
	public String savelpUpdateRecord(){
		String json = "";
		try {
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
			Integer departmentId = userLogin.getDepartment().getId();
			lpUpdatingRecord.setBmid(departmentId);
			lpUpdatingRecord.setUpdator(userLogin.getUserProfile().getId());
			String lpUpdateRecordId =personServices.savelpUpdateRecord(lpUpdatingRecord);
			json = "{\"data\" : \"success\",\"id\": \""+lpUpdateRecordId+"\"}";
		} catch (Exception e) {
			e.printStackTrace();
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
		
	}
	
	public String savayezhu(){
		String json = "";
		try {
			
			String personId= personServices.savePersoninfo(yezhu);
			personServices.saveXhjCommunicator(Integer.parseInt(personId), contact);
			json = "{\"data\" : \"success\",\"id\": \""+personId+"\"}";
		} catch (Exception e) {
			e.printStackTrace();
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	}
	public XhjLpfanghao getFanghao() {
		return fanghao;
	}

	public void setFanghao(XhjLpfanghao fanghao) {
		this.fanghao = fanghao;
	}

	public XhjPersoninfo getYezhu() {
		return yezhu;
	}

	public void setYezhu(XhjPersoninfo yezhu) {
		this.yezhu = yezhu;
	}

	public List<XhjCommunicator> getContact() {
		return contact;
	}

	public void setContact(List<XhjCommunicator> contact) {
		this.contact = contact;
	}

	public List<XhjPersonimg> getImgs() {
		return imgs;
	}

	public void setImgs(List<XhjPersonimg> imgs) {
		this.imgs = imgs;
	}

	public List<XhjLpfanghaoimg> getFanghaoImg() {
		return fanghaoImg;
	}

	public void setFanghaoImg(List<XhjLpfanghaoimg> fanghaoImg) {
		this.fanghaoImg = fanghaoImg;
	}

}
