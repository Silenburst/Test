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

public class XhjLptpDao extends DaoParent<XhjLptp>{
 	
	public void saveLpimges(Integer lpid, String imgName, List<XhjLptp> img, String relational){
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpxx lpxx = pm.getObjectById(XhjLpxx.class, lpid);
		Transaction tx = pm.currentTransaction();
		try {
			Query query = pm.newQuery(XhjLptp.class);
			query.setFilter("lpid==" + lpxx.getId());
			List<XhjLptp> imgs = (List<XhjLptp>)query.execute();
			tx.begin();
			pm.deletePersistentAll(imgs);
			if(img != null && img.size() > 0) {
				for (int i = 0; i < img.size(); i++) {
					if(img.get(i) != null) {
						XhjLptp lpImge = img.get(i);
						lpImge.setLpid(lpxx.getId());
						lpImge.setImgName(imgName);
						lpImge.setTime(new Timestamp(new Date().getTime()));
						pm.makePersistent(lpImge);
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
	 * 获取楼盘图片
	 * @param relational
	 * @return
	 */
	public List<XhjLptp> queryLptpInfo(Integer lpid,Integer shi,Integer fengge, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Query query = pm.newQuery(XhjLptp.class);
		if(shi!=null&&shi!=0){
			query.setFilter("lpid=="+ lpid+" && shi=="+shi );
		}else if(fengge!=null&&fengge!=0){
			query.setFilter("lpid=="+ lpid+" && fengge=="+fengge );
		}else{
			query.setFilter("lpid=="+ lpid );
		}
		List<XhjLptp> xhjLptp =(List<XhjLptp>)query.execute();
		pm.close();
		return xhjLptp;
	};
}
