package com.newenv.lpzd.base.action;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.service.MaintenanceService;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class MaintenanceAction extends BaseAction{
		private PageInfo pageInfo;
		private MaintenanceService maintenanceService;
		private Enetiy enetiy;
		private Integer lpid;
		private String 	mtype;
		private String 	companyName;
		private String 	tel;
		private String 	address;
		private String 	remark;
		private String  flag;
		private Integer lpmId;
		/**
		 * 分页显示
		 * @return
		 */
		public String findByPageInFo(){
			if (pageInfo == null) {
				pageInfo = new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			pageInfo = maintenanceService.findByPageInFo(enetiy,pageInfo);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}
		/**
		 * 新增维护单位
		 * @return
		 */
		public String addData(){
			enetiy = new Enetiy();
			enetiy.setId(lpmId);
			enetiy.setLpid(lpid);
			enetiy.setmType(mtype);
			enetiy.setCompanyName(companyName);
			enetiy.setTel(tel);
			enetiy.setAddress(address);
			enetiy.setRemark(remark);
			return jsonAjaxResult(JSON.toJSONString(maintenanceService.AddCBMU(enetiy)));
		}
		/**
		 * 新增判断
		 * @return
		 */
		public String update(){
			enetiy = new Enetiy();
			enetiy.setCompanyName(companyName);
			return  jsonAjaxResult(JSON.toJSONString(maintenanceService.update(enetiy)));
		}
		
		
		public String getById(){
			Integer id= Integer.parseInt(this.getRequest().getParameter("lpmId"));
			LpMaintenanceUnit byId = maintenanceService.getById(id);
			return jsonAjaxResult(JSON.toJSONString(byId));
		}
		public String deleteLPM(){
			String json = "{\"data\" : \"success\"}";
			try{
				Integer lpmId= Integer.parseInt(this.getRequest().getParameter("lpmId"));
				 this.maintenanceService.deleteLPM(lpmId);
			}catch(Exception e){
				json = "{\"data\" : \""+e.getMessage()+"\"}";
			}
			return jsonAjaxResult(json);
		}
		
		
		public PageInfo getPageInfo() {
			return pageInfo;
		}
		public void setPageInfo(PageInfo pageInfo) {
			this.pageInfo = pageInfo;
		}
		public MaintenanceService getMaintenanceService() {
			return maintenanceService;
		}
		public void setMaintenanceService(MaintenanceService maintenanceService) {
			this.maintenanceService = maintenanceService;
		}
		public Enetiy getEnetiy() {
			return enetiy;
		}
		public void setEnetiy(Enetiy enetiy) {
			this.enetiy = enetiy;
		}
		public Integer getLpid() {
			return lpid;
		}
		public void setLpid(Integer lpid) {
			this.lpid = lpid;
		}
		public String getMtype() {
			return mtype;
		}
		public void setMtype(String mtype) {
			this.mtype = mtype;
		}
		public String getCompanyName() {
			return companyName;
		}
		public void setCompanyName(String companyName) {
			this.companyName = companyName;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
		}
		public String getFlag() {
			return flag;
		}
		public void setFlag(String flag) {
			this.flag = flag;
		}
		public Integer getLpmId() {
			return lpmId;
		}
		public void setLpmId(Integer lpmId) {
			this.lpmId = lpmId;
		}
		
}
