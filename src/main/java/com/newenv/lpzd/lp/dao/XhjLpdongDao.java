package com.newenv.lpzd.lp.dao;

import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.XhjFangHaoUtil;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;

public class XhjLpdongDao extends DaoParent<XhjLpdong>{
	public List<Object[]> getBYLpId(Integer lpId,String strategy){
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
			String sql ="select ld.id,ld.Lpd_Name from  Xhj_LpDong ld  where ld.LPID="+lpId;
		Query query =pm.newQuery("SQL",sql);
			return (List<Object[]>)query.execute();
	}

	/**
	 * 单个添加楼盘栋信息
	 * @param lpid 楼盘id
	 * @param lpdName 楼盘栋名称
	 * @param relational
	 * @throws Exception 
	 */
	public void saveLpDongSingle(XhjLpdong xhjLpdong,String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			Query query =pm.newQuery(XhjLpdong.class);
			query.setFilter(" lpdName =='"+xhjLpdong.getLpdName()+"' && lpId ==" + xhjLpdong.getLpId());
			List<XhjLpdong> list = (List<XhjLpdong>)query.execute();
			if(list == null || list.size() == 0) {
				//XhjLpdong lpdong = new XhjLpdong();
				//lpdong.setLpId(Integer.valueOf(lpid));
				//lpdong.setLpdName(lpdName);
				//xhjLpdong.setCreatorId(userid);
				xhjLpdong.setCreateDate(new Date());
//				if(dType != null && dType !=""){
//					lpdong.setDtype(Integer.parseInt(XhjFangHaoUtil.equeasParams(dType)));
//				} 
//				if(dyNum != null && dyNum !=""){
//					lpdong.setDyNum(Integer.parseInt(XhjFangHaoUtil.equeasParams(dyNum)));
//				} 
//				if(ages != null && ages !=""){
//					lpdong.setAges(ages);
//				} 
//				if(size != null && size !=""){
//					lpdong.setSize(size);
//				} 
//				if(topNum != null && topNum !=""){
//					lpdong.setTopNum(Integer.parseInt(XhjFangHaoUtil.equeasParams(topNum)));
//				} 
//				if(underNum != null && underNum != ""){
//					lpdong.setUnderNum(Integer.parseInt(XhjFangHaoUtil.equeasParams(underNum)));
//				}
//				if(located != null && located != ""){
//					lpdong.setLocated(Integer.parseInt(XhjFangHaoUtil.equeasParams(located)));
//				}
//				if(ownership != null && ownership !=""){
//					lpdong.setOwnership(Integer.parseInt(XhjFangHaoUtil.equeasParams(ownership)));
//				} 
//				if(remarks !=null && remarks !=""){
//					lpdong.setRemarks(remarks);
//				} 
				pm.makePersistent(xhjLpdong);
			} else {
				 throw new Exception("当前栋信息已存在!");
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw e;
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}
	/**
	 * 批量添加楼盘栋信息
	 */
	public void saveLpDongBatch(XhjLpdong xhjLpdong,String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			int st = Integer.valueOf(xhjLpdong.getStart());
			int en =Integer.valueOf(xhjLpdong.getEnd());
			for (int i = st; i <= en; i++) {
				Query query =pm.newQuery(XhjLpdong.class);
				query.setFilter(" lpdName =='"+xhjLpdong.getPrefix() + i + xhjLpdong.getSuffix()+"' && lpId ==" + xhjLpdong.getLpId());
				List<XhjLpdong> list = (List<XhjLpdong>)query.execute();
				if(list == null || list.size() == 0) {
						XhjLpdong lpdong = new XhjLpdong();
						lpdong.setLpId(xhjLpdong.getLpId());
						lpdong.setCreatorId(xhjLpdong.getCreatorId());
						lpdong.setCreateDate(new Date());
						lpdong.setDtype(xhjLpdong.getDtype());
						lpdong.setDyNum(xhjLpdong.getDyNum());
						lpdong.setAges(xhjLpdong.getAges());
						lpdong.setSize(xhjLpdong.getSize());
						lpdong.setTopNum(xhjLpdong.getTopNum());
						lpdong.setUnderNum(xhjLpdong.getUnderNum());
						lpdong.setLocated(xhjLpdong.getLocated());
						lpdong.setOwnership(xhjLpdong.getOwnership());
						lpdong.setRemarks(xhjLpdong.getRemarks());
					//批量添加
					lpdong.setLpdName(xhjLpdong.getPrefix() + i + xhjLpdong.getSuffix());
					pm.makePersistent(lpdong);
				}
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw e;
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}
	/**
	 * 修改楼盘栋数
	 * @param lpdid
	 * @param lpdName
	 * @param relational
	 * @throws Exception 
	 */
	public void updLpDong(XhjLpdong xhjLpdong, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpdong oldLpd = pm.getObjectById(XhjLpdong.class,xhjLpdong.getId());
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			if(!oldLpd.getLpdName().equals(xhjLpdong.getLpdName())) {
				Query query =pm.newQuery(XhjLpdong.class);
				query.setFilter(" lpdName =='"+xhjLpdong.getLpdName()+"' && lpId ==" + xhjLpdong.getLpId());
				List<XhjLpdong> list = (List<XhjLpdong>)query.execute();
				if(list == null || list.size() == 0) {
						oldLpd.setLpdName(xhjLpdong.getLpdName());
						oldLpd.setDtype(xhjLpdong.getDtype());
						oldLpd.setDyNum(xhjLpdong.getDyNum());
						oldLpd.setAges(xhjLpdong.getAges());
						oldLpd.setSize(xhjLpdong.getSize());
						oldLpd.setTopNum(xhjLpdong.getTopNum());
						oldLpd.setUnderNum(xhjLpdong.getUnderNum());
						oldLpd.setLocated(xhjLpdong.getLocated());
						oldLpd.setOwnership(xhjLpdong.getOwnership());
						oldLpd.setRemarks(xhjLpdong.getRemarks());
						pm.makePersistent(oldLpd);
				} else {
					 throw new Exception("当前栋信息已存在!");
				}
			} else {
				oldLpd.setLpdName(xhjLpdong.getLpdName());
				oldLpd.setDtype(xhjLpdong.getDtype());
				oldLpd.setDyNum(xhjLpdong.getDyNum());
				oldLpd.setAges(xhjLpdong.getAges());
				oldLpd.setSize(xhjLpdong.getSize());
				oldLpd.setTopNum(xhjLpdong.getTopNum());
				oldLpd.setUnderNum(xhjLpdong.getUnderNum());
				oldLpd.setLocated(xhjLpdong.getLocated());
				oldLpd.setOwnership(xhjLpdong.getOwnership());
				oldLpd.setRemarks(xhjLpdong.getRemarks());
				pm.makePersistent(oldLpd);
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw e;
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}
	public String deleteDany(String id, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpdong dany = pm.getObjectById(XhjLpdong.class, Integer.valueOf(id));
		String dongName = "";
		if(dany != null) {
			Query query =pm.newQuery(XhjLpdanyuan.class);
			query.setFilter("dzid ==" + Integer.parseInt(id));
			List<XhjLpdanyuan> list = (List<XhjLpdanyuan>)query.execute();
			if(list == null || list.size() == 0) {
				dongName = dany.getLpdName();
				pm.deletePersistent(dany);
			} else {
				for(XhjLpdanyuan xhjLpdanyuan :list){
					Query queryfanghao =pm.newQuery(XhjLpfanghao.class);
					queryfanghao.setFilter("dyId ==" + xhjLpdanyuan.getId());
					List<XhjLpfanghao> fangHaolist = (List<XhjLpfanghao>)queryfanghao.execute();
					if(fangHaolist!=null&&fangHaolist.size()!=0){
						pm.deletePersistentAll(fangHaolist);
					}
					
				}
				pm.deletePersistentAll(list);
				dongName = dany.getLpdName();
				pm.deletePersistent(dany);
			}
		}
		pm.close();
		return dongName;
		
	}
	
	public void batchDeleteLpD(String dzid, String relational) {
		PersistenceManager pm=getPersistenceManagerByStratey(relational);
		Transaction tx=pm.currentTransaction();
		try {
		    tx.begin();
		    String[] id = dzid.split(",");
		    for (int i = 0; i < id.length; i++) {
		    	XhjLpdong lpd = pm.getObjectById(XhjLpdong.class, Integer.valueOf(id[i]));
				if(lpd != null) {
					Query query =pm.newQuery(XhjLpdanyuan.class);
					query.setFilter("dzid ==" + lpd.getId());
					List<XhjLpdanyuan> list = (List<XhjLpdanyuan>)query.execute();
					if(list==null&&list.size()==0){
						pm.deletePersistent(lpd);
					}else{
						for(XhjLpdanyuan xhjLpdanyuan :list){
							Query queryfanghao =pm.newQuery(XhjLpfanghao.class);
							queryfanghao.setFilter("dyId ==" + xhjLpdanyuan.getId());
							List<XhjLpfanghao> fangHaolist = (List<XhjLpfanghao>)queryfanghao.execute();
							if(fangHaolist!=null&&fangHaolist.size()!=0){
								pm.deletePersistentAll(fangHaolist);
							}
					}
						pm.deletePersistentAll(list);
						pm.deletePersistent(lpd);
					
				}
			}
		    }
			tx.commit();
			pm.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
	}


}
