package com.newenv.lpzd.lp.dao;

import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;

public class XhjLpDanyuanDao extends DaoParent<XhjLpdanyuan>{
	
	/**
	 * 单个添加单元栋信息
	 * @param lpid 楼盘id
	 * @param lpdName 楼盘栋名称
	 * @param relational
	 * @throws Exception 
	 */
	public void saveLpDanySingle(XhjLpdanyuan xhjLpdanyuan, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			Query query =pm.newQuery(XhjLpdanyuan.class);
			query.setFilter(" dyName =='"+xhjLpdanyuan.getDyName()+"' && dzid ==" + xhjLpdanyuan.getDzid());
			List<XhjLpdanyuan> list = (List<XhjLpdanyuan>)query.execute();
			if(list == null || list.size() == 0) {
				XhjLpdanyuan lpdany = new XhjLpdanyuan();
					lpdany.setDzid(xhjLpdanyuan.getDzid());
					lpdany.setDyName(xhjLpdanyuan.getDyName());
					lpdany.setCreatorId(xhjLpdanyuan.getCreatorId());
					lpdany.setCreateDate(new Date());
					lpdany.setDtype(xhjLpdanyuan.getDtype());
					lpdany.setTopNum(xhjLpdanyuan.getTopNum());
					lpdany.setUnderNum(xhjLpdanyuan.getUnderNum());
					lpdany.setTotalNum(xhjLpdanyuan.getTotalNum());
					lpdany.setDihu(xhjLpdanyuan.getDihu());
					lpdany.setRemarks(xhjLpdanyuan.getRemarks());
				pm.makePersistent(lpdany);
			} else {
				throw new Exception("当前单元号已存在!");
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
	 * 批量添加楼盘单元信息
	 */
	public void saveLpDanyBatch(XhjLpdanyuan xhjLpdanyuan, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			int st = Integer.valueOf(xhjLpdanyuan.getStart());
			int en =Integer.valueOf(xhjLpdanyuan.getEnd());
			for (int i = st; i <= en; i++) {
				Query query =pm.newQuery(XhjLpdanyuan.class);
				query.setFilter(" dyName =='"+xhjLpdanyuan.getPrefix() + i + xhjLpdanyuan.getSuffix()+"' && dzid ==" + xhjLpdanyuan.getDzid());
				List<XhjLpdanyuan> list = (List<XhjLpdanyuan>)query.execute();
				if(list == null || list.size() == 0) {
					XhjLpdanyuan lpdany = new XhjLpdanyuan();
					lpdany.setDzid(xhjLpdanyuan.getDzid());
					lpdany.setCreatorId(xhjLpdanyuan.getCreatorId());
					lpdany.setCreateDate(new Date());
						lpdany.setDtype(xhjLpdanyuan.getDtype());
						lpdany.setTopNum(xhjLpdanyuan.getTopNum());
						lpdany.setUnderNum(xhjLpdanyuan.getUnderNum());
						lpdany.setTotalNum(xhjLpdanyuan.getTotalNum());
						lpdany.setDihu(xhjLpdanyuan.getDihu());
						lpdany.setRemarks(xhjLpdanyuan.getRemarks());
					//批量添加
					lpdany.setDyName(xhjLpdanyuan.getPrefix() + i + xhjLpdanyuan.getSuffix());
					pm.makePersistent(lpdany);
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
	 * 修改楼盘单元
	 * @param relational
	 */
	public void updLpDany(XhjLpdanyuan xhjLpdanyuan, String relational) throws Exception{
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpdanyuan oldLpd = pm.getObjectById(XhjLpdanyuan.class, xhjLpdanyuan.getId());
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			if(!oldLpd.getDyName().equals(xhjLpdanyuan.getDyName())) {
				Query query =pm.newQuery(XhjLpdanyuan.class);
				query.setFilter(" dyName =='"+xhjLpdanyuan.getDyName()+"' && dzid ==" + xhjLpdanyuan.getDzid());
				List<XhjLpdanyuan> list = (List<XhjLpdanyuan>)query.execute();
				if(list == null || list.size() == 0) {
						oldLpd.setDyName(xhjLpdanyuan.getDyName());
						oldLpd.setDtype(xhjLpdanyuan.getDtype());
						oldLpd.setTopNum(xhjLpdanyuan.getTopNum());
						oldLpd.setUnderNum(xhjLpdanyuan.getUnderNum());
						oldLpd.setTotalNum(xhjLpdanyuan.getTotalNum());
						oldLpd.setDihu(xhjLpdanyuan.getDihu());
						oldLpd.setRemarks(xhjLpdanyuan.getRemarks());
						pm.makePersistent(oldLpd);
				} else {
					throw new Exception("当前单元号已存在!");
				}
			} else {
					oldLpd.setDyName(xhjLpdanyuan.getDyName());
					oldLpd.setDtype(xhjLpdanyuan.getDtype());
					oldLpd.setTopNum(xhjLpdanyuan.getTopNum());
					oldLpd.setUnderNum(xhjLpdanyuan.getUnderNum());
					oldLpd.setTotalNum(xhjLpdanyuan.getTotalNum());
					oldLpd.setDihu(xhjLpdanyuan.getDihu());
					oldLpd.setRemarks(xhjLpdanyuan.getRemarks());
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
		XhjLpdanyuan dany = pm.getObjectById(XhjLpdanyuan.class, Integer.valueOf(id));
		String fanghao = "";
		if(dany != null) {
			Query query =pm.newQuery(XhjLpfanghao.class);
			query.setFilter("dyId ==" + Integer.parseInt(id));
			List<XhjLpfanghao> list = (List<XhjLpfanghao>)query.execute();
			if(list == null || list.size() == 0) {
				fanghao = dany.getDyName();
				
			} else {
				for(XhjLpfanghao xhjLpfanghao :list){
					Query queryfanghao =pm.newQuery(XhjLpfanghao.class);
					queryfanghao.setFilter("id ==" + xhjLpfanghao.getId());
					List<XhjLpfanghao> fangHaolist = (List<XhjLpfanghao>)queryfanghao.execute();
					if(fangHaolist!=null&&fangHaolist.size()!=0){
						pm.deletePersistentAll(fangHaolist);
					}
					
				}
				pm.deletePersistentAll(list);
				pm.deletePersistent(dany);
			}
		}
		pm.close();
		return fanghao;
	}
	
	public List<Object[]> getBYdzId(Integer dzId,String strategy){
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
			String sql ="select dy.id,dy.Dy_Name from  xhj_lpdanyuan dy    where dy.DZID="+dzId;
		Query query =pm.newQuery("SQL",sql);
		List<Object[]> objs = (List<Object[]>)query.execute();
		pm.close();
		return objs;
	}
	
	public void batchDeleteDany(String dyid, String relational) {
		PersistenceManager pm=getPersistenceManagerByStratey(relational);
		Transaction tx=pm.currentTransaction();
		try {
		    tx.begin();
		    String[] id = dyid.split(",");
		    for (int i = 0; i < id.length; i++) {
		    	XhjLpdanyuan danyuan = pm.getObjectById(XhjLpdanyuan.class, Integer.valueOf(id[i]));
				if(danyuan != null) {
					Query query =pm.newQuery(XhjLpfanghao.class);
					query.setFilter("dyId ==" + danyuan.getId());
					List<XhjLpfanghao> list = (List<XhjLpfanghao>)query.execute();
					if(list==null&&list.size()==0){
						pm.deletePersistent(danyuan);
					}else {
						for(XhjLpfanghao xhjLpfanghao :list){
							Query queryfanghao =pm.newQuery(XhjLpfanghao.class);
							queryfanghao.setFilter("id ==" + xhjLpfanghao.getId());
							List<XhjLpfanghao> fangHaolist = (List<XhjLpfanghao>)queryfanghao.execute();
							if(fangHaolist!=null&&fangHaolist.size()!=0){
								pm.deletePersistentAll(fangHaolist);
							}
							
						}
						pm.deletePersistentAll(list);
						pm.deletePersistent(danyuan);
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
	
	public Integer getByLdId(String dzid,String strategy){
		String sql="select count(*) from xhj_lpdanyuan where  DZID in("+dzid+")";
		PersistenceManager pm =getPersistenceManagerByStratey(strategy);
		Query  query = pm.newQuery("SQL",sql);
		int fian=0;
		List<Object> list=(List<Object>) query.execute();
		fian = Integer.parseInt(list.get(0).toString());
		pm.close();
		return fian;
	}
}
