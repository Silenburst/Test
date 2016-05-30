package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpwuye;
import com.newenv.lpzd.lp.domain.XhjLpxx;

public class XhjLpWuYeDao extends DaoParent<XhjLpwuye>{
 	

	public String saveWuye(XhjLpwuye wyxx, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpxx wylp = pm.getObjectById(XhjLpxx.class, wyxx.getXhjLpxx().getId());
		wyxx.setXhjLpxx(wylp);
		String id = "";
		if(wyxx.getId() == null || wyxx.getId() == 0) {
			id = getNextSeqId(XhjLpwuye.class);
			wyxx.setId(Integer.valueOf(id));
			wyxx.setCreateDate(new Timestamp(new Date().getTime()));
			Transaction tx = pm.currentTransaction();
			try {
				tx.begin();
				pm.makePersistent(wyxx);
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			}
		} else {
			id = wyxx.getId().toString();
			XhjLpwuye oldWyxx = pm.getObjectById(XhjLpwuye.class, wyxx.getId());
			oldWyxx = oldLpxxPerNewLpxx(oldWyxx, wyxx);
			Transaction tx = pm.currentTransaction();
			try {
				tx.begin();
				pm.makePersistent(oldWyxx);
				tx.commit();
			} catch (Exception e) {
				tx.rollback();
				throw e;
			}
		}
		pm.close();
		return id;
	}
	
	/**
	 * 
	 * @param old 更新对象
	 * @param news 更新前对象
	 */
	private XhjLpwuye oldLpxxPerNewLpxx(XhjLpwuye old, XhjLpwuye news){
		old.setWyName(news.getWyName());
		old.setWydz(news.getWydz());
		old.setTelephone(news.getTelephone());
		old.setTelephone1(news.getTelephone1());
		old.setWuYe(news.getWuYe());
		old.setRemark(news.getRemark());
		old.setParkingFee(news.getParkingFee());
		old.setMenJin(news.getMenJin());
		old.setJianKong(news.getJianKong());
		old.setZuShou(news.getZuShou());
		return old;
	}
	
	/*
	 * 根据楼盘ID查询物业信息
	 */
	public XhjLpwuye queryWuyeInfo(Integer lpid, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query =pm.newQuery(XhjLpwuye.class);
		query.setFilter(" xhjLpxx.id =="+lpid);
		List<XhjLpwuye> list = (List<XhjLpwuye>)query.execute();
		pm.close();
		if(list != null && list.size() > 0) {
			return list.get(0);
		}
		return new XhjLpwuye();
	}
}
