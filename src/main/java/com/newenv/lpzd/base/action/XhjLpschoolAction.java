package com.newenv.lpzd.base.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.base.domain.pojo.BaseCondition;
import com.newenv.lpzd.base.service.XhjLpschoolService;
import com.newenv.lpzd.lp.domain.XhjLptp;
import com.newenv.pagination.PageInfo;

public class XhjLpschoolAction extends BaseAction {

	private XhjLpschoolService XhjLpschoolService;
	public LpSyscs1  lpSyscs1;
	private PageInfo pageInfo;//分页信息
	private  BaseCondition condition;
	
	public LpSyscs1 getLpSyscs1() {
		return lpSyscs1;
	}
	public void setLpSyscs1(LpSyscs1 lpSyscs1) {
		this.lpSyscs1 = lpSyscs1;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}


	public BaseCondition getCondition() {
		return condition;
	}

	public void setCondition(BaseCondition condition) {
		this.condition = condition;
	}

	public String execute(){
		return SUCCESS;
	}
	
	public XhjLpschoolService getXhjLpschoolService() {
		return XhjLpschoolService;
	}

	public void setXhjLpschoolService(XhjLpschoolService xhjLpschoolService) {
		XhjLpschoolService = xhjLpschoolService;
	}
	
	/**
	 * 添加學校
	 */
	public String addSchool(){
		//String cond = this.getRequest().getParameter("cond");
		String addSchoolid = XhjLpschoolService.addSchool(condition);
		this.getRequest().setAttribute("schoolid",addSchoolid);
		return jsonAjaxResult(JSON.toJSONString(addSchoolid));
	}
	/**
	 * 编辑类型 展示
	 * @return
	 */
	public String findBySType() {
		String name = this.getRequest().getParameter("name");
		List<LpSyscs1> findBySchoolType = XhjLpschoolService.findBySchoolType(name);
		this.getRequest().setAttribute("typeLists", findBySchoolType);
		return jsonAjaxResult(JSON.toJSONString(findBySchoolType));
	}
	
	/**
	 * 批量添加类型
	 * @return
	 */
	public String addType() {
		String typeNames = this.getRequest().getParameter("typeNames");
		return jsonAjaxResult(JSON.toJSONString(XhjLpschoolService.addType(typeNames)));
	}
	
//	
//	public String delType() {
//		int id = Integer.valueOf(this.getRequest().getParameter("id"));
//		return jsonAjaxResult(JSON.toJSONString(XhjLpschoolService.delType(id)));
//	}
//	
	/**
	 * 删除学校，修改状态，假删
	 * @return
	 */
	public String delSchool() {
		String id = this.getRequest().getParameter("id");
		return jsonAjaxResult(JSON.toJSONString(XhjLpschoolService.delSchool(id)));
	}
	
	/**
	 * 删图片 假删
	 * @return
	 */
	public String delImage() {
		String id = this.getRequest().getParameter("id");
		return jsonAjaxResult(JSON.toJSONString(XhjLpschoolService.delImage(id)));
	}
	/**
	 * 批量删除 假删除
	 * @return
	 */
	public String deleteAllSchool() {
		String ids = this.getRequest().getParameter("ids");
		return jsonAjaxResult(JSON.toJSONString(XhjLpschoolService.deleteAllSchool(ids)));
	}
	
	/**
	 * 批量修改schoolType
	 * @return
	 */
	public String updateType() {
		String ids = this.getRequest().getParameter("ids");
		condition.setIds(ids);
		int addType = XhjLpschoolService.updateType(condition);
		return jsonAjaxResult(JSON.toJSONString(addType));
	}
	
	
	/**
	 * 编辑学校信息
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public String updateDetail()
	{
		String schoolid = this.getRequest().getParameter("schoolid");
		int id = Integer.valueOf(schoolid);
		condition = XhjLpschoolService.updateDetail(id);
		this.bindParam("condition", condition);
		this.getRequest().setAttribute("condition", condition);
		if(condition != null)
		{
			return "edit";
		}
		return "fail";
	}
	/**
	 * 编辑学校信息
	 * @param condition
	 * @param strategy
	 * @return
	 */
	public String updateSchool()
	{
		int updateSchool = XhjLpschoolService.updateSchool(condition);
		return jsonAjaxResult(JSON.toJSONString(updateSchool));
	}
	/**
	 * 展示学校详情
	 * @return
	 */
	public String detail(){
		String schoolid = this.getRequest().getParameter("id");
		int id = Integer.valueOf(schoolid);
		condition = XhjLpschoolService.findSchoolById(id);
		this.bindParam("condition", condition);
		this.getRequest().setAttribute("condition", condition);
		return INPUT;
	}
	/**
	 * 咧别展示  分页查询
	 * @return
	 */
	public String queryData(){
		if(pageInfo == null){
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo =XhjLpschoolService.findSchoolByPage(pageInfo, condition,DAOConstants.RELATIONAL);//page = houseSolrClient.find(page, condition);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
}
