package com.newenv.lpzd.lp.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.XhjLcfz1;
import com.newenv.lpzd.lp.service.XhjLcfz1Service;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;
import com.opensymphony.xwork2.ActionContext;


/**
 * 划盘信息维护(维护盘、范围盘)
 * @author chenky
 *
 */
public class XhjLcfz1Action extends BaseAction {

	private PageInfo pager;
	
	private XhjLcfz1 lcfz1;
	
	private XhjLcfz1Service xhjLcfz1Service;
	
	private XhjJcstressService xhjJcstressService;
	
	private int[] ids;	//多个楼盘id拼接起来的字符串
	
	private int fromBmId;
	private short fromSta;
	private int toBmId;
	private short toSta;
	
	private static Log log = LogFactory.getLog(XhjLcfz1Action.class);
	
	/**
	 * 进入划盘信息维护页面(维护盘、范围盘)。
	 */
	public String execute(){
		//获取登录人当前城市的区域列表
		List<XhjJcstress> stressList = xhjJcstressService.findByCityId(SecurityUserHolder.getCurrentUserLogin().getCityId());
		ActionContext.getContext().put("stressList", stressList);
		return SUCCESS;
	}

	/**
	 * 查询一个楼盘有哪些店组。
	 * @return
	 */
	public String query(){
		pager = xhjLcfz1Service.query(pager, lcfz1);
		String json = "{\"page\":" + pager.getPage() + ",\"records\":" + pager.getRecords() + ",\"total\":" + pager.getTotal() + ",\"datas\":[";
		List<Object[]> lcfzList = (List<Object[]>) pager.getGridModel();
		int i=0;
		for(Object[] temp : lcfzList){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"name\":\""+ temp[1] +"\",\"lcfz1Id\":"+ temp[2] +"}";
			i++;
		}
		json += "]}";
		return jsonAjaxResult(json);
	}
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息。
	 * @return
	 */
	public String getLcfc1OfBmForCopy() throws Exception{
		pager = xhjLcfz1Service.getLcfc1OfBmForCopy(pager, lcfz1);
		return jsonAjaxResult(this.lcfzPagerToJson(true));
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @return
	 */
	public String getLcfc1OfBm() throws Exception{
		pager = xhjLcfz1Service.getLcfc1OfBm(pager, lcfz1);
		return jsonAjaxResult(this.lcfzPagerToJson(false));
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门列表。
	 * (供楼盘字典模块调用)
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public String getBmsOfLcfcForLpxx(){
		List<TblDepartment> depts = xhjLcfz1Service.getBmsOfLcfc1(lcfz1.getLpid(), lcfz1.getSta());
		String json = "[";
		int i=0;
		for(TblDepartment dept : depts){
			json += (i==0?"":",") + "{\"id\":"+ dept.getId() +",\"name\":\""+ dept.getDepartmentName() +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门列表。
	 * (供房源模块调用)
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public String getBmsOfLcfc(){
		List<TblDepartment> depts = null;
		if(SecurityUserHolder.getCurrentUserLogin().getHtype()==1){	//三级市场对楼盘具有职责范围的部门
			depts = xhjLcfz1Service.getBmsOfLcfc(lcfz1.getLpid(), lcfz1.getSta());
		} else {	//其它系统取登录人当前部门
			depts = new ArrayList<TblDepartment>();
			depts.add(SecurityUserHolder.getCurrentUserLogin().getDepartment());
		}
		String json = "[";
		int i=0;
		for(TblDepartment dept : depts){
			json += (i==0?"":",") + "{\"id\":"+ dept.getId() +",\"name\":\""+ dept.getDepartmentName() +"\"}";
			i++;
		}
		json += "]";
		
		return jsonAjaxResult(json);
	}
	
	/**
	 * 进入添加页面。
	 * @return
	 */
	public String preAdd(){
		
		return INPUT;
	}
	
	//批量划盘
	public String batchAdd(){
		try{
			xhjLcfz1Service.saveBatch(lcfz1, ids);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 进入修改页面。
	 * @return
	 */
	public String preUpdate(){
		
		return INPUT;
	}
	
	/**
	 * 复制店组方式，将一个组的权责盘信息复制到另一个组。
	 * @return
	 */
	public String copy(){
		try{
			xhjLcfz1Service.copy(fromBmId, fromSta, toBmId, toSta);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 批量删除
	 * @return
	 */
	public String batchDelete(){
		try{
			xhjLcfz1Service.deleteBatch(ids);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	public XhjLcfz1 getXhjLcfz1() {
		return lcfz1;
	}

	public void setXhjLcfz1(XhjLcfz1 lcfz1) {
		this.lcfz1 = lcfz1;
	}

	public XhjLcfz1Service getXhjLcfz1Service() {
		return xhjLcfz1Service;
	}

	public void setXhjLcfz1Service(XhjLcfz1Service lcfz1Service) {
		this.xhjLcfz1Service = lcfz1Service;
	}

	public XhjJcstressService getXhjJcstressService() {
		return xhjJcstressService;
	}

	public void setXhjJcstressService(XhjJcstressService xhjJcstressService) {
		this.xhjJcstressService = xhjJcstressService;
	}
	
	public XhjLcfz1 getLcfz1() {
		return lcfz1;
	}

	public void setLcfz1(XhjLcfz1 lcfz1) {
		this.lcfz1 = lcfz1;
	}

	public PageInfo getPager() {
		return pager;
	}

	public void setPager(PageInfo pager) {
		this.pager = pager;
	}
	
	public int[] getIds() {
		return ids;
	}

	public void setIds(int[] ids) {
		this.ids = ids;
	}

	/**
	 * 将划盘分页信息转为json格式。
	 * @param needSqInfo 是否需要获取商圈信息
	 * @return
	 */
	private String lcfzPagerToJson(boolean needSqInfo){
		String json = "{\"page\":" + pager.getPage() + ",\"records\":" + pager.getRecords() + ",\"total\":" + pager.getTotal() + ",\"datas\":[";
		List<Object[]> lcfzList = (List<Object[]>) pager.getGridModel();
		int i=0;
		for(Object[] temp : lcfzList){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpId\":"+ temp[1] +",\"lpName\":\""+ temp[2] +"\"";
			if(needSqInfo){
				json += ",\"sqName\":\""+ temp[3] +"\"";
			}
			json += "}";
			i++;
		}
		json += "]}";
		return json;
	}

	public int getFromBmId() {
		return fromBmId;
	}

	public void setFromBmId(int fromBmId) {
		this.fromBmId = fromBmId;
	}

	public short getFromSta() {
		return fromSta;
	}

	public void setFromSta(short fromSta) {
		this.fromSta = fromSta;
	}

	public int getToBmId() {
		return toBmId;
	}

	public void setToBmId(int toBmId) {
		this.toBmId = toBmId;
	}

	public short getToSta() {
		return toSta;
	}

	public void setToSta(short toSta) {
		this.toSta = toSta;
	}

}
