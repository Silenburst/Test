package com.newenv.lpzd.base.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.base.dao.LpCountryDao;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class LpCountryService {

	private LpCountryDao lpCountryDao;

	public List<LpCountry> findAll(){
		return lpCountryDao.findAll(DAOConstants.RELATIONAL);
	}
	public List<LpCountry> getByLpCountry(String cName){
		return lpCountryDao.getByLpCountry(cName,DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取下拉框国家
	 * @param request
	 * @return
	 */
	public String getCountrySelect(HttpServletRequest request) {
		try {
			String opt = "";
			String cityId = request.getParameter("cityId");
			if(StringUtils.isNotEmpty(cityId)){
				List<LpCountry> lpCountryList = lpCountryDao.findAll(DAOConstants.RELATIONAL);
				for (LpCountry lpCountry : lpCountryList) {
					opt += "<option value='" + lpCountry.getId() +"'>" + lpCountry.getCname() + "</option>";
				}
			}
			return opt;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public LpCountryDao getLpCountryDao() {
		return lpCountryDao;
	}

	public void setLpCountryDao(LpCountryDao lpCountryDao) {
		this.lpCountryDao = lpCountryDao;
	}
	
	public PageInfo findByPage(PageInfo pageInfo){
		pageInfo=lpCountryDao.findByPage( pageInfo, DAOConstants.RELATIONAL);
		return pageInfo;
		
	}
	/**
	 * 列表页数据的分页显示
	 * @param pager
	 * @return
	 */
	public PageInfo findByPageInFo(Metro metro ,PageInfo pager){
		pager = lpCountryDao.findByPageInFo(metro,pager);
		return pager;
	}
	
	/**
	 * 新增数据
	 * @param metro
	 * @return
	 */
	public XhjJcsq addData(Metro metro){
		return lpCountryDao.addData(metro, DAOConstants.RELATIONAL);
	}
	public long selectShangQuanData(Metro metro){
		return lpCountryDao.selectShangQuanData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 新增国家
	 * @param metro
	 * @return
	 */
	public LpCountry addState(Metro metro){
		return lpCountryDao.addState(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 新增国家判断
	 * @param metro
	 * @return
	 */
	public long selectStateData(Metro metro){
		return lpCountryDao.selectStateData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 根据ID查询所有国家姓名
	 * @param metro
	 * @return
	 */
	public List<Metro> selectState(Metro metro){
		return lpCountryDao.selectState(metro, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 修改国家
	 * @param metro
	 * @return
	 */
	public int updateState(Metro metro){
		return lpCountryDao.updateState(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 新增省份
	 * @param metro
	 * @return
	 */
	public LpProvince addProvince(Metro metro){
		return lpCountryDao.addProvince(metro, DAOConstants.RELATIONAL);
	}
	//新增省份判断
	public long selectProvinceData(Metro metro){
		return lpCountryDao.selectProvinceData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 根据ID查询省份名称
	 * @param metro
	 * @return
	 */
	public List<Metro> selectProvince(Metro metro){
		return lpCountryDao.selectProvince(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改省份
	 * @param metro
	 * @return
	 */
	public int updateProvince(Metro metro){
		return lpCountryDao.updateProvince(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 添加城市
	 * @param metro
	 * @return
	 */
	public XhjJccity addCity(Metro metro){
		return lpCountryDao.addCity(metro, DAOConstants.RELATIONAL);
	}
	//新增城市判断
	public long selectCityData(Metro metro){
		return lpCountryDao.selectCityData(metro, DAOConstants.RELATIONAL);
	}
	//根据城市ID获取名称
	public List<Metro> selectCity(Metro metro){
		return lpCountryDao.selectCity(metro,DAOConstants.RELATIONAL);
	}
	/**
	 * 修改城市
	 * @param metro
	 * @return
	 */
	public int updateCity(Metro metro){
		return lpCountryDao.updateCity(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 添加区域
	 * @param metro
	 * @return
	 */
	public XhjJcstress addArea(Metro metro){
		return lpCountryDao.addArea(metro, DAOConstants.RELATIONAL);
	}
	//新增区域判断
	public long selectDataArea(Metro metro){
		return lpCountryDao.selectDataArea(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 根据区域ID查询出所属区域Name
	 * @param metro
	 * @return
	 */
	public List<Metro> selectAreaData(Metro metro){
		return lpCountryDao.selectAreaData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改区域
	 * @param metro
	 * @return
	 */
	public int updateArea(Metro metro){
		return lpCountryDao.updateArea(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 批量删除
	 * @param metro
	 * @return
	 */
	public int updateBatchRemove(Metro metro){
		return lpCountryDao.updateBatchRemove(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 根据ID查询出单条数据进行修改
	 * @param metro
	 * @return
	 */
	public List<Metro> selectData(Metro metro){
		return lpCountryDao.selectData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 修改数据
	 * @param metro
	 * @return
	 */
	public int updateData(Metro metro){
		return lpCountryDao.updateData(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 查询国家
	 * @return
	 */
	public List<Metro> selectCountryData(){
		return lpCountryDao.selectCountryData(DAOConstants.RELATIONAL);
	}
	/**
	 * 根据国家ID查询所属国家的省份名称
	 * @param metro
	 * @return
	 */
	public List<Metro>selectDataProvince(Metro metro){
		return lpCountryDao.selectDataProvince(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 新增数据查询  
	 * 获取出城市名称和ID
	 */
	public List<Metro> selectDataCity(Metro metro){
		return lpCountryDao.selectDataCity(metro,DAOConstants.RELATIONAL);
	}
	/**
	 * 根据城市ID获取商圈的联动
	 */
	public List<Metro> selectShuangQuan(Metro metro){
		return lpCountryDao.selectShuangQuan(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除国家
	 * @param metro
	 * @return
	 */
	public int updateDataState(Metro metro){
		return lpCountryDao.updateDataState(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除省份
	 * @param metro
	 * @return
	 */
	public int updateDataProvince(Metro metro){
		return lpCountryDao.updateDataProvince(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除城市
	 * @param metro
	 * @return
	 */
	public 	int updateDataCity(Metro metro){
		return lpCountryDao.updateDataCity(metro, DAOConstants.RELATIONAL);
	}
	/**
	 * 删除区域
	 * @param metro
	 * @return
	 */
	public int updateDataArea(Metro metro){
		return lpCountryDao.updateDataArea(metro, DAOConstants.RELATIONAL);
	}
}
