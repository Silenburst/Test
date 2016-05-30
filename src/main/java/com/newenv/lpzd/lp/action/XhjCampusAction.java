package com.newenv.lpzd.lp.action;

import java.text.DecimalFormat;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.Utils.DateUtils;
import com.newenv.lpzd.Utils.FileUtil;
import com.newenv.lpzd.base.service.LpCountryService;
import com.newenv.lpzd.base.service.LpProvinceService;
import com.newenv.lpzd.base.service.XhjJccityService;
import com.newenv.lpzd.base.service.XhjJcsqService;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.LpCostLiving;
import com.newenv.lpzd.lp.domain.LpFinsh;
import com.newenv.lpzd.lp.domain.LpMaintenanceUnit;
import com.newenv.lpzd.lp.domain.LpReview;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLptp;
import com.newenv.lpzd.lp.domain.XhjLpwuye;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.vo.XhjLpxxVo;
import com.newenv.lpzd.lp.service.LpCostLivingService;
import com.newenv.lpzd.lp.service.LpMaintenanceUnitService;
import com.newenv.lpzd.lp.service.LpSyscs1Service;
import com.newenv.lpzd.lp.service.LpfinshService;
import com.newenv.lpzd.lp.service.XhjLpWuYeService;
import com.newenv.lpzd.lp.service.XhjLpfanghaoService;
import com.newenv.lpzd.lp.service.XhjLptpService;
import com.newenv.lpzd.lp.service.XhjLpxxService;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;

public class XhjCampusAction extends BaseAction {
	private LpCountryService lpCountryService;
	private LpProvinceService lpProvinceService;
	private XhjJccityService xhjJccityService;
	private XhjJcstressService xhjJcStressService;
	private XhjJcsqService xhjJcsqService;
	private XhjLpxxService xhjLpxxService;
	private LpSyscs1Service lpSyscs1Service;
	private XhjLpWuYeService xhjLpWuYeService;
	private XhjLptpService xhjLptpService;
	private XhjLpfanghaoService xhjLpfanghaoService;
	private LpMaintenanceUnitService lpMaintenanceUnitService;
	private LpCostLivingService lpCostLivingService;
	private XhjLpxx queryLpxx;
	private XhjLpxx lpxx;
	private XhjLpwuye wyxx;
	private PageInfo pageInfo;//分页信息
	private List<XhjLptp> imageUrl;
	private LpReview lpReview;
	private String userID;
	private String lpId;
	private String content;
	private LpCostLiving lcl;
	private LpMaintenanceUnit lmu;
	private String lpLtype;
	private List<LpFinsh> lpfinsh;
	private LpfinshService lpfinshService;
	private XhjLpdong xhjLpdong;
	private XhjLpdanyuan xhjLpdanyuan;
	private XhjLpfanghao xhjLpfanghao;
	
	
	

	public XhjLpfanghao getXhjLpfanghao() {
		return xhjLpfanghao;
	}

	public void setXhjLpfanghao(XhjLpfanghao xhjLpfanghao) {
		this.xhjLpfanghao = xhjLpfanghao;
	}

	public XhjLpdanyuan getXhjLpdanyuan() {
		return xhjLpdanyuan;
	}

	public void setXhjLpdanyuan(XhjLpdanyuan xhjLpdanyuan) {
		this.xhjLpdanyuan = xhjLpdanyuan;
	}

	public XhjLpdong getXhjLpdong() {
		return xhjLpdong;
	}

	public void setXhjLpdong(XhjLpdong xhjLpdong) {
		this.xhjLpdong = xhjLpdong;
	}

	public LpCostLiving getLcl() {
		return lcl;
	}

	public void setLcl(LpCostLiving lcl) {
		this.lcl = lcl;
	}

	public LpMaintenanceUnit getLmu() {
		return lmu;
	}

	public void setLmu(LpMaintenanceUnit lmu) {
		this.lmu = lmu;
	}

	private String from = "";	//从哪个列表页面过来的		lpxx: lpxxList, apply: 楼盘采集页面, check：楼盘字典审核页面 
	
	private int[] ids;

	@Override
	public String execute() throws Exception {
		return super.execute();
	}
	
	public String savelpReview(){
		String json = "{\"data\" : \"success\"}";
		try {
			lpReview=new LpReview();
			lpReview.setCreatedate(new Date());
			lpReview.setUserid(Integer.valueOf(userID));
			lpReview.setLpid(Integer.valueOf(lpId));
			lpReview.setContent(content);
			xhjLpxxService.saveLpReview(lpReview);
		}catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
		
	}
	
	public String queryData(){
		try {
			if(pageInfo == null){
				pageInfo = new PageInfo();
				pageInfo.setPage(1);
				pageInfo.setRows(10);
			}
			pageInfo = xhjLpxxService.queryData(queryLpxx, pageInfo);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	};
	
	public String updLpxx(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		XhjLpxx loadLpxx = xhjLpxxService.queryLpxx(lpid);
		XhjLpwuye wuye = xhjLpWuYeService.queryWuyeInfo(lpid);
		List<XhjLptp> lptp = xhjLptpService.queryLptpInfo(lpid,0,0);
		this.bindParam("loadLpxx", loadLpxx);
		this.bindParam("wuye", wuye);
		this.bindParam("lptp", lptp);
		return "LPXXUPDATE";
	};
	/**
	 * 删除楼盘信息
	 * @return
	 */
	public String delLpxx(){
		String json = "{\"data\" : \"success\"}";
		try {
			Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
			xhjLpxxService.delLpxx(lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	public String showDetail(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		XhjLpxx loadLpxx = xhjLpxxService.queryLpxx(lpid);
		XhjLpwuye wuye = xhjLpWuYeService.queryWuyeInfo(lpid);
		List<XhjLptp> lptp = xhjLptpService.queryLptpInfo(lpid,0,0);
		List<Object> fhCount = xhjLpxxService.queryCount(lpid);
		DecimalFormat df = new DecimalFormat("######0.00");
		Double saleCount = Double.valueOf(fhCount.get(0).toString());
		Double rentCount = Double.valueOf(fhCount.get(1).toString());
		Double sumNum = Double.valueOf(fhCount.get(3).toString());
		List<Object> list = new ArrayList<Object>();
		Double s = saleCount / sumNum * 100;
		Double r = rentCount / sumNum * 100;
		list.add(df.format(s));//售
		list.add(df.format(r));//租
		list.add(fhCount.get(2));//租
		this.bindParam("loadLpxx", loadLpxx);
		this.bindParam("wuye", wuye);
		this.bindParam("lptp", lptp);
		this.bindParam("fhCount", list);
		return "DETAIL";
	};
	
	public String showDetail2(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		XhjLpxxVo loadLpxxVo = xhjLpxxService.queryLpxx2(lpid);
		XhjLpxx loadLpxx=loadLpxxVo.getXhjLpxx();
		//XhjLpwuye wuye = xhjLpWuYeService.queryWuyeInfo(lpid);
		List<XhjLptp> lptp = xhjLptpService.queryLptpInfo(lpid,0,0);
		List<Object> fhCount = xhjLpxxService.queryCount2(lpid);
		List<Object> cjCount = xhjLpxxService.querycjCount(lpid);
		List<Object> byjujiaCount = xhjLpxxService.queryjunjiaCount(lpid);
		DecimalFormat df = new DecimalFormat("######0.00");
		Double cssCount = Double.valueOf(fhCount.get(3).toString());//小区上个月在售数
		Double csbCount = Double.valueOf(fhCount.get(4).toString());//小区本月在售数
		Double czsCount = Double.valueOf(fhCount.get(8).toString());//小区上个月在租数
		Double czbCount = Double.valueOf(fhCount.get(9).toString());//小区本月在租数
		Double kzsCount = Double.valueOf(fhCount.get(13).toString());//小区上个月在租数
		Double kzbCount = Double.valueOf(fhCount.get(14).toString());//小区本月在租数
		
		Double csbcjCount= Double.valueOf(cjCount.get(0).toString());//小区本月在售成交数
		Double csscjCount= Double.valueOf(cjCount.get(1).toString());//小区上个月在售成交数
		
		Double czbcjCount= Double.valueOf(cjCount.get(2).toString());//小区本月在租成交数
		Double czscjCount= Double.valueOf(cjCount.get(3).toString());//小区上个月在租成交数
		
		Double csbjjCount= Double.valueOf(byjujiaCount.get(0).toString());//小区本月在售均价
		Double cssjjCount= Double.valueOf(byjujiaCount.get(2).toString());//小区上个月在售均价
		
		Double czbjjCount= Double.valueOf(byjujiaCount.get(1).toString());//小区本月在租均价
		Double czsjjCount= Double.valueOf(byjujiaCount.get(3).toString());//小区上个月在租均价
		
		List<Object> list = new ArrayList<Object>();
		Double cs=0.0;
		if(csbCount>0.0){
			 cs = (csbCount-cssCount) / csbCount * 100;//在售房环比上月数
		}
		Double cz=0.0;
		if(czbCount>0.0){
			 cz = (czbCount-czsCount) / czbCount * 100;//环比上月租数
		}
		Double kz=0.0;
		if(kzbCount>0.0){
			kz = (kzbCount-kzsCount) / kzbCount * 100;//环比上月空置数
		}
//		Double cscj=0.0;
//		if(csbcjCount>0.0){
//			cscj = (csbcjCount-csscjCount) / csbcjCount * 100;//在售成交房环比上月数
//		}
//		Double czcj=0.0;
//		if(czbcjCount>0.0){
//			czcj = (czbcjCount-czscjCount) / czbcjCount * 100;//在租成交房环比上月数
//		}
//		
//		Double csjj=0.0;
//		if(csbjjCount>0.0){
//			csjj = (csbjjCount-cssjjCount) / csbjjCount * 100;//在售均价环比上月数
//		}
//		Double czjj=0.0;
//		if(czbjjCount>0.0){
//			czjj = (czbjjCount-czsjjCount) / czbjjCount * 100;//在租均价环比上月数
//		}
		Double cscj = csbcjCount / csscjCount * 100;//在售成交房环比上月数
		Double czcj = czbcjCount / czscjCount * 100;//在租成交房环比上月数
		Double csjj = csbjjCount / cssjjCount * 100;//在售均价环比上月数
		Double czjj = czbjjCount / czsjjCount * 100;//在租均价环比上月数
		list.add(fhCount.get(0));//小区在售总数
		list.add(fhCount.get(1));//小区内部系统在售数
		list.add(fhCount.get(2));//小区外部系统在售数
		list.add(cs>=0.0?df.format(cs):"--");//在售房环比上月数
		
		list.add(fhCount.get(5));//小区在租总数
		list.add(fhCount.get(6));//小区内部系统在租数
		list.add(fhCount.get(7));//小区外部系统在租数
		list.add(df.format(cz));//环比上月租数
		
		list.add(fhCount.get(10));//小区空置总数
		list.add(fhCount.get(11));//小区内部系统空置数
		list.add(fhCount.get(12));//小区外部系统空置数
		list.add(df.format(kz));//环比上月空置数
		list.add(cjCount.get(0));
		list.add(cscj>=0.0?df.format(cscj):"--");
		list.add(cjCount.get(2));
		list.add(czcj>=0.0?df.format(czcj):"--");
		list.add(df.format(byjujiaCount.get(0)));
		list.add(df.format(byjujiaCount.get(1)));
		list.add(csjj>=0.0?df.format(csjj):"--");
		list.add(czjj>=0.0?df.format(czjj):"--");
		list.add(DateUtils.getCurrentDate());
		this.bindParam("loadLpxx", loadLpxx);
		this.bindParam("loadLpxxVo", loadLpxxVo);
		this.bindParam("lptp", lptp);
		this.bindParam("fhCount", list);
		return "DETAIL2";
	};
	
	public String lpxxlptp(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		List<XhjLptp> lptps = xhjLptpService.queryLptpInfo(lpid,0,0);
		String jsonString = JSON.toJSONString(lptps);
		return jsonAjaxResult(jsonString);
	}
	
	public String xhjLpxxshi(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		Integer shi = Integer.valueOf(this.getRequest().getParameter("shi"));
		Integer fengge = Integer.valueOf(this.getRequest().getParameter("fengge"));
		List<XhjLptp> lptp = xhjLptpService.queryLptpInfo(lpid,shi,fengge);
		String json="[";
		for(XhjLptp lptpxx:lptp){
			if(shi!=0){
				if(lptpxx.getImgType()==1){
					if(lptpxx.getShi()==shi){
						json+="{\"image\":\""+FileUtil.imageUrl+"/"+lptpxx.getImg()+"\",\"thumb\":\""+FileUtil.imageUrl+"/"+lptpxx.getImg()+"\",\"mark\":\"0\"},";
					}
				}
			}else if(fengge!=0){
				if(lptpxx.getImgType()==4){
					if(lptpxx.getFengge()==fengge){
						json+="{\"image\":\""+FileUtil.imageUrl+"/"+lptpxx.getImg()+"\",\"thumb\":\""+FileUtil.imageUrl+"/"+lptpxx.getImg()+"\",\"mark\":\"0\"},";
					}
				}
			}
			
			
		}
		json=json.substring(0, json.length()-1);
		json +="]";
		
		System.out.println(json);
		return jsonAjaxResult(json);
	}
	public String saveDzRemark(){
		String json = "{\"data\" : \"success\"}";
		try {
			Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
			String dzRemark = this.getRequest().getParameter("dzRemark");
			xhjLpxxService.saveDzRemark(lpid, dzRemark);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	public String queryLpxx() throws Exception{
		queryLpxx.setCityId(Integer.parseInt(SecurityUserHolder.getCurrentUserLogin().getCityId()));	//只查询本市的楼盘
		pageInfo = xhjLpxxService.querySimpleLpxx(pageInfo, queryLpxx, ids);
		return jsonAjaxResult(this.lpxxPagerToJson(pageInfo));
	}
	
	private String lpxxPagerToJson(PageInfo pager){
		String json = "{\"page\":" + pager.getPage() + ",\"records\":" + pager.getRecords() + ",\"total\":" + pager.getTotal() + ",\"datas\":[";
		List<Object[]> lcfzList = (List<Object[]>) pager.getGridModel();
		int i=0;
		for(Object[] temp : lcfzList){
			json += (i==0?"":",") + "{\"lpId\":"+ temp[0] +",\"lpName\":\""+ temp[1] +"\",\"sqName\":\""+ temp[2] +"\"";
			if(queryLpxx.getStatuss()!=null && queryLpxx.getStatuss()==10){//这里使用lpxx.status作为判断条件，如果是10则获取楼盘下的栋座
				json += ",\"dongs\":" + getDongOfLp((Integer)temp[0]);
			}
			
			json += "}";
			i++;
		}
		json += "]}";
		return json;
	};
	/**
	 * 查询成交信息
	 * @return
	 */
	public String findByLpChengjiao(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		int lpid=Integer.parseInt(this.getRequest().getParameter("lpid"));
		String type = this.getRequest().getParameter("type");
		try{
			pageInfo = xhjLpfanghaoService.findByLpChengjiao(pageInfo, lpid, type);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	};
	/**
	 * 加载最新动态
	 * @return
	 */
	public String findByLpLog(){
		if(pageInfo==null){
			pageInfo= new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		int lpid = Integer.parseInt(this.getRequest().getParameter("lpid"));
		try{
			pageInfo = xhjLpxxService.findByLpLog(pageInfo, lpid);
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	};
	
	/**
	 * 保存楼盘信息并返回楼盘ID
	 * @return
	 */
	public String saveLpxx(){
		String json = "";
		try {
			if(from.equals("apply")){
				lpxx.setStatuss(0);		//无效
				lpxx.setCheckStatus(0);	//未提交
			}
//			lpxx.setLtype(Integer.parseInt(lpLtype));
			String sid = xhjLpxxService.saveLpxx(lpxx);
			json = "{\"data\" : \"success\",\"id\": \""+sid+"\"}";
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	
	
	
	/**
	 * 保存物业信息并返回物业ID
	 * @return
	 */
	public String saveLpwy(){
		String json = "";
		try {
			String sid = xhjLpWuYeService.saveWuye(wyxx);
			json = "{\"data\" : \"success\",\"id\": \""+sid+"\"}";
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	/**
	 * 保存图片
	 * @return
	 */
	public String saveLptp(){
		String json = "{\"data\" : \"success\"}";
		try {
			Integer lpid = Integer.valueOf(this.getRequest().getParameter("tuplpid"));
			String imgName = this.getRequest().getParameter("imgNameAll");
			xhjLptpService.saveLpimges(lpid, imgName, imageUrl);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 保存栋数
	 * @return
	 */
	public String addDong(){
		String json = "{\"data\" : \"success\"}";
		try {
			int userid = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
			xhjLpdong.setCreatorId(userid);
			xhjLpxxService.saveLpDong(xhjLpdong);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	}
	
	public String updDong(){
		String json = "{\"data\" : \"success\"}";
		try {
//			String lpid = this.getRequest().getParameter("lpid");
//			String lpdid = this.getRequest().getParameter("lpdid");
//			String lpdName = this.getRequest().getParameter("lpdName");
//			String dType = this.getRequest().getParameter("dType");
//			String dyNum = this.getRequest().getParameter("dyNum");
//			String ages = this.getRequest().getParameter("ages");
//			String size = this.getRequest().getParameter("size");
//			String topNum = this.getRequest().getParameter("topNum");
//			String underNum = this.getRequest().getParameter("underNum");
//			String located = this.getRequest().getParameter("located");
//			String ownership = this.getRequest().getParameter("ownership");
//			String remarks = this.getRequest().getParameter("remarks");
			xhjLpxxService.updLpDong(xhjLpdong);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	}
	
	/**
	 * 新增单元
	 * @return
	 */
	public String addDany(){
		String json = "{\"data\" : \"success\"}";
		try {
			int userid = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
			String lpid = this.getRequest().getParameter("lpid");
			xhjLpdanyuan.setCreatorId(userid);
			xhjLpxxService.saveDany(xhjLpdanyuan,lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	}
	/**
	 * 修改单元
	 * @return
	 */
	public String updDany(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid = this.getRequest().getParameter("lpid");
			xhjLpxxService.updLpDany(lpid,xhjLpdanyuan);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	public String saveFanghao(){
		String json = "{\"data\" : \"success\"}";
		try {
			String datas = this.getRequest().getParameter("datas");
			String type = this.getRequest().getParameter("fanghaoAddType");
			int userid = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
			xhjLpxxService.saveFanghao(datas, type, userid,xhjLpfanghao);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 获取楼盘的栋信息。
	 * @param bmid
	 * @param lpid
	 * @return
	 */
	private String getDongOfLp(int lpid){
		List<Object[]> dongs = xhjLpxxService.getDongOfLp(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return json;
	};
	
	/**
	 * 删除房号
	 * @return
	 */
	public String deleteFangh(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid= this.getRequest().getParameter("lpid");
			String id = this.getRequest().getParameter("id");
			xhjLpxxService.deleteFangh(lpid, id);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 批量删除房号
	 * @return
	 */
	public String batchDeleteFangh(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid= this.getRequest().getParameter("lpid");
			String idsi= this.getRequest().getParameter("idsi");
			xhjLpxxService.batchDeleteFangh(idsi,lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	/**
	 * 批量删除单元
	 * @return
	 */
	public String batchDeleteDany(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid= this.getRequest().getParameter("lpid");
			String dyid= this.getRequest().getParameter("dyid");
			xhjLpxxService.batchDeleteDany(dyid,lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	/**
	 * 删除前判断单元下房号信息
	 * @return
	 */
	public String getByDyid(){
		
			String dyid= this.getRequest().getParameter("dyid");
			int  fian=xhjLpxxService.getByDyid(dyid);
			String json = "{\"data\" : \""+fian+"\"}";
		return jsonAjaxResult(json);
	}
	/**
	 * 删除栋座资料
	 * @return
	 */
	public String deleteDong(){
		String json = "{\"data\" : \"success\"}";
		try {
			String id = this.getRequest().getParameter("id");
			String lpid= this.getRequest().getParameter("lpid");
			xhjLpxxService.deleteDong(lpid, id);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 批量删除楼栋
	 * @return
	 */
	public String batchDeleteLpD(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid= this.getRequest().getParameter("lpid");
			String dzid= this.getRequest().getParameter("dzid");
			xhjLpxxService.batchDeleteLpD(dzid,lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	/**
	 * 删除前判断楼栋下单元信息
	 * @return
	 */
	public String getByDzid(){
		
			String dzid= this.getRequest().getParameter("dzid");
			int  fian=xhjLpxxService.getByLdId(dzid);
			String json = "{\"data\" : \""+fian+"\"}";
		return jsonAjaxResult(json);
	}
	/**
	 * 删除单元
	 * @return
	 */
	public String deleteDany(){
		String json = "{\"data\" : \"success\"}";
		try {
			String id = this.getRequest().getParameter("id");
			String lpid= this.getRequest().getParameter("lpid");
			xhjLpxxService.deleteDany(lpid, id);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 显示某楼盘下的所有栋数
	 * @return
	 */
	public String showDongLp(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		List<Object[]> dongs = xhjLpxxService.getDongOfLp(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 修改加载当点楼盘下的学区房信息
	 * @return
	 */
	public String showDongLpUpd(){
 		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		String id = this.getRequest().getParameter("lpsid");
		String checkedDong = xhjLpxxService.getLpSchoolXqUpd(id,"fhid"); //查某个楼盘某个学校的学区栋信息
		List<Object[]> dongs = xhjLpxxService.getDongOfLp(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			if(checkedDong.indexOf(temp[0] + "," ) >= 0) {
				json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\",\"checked\":" + true + "}";
			} else {
				json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\",\"checked\":" + false + "}";
			}
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	
	/**
	 * 加载该楼盘下栋对应房号树
	 * @return
	 */
	public String showSchoolFang(){
		String id = this.getRequest().getParameter("node");
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		String endTitle = "";
		List<Object[]> dongs = null;
		boolean checked = false;
		boolean leaf = false;
		if("0".equals(id)){
			//栋
			dongs = xhjLpxxService.getDongOfLp(lpid);
			endTitle = "D";
		} else if(id.indexOf("D") > 0){
			//单元
			String idd = id.substring(0,id.indexOf("D"));
			dongs = xhjLpxxService.getDanYuan(Integer.valueOf(idd));
			endTitle = "Y";
		} else if(id.indexOf("Y") > 0){
			//查询单元下所有
			String idd = id.substring(0,id.indexOf("Y"));
			dongs = xhjLpxxService.getSchoolCeng(Integer.valueOf(idd));
			endTitle = "C";
			checked = true;
		} else if(id.indexOf("C") > 0){
			//查询层下所有房号
			String idds = id.substring(0,id.indexOf("C"));
			String[] ids = idds.split("&");
			dongs = xhjLpxxService.getFanghao(Integer.valueOf(ids[0]),Integer.valueOf(ids[1]));
			checked = true;
			leaf = true;
		};
		String json = "[";
		int i=0;
		for(Object[] temp : dongs){
			if(checked) {
				json += (i==0?"":",") + "{\"id\":\""+ temp[0] + endTitle + "\",\"text\":\""+ temp[1] +"\",\"parent\":\""+ id +"\",\"checked\":"+ false +",\"leaf\":"+leaf+"}";
			} else {
				json += (i==0?"":",") + "{\"id\":\""+ temp[0] + endTitle + "\",\"text\":\""+ temp[1] +"\",\"parent\":\""+ id +"\",\"leaf\":"+leaf+"}";
			}
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 修改楼盘下学位房号的加载
	 * @return
	 */
	public String showSchoolFangUpd() {
		String id = this.getRequest().getParameter("node");
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		String lpsid = this.getRequest().getParameter("lpsid");
		String endTitle = "";
		List<Object[]> dongs = null;
		boolean checked = false;
		boolean leaf = false;
		String checkedFang = "";
		if("0".equals(id)){
			//栋
			dongs = xhjLpxxService.getDongOfLp(lpid);
			endTitle = "D";
		} else if(id.indexOf("D") > 0){
			//单元
			String idd = id.substring(0,id.indexOf("D"));
			dongs = xhjLpxxService.getDanYuan(Integer.valueOf(idd));
			endTitle = "Y";
		} else if(id.indexOf("Y") > 0){
			//查询单元下所有
			String idd = id.substring(0,id.indexOf("Y"));
			dongs = xhjLpxxService.getSchoolCeng(Integer.valueOf(idd));
			endTitle = "C";
			checked = true;
			checkedFang = xhjLpxxService.getLpSchoolXqUpd(lpsid, "fhid"); //查某个楼盘某个学校的学区选择的房号
		} else if(id.indexOf("C") > 0){
			//查询层下所有房号
			String idds = id.substring(0,id.indexOf("C"));
			String[] ids = idds.split("&");
			dongs = xhjLpxxService.getFanghao(Integer.valueOf(ids[0]),Integer.valueOf(ids[1]));
			checked = true;
			leaf = true;
			checkedFang = xhjLpxxService.getLpSchoolXqUpd(lpsid, "fhid"); //查某个楼盘某个学校的学区选择的房号
		};
		String json = "[";
		int i=0;
		for(Object[] temp : dongs){
			if(checked) {
				if(checkedFang.indexOf(temp[0] + ",") >= 0) {
					json += (i==0?"":",") + "{\"id\":\""+ temp[0] + endTitle + "\",\"text\":\""+ temp[1] +"\",\"parent\":\""+ id +"\",\"checked\":"+ true +",\"leaf\":"+leaf+"}";
				} else {
					json += (i==0?"":",") + "{\"id\":\""+ temp[0] + endTitle + "\",\"text\":\""+ temp[1] +"\",\"parent\":\""+ id +"\",\"checked\":"+ false +",\"leaf\":"+leaf+"}";
				}
			} else {
				json += (i==0?"":",") + "{\"id\":\""+ temp[0] + endTitle + "\",\"text\":\""+ temp[1] +"\",\"parent\":\""+ id +"\",\"leaf\":"+leaf+"}";
			}
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 保存楼盘关联的学区和学号信息
	 * @return
	 */
	public String saveLpSchool(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.saveLpSchool(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 修改楼盘关联的学区和学号信息
	 * @return
	 */
	public String updLpSchool(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.updLpSchool(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	//删除某学校划分记录
	public String deleteLpSchool(){
		String json = "{\"data\" : \"success\"}";
		try {
			Integer lpsid = Integer.valueOf(this.getRequest().getParameter("lpsid"));
			String lpid = this.getRequest().getParameter("lpid");
			xhjLpxxService.deleteLpSchool(lpsid,lpid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 显示栋下所有单元
	 * @return
	 */
	public String showLpDanyuan(){
		Integer dzid = Integer.valueOf(this.getRequest().getParameter("dongId"));
		List<Object[]> dongs = xhjLpxxService.getDanYuan(dzid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"dyName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 显示楼盘对应的学校
	 * @return
	 */
	public String loadLpSchoolInfo(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		List<Object[]> dongs = xhjLpxxService.loadLpSchoolInfo(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"schoolType\":\""+ temp[1] +"\",\"schoolName\":\""+ temp[2] 
					+"\",\"names\":\""+ temp[3] +"\",\"type\":\""+ temp[4] +"\",\"schooltype2\":\""+ temp[5] +"\",\"schoolid\":\""+ temp[6] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 显示单元下所有楼层
	 * @return
	 */
	public String showCeng(){
		Integer dyId = Integer.valueOf(this.getRequest().getParameter("dyId"));
		List<Object[]> dongs = xhjLpxxService.getCeng(dyId);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"ceng\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	
	/**
	 * 批量锁盘
	 * @return
	 */
	public String batchLock(){
		String json = "{\"data\" : \"success\"}";
		try {
			String ids = this.getRequest().getParameter("idsi");
			xhjLpxxService.batchLock(ids);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	public String showFanghaoOfDanyuan(){
		Integer dyId = Integer.valueOf(this.getRequest().getParameter("dyId"));
		Integer ceng = Integer.valueOf(this.getRequest().getParameter("ceng"));
		List<Object[]> dongs = xhjLpxxService.getFanghao(dyId,ceng);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"fhName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 获取所有的地铁线路
	 * @return
	 */
	public String getMotors(){
		List<Object[]> dongs = xhjLpxxService.findMotors();
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"xlName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 获取某线路下的站名
	 * @return
	 */
	public String loadZhan(){
		String xid = this.getRequest().getParameter("xid");
		List<Object[]> dongs = xhjLpxxService.findLoadZhan(xid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"zdName\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	public String deleteLpZhan(){
		String json = "{\"data\" : \"success\"}";
		try {
			String lpid = this.getRequest().getParameter("lpid");
			String zhanid = this.getRequest().getParameter("zhanid");
			xhjLpxxService.deleteLpZhan(lpid, zhanid);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 获取要修改的房号对象
	 * @return
	 */
	public String findFanghaoById(){
		Integer fanghId = Integer.valueOf(this.getRequest().getParameter("fanghId"));
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.findFanghaoById(fanghId)));
	};
	/**
	 * 加载关联房号
	 * @return
	 */
	public String showCorHouseInit(){
		String fanghId = this.getRequest().getParameter("fhid");
		String idss = this.getRequest().getParameter("idss");
		if(idss != null && !"".equals(idss)){
			fanghId = idss;
		}
		List<Object[]> list =  xhjLpxxService.showCorHouseInit(fanghId);
		return jsonAjaxResult(JSON.toJSONString(list));
	};
	/**
	 * 加载关联单元
	 * @return
	 */
	public String showCorHouseInitDanYuan(){
		String danYuanID = this.getRequest().getParameter("danYuanID");
		String idss = this.getRequest().getParameter("idss");
		if(idss != null && !"".equals(idss)){
			danYuanID = idss;
		}
		List<Object[]> list =  xhjLpxxService.showCorHouseInitDanYan(danYuanID);
		return jsonAjaxResult(JSON.toJSONString(list));
	};
	
	
	
	/**
	 * 修改房号
	 * @return
	 */
	public String doUpdateFanghao(){
		String json = "{\"data\" : \"success\"}";
		try {
//			String dyid = this.getRequest().getParameter("dyid");
//			String fanghId = this.getRequest().getParameter("fanghId");
//			String fangHao = this.getRequest().getParameter("fangHao");
//			String fhName = this.getRequest().getParameter("fhName");
//			String leixing = this.getRequest().getParameter("leixing");
//			String lpid = this.getRequest().getParameter("lpid");
//			String shi = this.getRequest().getParameter("shi");
//			String ting = this.getRequest().getParameter("ting");
//			String chu = this.getRequest().getParameter("chu");
//			String wei = this.getRequest().getParameter("wei");
//			String leibei2 = this.getRequest().getParameter("leibei2");
//			String chaoXiang = this.getRequest().getParameter("chaoXiang");
//			String decorationStandard = this.getRequest().getParameter("decorationStandard");
//			String cqmj = this.getRequest().getParameter("cqmj");
//			String tnmj = this.getRequest().getParameter("tnmj");
//			String remark2 = this.getRequest().getParameter("remark2");
//			String totalFloor= this.getRequest().getParameter("totalFloor");
			xhjLpxxService.doUpdateFanghao(xhjLpfanghao);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	}
	
	/**
	 * 添加楼盘对应地铁站
	 * @return
	 */
	public String saveLpZhan(){
		String json = "{\"data\" : \"success\"}";
		try {
			String zhanids = this.getRequest().getParameter("zhanids");
			String lpid = this.getRequest().getParameter("lpid");
			if(lpid == null || "".equals(lpid)) {
				throw new Exception("未获取到楼盘ID");
			}
			xhjLpxxService.saveLpZhan(lpid, zhanids);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 显示楼盘地铁站
	 * @return
	 */
	public String showLpZhan(){
		String lpid = this.getRequest().getParameter("lpid");
		List<Object[]> dongs = xhjLpxxService.showLpZhan(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"zdName\":\""+ temp[1] +"\",\"xName\":\""+temp[2]+"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 显示所有学校类型及其他类型
	 * @return
	 */
	public String showSchoolAllType(){
		String sid = this.getRequest().getParameter("sid");
		List<Object[]> dongs = xhjLpxxService.getSyscs(sid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"name\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	
	
	/**
	 * 显示所有学校类型及其他类型
	 * @return
	 */
	public String showSyscsParams(){
		String name = this.getRequest().getParameter("name");
		List<Object[]> dongs = xhjLpxxService.getSyscsParams(name);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"name\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	
	/**
	 * 显示某学校类型下的学校
	 * @return
	 */
	public String showSchoolDetail(){
		String id = this.getRequest().getParameter("id");
		List<Object[]> dongs = xhjLpxxService.showSchoolDetail(id);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"name\":\""+ temp[1] +"\"}";
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 保存责任盘数据
	 * @return
	 */
	public String saveZeren(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.saveZeren(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 保存责任盘和维护盘信息
	 * @return
	 */
	public String saveWeih(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.saveWeih(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	/**
	 * 修改划分盘信息
	 * @return
	 */
	public String updLpFuzh(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.updLpFuzh(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 加载责任盘选中
	 * @return
	 */
	public String showLpfuZhuDongUpd(){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		String bmid = this.getRequest().getParameter("bmid");
		List<Object> checkedDong = xhjLpxxService.getLpBmFuzhInfo(lpid, bmid); //查某个楼盘某个学校的学区栋信息
		List<Object[]> dongs = xhjLpxxService.getDongOfLp(lpid);
		int i=0;
		String json = "[";
		for(Object[] temp : dongs){
			if(checkedDong.contains(temp[0])) {
				json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\",\"checked\":" + true + "}";
			} else {
				json += (i==0?"":",") + "{\"id\":"+ temp[0] +",\"lpdName\":\""+ temp[1] +"\",\"checked\":" + false + "}";
			}
			i++;
		}
		json += "]";
		return jsonAjaxResult(json);
	};
	/**
	 * 加载楼盘的所有划分盘
	 * @return
	 */
	public String loadLpFuzh(){
		//TODO
		if(pageInfo == null){
			pageInfo = new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(10);
		}
		String lpid = this.getRequest().getParameter("lpid");
		String findsta = this.getRequest().getParameter("findsta");
		String bmid = this.getRequest().getParameter("bmid");
		pageInfo = xhjLpxxService.loadLpFuzh(pageInfo, lpid, findsta, bmid);
		return jsonAjaxResult(JSON.toJSONString(pageInfo));
	};
	
	public String deleteLpFuzh(){
		String json = "{\"data\" : \"success\"}";
		try {
			xhjLpxxService.deleteLpFuzh(this.getRequest());
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	/**
	 * 国家
	 * @return
	 */
	public String getCountryInfo(){
		return jsonAjaxResult(JSON.toJSONString(lpCountryService.findAll()));
	}
	/**
	 * 省份
	 * @return
	 */
	public String getPro(){
		String countryId = this.getRequest().getParameter("cid");
		return jsonAjaxResult(JSON.toJSONString(lpProvinceService.findByCountryId(countryId)));
	}
	/**
	 * 城市
	 * @return
	 */
	public String getCity(){
		String provinceId = this.getRequest().getParameter("pid");
		return jsonAjaxResult(JSON.toJSONString(xhjJccityService.findByProvinceId(provinceId)));
	}
	/**
	 * 区域
	 * @return
	 */
	public String getQy(){
		String cityId = this.getRequest().getParameter("cid");
		return jsonAjaxResult(JSON.toJSONString(xhjJcStressService.findByCityId(cityId)));
	}
	/**
	 * 商圈
	 * @return
	 */
	public String getSq(){
		String stressId = this.getRequest().getParameter("stressId");
		return jsonAjaxResult(JSON.toJSONString(xhjJcsqService.findByQyid(stressId)));
	}
	/**
	 * 获取系统参数
	 * @return
	 */
	public String getSyscs(){
		int sid = Integer.valueOf(this.getRequest().getParameter("sid"));
		return jsonAjaxResult(JSON.toJSONString(lpSyscs1Service.getSyscs1es(sid)));
	}
	/**
	 * 查询维护单位信息
	 * @return
	 */
	public String queryLpMaintenanceUnit(){
		if(pageInfo==null){
			pageInfo=new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		try{
			String lpid = this.getRequest().getParameter("lpid");
			pageInfo=this.lpMaintenanceUnitService.queryLpMaintenanceUnit(pageInfo, Integer.valueOf(lpid));
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
		
	}
	/**
	 * 查询居住成本信息
	 * @return
	 */
	public String queryLpCostLiving(){
		if(pageInfo==null){
			pageInfo=new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		try{
			String lpid = this.getRequest().getParameter("lpid");
			pageInfo =this.lpCostLivingService.queryLpCostLiving(pageInfo, Integer.valueOf(lpid));
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	
	public String fangwquxian(){
		
		String lpid = this.getRequest().getParameter("lpid");
		String zt = this.getRequest().getParameter("zt");
		List<Object> qblist = this.xhjLpxxService.fangwquxian(DateUtils.getYeay(),Integer.valueOf(lpid),0);
		List<Object>  cslist  = this.xhjLpxxService.fangcsquxian(DateUtils.getYeay(),Integer.valueOf(lpid),0,1);
		List<Object>  czlist  = this.xhjLpxxService.fangcsquxian(DateUtils.getYeay(),Integer.valueOf(lpid),0,2);
		
			this.bindParam("ldqianxian",qblist);
			this.bindParam("ldcsquxian",cslist);
			this.bindParam("ldczquxian",czlist);
			this.bindParam("zt", zt);
		
		return "quxianld";
	}
	
	public String lpcjquxian(){
	
		String lpid = this.getRequest().getParameter("lpid");
		String shi = this.getRequest().getParameter("shi");
		List<Object> junjialist  = this.xhjLpxxService.cjjunjiaquxian(DateUtils.getYeay(),Integer.valueOf(lpid),Integer.valueOf(shi),1);
		List<Object> cslist  = this.xhjLpxxService.fangcsquxian(DateUtils.getYeay(),Integer.valueOf(lpid),Integer.valueOf(shi),1);
		this.bindParam("junjialist",junjialist);
		this.bindParam("cslist",cslist);
		return "quxiancj";
	}
	
	public String lpczcjquxian(){
		///DateUtils.getYeay()
		String lpid = this.getRequest().getParameter("lpid");
		String shi = this.getRequest().getParameter("shi");
		List<Object> junjialistcz  = this.xhjLpxxService.cjjunjiaquxian(DateUtils.getYeay(),Integer.valueOf(lpid),Integer.valueOf(shi),2);
		List<Object> czlist  = this.xhjLpxxService.fangcsquxian(DateUtils.getYeay(),Integer.valueOf(lpid),Integer.valueOf(shi),2);
		this.bindParam("junjialistcz",junjialistcz);
		this.bindParam("czlist",czlist);
		return "quxiancjcz";
	}
	
	public String queryLpReview(){
		if(pageInfo==null){
			pageInfo=new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		try{
			String lpid = this.getRequest().getParameter("lpid");
			pageInfo =this.xhjLpxxService.queryLpReview(pageInfo, Integer.valueOf(lpid));
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	
	public String queryLpzj(){
		if(pageInfo==null){
			pageInfo=new PageInfo();
			pageInfo.setPage(1);
			pageInfo.setRows(5);
		}
		try{
			String lpid = this.getRequest().getParameter("lpid");
			pageInfo =this.xhjLpxxService.queryLpzj(pageInfo, Integer.valueOf(lpid));
			return jsonAjaxResult(JSON.toJSONString(pageInfo));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	
	public  String  getDongId(){
		String dzid = this.getRequest().getParameter("dzid");
		XhjLpdong entity =  this.xhjLpxxService.getDongId(Integer.valueOf(dzid));
		return jsonAjaxResult(JSON.toJSONString(entity));
	}
	
	public  String  getDyyuanId(){
		String dyid = this.getRequest().getParameter("dyid");
		XhjLpdanyuan entity =  this.xhjLpxxService.getDyyuanId(Integer.valueOf(dyid));
		return jsonAjaxResult(JSON.toJSONString(entity));
	}
	
	public  String  getFangHaoId(){
		String fangId = this.getRequest().getParameter("fangId");
		XhjLpfanghao entity =  this.xhjLpxxService.getFangHaoId(Integer.valueOf(fangId));
		return jsonAjaxResult(JSON.toJSONString(entity));
	}
	
	/**
	 * 保存完成度
	 * @return
	 */
	public String saveLpFinsh(){
		String json = "{\"data\" : \"success\"}";
		try {
			Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
			lpfinshService.saveLpFinshs(lpid, lpfinsh);
		} catch (Exception e) {
			json = "{\"data\" : \""+e.getMessage()+"\"}";
		}
		return jsonAjaxResult(json);
	};
	
	
	public String queryCtype(){
		String ctype = this.getRequest().getParameter("ctype");
		return jsonAjaxResult(JSON.toJSONString(xhjLpxxService.queryCtype(ctype)));
		}
	public String  querylpFinshs (){
		Integer lpid = Integer.valueOf(this.getRequest().getParameter("lpid"));
		List<LpFinsh> lpFinshs= lpfinshService.querylpFinshs(lpid);
		return jsonAjaxResult(JSON.toJSONString(lpFinshs));
	}
	
	public LpCountryService getLpCountryService() {
		return lpCountryService;
	}

	public void setLpCountryService(LpCountryService lpCountryService) {
		this.lpCountryService = lpCountryService;
	}
	
	public LpProvinceService getLpProvinceService() {
		return lpProvinceService;
	}

	public void setLpProvinceService(LpProvinceService lpProvinceService) {
		this.lpProvinceService = lpProvinceService;
	}

	public XhjJccityService getXhjJccityService() {
		return xhjJccityService;
	}

	public void setXhjJccityService(XhjJccityService xhjJccityService) {
		this.xhjJccityService = xhjJccityService;
	}

	public XhjJcstressService getXhjJcStressService() {
		return xhjJcStressService;
	}

	public void setXhjJcStressService(XhjJcstressService xhjJcStressService) {
		this.xhjJcStressService = xhjJcStressService;
	}

	public XhjJcsqService getXhjJcsqService() {
		return xhjJcsqService;
	}

	public void setXhjJcsqService(XhjJcsqService xhjJcsqService) {
		this.xhjJcsqService = xhjJcsqService;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public XhjLpxxService getXhjLpxxService() {
		return xhjLpxxService;
	}

	public void setXhjLpxxService(XhjLpxxService xhjLpxxService) {
		this.xhjLpxxService = xhjLpxxService;
	}

	public LpSyscs1Service getLpSyscs1Service() {
		return lpSyscs1Service;
	}

	public void setLpSyscs1Service(LpSyscs1Service lpSyscs1Service) {
		this.lpSyscs1Service = lpSyscs1Service;
	}
	
	public XhjLptpService getXhjLptpService() {
		return xhjLptpService;
	}

	public void setXhjLptpService(XhjLptpService xhjLptpService) {
		this.xhjLptpService = xhjLptpService;
	}

	public XhjLpxx getQueryLpxx() {
		return queryLpxx;
	}

	public void setQueryLpxx(XhjLpxx queryLpxx) {
		this.queryLpxx = queryLpxx;
	}

	public XhjLpxx getLpxx() {
		return lpxx;
	}

	public void setLpxx(XhjLpxx lpxx) {
		this.lpxx = lpxx;
	}
	
	public int[] getIds() {
		return ids;
	}

	public void setIds(int[] ids) {
		this.ids = ids;
	}

	public XhjLpWuYeService getXhjLpWuYeService() {
		return xhjLpWuYeService;
	}
	
	public void setXhjLpWuYeService(XhjLpWuYeService xhjLpWuYeService) {
		this.xhjLpWuYeService = xhjLpWuYeService;
	}

	public XhjLpwuye getWyxx() {
		return wyxx;
	}

	public void setWyxx(XhjLpwuye wyxx) {
		this.wyxx = wyxx;
	}

	public List<XhjLptp> getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(List<XhjLptp> imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public XhjLpfanghaoService getXhjLpfanghaoService() {
		return xhjLpfanghaoService;
	}

	public void setXhjLpfanghaoService(XhjLpfanghaoService xhjLpfanghaoService) {
		this.xhjLpfanghaoService = xhjLpfanghaoService;
	}

	public LpReview getLpReview() {
		return lpReview;
	}

	public void setLpReview(LpReview lpReview) {
		this.lpReview = lpReview;
	}

	

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getLpId() {
		return lpId;
	}

	public void setLpId(String lpId) {
		this.lpId = lpId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LpMaintenanceUnitService getLpMaintenanceUnitService() {
		return lpMaintenanceUnitService;
	}

	public void setLpMaintenanceUnitService(
			LpMaintenanceUnitService lpMaintenanceUnitService) {
		this.lpMaintenanceUnitService = lpMaintenanceUnitService;
	}

	public LpCostLivingService getLpCostLivingService() {
		return lpCostLivingService;
	}

	public void setLpCostLivingService(LpCostLivingService lpCostLivingService) {
		this.lpCostLivingService = lpCostLivingService;
	}

	public String getLpLtype() {
		return lpLtype;
	}

	public void setLpLtype(String lpLtype) {
		this.lpLtype = lpLtype;
	}

	public List<LpFinsh> getLpfinsh() {
		return lpfinsh;
	}

	public void setLpfinsh(List<LpFinsh> lpfinsh) {
		this.lpfinsh = lpfinsh;
	}

	public LpfinshService getLpfinshService() {
		return lpfinshService;
	}

	public void setLpfinshService(LpfinshService lpfinshService) {
		this.lpfinshService = lpfinshService;
	}
	
	
}
