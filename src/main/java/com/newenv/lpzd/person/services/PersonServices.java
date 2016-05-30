package com.newenv.lpzd.person.services;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSON;
import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.ActionAllDao;
import com.newenv.lpzd.base.dao.LpCountryDao;
import com.newenv.lpzd.base.domain.ChanQuan;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.lp.dao.LpHouseOperationLogDao;
import com.newenv.lpzd.lp.dao.LpUpdateRecordDao;
import com.newenv.lpzd.lp.dao.XhjCommunicatorDao;
import com.newenv.lpzd.lp.dao.XhjLpfanghaoDao;
import com.newenv.lpzd.lp.dao.XhjLpfanghaoimgDao;
import com.newenv.lpzd.lp.dao.XhjPersonimgDao;
import com.newenv.lpzd.lp.dao.XhjPersoninfoDao;
import com.newenv.lpzd.lp.domain.LpHouseOperationLog;
import com.newenv.lpzd.lp.domain.XhjCommunicator;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;
import com.newenv.lpzd.lp.domain.XhjPersonimg;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;
import com.newenv.lpzd.person.Condition;
import com.newenv.lpzd.person.LpUpdatingRecord;
import com.newenv.lpzd.person.dao.PersonDao;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.pagination.PageInfo;

import diqu.Information;
import diqu.Metro;

public class PersonServices {

	private PersonDao personDao;
	private XhjLpfanghaoDao xhjLpfanghaoDao;
	private XhjPersoninfoDao xhjPersoninfoDao;
	private XhjPersonimgDao xhjPersonimgDao;
	private XhjCommunicatorDao xhjCommunicatorDao;
	private XhjLpfanghaoimgDao xhjLpfanghaoimgDao;
	private LpUpdateRecordDao lpUpdateRecordDao;
	private LpHouseOperationLogDao lpHouseOperationLogDao; 
	
	
	public LpHouseOperationLogDao getLpHouseOperationLogDao() {
		return lpHouseOperationLogDao;
	}

	public void setLpHouseOperationLogDao(
			LpHouseOperationLogDao lpHouseOperationLogDao) {
		this.lpHouseOperationLogDao = lpHouseOperationLogDao;
	}

	public LpUpdateRecordDao getLpUpdateRecordDao() {
		return lpUpdateRecordDao;
	}

	public void setLpUpdateRecordDao(LpUpdateRecordDao lpUpdateRecordDao) {
		this.lpUpdateRecordDao = lpUpdateRecordDao;
	}

	public XhjLpfanghaoimgDao getXhjLpfanghaoimgDao() {
		return xhjLpfanghaoimgDao;
	}

	public void setXhjLpfanghaoimgDao(XhjLpfanghaoimgDao xhjLpfanghaoimgDao) {
		this.xhjLpfanghaoimgDao = xhjLpfanghaoimgDao;
	}

	public XhjCommunicatorDao getXhjCommunicatorDao() {
		return xhjCommunicatorDao;
	}

	public void setXhjCommunicatorDao(XhjCommunicatorDao xhjCommunicatorDao) {
		this.xhjCommunicatorDao = xhjCommunicatorDao;
	}

	public XhjPersoninfoDao getXhjPersoninfoDao() {
		return xhjPersoninfoDao;
	}

	public void setXhjPersoninfoDao(XhjPersoninfoDao xhjPersoninfoDao) {
		this.xhjPersoninfoDao = xhjPersoninfoDao;
	}

	public XhjPersonimgDao getXhjPersonimgDao() {
		return xhjPersonimgDao;
	}

	public void setXhjPersonimgDao(XhjPersonimgDao xhjPersonimgDao) {
		this.xhjPersonimgDao = xhjPersonimgDao;
	}

	public PersonDao getPersonDao() {
		return personDao;
	}

	public void setPersonDao(PersonDao personDao) {
		this.personDao = personDao;
	}

	public XhjLpfanghaoDao getXhjLpfanghaoDao() {
		return xhjLpfanghaoDao;
	}

	public void setXhjLpfanghaoDao(XhjLpfanghaoDao xhjLpfanghaoDao) {
		this.xhjLpfanghaoDao = xhjLpfanghaoDao;
	}

	/**
	 * 我的维护盘信息
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForMY(Condition condition ,PageInfo pager){
		pager = personDao.queryForMY(condition, pager);
		return pager;
	}
	/**
	 * 房屋分派
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForAssign(Condition condition ,PageInfo pager){
		pager = personDao.queryForAssign(condition, pager);
		return pager;
	}
	
	/**
	 * 查询楼盘
	 * @return
	 */
	public List queryLpName()
	{
		return personDao.queryLpName();
	}
	
	
	/**
	 * 查询部门
	 * @return
	 */
	public List<String[]> queryBM(String dianzuName)
	{
		return personDao.queryBM(dianzuName);
	}
	
	
	/**
	 * 查询部门经理
	 * @param dzid  店组id
	 * @return
	 */
	public List<String[]> queryBMJL(String dzid)
	{
		return personDao.queryBMJL(dzid);
	}
	
	
	
	
	/**
	 * 批量分派
	 * @param dzid  店组id
	 * @return
	 */
	public int insertBatchFenpai(Condition condition)
	{
		return personDao.insertBatchFenpai(condition);
	}
	
	
	
	/**
	 * 查询dong
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public List<Object[]> queryDong(String id)
	{
		return personDao.queryDong(id);
	}
	
	
	/**
	 * 查询danyuan
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public List<Object[]> queryDanyuan(String id)
	{
		return personDao.queryDanyuan(id);
	}
	
	/**
	 * 查询房屋信息
	 * @return
	 */
	public XhjLpfanghao queryFanghao(Condition condition)
	{
		return personDao.queryFanghao(condition);

	}
	
	/**
	 * 查询房屋图片
	 * fhids 的id
	 * @return
	 */
	public List<XhjLpfanghaoimg> queryFanghaoImg(String fhids)
	{
		return personDao.queryFanghaoImg(fhids);
	}

	/**
	 * 批量修改
	 * @return
	 */
	public int batchUpdate(Condition condition )
	{
		return personDao.batchUpdate(condition);

	}
	
	
	/**
	 * 查询huxing
	 * @param ids  待分配所有房号id
	 * @return
	 */
	public List<Object[]> queryHuxing(String lpid,String dongid,String danyuanid)
	{	
		return personDao.queryHuxing(lpid, dongid, danyuanid);
	}
	
	/**
	 * 查询
	 * @param conditon
	 * @return
	 */
	public PageInfo querySource(Condition condition, PageInfo pager)
	{
		return personDao.querySource(condition,pager);
	}
	
	/**
	 * 责任盘维护 xhj_lcfz  信息楼盘 以及栋座的信息栋数据 
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForZR(Condition condition ,PageInfo pager){
		pager = personDao.queryForZR(condition, pager);
		return pager;
	}
	
	/**
	 * 本组维护盘信息 根据部门，分配表lp_assignment
	 * @param pager 分页信息
	 * @param strategy 查询数据库类型
	 * @return
	 */
	public PageInfo queryForBZ(Condition condition ,PageInfo pager){
		pager = personDao.queryForBZ(condition, pager);
		return pager;
	}
	
	/**
	 *@description 房屋信息-基本信息展示
	 *@base lfid 房号id 
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public Object queryByLFId(String lfid)
	{
		return personDao.queryByLFId(lfid);
	}
	
	/**
	 *@description 房屋信息--跟踪记录
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryUpdateRecord(String lfid,PageInfo pager)
	{
		return personDao.queryUpdateRecord(lfid,pager);
	}
	
	
	/**
	 *@description 房屋信息--动态
	 *@base lfid
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryFHLog(String lfid,PageInfo pager)
	{
		return personDao.queryFHLog(lfid,pager);
	}
	
	
	/**
	 *@description 房屋信息--历史委托记录
	 *@base lfid 房号id
	 *@author chenxiang
	 *@Date 2015/9/29
	 */
	public PageInfo queryWeiTuoJiLu(String lfid,PageInfo pager)
	{
		return personDao.queryWeiTuoJiLu(lfid,pager);
	}
	/**
	 * 查询所有业主信息
	 * @return
	 */
	public PageInfo queryData(String lfid,PageInfo pager)
	{
		return personDao.queryData(lfid, pager);
	}

	/**
	 * 业主数据查询
	 * @param lfid
	 * @param strategy
	 * @return
	 */
	public Information selectState(String lfid)
	{
		return personDao.selectState(lfid, DAOConstants.RELATIONAL);
	}
	
	 public Information selectLpfanghao(String lfid)
	 {
		 return personDao.selectLpfanghao(lfid, DAOConstants.RELATIONAL); 
	 }

	
	public String saveFangHao(XhjLpfanghao fanghao) throws Exception{
		return  this.xhjLpfanghaoDao.saveFangHao(fanghao, DAOConstants.RELATIONAL);
	}
	
	public void saveXhjPersonimg(Integer personId,List<XhjPersonimg> img){
		this.xhjPersonimgDao.saveXhjPersonimg(personId, img, DAOConstants.RELATIONAL);
	}
	
	public String savePersoninfo(XhjPersoninfo xhjPersoninfo) throws Exception{
		return this.xhjPersoninfoDao.savePersoninfo(xhjPersoninfo, DAOConstants.RELATIONAL);
	}
	
	public  List<XhjPersonimg>  queryXhjPersonimg(Integer personId){
		return this.xhjPersonimgDao.queryXhjPersonimg(personId, DAOConstants.RELATIONAL);
	}
	
	public void saveXhjCommunicator(Integer personId,List<XhjCommunicator> communicators){
		this.xhjCommunicatorDao.saveXhjCommunicator(personId, communicators, DAOConstants.RELATIONAL);
	}
	
	public  List<XhjCommunicator>  queryXhjCommunicator(Integer personId){
		return this.xhjCommunicatorDao.queryXhjCommunicator(personId, DAOConstants.RELATIONAL);
	}
	
	public void savefanghaoimg(Integer fanghaoId,List<XhjLpfanghaoimg> img){
		this.xhjLpfanghaoimgDao.savefanghaoimg(fanghaoId, img, DAOConstants.RELATIONAL);
	}
	
	public  List<XhjLpfanghaoimg>  queryXhjLpfanghaoimg(Integer fanghaoId){
		return this.xhjLpfanghaoimgDao.queryXhjLpfanghaoimg(fanghaoId, DAOConstants.RELATIONAL);
	}
	
	public XhjLpfanghao getxhjFangHao(Integer fanghaoid){
		return this.xhjLpfanghaoDao.getxhjFangHao(fanghaoid,  DAOConstants.RELATIONAL);
	}
	
	public XhjPersoninfo getXhjPersoninfo(Integer personId){
		return this.xhjPersoninfoDao.getXhjPersoninfo(personId, DAOConstants.RELATIONAL);
	}
	
	public String  savelpUpdateRecord(LpUpdatingRecord lpUpdateRecord) throws Exception{
		return  this.lpUpdateRecordDao.savelpUpdateRecord(lpUpdateRecord, DAOConstants.RELATIONAL);
	}
	//操作日志
		private void setFanghLog(String type, String message, String fanghid){
			lpHouseOperationLogDao.addLpLog(type, message, fanghid);
		}

}
