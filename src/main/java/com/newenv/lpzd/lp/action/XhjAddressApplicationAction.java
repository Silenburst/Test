package com.newenv.lpzd.lp.action;

import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.service.MessageService;
import com.newenv.lpzd.base.service.XhjJccityService;
import com.newenv.lpzd.base.service.XhjJcsqService;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.XhjAddressapplication;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.lpzd.lp.service.XhjAddressApplicationService;
import com.newenv.lpzd.security.domain.TblUserProfile;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.security.service.TblDepartmentService;
import com.newenv.lpzd.security.service.TblUserProfileService;
import com.newenv.lpzd.util.AppConstants;
import com.newenv.pagination.PageInfo;

/**
 * 新地址申请。
 *
 */
public class XhjAddressApplicationAction extends BaseAction {

	private PageInfo pageInfo;
	
	private XhjAddressapplication addressapplication;
	
	private CheckCondition condition;
	
	private XhjAddressApplicationService addressApplicationService;
	
	private XhjJccityService cityService;
	
	private XhjJcstressService stressService;
	
	private XhjJcsqService sqService;
	
	private TblDepartmentService departmentService;
	
	private TblUserProfileService userProfileService;
	
	private int pageSize = 10;
	
	//导入文件
	private File file;
	//导出文件流
	private InputStream downloadStream;
	//导出EXCEL名
	private String fileName="新地址申请明细详情";
	//导出审核人EXCEL名
	private String checkerFileName="新增地址汇总";
	//时间类型
	private String timeType;
	//月份
	private String month;
	
	private MessageService messageService;
	
	/**
	 * 进入申请界面.
	 * @return
	 */
	public String preApply(){
		this.bindParam("cityList", cityService.findAll());
		if(addressapplication==null){
			addressapplication = new XhjAddressapplication();
		}
		addressapplication.setApplicantId(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
		addressapplication.setPhone(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getTel());
		addressapplication.setBmId(SecurityUserHolder.getCurrentUserLogin().getDepartment().getId());
		try{
			addressapplication.setApplicantName(userProfileService.getById(addressapplication.getApplicantId()).getFullname());
		}catch(Exception ignore){}
		try{
			addressapplication.setBmName(departmentService.getById(addressapplication.getBmId()).getDepartmentName());
		}catch(Exception ignore){}
		return "apply";
	}
	
	/**
	 * 提交申请。
	 * @return
	 */
	public String apply(){
		try{
			if(addressApplicationService.isApplied(addressapplication.getLpId(),addressapplication.getZdid(),addressapplication.getDyid(),addressapplication.getFangHaoId())){
				return this.jsonAjaxFailedResult("已存在相同的地址申请，无需重复申请！");
			}
			
			if(addressApplicationService.isExist(addressapplication.getLpId(),addressapplication.getZdid(),addressapplication.getDyid(),addressapplication.getFangHaoId())){
				return this.jsonAjaxFailedResult("地址已存在，无需申请！");
			}
			
			addressapplication.setCreateDate(new Date());
			addressapplication.setApplicantId(SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId());
			addressapplication.setBmId(SecurityUserHolder.getCurrentUserLogin().getDepartment().getId());
			addressapplication.setCheckState(0);
			addressApplicationService.save(addressapplication);
		}catch(Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 进入审核界面
	 * @return
	 */
	public String preCheck(){
		this.bindParam("cityList", cityService.findAll());
		String lpName = addressapplication.getLpName();
		/*if(StringUtils.hasText(lpName)){
			try {
				lpName = new String(lpName.getBytes("iso-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				//ignore
			}
		}*/
		addressapplication = addressApplicationService.getById(addressapplication.getId());
		addressapplication.setLpName(lpName);
		try{
			TblUserProfile u = userProfileService.getById(addressapplication.getApplicantId());
			addressapplication.setApplicantName(u.getFullname());
			if(!StringUtils.hasText(addressapplication.getPhone())){
				addressapplication.setPhone(u.getTel());
			}
		}catch(Exception ignore){}
		try{
			addressapplication.setBmName(departmentService.getById(addressapplication.getBmId()).getDepartmentName());
		}catch(Exception ignore){}
		return "check";
	}
	/**
	 * 进入详情界面
	 * @return
	 */
	public String info(){
		this.bindParam("cityList", cityService.findAll());
		String lpName = addressapplication.getLpName();
		/*if(StringUtils.hasText(lpName)){
			try {
				lpName = new String(lpName.getBytes("iso-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				//ignore
			}
		}*/
		addressapplication = addressApplicationService.getById(addressapplication.getId());
		addressapplication.setLpName(lpName);
		try{
			TblUserProfile u = userProfileService.getById(addressapplication.getApplicantId());
			addressapplication.setApplicantName(u.getFullname());
			if(!StringUtils.hasText(addressapplication.getPhone())){
				addressapplication.setPhone(u.getTel());
			}
		}catch(Exception ignore){}
		try{
			addressapplication.setBmName(departmentService.getById(addressapplication.getBmId()).getDepartmentName());
		}catch(Exception ignore){}
		return "info";
	}
	/**
	 * 审核。
	 * @return
	 */
	public String check(){
		try{
			addressApplicationService.saveCheck(addressapplication);
			
			String actionName = "";
			String message = "";
			if(addressapplication.getCheckState()==1){
				actionName = AppConstants.REALTER_APPROVE;
				message = "<a class=\"list-group-item ff0000\"><span class=\"pull-right\"></span> 您申请的"+addressapplication.getLpName()+"楼盘" + addressapplication.getFangHaoId() + "房号地址已被审核通过。</a>";
			}else if(addressapplication.getCheckState()==2){
				actionName = AppConstants.REALTER_REJECT;
				message = "<a class=\"list-group-item ff0000\"><span class=\"pull-right\"></span> 您申请的"+addressapplication.getLpName()+"楼盘" + addressapplication.getFangHaoId() + "房号地址审核没有通过。原因:"+addressapplication.getCheckerComment() +"</a>";
			}
			
			messageService.sendMessage(addressapplication.getApplicantId(), AppConstants.REALTER_DICTIONARY, actionName, "", message);
			
		}catch(Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 相同房号是否已经存在。
	 * @return
	 */
	public String isExist(){
		if(addressApplicationService.isExist(addressapplication.getLpId(), addressapplication.getZdid(), addressapplication.getDyid(), addressapplication.getFangHaoId())){
			return this.jsonAjaxSuccessResult("1");
		} else {
			return this.jsonAjaxSuccessResult("0");
		}
	}

	/**
	 * 查询地址List
	 * @return
	 */
	public String checkList(){
		this.bindParam("stressList", stressService.findByCityId(SecurityUserHolder.getCurrentUserLogin().getCityId()));
		if(pageInfo==null){
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = addressApplicationService.getAddress(pageInfo, condition);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public XhjAddressapplication getAddressapplication() {
		return addressapplication;
	}

	public void setAddressapplication(XhjAddressapplication addressapplication) {
		this.addressapplication = addressapplication;
	}

	public CheckCondition getCondition() {
		return condition;
	}

	public void setCondition(CheckCondition condition) {
		this.condition = condition;
	}

	public XhjAddressApplicationService getAddressApplicationService() {
		return addressApplicationService;
	}

	public void setAddressApplicationService(
			XhjAddressApplicationService addressApplicationService) {
		this.addressApplicationService = addressApplicationService;
	}

	public XhjJccityService getCityService() {
		return cityService;
	}

	public void setCityService(XhjJccityService cityService) {
		this.cityService = cityService;
	}

	public XhjJcstressService getStressService() {
		return stressService;
	}

	public void setStressService(XhjJcstressService stressService) {
		this.stressService = stressService;
	}

	public XhjJcsqService getSqService() {
		return sqService;
	}

	public void setSqService(XhjJcsqService sqService) {
		this.sqService = sqService;
	}

	public TblDepartmentService getDepartmentService() {
		return departmentService;
	}

	public void setDepartmentService(TblDepartmentService departmentService) {
		this.departmentService = departmentService;
	}

	public TblUserProfileService getUserProfileService() {
		return userProfileService;
	}

	public void setUserProfileService(TblUserProfileService userProfileService) {
		this.userProfileService = userProfileService;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public InputStream getDownloadStream() {
		return downloadStream;
	}

	public void setDownloadStream(InputStream downloadStream) {
		this.downloadStream = downloadStream;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getTimeType() {
		return timeType;
	}

	public void setTimeType(String timeType) {
		this.timeType = timeType;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getCheckerFileName() {
		return checkerFileName;
	}

	public void setCheckerFileName(String checkerFileName) {
		this.checkerFileName = checkerFileName;
	}

	public MessageService getMessageService() {
		return messageService;
	}

	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	
}
