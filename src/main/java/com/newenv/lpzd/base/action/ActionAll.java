package com.newenv.lpzd.base.action;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.ChanQuan;
import com.newenv.lpzd.base.service.ActionAllService;
import com.newenv.pagination.PageInfo;

public class ActionAll extends BaseAction {
	private PageInfo pageInfo;
	private ActionAllService actionAllServices;
	private ChanQuan chanquan;
	
	public ActionAllService getActionAllServices() {
		return actionAllServices;
	}

	public void setActionAllServices(ActionAllService actionAllServices) {
		this.actionAllServices = actionAllServices;
	}

	public ChanQuan getChanquan() {
		return chanquan;
	}

	public void setChanquan(ChanQuan chanquan) {
		this.chanquan = chanquan;
	}

	/**
	 * 分页显示
	 * @return
	 */
	public String pageInFo(){
		if (pageInfo == null) {
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		pageInfo = actionAllServices.findByPageInFo(chanquan,pageInfo);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

}
