package com.newenv.lpzd.lp.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.dao.XhjLcfzDao;
import com.newenv.lpzd.lp.domain.XhjLcfz;
import com.newenv.lpzd.security.dao.TblDepartmentDao;
import com.newenv.lpzd.security.domain.TblDepartment;
import com.newenv.pagination.PageInfo;

/**
 * 楼盘信息维护(责任盘)。
 * @author chenky.
 *
 */
public class XhjLcfzService {

	private XhjLcfzDao xhjLcfzDao;
	
	private TblDepartmentDao tblDepartmentDao;
	
	/**
	 * 复制店组方式，将一个组的权责盘信息复制到另一个组。
	 * @param fromBmId
	 * @param toBmId
	 */
	public void copy(int fromBmId, int toBmId){
		xhjLcfzDao.copy(fromBmId, toBmId, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 批量划盘。
	 * @param lcfz
	 * @param ldIds
	 */
	public void saveBatch(XhjLcfz lcfz, String[] ldIds){
		xhjLcfzDao.saveBatch(lcfz, ldIds, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 保存所选责任盘小区栋座 id到责任盘表 xhj_lcfz,同时保存小区id至维范维盘表 xhj_lcfz_1作为所选店组维护盘（判断是否重复）.
	 */
	public Serializable save(XhjLcfz lcfz, boolean isNewLp) {
		return xhjLcfzDao.save(lcfz, isNewLp, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 批量删除。
	 * @param lcfz
	 * @param ids 楼盘id数组
	 */
	public void deleteBatch(XhjLcfz lcfz, Integer[] ids){
		xhjLcfzDao.deleteBatch(lcfz, ids, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 批量删除。
	 * @param lpId
	 * @param ids 店组id数组
	 */
	public void deleteBatch(Integer lpId, Integer[] ids){
		xhjLcfzDao.deleteBatch(lpId, ids, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取责任盘下的责任栋。
	 * @param bmid
	 * @param lpid
	 * @return
	 */
	public List<Object[]> getLcfzDongOfLp(int bmid, int lpid){
		return xhjLcfzDao.getLcfzDongOfLp(bmid, lpid, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取对栋座具有责任权限的部门列表。
	 * @param dids  
	 * @return [[did, bmid],[did, bmid],..]
	 */
	public List<Integer[]> getBmidsOfLcfc(Integer[] dids){
		return xhjLcfzDao.getBmidsOfLcfc(dids, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取对栋座具有责任权限的部门列表。
	 * @param dids  
	 * @return map-key:栋座ID， map-value:对相应栋座具有责任盘权限的部门列表
	 */
	public Map<Integer, List<TblDepartment>> getBmsOfLcfc(Integer[] dids){
		List<Integer[]> idses = this.xhjLcfzDao.getBmidsOfLcfc(dids, DAOConstants.RELATIONAL);
		
		//将涉及到的所有的部门id放在一起，调用departmentService调用一次查询
		List<Integer> deptIds = new ArrayList<Integer>();
		Object[] idsTemp = null;
		int idTemp ;
		for(int i=0;i<idses.size();i++){
			idsTemp = idses.get(i);
			idTemp = Integer.parseInt(idsTemp[1].toString());
			if(!deptIds.contains(idTemp))
				deptIds.add(idTemp);
		}
		List<TblDepartment> depts = tblDepartmentDao.findDepartmentByOrgIdAndDeparmentIDs(88, deptIds, DAOConstants.RELATIONAL);
		
		//将部门列表放到map里方便后面的处理
		Map<Integer, TblDepartment> deptMap = new HashMap<Integer, TblDepartment>();
		for(TblDepartment dept : depts){
			deptMap.put(dept.getId(), dept);
		}
		
		Map<Integer, List<TblDepartment>> result = new HashMap<Integer, List<TblDepartment>>();
		List<TblDepartment> tempDepts = null;
		for(Object[] ids : idses){
			idTemp = Integer.parseInt(ids[0].toString());
			tempDepts = result.get(idTemp);
			if(tempDepts==null){
				tempDepts = new ArrayList<TblDepartment>();
				result.put(idTemp, tempDepts);
			}
			tempDepts.add(deptMap.get(ids[1]));
		}
		
		return result;
	}
	
	/**
	 * 相同的划盘信息是否存在。
	 * @param bmid
	 * @param lpid
	 * @param did
	 * @return
	 */
	public boolean isExist(int bmid, int lpid, int did){
		return xhjLcfzDao.isExist(bmid, lpid, did, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 移除某个部门针对某个楼盘的责任。
	 * @param bmid
	 * @param lpid
	 */
	public void delete(int bmid, int lpid){
		xhjLcfzDao.delete(bmid, lpid, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询一个楼盘划分的店组信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo query(PageInfo pager, XhjLcfz lcfz){
		return xhjLcfzDao.query(pager, lcfz, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个店组的划盘信息，会返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo getLcfcOfBmForCopy(PageInfo pager, XhjLcfz lcfz){
		return xhjLcfzDao.getLcfcOfBmForCopy(pager, lcfz, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取某个店组的划盘信息,不返回楼盘的商圈信息。
	 * @param pager
	 * @param lcfz
	 * @return
	 */
	public PageInfo getLcfcOfBm(PageInfo pager, XhjLcfz lcfz){
		return xhjLcfzDao.getLcfcOfBm(pager, lcfz, DAOConstants.RELATIONAL);
	}

	public XhjLcfzDao getXhjLcfzDao() {
		return xhjLcfzDao;
	}

	public void setXhjLcfzDao(XhjLcfzDao xhjLcfzDao) {
		this.xhjLcfzDao = xhjLcfzDao;
	}

	public TblDepartmentDao getTblDepartmentDao() {
		return tblDepartmentDao;
	}

	public void setTblDepartmentDao(TblDepartmentDao tblDepartmentDao) {
		this.tblDepartmentDao = tblDepartmentDao;
	}
	
}
