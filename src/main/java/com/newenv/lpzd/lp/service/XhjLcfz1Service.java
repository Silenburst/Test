package com.newenv.lpzd.lp.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.XhjLcfz1Dao;
import com.newenv.lpzd.lp.domain.XhjLcfz1;
import com.newenv.lpzd.security.dao.TblDepartmentDao;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.lpzd.security.service.TblDepartmentService;
import com.newenv.pagination.PageInfo;

/**
 * 楼盘信息维护(维护盘、范围般)。
 * @author chenky.
 *
 */
public class XhjLcfz1Service{
	
	private XhjLcfz1Dao xhjLcfz1Dao;
	
	private TblDepartmentDao tblDepartmentDao;
	
	public static final int DZ_ORGNIZE_TYPE_ID = 88;	//店组的部门类型ID；
	
	/**
	 * 批量划盘。
	 * @param lcfz1
	 * @param ids
	 */
	public void saveBatch(XhjLcfz1 lcfz1, int[] ids){
		xhjLcfz1Dao.saveBatch(lcfz1, ids, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 批量删除划盘信息。
	 * @param ids
	 */
	public void deleteBatch(int[] ids){
		xhjLcfz1Dao.deleteBatch(ids, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个部门的维护盘或范围盘。
	 * @param bmid	部门id
	 * @param sta 2：维护盘3：范围盘
	 * @return
	 */
	public List<XhjLcfz1> getLcfz1OfBm(Integer bmid, short sta){
		return xhjLcfz1Dao.getLcfz1OfBm(bmid, sta, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门的id列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public List<Integer> getBmidsOfLcfc(int lpid, short sta){
		return xhjLcfz1Dao.getBmidsOfLcfc(lpid, sta, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public List<TblDepartment> getBmsOfLcfc(int lpid, short sta){
		List<Integer> bmIds = xhjLcfz1Dao.getBmidsOfLcfc(lpid, sta, DAOConstants.RELATIONAL);
		return tblDepartmentDao.findDepartmentByOrgIdAndDeparmentIDs(DZ_ORGNIZE_TYPE_ID, bmIds, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取对某个楼盘具有权责的所有部门列表。
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public List<TblDepartment> getBmsOfLcfc1(int lpid, short sta){
		List<Integer> bmIds = xhjLcfz1Dao.getBmidsOfLcfc1(lpid, sta, DAOConstants.RELATIONAL);
		return tblDepartmentDao.findDepartmentByOrgIdAndDeparmentIDs(DZ_ORGNIZE_TYPE_ID, bmIds, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 复制店组方式，将一个组的权责盘信息复制到另一个组。
	 * @param fromBmId
	 * @param fromSta
	 * @param toBmId
	 * @param toSta
	 */
	public void copy(int fromBmId, short fromSta, int toBmId, short toSta){
		xhjLcfz1Dao.copy(fromBmId, fromSta, toBmId, toSta, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 相同的划盘信息是否存在。
	 * @param bmid
	 * @param lpid
	 * @param sta
	 * @return
	 */
	public boolean isExist(int bmid, int lpid, short sta){
		return xhjLcfz1Dao.isExist(bmid, lpid, sta, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询一个楼盘划分的店组信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo query(PageInfo pager, XhjLcfz1 lcfz1){
		return xhjLcfz1Dao.query(pager, lcfz1, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息.
	 * @param pager
	 * @param lcfz1
	 * @return
	 */
	public PageInfo getLcfc1OfBmForCopy(PageInfo pager, XhjLcfz1 lcfz1){
		return xhjLcfz1Dao.getLcfc1OfBmForCopy(pager, lcfz1, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz1
	 * @return
	 */
	public PageInfo getLcfc1OfBm(PageInfo pager, XhjLcfz1 lcfz1){
		return xhjLcfz1Dao.getLcfc1OfBm(pager, lcfz1, DAOConstants.RELATIONAL);
	}

	public XhjLcfz1Dao getXhjLcfz1Dao() {
		return xhjLcfz1Dao;
	}

	public void setXhjLcfz1Dao(XhjLcfz1Dao xhjLcfz1Dao) {
		this.xhjLcfz1Dao = xhjLcfz1Dao;
	}

	public TblDepartmentDao getTblDepartmentDao() {
		return tblDepartmentDao;
	}

	public void setTblDepartmentDao(TblDepartmentDao tblDepartmentDao) {
		this.tblDepartmentDao = tblDepartmentDao;
	}
}
