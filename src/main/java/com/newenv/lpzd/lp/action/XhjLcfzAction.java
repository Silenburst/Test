package com.newenv.lpzd.lp.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.XhjLcfz;
import com.newenv.lpzd.lp.service.XhjLcfzService;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.security.service.TblDepartmentService;
import com.newenv.pagination.PageInfo;
import com.opensymphony.xwork2.ActionContext;

/**
 * 划盘信息维护(责任盘)
 * @author chenky
 *
 */
public class XhjLcfzAction extends BaseAction {

	private PageInfo pager;
	
	private XhjLcfz lcfz;
	
	private XhjLcfzService xhjLcfzService;
	
	private XhjJcstressService xhjJcstressService;
	
	private TblDepartmentService tblDepartmentService;
	
	private Integer[] ids;	//多个 id 拼接起来的字符串
	
	private String[] ldIds;	//(lp and dong ids)多个 楼盘id#栋座id 拼接起来的字符串 
	
	private String term;	//查询关键字
	
	private int fromBmId;
	private int toBmId;
	
	private static Log log = LogFactory.getLog(XhjLcfzAction.class);
	
	/**
	 * 进入划盘信息维护页面。
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
		pager = xhjLcfzService.query(pager, lcfz);
		String json = "{\"page\":" + pager.getPage() + ",\"records\":" + pager.getRecords() + ",\"total\":" + pager.getTotal() + ",\"datas\":[";
		List<Object[]> lcfzList = (List<Object[]>) pager.getGridModel();
		int i=0;
		for(Object[] temp : lcfzList){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"name\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]}";
		return jsonAjaxResult(json);
	}
	
	/**
	 * 转向楼盘的权责店组页面。
	 * @return
	 */
	public String department(){
		return "lcfzDepartment";
	}
	
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息。
	 * @return
	 */
	public String getLcfcOfBmForCopy() throws Exception{
		pager = xhjLcfzService.getLcfcOfBmForCopy(pager, lcfz);
		return jsonAjaxResult(this.lcfzPagerToJson(true));
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @return
	 */
	public String getLcfcOfBm() throws Exception{
		pager = xhjLcfzService.getLcfcOfBm(pager, lcfz);
		return jsonAjaxResult(this.lcfzPagerToJson(false));
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public String getBmsOfLcfc(){
		Map<Integer,List<TblDepartment>> depts = xhjLcfzService.getBmsOfLcfc(ids);
		String json = "[";
		int i=0;
		for(Integer did : depts.keySet()){
			json += (i==0?"":",") + "{\"id\":"+ did +",\"names\":\""+ getDepartmentsName(depts.get(did)) +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	}
	
	/**
	 * 根据部门名称查询部门列表。
	 * @return
	 */
	/*
	public String queryDepartmentsByName(){
		List<Department> depts = departmentService.findDepartmentByOrgIdAndBlurDeparmentQuery(Lcfz1Service.DZ_ORGNIZE_TYPE_ID, term);
		int i=0;
		String json = "[";
		for(Department dept : depts){
			json += (i==0?"":",") + "{\"id\":"+ dept.getId() +",\"name\":\""+ dept.getDepartmentName() +"\"}";
			i++;
		}
		json += "]";
		return this.jsonAjaxResult(json);
	}
	*/
	
	private String getDepartmentsName(List<TblDepartment> depts){
		String deptsName = "";
		int i=0;
		for(TblDepartment dept : depts){
			deptsName += (i==0?"":",") + dept.getDepartmentName();
			i++;
		}
		return deptsName;
	}
	
	/**
	 * 进入添加页面。
	 * @return
	 */
	public String preAdd(){
		
		return INPUT;
	}
	
	//复制店组方式，将一个组的权责盘信息复制到另一个组。
	public String copy(){
		try{
			xhjLcfzService.copy(fromBmId, toBmId);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	//批量划盘
	public String batchAdd(){
		try{
			xhjLcfzService.saveBatch(lcfz, ldIds);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 批量删除。删除一个店组对应的多个楼盘。
	 * @return
	 */
	public String batchDelete(){
		try{
			xhjLcfzService.deleteBatch(lcfz, ids);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 批量删除。删除一个楼盘对应的多个店组。
	 * @return
	 */
	public String batchDeleteExt(){
		try{
			xhjLcfzService.deleteBatch(lcfz.getLpid(), ids);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	public XhjLcfz getLcfz() {
		return lcfz;
	}

	public void setLcfz(XhjLcfz lcfz) {
		this.lcfz = lcfz;
	}

	public XhjLcfzService getXhjLcfzService() {
		return xhjLcfzService;
	}

	public void setXhjLcfzService(XhjLcfzService xhjLcfzService) {
		this.xhjLcfzService = xhjLcfzService;
	}

	public XhjJcstressService getXhjJcstressService() {
		return xhjJcstressService;
	}

	public void setXhjJcstressService(XhjJcstressService xhjJcstressService) {
		this.xhjJcstressService = xhjJcstressService;
	}

	public TblDepartmentService getTblDepartmentService() {
		return tblDepartmentService;
	}

	public void setTblDepartmentService(TblDepartmentService tblDepartmentService) {
		this.tblDepartmentService = tblDepartmentService;
	}

	public PageInfo getPager() {
		return pager;
	}

	public void setPager(PageInfo pager) {
		this.pager = pager;
	}
	
	public Integer[] getIds() {
		return ids;
	}

	public void setIds(Integer[] ids) {
		this.ids = ids;
	}

	public String[] getLdIds() {
		return ldIds;
	}

	public void setLdIds(String[] ldIds) {
		this.ldIds = ldIds;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
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
			json += (i==0?"":",") + "{\"lpId\":"+ temp[0] +",\"lpName\":\""+ temp[1] +"\"";
			if(needSqInfo){
				json += ",\"sqName\":\""+ temp[3] +"\"";
			}
			json += ",\"dongs\":" + getLcfzDongOfLp((Integer)temp[2], (Integer)temp[0])
				+ "}";
			i++;
		}
		json += "]}";
		return json;
	}
	
	/**
	 * 获取责任盘的责任栋信息。
	 * @param bmid
	 * @param lpid
	 * @return
	 */
	private String getLcfzDongOfLp(int bmid, int lpid){
		List<Object[]> dongs = this.xhjLcfzService.getLcfzDongOfLp(bmid, lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return json;
	}

	public int getFromBmId() {
		return fromBmId;
	}

	public void setFromBmId(int fromBmId) {
		this.fromBmId = fromBmId;
	}

	public int getToBmId() {
		return toBmId;
	}

	public void setToBmId(int toBmId) {
		this.toBmId = toBmId;
	}

}
