package com.newenv.lpzd.lp.service;

import java.util.List;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.service.IBaseService;
import com.newenv.lpzd.lp.dao.XhjAddressApplicationDao;
import com.newenv.lpzd.lp.domain.XhjAddressapplication;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.pagination.PageInfo;

/**
 * 新地址申请。
 * @author chenky
 *
 */
public class XhjAddressApplicationService {
	
	private XhjAddressApplicationDao xhjAddressApplicationDao;
	
	/**
	 * 根据ID获取地址申请信息。
	 * @param id
	 * @return
	 */
	public XhjAddressapplication getById(Integer id){
		return xhjAddressApplicationDao.getById(id, DAOConstants.RELATIONAL);
	}
	
	public void save(XhjAddressapplication addressapplication){
		xhjAddressApplicationDao.save(addressapplication, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 查询地址申请List
	 * @param pager
	 * @param condition
	 * @return
	 */
	public PageInfo getAddress(PageInfo pager,CheckCondition condition){
		return xhjAddressApplicationDao.getAddress(pager, condition);
	}
	
	/**
	 * 导出查询地址申请List
	 * @param pager
	 * @param condition
	 * @return
	 */
	public PageInfo getExportAddress(PageInfo pager,CheckCondition condition){
		return xhjAddressApplicationDao.getExportAddress(pager, condition);
	}
	
	/**
	 * 获取所有的导出查询地址数据
	 * @param condition
	 * @return
	 */
	public List getExportAddressAll(CheckCondition condition){
		return xhjAddressApplicationDao.getExportAddressAll(condition);
	}
	
	/**
	 * 导出查询地址申请List==审核人
	 * @param pager
	 * @param addressapplication
	 * @return
	 */
	public PageInfo getExportCheckerAddress(PageInfo pager,XhjAddressapplication addressapplication){
		return xhjAddressApplicationDao.getExportCheckerAddress(pager, addressapplication);
	}
	
	/**
	 * 获取所有的导出查询地址数据==审核人
	 * @param addressapplication
	 * @return
	 */
	public List getExportCheckerAddressAll(XhjAddressapplication addressapplication){
		return xhjAddressApplicationDao.getExportCheckerAddressAll(addressapplication);
	}
	
	/**
	 * 获取地址申请数==审核人
	 * @param addressapplication
	 * @return
	 */
	public int getAddressApplyNum(XhjAddressapplication addressapplication){
		return xhjAddressApplicationDao.getAddressApplyNum(addressapplication);
	}
	
	/**
	 * 获取地址处理数==审核人
	 * @param addressapplication
	 * @return
	 */
	public int getAddressCheckerNum(XhjAddressapplication addressapplication){
		return xhjAddressApplicationDao.getAddressCheckerNum(addressapplication);
	}
	
	
	/**
	 *  获取未审核数 根据审核人 为审核数
	 * @param addressapplication
	 * @return
	 */
	public int queryAddressNoCheckerNum(XhjAddressapplication addressapplication){
		return xhjAddressApplicationDao.queryAddressNoCheckerNum(addressapplication);
	}
	
	/**
	 * 审核地址申请。
	 * @param application
	 */
	public void saveCheck(XhjAddressapplication application){
		xhjAddressApplicationDao.saveCheck(application, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 相同房号已是否存在。
	 * @param lpId
	 * @param dong
	 * @param danyuan
	 * @param fanghao
	 * @return
	 */
	public boolean isExist(Integer lpId, String dong, String danyuan, String fanghao){
		return xhjAddressApplicationDao.isExist(lpId, dong, danyuan, fanghao);
	}
	
	/**
	 * 相同的地址是否已有申请。
	 * @param lpId
	 * @param dong
	 * @param danyuan
	 * @param fanghao
	 * @return
	 */
	public boolean isApplied(Integer lpId, String dong, String danyuan, String fanghao){
		return xhjAddressApplicationDao.isApplied(lpId, dong, danyuan, fanghao);
	}

	public XhjAddressApplicationDao getXhjAddressApplicationDao() {
		return xhjAddressApplicationDao;
	}

	public void setXhjAddressApplicationDao(
			XhjAddressApplicationDao xhjAddressApplicationDao) {
		this.xhjAddressApplicationDao = xhjAddressApplicationDao;
	}
	
}
