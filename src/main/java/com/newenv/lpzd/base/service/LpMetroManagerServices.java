package com.newenv.lpzd.base.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.LpMetroManagerDao;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhan;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongzhantoxian;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class LpMetroManagerServices {
	private LpMetroManagerDao lpMetroManagerDao;
	private XhjLpjiaotongzhan pojo;
	
	/**
	 * 地铁详细信息管理
	 * @param pager
	 * @param metro
	 * @return
	 */
	public PageInfo findByPageInfo(Metro metro,PageInfo pager){
		return lpMetroManagerDao.findByPage(metro,pager);
	}
	public long selectDataZD(Metro metro){
		return lpMetroManagerDao.selectDataZD(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 地铁线路
	 * @param request
	 * @return
	 */
	public List<XhjLpjiaotongzhantoxian> getXiLuSelect(Metro metro){
		return lpMetroManagerDao.finAll(metro,DAOConstants.RELATIONAL);
	}
	/**
	 * 交通类别
	 * @param request
	 * @return
	 */
	public List<LpSyscs1> getJiaoTongSelect (Metro metro){
			return lpMetroManagerDao.findAll(metro,DAOConstants.RELATIONAL);
		}
	public List<Metro> getSelectXianLu_Name(Metro metro){
		return lpMetroManagerDao.selectXianLu_Name(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改地铁详细信息
	 * @param pojo
	 * @param strategy
	 * @return
	 */
	public int getUpdateStation(Metro metro){
		return lpMetroManagerDao.updateStation(metro, DAOConstants.RELATIONAL);
	}
	public int getupdateSiteLine(Metro metro){
		return lpMetroManagerDao.updateSiteLine(metro, DAOConstants.RELATIONAL);
	}
	
	//新增页面数据的三级联动
	public List selectCity(Metro metro){
		return lpMetroManagerDao.selectCity(metro,DAOConstants.RELATIONAL);
	}
	public List selectLeiBei(Metro metro){
		return lpMetroManagerDao.selectLeiBei(metro, DAOConstants.RELATIONAL);
	}
	public List<Metro> selectXianLu(Metro metro){
		return lpMetroManagerDao.selectXianLu(metro,DAOConstants.RELATIONAL);
		
	}
	
	//修改页面详细信息查询
	public List<Metro> selectData(Metro metro){
		return lpMetroManagerDao.selectData(metro,DAOConstants.RELATIONAL);
	}
	
	//新增交通数据
	public XhjLpjiaotongzhantoxian insertDataZD(Metro metro){
		return lpMetroManagerDao.insertDataZD(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 批量删除
	 * @param metro
	 * @return
	 */
	public int updateData(Metro metro){
		return lpMetroManagerDao.updateData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 新增类别
	 * @param metro
	 * @return
	 */
	public LpSyscs1 addLeiBei(Metro metro){
		return lpMetroManagerDao.addLeiBei(metro, DAOConstants.RELATIONAL);
	}
	
	public List<Metro> selectLeiBeiData(Metro metro){
		return lpMetroManagerDao.seleLeiBeiData(metro, DAOConstants.RELATIONAL);
	}
	public long selectDataLeiBei(Metro metro){
		return lpMetroManagerDao.selectDataLeiBei(metro,DAOConstants.RELATIONAL);
	}
	/**
	 * 修改类别
	 * @param metro
	 * @return
	 */
	public int updateLeiBei(Metro metro){
		return lpMetroManagerDao.updateLeiBei(metro, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 新增线路
	 * @param metro
	 * @return
	 */
	public XhjLpjiaotongxian addXianLu(Metro metro){
		return lpMetroManagerDao.addXianLu(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 查询数据进行判断
	 * @param metro
	 * @return
	 */
	public long selectXianluData(Metro metro){
		return lpMetroManagerDao.selectXianluData(metro, DAOConstants.RELATIONAL);
	}
	public List<Metro> selectDateXianlu(Metro metro){
		return lpMetroManagerDao.selectDateXianlu(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改线路
	 * @param metro
	 * @return
	 */
	public int updateXianLu(Metro metro){
		return lpMetroManagerDao.updateXianLu(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改数据线路
	 * @param metro
	 * @return
	 */
	public int updateDataXianLu(Metro metro){
		return lpMetroManagerDao.updateDataXianLu(metro, DAOConstants.RELATIONAL);
	}

	public LpMetroManagerDao getLpMetroManagerDao() {
		return lpMetroManagerDao;
	}

	public void setLpMetroManagerDao(LpMetroManagerDao lpMetroManagerDao) {
		this.lpMetroManagerDao = lpMetroManagerDao;
	}

	/**
	 * 删除类别
	 * @param metro
	 * @return
	 */
	public int updateDataLeiBei(Metro metro){
		return lpMetroManagerDao.updateDataLeiBei(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除线路
	 * @param metro
	 * @return
	 */
	public int updateXianLuData1(Metro metro){
		return lpMetroManagerDao.updateXianLuData(metro, DAOConstants.RELATIONAL);
	}
}
