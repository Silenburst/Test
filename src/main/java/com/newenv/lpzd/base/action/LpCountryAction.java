package com.newenv.lpzd.base.action;

import java.io.IOException;
import java.util.List;

import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.service.LpCountryService;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.service.XhjLpfanghaoService;
import com.newenv.pagination.PageInfo;

public class LpCountryAction extends BaseAction {

	private LpCountryService lpCountryService;
	private PageInfo pageInfo;//分页信息
	public LpCountry  lpCountry;
	/**
	 * 查询
	 * @return 列表视图
	 * @throws IOException
	 */
	public String queryCountryByPage(){
		try {
			if(pageInfo == null){
				pageInfo = new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			pageInfo = lpCountryService.findByPage(pageInfo);
			this.getRequest().setAttribute("pager", pageInfo);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String execute(){
		this.bindParam("countryList", lpCountryService.findAll());
		return SUCCESS;
	}

	public LpCountryService getLpCountryService() {
		return lpCountryService;
	}

	public void setLpCountryService(LpCountryService lpCountryService) {
		this.lpCountryService = lpCountryService;
	}
	
}
