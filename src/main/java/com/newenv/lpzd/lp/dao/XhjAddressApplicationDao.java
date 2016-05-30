package com.newenv.lpzd.lp.dao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;
import javax.jdo.identity.IntIdentity;

import org.springframework.util.StringUtils;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.XhjAddressapplication;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.vo.CheckCondition;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;

/**
 * 新地址申请。
 * @author chenky
 *
 */
public class XhjAddressApplicationDao extends DaoParent<XhjAddressapplication> {
	
	public XhjAddressapplication getById(Integer id, String strategy){
		return (XhjAddressapplication)getPersistenceManagerByStratey(strategy).getObjectById(XhjAddressapplication.class, id);
	}
	
	/**
	 * 查询地址List
	 * @param pager
	 * @param addressapplication
	 * @return
	 */
	public PageInfo getAddress(PageInfo pager,CheckCondition condition){
		StringBuffer sql=new StringBuffer("select a.id,a.CheckState,s.Sq_Name,x.LP_Name,a.zdid,a.dyid,a.lcid,a.FangHaoID,a.CreateDate,u.fullname,d.department_name,a.lpid,a.SHDate,u.tel,(select fullname from tbl_user_profile where id=a.checkerid) checkername "
				+ " from XHJ_AddressApplication a,xhj_lpxx x,xhj_jcsq s,tbl_user_profile u,tbl_department d ");
		StringBuffer where = new StringBuffer(" where a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + " and a.lpid=x.ID and a.SqID=s.ID and a.ApplicantID=u.id and a.BmID=d.id");
		if(condition!=null){
			if(condition.getStressId()!=null){
				where.append(" and a.StressID="+condition.getStressId());
			}
			if(condition.getSqId()!=null){
				where.append(" and a.SqID="+condition.getSqId());
			}
			if(StringUtils.hasText(condition.getLpName())){
				where.append(" and x.LP_Name like '%"+condition.getLpName()+"%'");
			}
			if(condition.getDepartmentId()!=null){
				where.append(" and a.BmID="+condition.getDepartmentId());
			}
			if(condition.getUserId()!=null){
				where.append(" and a.ApplicantID="+condition.getUserId());
			}
			if(condition.getCheckStatus()!=null){
				where.append(" and a.CheckState="+condition.getCheckStatus());
			}
			if(StringUtils.hasText(condition.getTimeFrom())){
				where.append(" and a.CreateDate>='" + condition.getTimeFrom() + " 00:00:00'");
			}
			if(StringUtils.hasText(condition.getTimeTo())){
				where.append(" and a.CreateDate<='" + condition.getTimeTo() + " 23:59:59'");
			}
		}
		sql.append(where).append(" order by case a.CheckState WHEN 3 THEN 0.5 ELSE a.CheckState END, id desc ");
		String csql = "select count(*) from XHJ_AddressApplication a,xhj_lpxx x,xhj_jcsq s,tbl_user_profile u,tbl_department d " + where.toString();
		return super.getEntitiesByPaginationWithSql(pager, sql.toString(), csql, DAOConstants.RELATIONAL);
	}

	/**
	 * 查询地址List
	 * @param pager
	 * @param addressapplication
	 * @return
	 */
	public PageInfo getExportAddress(PageInfo pager,CheckCondition condition){
		return this.getAddress(pager, condition);
	}
	
	
	/**
	 * 获取所有查询地址
	 * @param addressapplication
	 * @return
	 */
	public List getExportAddressAll(CheckCondition condition){
		StringBuffer sql=new StringBuffer("select a.id,jt.qy_name,x.LP_Name,a.zdid,a.dyid,a.FangHaoID,a.comment,a.disablecomment,a.CreateDate,a.SHDate,a.CheckState,u.fullname,a.lpid "
				+ " from XHJ_AddressApplication a,xhj_lpxx x,xhj_jcsq s,xhj_jcstress jt,tbl_user_profile u,tbl_department d "
				+ " where a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + " and a.lpid=x.ID and a.SqID=s.ID and a.StressID=jt.id and a.checkerid=u.id and a.BmID=d.id");
		if(condition!=null){
			if(condition.getStressId()!=null){
				sql.append(" and a.StressID="+condition.getStressId());
			}
			if(condition.getSqId()!=null){
				sql.append(" and a.SqID="+condition.getSqId());
			}
			if(StringUtils.hasText(condition.getLpName())){
				sql.append(" and x.LP_Name like '%"+condition.getLpName()+"%'");
			}
			if(condition.getDepartmentId()!=null){
				sql.append(" and a.BmID="+condition.getDepartmentId());
			}
			if(condition.getCheckStatus()!=null){
				sql.append(" and a.CheckState="+condition.getCheckStatus());
			}
			if(StringUtils.hasText(condition.getTimeFrom())){
				sql.append(" and a.CreateDate>='" + condition.getTimeFrom() + " 00:00:00'");
			}
			if(StringUtils.hasText(condition.getTimeTo())){
				sql.append(" and a.CreateDate<='" + condition.getTimeTo() + " 23:59:59'");
			}
		}
		sql.append(" order by case a.CheckState WHEN 3 THEN 0.5 ELSE a.CheckState END, id desc ");
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		List objs = (List)pm.newQuery("SQL", sql.toString()).execute();
		pm.close();
		return objs;
	}
	
	
	/**
	 * 导出查询地址申请List==审核人
	 * @param pager
	 * @param addressapplication
	 * @return
	 */
	public PageInfo getExportCheckerAddress(PageInfo pager,XhjAddressapplication addressapplication){
		String numTimeFromSql="";
		String numTimeToSql="";
		
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				numTimeFromSql= " and xa.SHDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				numTimeToSql= " and xa.SHDate<='" + addressapplication.getDateTo() + " 23:59:59'";
			}
		}
		String cityId = SecurityUserHolder.getCurrentUserLogin().getCityId();
		String sql = "select u.fullname,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=u.id and xa.CheckState=1 and CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as checknum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=u.id and xa.CheckState=2 and CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as refusenum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=u.id and xa.CheckState=3 and CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as tochecknum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=u.id and xa.CheckState in (1,2,3) and CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as allnum"+ 
				 " from tbl_user_profile u  where EXISTS (SELECT * from XHJ_AddressApplication where CheckerID=u.id and cityid="+cityId+")";
		String osql =sql;
		String csql = "select count(1) from ("+osql;
		csql+=" ) c";
		return super.getEntitiesByPaginationWithSql(pager, sql ,csql, DAOConstants.RELATIONAL);
	}
	
	/**
	 * 获取所有的导出查询地址数据==审核人
	 * @param addressapplication
	 * @return
	 */
	public List getExportCheckerAddressAll(XhjAddressapplication addressapplication){
		String numTimeFromSql="";
		String numTimeToSql="";
		
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				numTimeFromSql= " and xa.SHDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				numTimeToSql= " and xa.SHDate<='" + addressapplication.getDateTo() + " 23:59:59'";
			}
		}
		String cityId = SecurityUserHolder.getCurrentUserLogin().getCityId();
		String sql = "select u.fullname,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=a.CheckerID and xa.CheckState=1 and a.CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as checknum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=a.CheckerID and xa.CheckState=2 and a.CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as refusenum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=a.CheckerID and xa.CheckState=3 and a.CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as tochecknum,"+
				 "(select count(1) from XHJ_AddressApplication xa where xa.CheckerID=a.CheckerID and xa.CheckState in (1,2,3) and a.CityID ="+ cityId+numTimeFromSql+numTimeToSql+") as allnum"+ 
				 " from XHJ_AddressApplication a, tbl_user_profile u where a.CityID=" + cityId + " and a.CheckerID = u.id";
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				String timeFromSql= " and a.SHDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
				sql += timeFromSql;
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				String timeToSql= " and a.SHDate<='" + addressapplication.getDateTo() + " 23:59:59'";
				sql +=timeToSql;
			}
		}
		sql +=" GROUP BY a.CheckerID";
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		List objs = (List)pm.newQuery("SQL", sql).execute();
		pm.close();
		return objs;
	}
	
	
	/**
	 * 获取地址申请数==审核人
	 * @param addressapplication
	 * @return
	 */
	public int getAddressApplyNum(XhjAddressapplication addressapplication){
		String sql ="select count(1) from XHJ_AddressApplication  a where a.CheckState in (0,1,2,3) and a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + "";
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				sql += " and CreateDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				sql += " and CreateDate<='" + addressapplication.getDateTo() + " 23:59:59'";
			}
		} 
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		int num = Integer.valueOf(query.execute().toString());
		pm.close();
		return num;
	}
	
	/**
	 * 获取地址处理数==审核人
	 * @param addressapplication
	 * @return
	 */
	public int getAddressCheckerNum(XhjAddressapplication addressapplication){
		String sql = "select count(1) from XHJ_AddressApplication a where  a.CheckState in (1,2,3) and a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + "";
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				sql += " and SHDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				sql += " and SHDate<='" + addressapplication.getDateTo() + " 23:59:59'";
			}
		} 
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		int num = Integer.valueOf(query.execute().toString());
		pm.close();
		return num;
	}
	
	
	/**
	 *  获取未审核数 根据审核人 为审核数
	 * @param addressapplication
	 * @return
	 */
	public int queryAddressNoCheckerNum(XhjAddressapplication addressapplication){
		String sql ="select count(1) from XHJ_AddressApplication  a where a.CheckState =1 and a.CityID=" + SecurityUserHolder.getCurrentUserLogin().getCityId() + "";
		if(addressapplication!=null){
			if(StringUtils.hasText(addressapplication.getDateFrom())){
				sql += " and CreateDate>='" + addressapplication.getDateFrom() + " 00:00:00'";
			}
			if(StringUtils.hasText(addressapplication.getDateTo())){
				sql += " and CreateDate<='" + addressapplication.getDateTo() + " 23:59:59'";
			}
		} 
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		int num = Integer.valueOf(query.execute().toString());
		pm.close();
		return num;
	}
	
	public void saveCheck(XhjAddressapplication application, String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Transaction tx = pm.currentTransaction();
		try{
			tx.begin();
			XhjAddressapplication existAddressapplication = pm.getObjectById(XhjAddressapplication.class, application.getId());
			int userId = SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId();
			Date now = new Date();
			existAddressapplication.setZdid(application.getZdid());
			existAddressapplication.setDyid(application.getDyid());
			existAddressapplication.setFangHaoId(application.getFangHaoId());
			existAddressapplication.setMianji(application.getMianji());
			existAddressapplication.setLcid(application.getLcid());
			existAddressapplication.setTaltollou(application.getTaltollou());
			existAddressapplication.setCheckerId(userId);
			existAddressapplication.setCheckerComment(application.getCheckerComment());
			existAddressapplication.setCheckState(application.getCheckState());
			existAddressapplication.setShdate(new Date());
			if(application.getCheckState()==3){//待审核
				
			} else if(application.getCheckState()==1){//审核通过
				boolean needCheck = true;
				XhjLpdong dong = null;
				Integer existDongId = lpdongNameExist(pm, application.getLpId(), application.getZdid());
				if(existDongId==null){
					dong = new XhjLpdong();
					dong.setLpId(application.getLpId());
					dong.setLpdName(application.getZdid());
					dong.setCreatorId(userId);
					dong.setCreateDate(now);
					dong = pm.makePersistent(dong);
					existDongId = ((IntIdentity)pm.getObjectId(dong)).getKey();
					needCheck = false;
				}
				XhjLpdanyuan danyuan = null;
				Integer existDanyuanId = null;
				if(needCheck)
					existDanyuanId = lpdanyuanNameExist(pm, existDongId, application.getDyid());
				if(existDanyuanId==null){
					danyuan = new XhjLpdanyuan();
					danyuan.setDzid(existDongId);
					danyuan.setDyName(application.getDyid());
					danyuan.setCreatorId(userId);
					danyuan.setCreateDate(now);
					pm.makePersistent(danyuan);
					existDanyuanId = ((IntIdentity)pm.getObjectId(danyuan)).getKey();
					needCheck = false;
				}
				XhjLpfanghao fanghao = null;
				Integer existFanghaoId = null;
				if(needCheck)
					existFanghaoId = lpfanghaoNameExist(pm, existDanyuanId, application.getFangHaoId());
				if(existFanghaoId==null){
					fanghao = new XhjLpfanghao();
					fanghao.setNumber(generateFanghaoNumber(pm, application.getLpId()));
					fanghao.setDyId(existDanyuanId);
					fanghao.setFangHao(application.getFangHaoId());
					if(StringUtils.hasText(application.getLcid())){
						fanghao.setCeng(Integer.parseInt(application.getLcid()));
					}
					if(StringUtils.hasText(application.getTaltollou())){
						fanghao.setTotalFloor(Integer.parseInt(application.getTaltollou()));
					}
					fanghao.setTnmj(application.getMianji());
					fanghao.setOperatorId(userId);
					fanghao.setCreateDate(now);
					fanghao.setLeixing(41);
					fanghao.setLpid(application.getLpId());
					fanghao.setStatuss(1);
					pm.makePersistent(fanghao);
				}
			} else if(application.getCheckState()==2){//驳回
				
			}
			pm.makePersistent(existAddressapplication);
			tx.commit();
		}catch(Exception e){
			tx.rollback();
			throw new RuntimeException(e);
		} finally {
			if (tx.isActive()) {
				tx.rollback();
			}
			pm.close();
		}
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
		String sql = "select count(*) from xhj_lpdong a, xhj_lpdanyuan b, xhj_lpfanghao c where a.lpid="+lpId+" and a.id=b.dzid and b.id=c.dyid and a.lpd_name='"+dong+"' and b.dy_name='"+danyuan+"' and c.fanghao='"+fanghao+"'";
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		long count = (Long)query.execute();
		pm.close();
		return count>0;
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
		String sql = "select count(*) from Addressapplication where lpxx.id=? and zdid=? and dyid=? and fangHaoId=? and checkState in(0,3)";
		PersistenceManager pm = getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		long count = (Long)query.execute();
		pm.close();
		return count>0;
	}
	
	private Integer lpdongNameExist(PersistenceManager pm ,Integer lpId, String lpdName){
		String lpdNames = "'" + lpdName + "','" + lpdName+"栋','" + lpdName+"座','第"+lpdName+"栋','第"+lpdName+"座'";
		Query query = pm.newQuery("SQL", "select id from xhj_lpdong where lpid=" + lpId + " and lpd_name in(" + lpdNames + ")");
		query.setUnique(true);
		return (Integer)query.execute();
	}
	
	private Integer lpdanyuanNameExist(PersistenceManager pm ,int dzId, String dyName){
		String dyNames = "'" + dyName + "','" + dyName+"单元','第"+dyName+"单元'";
		Query query = pm.newQuery("SQL", "select id from xhj_lpdanyuan where dzid=" + dzId + " and dy_name in(" + dyNames + ")");
		query.setUnique(true);
		return (Integer)query.execute();
	}
	
	private Integer lpfanghaoNameExist(PersistenceManager pm ,int dyid, String fanghao){
		Query query = pm.newQuery("SQL", "select id from xhj_lpfanghao where dyid=" + dyid + " and fanghao='" + fanghao + "'");
		query.setUnique(true);
		return (Integer)query.execute();
	}
	
	/**
	 * 产生房号编码。
	 * @param pm
	 * @param lpid
	 * @return
	 */
	private String generateFanghaoNumber(PersistenceManager pm, Integer lpid){
		String lpsql = "select (select Number from xhj_jccity where id =l.CityID),(select number from xhj_jcstress where id=l.StressID) from xhj_lpxx l where id=" + lpid;
		Query query1 = pm.newQuery("SQL", lpsql);
		List<Object[]> listObj = (List<Object[]>) query1.execute();
		String queryInfo = "";
		for (Iterator iterator = listObj.iterator(); iterator.hasNext();) {
			Object[] objects = (Object[]) iterator.next();
			queryInfo = (objects[0] == null ? "" : objects[0]) + (objects[1] == null ? "" : objects[1].toString());
		}
		String maxNumberSQL = "select number from xhj_lpfanghao where number like'"+queryInfo+"%' ORDER BY number desc limit 1";
		query1 = pm.newQuery("SQL", maxNumberSQL);
		List<Object> obj = (List<Object>) query1.execute();
		Integer maxNumber = 0;
		for (Iterator iterator = obj.iterator(); iterator.hasNext();) {
			Object object = (Object) iterator.next();
			if(object != null) {
				maxNumber = Integer.valueOf(object.toString().substring(object.toString().length() - 8));
			}
		}
		return (queryInfo + codeAddOne(maxNumber,8));
	}
	
	private String codeAddOne(Integer maxNumber, int len){
	     maxNumber++;
	     String strHao = maxNumber.toString();
	     while (strHao.length() < len) {
	         strHao = "0" + strHao;
	     }
	     return strHao;
	 }
}
