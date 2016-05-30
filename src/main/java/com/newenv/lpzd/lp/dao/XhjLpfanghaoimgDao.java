package com.newenv.lpzd.lp.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;

public class XhjLpfanghaoimgDao extends DaoParent<XhjLpfanghaoimg>{
	public void savefanghaoimg(Integer fanghaoId, List<XhjLpfanghaoimg> img, String relational){
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpfanghao xhjLpfanghao = pm.getObjectById(XhjLpfanghao.class, fanghaoId);
		Transaction tx = pm.currentTransaction();
		try {
			Query query = pm.newQuery(XhjLpfanghaoimg.class);
			query.setFilter("fanghaoid==" + xhjLpfanghao.getId());
			List<XhjLpfanghaoimg> imgs = (List<XhjLpfanghaoimg>)query.execute();
			tx.begin();
			pm.deletePersistentAll(imgs);
			int index = 1;
			if(img != null && img.size() > 0) {
				for (int i = 0; i < img.size(); i++) {
					if(img.get(i) != null) {
						XhjLpfanghaoimg lpImge = img.get(i);
						lpImge.setOrderBy(index);
						lpImge.setFanghaoid(xhjLpfanghao.getId());
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
	 * 获取房号图片
	 * @param relational
	 * @return
	 */
	public List<XhjLpfanghaoimg> queryXhjLpfanghaoimg(Integer fanghaoId,  String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query = pm.newQuery(XhjLpfanghaoimg.class);
		
		query.setFilter("fanghaoid==" + fanghaoId);
		
		List<XhjLpfanghaoimg> imgs = (List<XhjLpfanghaoimg>)query.execute();
		pm.close();
		return imgs;
	};
}
