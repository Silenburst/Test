package com.newenv.lpzd.lp.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.LpHouseOperationLogDao;
import com.newenv.lpzd.lp.dao.LpOperationLogDao;
import com.newenv.lpzd.lp.dao.LpReviewDao;
import com.newenv.lpzd.lp.dao.XhjLcfz1Dao;
import com.newenv.lpzd.lp.dao.XhjLcfzDao;
import com.newenv.lpzd.lp.dao.XhjLpDanyuanDao;
import com.newenv.lpzd.lp.dao.XhjLpdongDao;
import com.newenv.lpzd.lp.dao.XhjLpfanghaoDao;
import com.newenv.lpzd.lp.dao.XhjLplinkshoolDao;
import com.newenv.lpzd.lp.dao.XhjLplinkxianluDao;
import com.newenv.lpzd.lp.dao.XhjLpxxDao;
import com.newenv.lpzd.lp.domain.LpReview;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.lpzd.lp.domain.vo.XhjLpxxVo;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class XhjLpxxService {
	private XhjLpxxDao xhjLpxxDao;
	private XhjLpdongDao xhjLpdongDao;
	private XhjLpDanyuanDao xhjLpDanyuanDao;
	private XhjLpfanghaoDao xhjLpfanghaoDao;
	private XhjLplinkxianluDao xhjLplinkxianluDao;
	private XhjLplinkshoolDao xhjLplinkshoolDao;
	private LpOperationLogDao operationLogDao; 
	private XhjLcfzDao xhjLcfzDao;
	private XhjLcfz1Dao xhjLcfz1Dao;
	private LpHouseOperationLogDao lpHouseOperationLogDao; 
	private LpReviewDao lpReviewDao;

	public LpReviewDao getLpReviewDao() {
		return lpReviewDao;
	}

	public void setLpReviewDao(LpReviewDao lpReviewDao) {
		this.lpReviewDao = lpReviewDao;
	}

	public XhjLpxxDao getXhjLpxxDao() {
		return xhjLpxxDao;
	}

	public void setXhjLpxxDao(XhjLpxxDao xhjLpxxDao) {
		this.xhjLpxxDao = xhjLpxxDao;
	}
	
	public XhjLpdongDao getXhjLpdongDao() {
		return xhjLpdongDao;
	}

	public void setXhjLpdongDao(XhjLpdongDao xhjLpdongDao) {
		this.xhjLpdongDao = xhjLpdongDao;
	}

	public XhjLpDanyuanDao getXhjLpDanyuanDao() {
		return xhjLpDanyuanDao;
	}

	public void setXhjLpDanyuanDao(XhjLpDanyuanDao xhjLpDanyuanDao) {
		this.xhjLpDanyuanDao = xhjLpDanyuanDao;
	}

	public XhjLpfanghaoDao getXhjLpfanghaoDao() {
		return xhjLpfanghaoDao;
	}

	public void setXhjLpfanghaoDao(XhjLpfanghaoDao xhjLpfanghaoDao) {
		this.xhjLpfanghaoDao = xhjLpfanghaoDao;
	}

	public XhjLplinkxianluDao getXhjLplinkxianluDao() {
		return xhjLplinkxianluDao;
	}

	public void setXhjLplinkxianluDao(XhjLplinkxianluDao xhjLplinkxianluDao) {
		this.xhjLplinkxianluDao = xhjLplinkxianluDao;
	}

	public XhjLplinkshoolDao getXhjLplinkshoolDao() {
		return xhjLplinkshoolDao;
	}

	public void setXhjLplinkshoolDao(XhjLplinkshoolDao xhjLplinkshoolDao) {
		this.xhjLplinkshoolDao = xhjLplinkshoolDao;
	}

	public LpOperationLogDao getOperationLogDao() {
		return operationLogDao;
	}

	public void setOperationLogDao(LpOperationLogDao operationLogDao) {
		this.operationLogDao = operationLogDao;
	}

	public XhjLcfzDao getXhjLcfzDao() {
		return xhjLcfzDao;
	}

	public void setXhjLcfzDao(XhjLcfzDao xhjLcfzDao) {
		this.xhjLcfzDao = xhjLcfzDao;
	}

	public XhjLcfz1Dao getXhjLcfz1Dao() {
		return xhjLcfz1Dao;
	}

	public void setXhjLcfz1Dao(XhjLcfz1Dao xhjLcfz1Dao) {
		this.xhjLcfz1Dao = xhjLcfz1Dao;
	}

	public XhjLpxx getById(Integer id){
		return xhjLpxxDao.getById(id, DAOConstants.RELATIONAL);
	}
	
	public LpHouseOperationLogDao getLpHouseOperationLogDao() {
		return lpHouseOperationLogDao;
	}

	public void setLpHouseOperationLogDao(
			LpHouseOperationLogDao lpHouseOperationLogDao) {
		this.lpHouseOperationLogDao = lpHouseOperationLogDao;
	}

	public List<XhjLpxx>  fianAll(){
		List<XhjLpxx> xhjLpxxList = xhjLpxxDao.fianAll(DAOConstants.RELATIONAL);
		return xhjLpxxList;
	}
	
	public List  getByXhjLpxx(){
		List xhjLpxxList = xhjLpxxDao.getByXhjLpxx(DAOConstants.RELATIONAL);
		return xhjLpxxList;
	}
	
	public List  getByXhjLptp(Integer lpid){
		List xhjLptpList = xhjLpxxDao.getByXhjLptp(lpid, DAOConstants.RELATIONAL);
		return xhjLptpList;
	}
	public PageInfo queryData(XhjLpxx xhjLpxx, PageInfo pageInfo){
		return xhjLpxxDao.queryData(xhjLpxx, pageInfo);
	}
	
	public PageInfo querySimpleLpxx(PageInfo pager, XhjLpxx lpxx, int[] sqIds){
		return xhjLpxxDao.querySimpleLpxx(pager, lpxx, sqIds, DAOConstants.RELATIONAL);
	}
	
	public PageInfo getLpmanagexx(PageInfo pager, CheckCondition condition) {
		return xhjLpxxDao.getLpmanagexx(pager, condition, DAOConstants.RELATIONAL);
	}
	
	public PageInfo queryCheckList(PageInfo pager, CheckCondition condition) {
		return xhjLpxxDao.queryCheckList(pager, condition, DAOConstants.RELATIONAL);
	}
	
	public List<Object[]> getDongOfLp(int lpid){
		return xhjLpxxDao.getDongOfLp(lpid, DAOConstants.RELATIONAL);
	}
	
	public List<Object[]> getFanghao(Integer dyId, Integer ceng) {
		return xhjLpxxDao.getFanghao(dyId, ceng, DAOConstants.RELATIONAL);
	}
	
	public XhjLpfanghao findFanghaoById(Integer fanghId) {
		return xhjLpfanghaoDao.findFanghaoById(fanghId, DAOConstants.RELATIONAL);
	}

	public List<Object[]> showCorHouseInit(String fanghId) {
		return xhjLpxxDao.showCorHouseInit(fanghId, DAOConstants.RELATIONAL);
	};
	/**
	 * 根据单元ID显示所有的房源
	 * @param danyuanID
	 * @return
	 */
	public 	List<Object[]> showCorHouseInitDanYan(String danyuanID)
	{
		return xhjLpxxDao.showCorHouseInitDanYan(danyuanID, DAOConstants.RELATIONAL);
	}
	public String saveLpxx(XhjLpxx lpxx) throws Exception {
		boolean flag = false;
		if(lpxx.getId() == null) {
			flag = true;
		}
		String lpid = xhjLpxxDao.saveLpxx(lpxx, DAOConstants.RELATIONAL);
		if(flag) {
			String message = "新增[" + lpxx.getLpName() + "]楼盘信息";
			setLog("LP10001", message, lpid);
		} else {
			String message = "修改[" + lpxx.getLpName() + "]楼盘信息";
			setLog("LP10002", message, lpid);
		}
		return lpid;
	}
	public List<Object[]> getBYLpId(Integer lpId){ 
		return (List<Object[]>)xhjLpdongDao.getBYLpId(lpId, DAOConstants.RELATIONAL);
	}
	public List<Object[]> getBYdzId(Integer dzId){
		return (List<Object[]>)xhjLpDanyuanDao.getBYdzId(dzId, DAOConstants.RELATIONAL);
	}
	public void saveLpDong(XhjLpdong xhjLpdong) throws Exception {
		if(xhjLpdong.getType() != null && "Single".equals(xhjLpdong.getType())) {
			xhjLpdongDao.saveLpDongSingle(xhjLpdong, DAOConstants.RELATIONAL);
			String message = "单个新增[" + xhjLpdong.getLpdName() + "]栋座信息";
			setLog("LP30001", message, xhjLpdong.getLpId().toString());
		} else {
			xhjLpdongDao.saveLpDongBatch(xhjLpdong, DAOConstants.RELATIONAL);
			String message = "批量新增[" + xhjLpdong.getPrefix() + xhjLpdong.getStart() + "-" + xhjLpdong.getEnd() + xhjLpdong.getSuffix() + "]栋座信息";
			setLog("LP30002", message, xhjLpdong.getLpId().toString());
		}
	}

	public void updLpDong(XhjLpdong xhjLpdong) throws Exception {
		xhjLpdongDao.updLpDong(xhjLpdong, DAOConstants.RELATIONAL);
		String message = "修改[" + xhjLpdong.getLpdName() + "]栋座信息";
		setLog("LP30003", message, xhjLpdong.getLpId().toString());
	}

	public List<Object[]> getDanYuan(Integer dzid) {
		return xhjLpxxDao.getDanYuan(dzid, DAOConstants.RELATIONAL);
	}
	
	
	public List<Object[]> getCeng(Integer dyid) {
		return xhjLpxxDao.getCeng(dyid, DAOConstants.RELATIONAL);
	}
	
	public List<Object[]> getSchoolCeng(Integer dyid) {
		return xhjLpxxDao.getSchoolCeng(dyid, DAOConstants.RELATIONAL);
	}

	public void saveDany(XhjLpdanyuan xhjLpdanyuan,String lpid) throws Exception{
		if(xhjLpdanyuan.getType() != null && "Single".equals(xhjLpdanyuan.getType())) {
			xhjLpDanyuanDao.saveLpDanySingle(xhjLpdanyuan, DAOConstants.RELATIONAL);
			String message = "单个新增[" + xhjLpdanyuan.getDyName() + "]单元信息";
			setLog("LP30011", message, lpid);
		} else {
			xhjLpDanyuanDao.saveLpDanyBatch(xhjLpdanyuan, DAOConstants.RELATIONAL);
			String message = "批量新增[" + xhjLpdanyuan.getPrefix() + xhjLpdanyuan.getStart() + "-" + xhjLpdanyuan.getEnd() + xhjLpdanyuan.getSuffix() + "]单元信息";
			setLog("LP30012", message, lpid);
		}
		
	}

	public void updLpDany(String lpid,XhjLpdanyuan xhjLpdanyuan) throws Exception {
		xhjLpDanyuanDao.updLpDany(xhjLpdanyuan, DAOConstants.RELATIONAL);
		String message = "修改[" + xhjLpdanyuan.getDyName() + "]单元信息";
		setLog("LP30013", message, lpid);
	}

	public void saveFanghao(String datas, String type, int userid,XhjLpfanghao xhjLpfanghao) throws Exception {
		if(type != null && "Single".equals(type)) {
			String fanghid = xhjLpfanghaoDao.saveFanghaoSingle(userid ,xhjLpfanghao,DAOConstants.RELATIONAL);
			String message = "单个新增[" + xhjLpfanghao.getFangHao() + "]房号信息";
			setFanghLog("FH1001", message, fanghid);
		} else {
			String fanghid = xhjLpfanghaoDao.saveFanghaoBatch(datas, userid ,xhjLpfanghao, DAOConstants.RELATIONAL);
			String[] ss = fanghid.split(",");
			for (int i = 0; i < ss.length; i++) {
				String message = "批量新增房号信息";
				setFanghLog("FH1002", message, ss[i]);
			}
		}
	}

	public void doUpdateFanghao(XhjLpfanghao xhjLpfanghao) throws Exception{
		xhjLpfanghaoDao.doUpdateFanghao(xhjLpfanghao, DAOConstants.RELATIONAL);
		String message = "修改[" + xhjLpfanghao.getFangHao() + "]房号信息";
		setFanghLog("FH1003", message, xhjLpfanghao.getLpid().toString());
	}

	public void deleteFangh(String lpid, String id) {
		String fanghName = xhjLpfanghaoDao.deleteFangh(id, DAOConstants.RELATIONAL);
		String message = "删除[" + fanghName + "]房号信息";
		setFanghLog("FH1004", message, lpid);
	}

	public void deleteDany(String lpid, String id) throws Exception {
		String danyName = xhjLpDanyuanDao.deleteDany(id, DAOConstants.RELATIONAL);
		String message = "删除[" + danyName + "]单元信息";
		setLog("LP30014", message, lpid);
	}

	public void deleteDong(String lpid, String id) throws Exception{
		String donaName = xhjLpdongDao.deleteDany(id, DAOConstants.RELATIONAL);
		String message = "删除[" + donaName + "]栋信息";
		setLog("LP30004", message, lpid);
	}

	public List<Object[]> findMotors() {
		return xhjLpxxDao.findMotors(DAOConstants.RELATIONAL);
	}

	public List<Object[]> findLoadZhan(String xid) {
		return xhjLpxxDao.findLoadZhan(xid, DAOConstants.RELATIONAL);
	}
	/**
	 * 添加楼盘对应地铁站
	 * @return
	 */
	public void saveLpZhan(String lpid, String zhanids) {
		xhjLplinkxianluDao.saveLpZhan(lpid, zhanids, DAOConstants.RELATIONAL);
		String message = "新增[" + zhanids + "]地铁信息";
		setLog("LP50001", message, lpid);
	}
	/**
	 * 显示楼盘地铁站
	 * @return
	 */
	public List<Object[]> showLpZhan(String lpid) {
		return xhjLplinkxianluDao.showLpZhan(lpid, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除楼盘对应地铁线
	 * @param lpid
	 * @param zhanid
	 */
	public void deleteLpZhan(String lpid, String zhanid) {
		String zhanName = xhjLplinkxianluDao.showLpZhan(lpid, zhanid, DAOConstants.RELATIONAL);
		String message = "删除[" + zhanName + "]地铁信息";
		setLog("LP50003", message, lpid);
	}
	/**
	 * 获取某个参数表的所有子参数
	 * @return
	 */
	public List<Object[]> getSyscs(String sid) {
		// TODO Auto-generated method stub
		return xhjLpxxDao.getSyscs(sid, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个参数表的所有供***子参数
	 * @return
	 */
	public List<Object[]> getSyscsParams(String name) {
		// TODO Auto-generated method stub
		return xhjLpxxDao.getSyscsParams(name, DAOConstants.RELATIONAL);
	}

	public List<Object[]> showSchoolDetail(String schoolType) {
		return xhjLpxxDao.showSchoolDetail(schoolType, DAOConstants.RELATIONAL);
	}
	/**
	 * 保存学校信息
	 * @param request
	 * @throws Exception
	 */
	public void saveLpSchool(HttpServletRequest request) throws Exception {
		String lpid = request.getParameter("lpid");
		String dongIds = request.getParameter("dongIds");
		String schoolid = request.getParameter("schoolid");
		String schoolType = request.getParameter("schoolType");
		String dongNames = request.getParameter("dongNames");
		String ids = request.getParameter("idss");
		if(ids != null && !"".equals(ids)) {
			String[] idp = ids.split(",");
			ids = "";
			for (int i = 0; i < idp.length; i++) {
				if(idp[i].indexOf("Y") == -1 && idp[i].indexOf("C") == -1){
					ids += ("".equals(ids) ? "" : ",") + idp[i];
				};
			}
		}
		String names = request.getParameter("names");
		xhjLplinkshoolDao.saveLpSchool(lpid, dongIds, dongNames, ids, names, schoolid, schoolType, DAOConstants.RELATIONAL);
		if(dongIds != null && !"".equals(dongIds) && ids != null && !"".equals(ids)) {
			String message = "新增划片学区和学号信息";
			setLog("LP40001", message, lpid);
		} else if(dongIds != null && !"".equals(dongIds)){
			String message = "新增划片学区信息";
			setLog("LP40002", message, lpid);
		} else if(ids != null && !"".equals(ids)){
			String message = "新增划片学号信息";
			setLog("LP40003", message, lpid);
		};
	};
	/**
	 * 修改学校信息
	 * @param request
	 * @throws Exception
	 */
	public void updLpSchool(HttpServletRequest request) throws Exception {
		String id = request.getParameter("lpsid");
		String schoolid = request.getParameter("schoolid");
		String schoolType = request.getParameter("schoolType");
		String dongIds = request.getParameter("dongIds");
		String dongNames = request.getParameter("dongNames");
		String type = request.getParameter("lpsType");
		String lpid= request.getParameter("lpid");
		if("2".equals(type)) {
			if(dongIds != null && !"".equals(dongIds)) {
				String[] idp = dongIds.split(",");
				dongIds = "";
				for (int i = 0; i < idp.length; i++) {
					if(idp[i].indexOf("Y") == -1 && idp[i].indexOf("C") == -1){
						dongIds += ("".equals(dongIds) ? "" : ",") + idp[i];
					};
				}
			}
		}
		xhjLplinkshoolDao.updLpSchool(id, schoolid, schoolType,dongIds , dongNames, DAOConstants.RELATIONAL);
		String message = "修改划片学区和学号信息";
		setLog("LP40004", message, lpid);
	};
	/**
	 * 删除某楼盘学校信息
	 * @param lpsid
	 */
	public void deleteLpSchool(Integer lpsid, String lpid) {
		xhjLplinkshoolDao.deleteLpSchool(lpsid, DAOConstants.RELATIONAL);
		String message = "删除划片学区学号["+lpsid+"]ID信息";
		setLog("LP40005", message, lpid);
	}
	
	/**
	 * 删除申请的楼盘采集记录。
	 * @param id
	 */
	public void deleteByCheckStatus(Integer id){
		xhjLpxxDao.deleteByCheckStatus(id, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 审核通过楼盘采集。
	 * @param lpxx
	 */
	public void shenhe(XhjLpxx lpxx){
		xhjLpxxDao.shenhe(lpxx, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 驳回楼盘采集。
	 * @param lpxx
	 */
	public void bohui(XhjLpxx lpxx){
		xhjLpxxDao.bohui(lpxx, DAOConstants.RELATIONAL);
	}
	/**
	 * 楼盘对应的学校
	 * @param lpid
	 * @return
	 */
	public List<Object[]> loadLpSchoolInfo(Integer lpid) {
		return xhjLpxxDao.loadLpSchoolInfo(lpid, DAOConstants.RELATIONAL);
	}

	public String getLpSchoolXqUpd(String id, String col) {
		return xhjLpxxDao.getLpSchoolXqUpd(id, col, DAOConstants.RELATIONAL);
	}
	/**
	 * 保存责任盘
	 * @param request
	 */
	public void saveZeren(HttpServletRequest request) {
		String sta = request.getParameter("sta");
		String source = request.getParameter("source");
		String addZrService = request.getParameter("addZrService");
		String dongIds = request.getParameter("dongIds");
		String lpid = request.getParameter("lpid");
		xhjLcfzDao.saveZeren(lpid, sta, source, addZrService, dongIds, DAOConstants.RELATIONAL);
		String message = "新增["+addZrService+"]责任盘信息";
		setLog("LP60001", message, lpid);
	}
	/**
	 * 保存维护盘和范围盘
	 * @param request
	 */
	public void saveWeih(HttpServletRequest request) {
		String sta = request.getParameter("sta");
		String source = request.getParameter("source");
		String addZrService = request.getParameter("addZrService");
		String lpid = request.getParameter("lpid");
		xhjLcfz1Dao.saveWeih(lpid, sta, source, addZrService, DAOConstants.RELATIONAL);
		if("2".equals(sta)){
			String message = "新增["+addZrService+"]网点范围盘信息";
			setLog("LP60011", message, lpid);
		} else {
			String message = "新增["+addZrService+"]网点范围盘信息";
			setLog("LP60021", message, lpid);
		}
	}
	/**
	 * 获取某个部门下责任盘对应的栋
	 * @param lpid
	 * @param bmid
	 * @return
	 */
	public List<Object> getLpBmFuzhInfo(Integer lpid, String bmid) {
		return xhjLpxxDao.getLpBmFuzhInfo(lpid, bmid, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改划盘信息
	 * @param request
	 * @throws Exception
	 */
	public void updLpFuzh(HttpServletRequest request) throws Exception {
		String lppid = request.getParameter("lppid");
		String sta = request.getParameter("sta");
		String source = request.getParameter("source");
		String bmid = request.getParameter("bmid");
		String dongIds = request.getParameter("dongIds");
		String lpid = request.getParameter("lpid");
		if("1".equals(sta)) {
			xhjLcfzDao.updZeren(lpid, bmid, source, dongIds, lppid, DAOConstants.RELATIONAL);
			String message = "修改["+bmid+"]网点范围盘信息";
			setLog("LP60002", message, lpid);
		} else {
			xhjLcfz1Dao.updWeih(lpid, bmid, source, lppid, sta, DAOConstants.RELATIONAL);
			if("2".equals(sta)){
				String message = "修改["+bmid+"]网点范围盘信息";
				setLog("LP60012", message, lpid);
			} else {
				String message = "修改["+bmid+"]网点范围盘信息";
				setLog("LP60022", message, lpid);
			}
		}
		
	}

	/**
	 * 删除划盘信息
	 * @param request
	 * @throws Exception 
	 */
	public void deleteLpFuzh(HttpServletRequest request) throws Exception {
		String lppid = request.getParameter("lppid");
		String sta = request.getParameter("sta");
		String bmid = request.getParameter("bmid");
		String lpid = request.getParameter("lpid");
		if("1".equals(sta)) {
			xhjLcfzDao.deleteLpFuzh(lpid, bmid, DAOConstants.RELATIONAL);
			String message = "删除["+bmid+"]网点范围盘信息";
			setLog("LP60003", message, lpid);
		} else {
			xhjLcfz1Dao.deleteLpFuzh(lppid, DAOConstants.RELATIONAL);
			if("2".equals(sta)){
				String message = "删除["+bmid+"]网点范围盘信息";
				setLog("LP60013", message, lpid);
			} else {
				String message = "删除["+bmid+"]网点范围盘信息";
				setLog("LP60023", message, lpid);
			}
		}
	}
	
	/**
	 * 修改查询对应楼盘信息
	 * @param lpid
	 */
	public XhjLpxx queryLpxx(Integer lpid) {
		return xhjLpxxDao.getById(lpid, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询对应楼盘信息
	 * @param lpid
	 */
	public XhjLpxxVo queryLpxx2(Integer lpid){
		return xhjLpxxDao.getById2(lpid, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某楼盘下的所有划分盘
	 * @param lpid
	 * @return
	 */
	public PageInfo loadLpFuzh(PageInfo pageInfo, String lpid, String findsta, String bmid) {
		return xhjLpxxDao.loadLpFuzh(pageInfo, lpid, findsta, bmid, DAOConstants.RELATIONAL);
	}
	//操作日志
	private void setLog(String type, String message, String lpid){
		operationLogDao.addLpLog(type, message, lpid);
	}
	//操作日志
	private void setFanghLog(String type, String message, String fanghid){
		lpHouseOperationLogDao.addLpLog(type, message, fanghid);
	}
	/**
	 * 查询操作日志
	 * @return
	 */
	public PageInfo findByLpLog(PageInfo pageInfo, int lpid) {
		return xhjLpxxDao.findByLpLog(pageInfo, lpid, DAOConstants.RELATIONAL);
	}

	public void delLpxx(Integer lpid) {
		xhjLpxxDao.delLpxx(lpid, DAOConstants.RELATIONAL);
	}

	public List<Object> queryCount(Integer lpid) {
		return xhjLpxxDao.queryCount(lpid, DAOConstants.RELATIONAL);
	}
	public List<Object> queryCount2(Integer lpid){
		return xhjLpxxDao.queryCount2(lpid, DAOConstants.RELATIONAL);
	}
 
	public PageInfo queryFanghaoInfo(PageInfo pageInfo, String lpid,
			String dzid, String dyid, String ceng, String fwzt, String source) {
		return xhjLpxxDao.queryFanghaoInfo(pageInfo, lpid, dzid, dyid, ceng, fwzt, source, DAOConstants.RELATIONAL);
	}
	/**
	 * 锁盘
	 * @param ids
	 */
	public void batchLock(String ids) {
		xhjLpxxDao.batchLock(ids, DAOConstants.RELATIONAL);
	}
	public List<XhjLpxx> getByLpName(String lpName){
		return xhjLpxxDao.getByLpName(lpName,DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询某城市下包含楼盘名的楼盘.
	 * @param cityId
	 * @param lpName
	 * @return
	 */
	public List<XhjLpxx> findByLpName(Integer cityId, String lpName){
		return xhjLpxxDao.findByLpName(cityId, lpName, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询楼盘根据名称
	 * @return
	 */
	public List<XhjLpxx> queryLpByName(Integer bmid,Integer cityId,String name)
	{	
		return xhjLpxxDao.queryLpByName(bmid, cityId, name);
	}
	
	
	/**
	 * 获取某个城市的楼盘。
	 * @param cityId
	 * @return
	 */
	public List<XhjLpxx> findByCity(Integer cityId){
		return xhjLpxxDao.findByCity(cityId, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个区域的楼盘。
	 * @param stressId
	 * @return
	 */
	public List<XhjLpxx> findByStress(Integer stressId){
		return xhjLpxxDao.findByStress(stressId, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个商圈的楼盘。
	 * @param stressId
	 * @return
	 */
	public List<XhjLpxx> findBySq(Integer sqId){
		return xhjLpxxDao.findBySq(sqId, DAOConstants.RELATIONAL);
	}
	/**
	 * 保存楼盘栋座备注
	 */
	public void saveDzRemark(Integer lpid, String dzRemark) {
		xhjLpxxDao.saveDzRemark(lpid, dzRemark, DAOConstants.RELATIONAL);
	}
	/**
	 * 批量删除房号
	 * @param idsi
	 */
	public void batchDeleteFangh(String idsi,String lpid) {
		xhjLpfanghaoDao.batchDeleteFangh(idsi, DAOConstants.RELATIONAL);
		String message = "批量删除[" + idsi + "]房号信息";
		setFanghLog("FH1005", message, lpid);
	}
	public  void saveLpReview(LpReview lpReview){
		lpReviewDao.saveLpReview(lpReview, DAOConstants.RELATIONAL);
	}
	
	public PageInfo queryLpdongInfo(PageInfo  pageInfo,String  lpid){
		return xhjLpxxDao.queryLpdongInfo(pageInfo, lpid, DAOConstants.RELATIONAL);
	}
	
	public List<Object>  fangwquxian(Integer years,Integer lpid,Integer shi){
		return xhjLpxxDao.fangwquxian(years,lpid,shi,DAOConstants.RELATIONAL);
	}
	
	public List<Object>  fangcsquxian(Integer years,Integer lpid,Integer shi,Integer contype){
		return xhjLpxxDao.fangcsquxian(years,lpid,shi,contype,DAOConstants.RELATIONAL);
	}
	
	public List<Object>  fangczquxian(Integer years,Integer lpid,Integer shi){
		return xhjLpxxDao.fangczquxian(years,lpid,shi,DAOConstants.RELATIONAL);
	}
	
	public PageInfo  queryLpReview(PageInfo pageInfo ,Integer lpid){
		return this.lpReviewDao.queryLpReview(pageInfo,lpid);
	}
	
	public List<Object>  querycjCount(Integer lpid){
		return this.xhjLpxxDao.querycjCount(lpid, DAOConstants.RELATIONAL);
	}
	
	public List<Object> queryjunjiaCount(Integer lpid){
		return this.xhjLpxxDao.queryjunjiaCount(lpid, DAOConstants.RELATIONAL);
	}
	
	public List<Object> cjjunjiaquxian(Integer years,Integer lpid,Integer shi,Integer contype){
		return this.xhjLpxxDao.cjjunjiaquxian(years,lpid,shi,contype,DAOConstants.RELATIONAL);
	
	}
//楼盘专家
	public PageInfo queryLpzj(PageInfo pageInfo,Integer lpid){
		return this.xhjLpxxDao.queryLpzj(pageInfo,lpid);
	}
	
	public XhjLpdong getDongId(int dzid){
		return this.xhjLpxxDao.getDongId(dzid, DAOConstants.RELATIONAL);
	}
	
	public XhjLpdanyuan getDyyuanId(int dYid){
		return this.xhjLpxxDao.getDyyuanId(dYid, DAOConstants.RELATIONAL);
	}
	
	public XhjLpfanghao  getFangHaoId(Integer fangId){
		return this.xhjLpfanghaoDao.getFangHaoId(fangId, DAOConstants.RELATIONAL);
	}
	
	public List<Metro> queryCtype(String ctype){
		return xhjLpxxDao.queryCtype(ctype, DAOConstants.RELATIONAL);
	}
	/**
	 * 批量删除单元
	 * @param dyid
	 * @return
	 */
	public void batchDeleteDany(String dyid,String lpid) {
		xhjLpDanyuanDao.batchDeleteDany(dyid, DAOConstants.RELATIONAL);
		String message = "批量删除[" + dyid + "]单元信息";
		setFanghLog("LP30014", message, lpid);
	} 
	/**
	 * 判断单元下是否还有房号信息
	 * @param dyid
	 * @return
	 */
	public Integer getByDyid(String dyid){
		return xhjLpfanghaoDao.getBydyId(dyid,DAOConstants.RELATIONAL);
	}
	
	/**
	 * 判断楼栋下是否还有单元信息
	 * @param dyid
	 * @return
	 */
	public Integer getByLdId(String dzid){
		return xhjLpDanyuanDao.getByLdId(dzid,DAOConstants.RELATIONAL);
	}
	
	/**
	 * 批量删除单元
	 * @param dyid
	 * @return
	 */
	public void batchDeleteLpD(String dzid,String lpid) {
		xhjLpdongDao.batchDeleteLpD(dzid, DAOConstants.RELATIONAL);
		String message = "批量删除[" + dzid + "]楼栋信息";
		setFanghLog("LP30004", message, lpid);
	} 
}
