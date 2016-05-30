package com.newenv.lpzd.security.action;

import java.util.List;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.service.TblDepartmentService;

public class DepartmentAction extends BaseAction{

	private TblDepartmentService departmentService;
	private Integer organizationId;
	private String departmentName;	//部门名
	
	/**
	 * 根据部门名称查询部门列表。
	 * @return
	 */
	public String queryDepartmentsByName(){
		List<TblDepartment> depts = departmentService.findDepartmentByOrgIdAndBlurDeparmentQuery(organizationId, departmentName);
		int i=0;
		String json = "[";
		for(TblDepartment dept : depts){
			json += (i==0?"":",") + "{\"id\":"+ dept.getId() +",\"name\":\""+ dept.getDepartmentName() +"\"}";
			i++;
		}
		json += "]";
		return this.jsonAjaxResult(json);
	}
	/**
	 * 获取部门电话和地址
	 * @return
	 */
	public String queryDepartAddress(){
		Integer deptId = Integer.valueOf(this.getRequest().getParameter("deptId"));
		List<Object[]> depts = departmentService.queryDepartAddress(deptId);
		int i=0;
		String json = "[";
		for(Object[] dept : depts){
			json += (i==0?"":",") + "{\"address\":\""+ dept[0] +"\",\"tel\":\""+ dept[1] +"\"}";
			i++;
		}
		json += "]";
		return this.jsonAjaxResult(json);
	};

	public TblDepartmentService getDepartmentService() {
		return departmentService;
	}

	public void setDepartmentService(TblDepartmentService departmentService) {
		this.departmentService = departmentService;
	}

	public Integer getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Integer organizationId) {
		this.organizationId = organizationId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
}
