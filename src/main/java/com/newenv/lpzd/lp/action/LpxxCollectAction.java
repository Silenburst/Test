package com.newenv.lpzd.lp.action;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.base.service.MessageService;
import com.newenv.lpzd.base.service.XhjJcsqService;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.lpzd.lp.service.XhjLpxxService;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.util.AppConstants;
import com.newenv.pagination.PageInfo;

/**
 * 楼盘采集。
 *
 */
public class LpxxCollectAction extends BaseAction {

	private PageInfo pageInfo;
	
	private XhjLpxx lpxx;
	
	private CheckCondition condition;
	
	private XhjLpxxService lpxxService;
	
	private XhjJcstressService xhjJcstressService;
	
	private XhjJcsqService xhjJcsqService;
	
	private int[] ids;
	
	//导入文件
	private File file;
	//导出文件流
	private InputStream downloadStream;
	//导出EXCEL名
	private String fileName="新增楼盘明细";
	//导出审核人EXCEL名
	private String checkerFileName="新增楼盘汇总";
	//时间类型
	private String timeType;
	//月份
	private String month;
	
	private int pageSize = 10;
	
	private MessageService messageService;
	
	/**
	 * 楼盘采集List
	 * @return
	 */
	public String execute(){
		List<XhjJcstress> stressList = xhjJcstressService.findByCityId(SecurityUserHolder.getCurrentUserLogin().getCityId());
		this.bindParam("stressList", stressList);
		return SUCCESS;
	}
	
	public String collectList(){
		if(pageInfo==null){
			pageInfo =new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(pageSize);
		}
		pageInfo = lpxxService.getLpmanagexx(pageInfo, condition);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}
	
	public String tijiao(){
		try{
			XhjLpxx byId = lpxxService.getById(lpxx.getId());
			byId.setRTime(new Date());
			byId.setCheckStatus(1);
			byId.setRequestRemark(lpxx.getRequestRemark());
			lpxxService.saveLpxx(byId);
			return this.jsonAjaxSuccessResult("");
		} catch(Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
	}
	
	/**
	 * 审核
	 * @return
	 */
	public String shenhe(){
		try{
			lpxxService.shenhe(lpxx);
			
			Date date=new Date();
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");    //记得要大写HH是24小时候制
			String time=df.format(date);
			String message = "<a class=\"list-group-item ff0000\"><span class=\"pull-right\"></span> 您采集的 "+lpxx.getLpName()+" 楼盘在"+time+"时间审核通过.</a>";
			messageService.sendMessage(lpxx.getUserId(), AppConstants.REALTER_DICTIONARY, AppConstants.REALTER_COLLECT_APPROVE, "", message);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 驳回
	 * @return
	 */
	public String bohui(){
		try{
			lpxxService.bohui(lpxx);
			
			Date date=new Date();
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");    //记得要大写HH是24小时候制
			String time=df.format(date);
			String message = "<a class=\"list-group-item ff0000\"><span class=\"pull-right\"></span> 您采集的 "+lpxx.getLpName()+" 楼盘在"+time+"时间被驳回.</a>";
			messageService.sendMessage(lpxx.getUserId(), AppConstants.REALTER_DICTIONARY, AppConstants.REALTER_COLLECT_REJECT, "", message);
		} catch (Exception e){
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	/**
	 * 删除楼盘采集信息。
	 * @return
	 */
	public String delete(){
		try{
			for(int id: ids){
				lpxxService.deleteByCheckStatus(id);
			}
		} catch (Exception e) {
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}
	
	public String info(){
		lpxx=lpxxService.getById(lpxx.getId());
		return "info";
	}
	
	/**
	 * 楼盘采集审批。
	 * @return
	 */
	public String checkList(){
		if(pageInfo==null){
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(pageSize);
		}
		pageInfo = lpxxService.queryCheckList(pageInfo, condition);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}

	/**
	 * 通过楼盘ID获取申请说明
	 * @return
	 */
	public String findrequest(){
		XhjLpxx byId = lpxxService.getById(lpxx.getId());
		String json="{\"remark\":" +"\""+byId.getRequestRemark()+"\""+ "}";
		return this.jsonAjaxResult(json);
	}
	
	public XhjLpxx getLpxx() {
		return lpxx;
	}

	public void setLpxx(XhjLpxx lpxx) {
		this.lpxx = lpxx;
	}

	public CheckCondition getCondition() {
		return condition;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public void setCondition(CheckCondition condition) {
		this.condition = condition;
	}

	public XhjLpxxService getLpxxService() {
		return lpxxService;
	}

	public void setLpxxService(XhjLpxxService lpxxService) {
		this.lpxxService = lpxxService;
	}
	
	public XhjJcstressService getXhjJcstressService() {
		return xhjJcstressService;
	}

	public void setXhjJcstressService(XhjJcstressService xhjJcstressService) {
		this.xhjJcstressService = xhjJcstressService;
	}

	public XhjJcsqService getXhjJcsqService() {
		return xhjJcsqService;
	}

	public void setXhjJcsqService(XhjJcsqService xhjJcsqService) {
		this.xhjJcsqService = xhjJcsqService;
	}

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int[] getIds() {
		return ids;
	}
	public void setIds(int[] ids) {
		this.ids = ids;
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
	public String getCheckerFileName() {
		return checkerFileName;
	}
	public void setCheckerFileName(String checkerFileName) {
		this.checkerFileName = checkerFileName;
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

	public MessageService getMessageService() {
		return messageService;
	}

	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	
}
