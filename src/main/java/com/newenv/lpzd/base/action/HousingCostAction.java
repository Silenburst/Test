package com.newenv.lpzd.base.action;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.service.HousingCostService;
import com.newenv.lpzd.base.service.MaintenanceService;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.pagination.PageInfo;

import diqu.Enetiy;

public class HousingCostAction extends BaseAction{
		private PageInfo pageInfo;
		private HousingCostService housingCostService;
		private Enetiy enetiy;
		private Integer lpid;
		private Integer ctype;
		private Integer payingWay;
		private Double price;
		private String unit;
		private String 	address;
		private String 	remark;
		private Integer costid;
		/**
		 * 分页显示
		 * @return
		 */
		public String pageinfo(){
			if (pageInfo == null) {
				pageInfo = new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			pageInfo = housingCostService.findByPageInFo(enetiy,pageInfo);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}
		/**
		 * 新增数据
		 * @return
		 */
		public String addDwell(){
			enetiy = new Enetiy();
			enetiy.setId(costid);
			enetiy.setLpid(lpid);
			enetiy.setCtype(ctype);
			enetiy.setPayingWay(payingWay);
			enetiy.setPrice(price);
			enetiy.setUnit(unit);
			enetiy.setRemark(remark);
			return jsonAjaxResult(JSON.toJSONString(housingCostService.addData(enetiy)));
		}
		
		
		public String getById(){
			Integer id= Integer.parseInt(this.getRequest().getParameter("costid"));
			LpCostLiving byId = housingCostService.getById(id);
			return jsonAjaxResult(JSON.toJSONString(byId));
		}
		public String deleteCost(){
			String json = "{\"data\" : \"success\"}";
			try{
				Integer costid= Integer.parseInt(this.getRequest().getParameter("costid"));
				 this.housingCostService.deleteCost(costid);
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
		public HousingCostService getHousingCostService() {
			return housingCostService;
		}
		public void setHousingCostService(HousingCostService housingCostService) {
			this.housingCostService = housingCostService;
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
		public Integer getCtype() {
			return ctype;
		}
		public void setCtype(Integer ctype) {
			this.ctype = ctype;
		}
		public Integer getPayingWay() {
			return payingWay;
		}
		public void setPayingWay(Integer payingWay) {
			this.payingWay = payingWay;
		}
		public Double getPrice() {
			return price;
		}
		public void setPrice(Double price) {
			this.price = price;
		}
		public String getUnit() {
			return unit;
		}
		public void setUnit(String unit) {
			this.unit = unit;
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
		public Integer getCostid() {
			return costid;
		}
		public void setCostid(Integer costid) {
			this.costid = costid;
		}
		
		
}
