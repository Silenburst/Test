package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjLptp;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.XhjPersonimg;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;

public class XhjPersonimgDao extends DaoParent<XhjPersonimg>{
	public void saveXhjPersonimg(Integer personId, List<XhjPersonimg> img, String relational){
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjPersoninfo xhjPersoninfo = pm.getObjectById(XhjPersoninfo.class, personId);
		Transaction tx = pm.currentTransaction();
		try {
			Query query = pm.newQuery(XhjPersonimg.class);
			query.setFilter("personId==" + xhjPersoninfo.getId());
			List<XhjPersonimg> imgs = (List<XhjPersonimg>)query.execute();
			tx.begin();
			pm.deletePersistentAll(imgs);
			int index = 1;
			if(img != null && img.size() > 0) {
				for (int i = 0; i < img.size(); i++) {
					if(img.get(i) != null) {
						XhjPersonimg lpImge = img.get(i);
						lpImge.setDisplayIndex(index);
						lpImge.setPersonId(xhjPersoninfo.getId());
						lpImge.setCreateDate(new Timestamp(new Date().getTime()));
						pm.makePersistent(lpImge);
						index++;
					}
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
	 * 获取业主图片
	 * @param relational
	 * @return
	 */
	public List<XhjPersonimg> queryXhjPersonimg(Integer personId,  String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query = pm.newQuery(XhjPersonimg.class);
		
		query.setFilter("personId==" + personId);
		
		List<XhjPersonimg> imgs = (List<XhjPersonimg>)query.execute();
		
		pm.close();
		
		return imgs;
	};
}
