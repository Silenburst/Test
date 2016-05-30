package com.newenv.lpzd.lp.dao;

import java.math.BigDecimal;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.lp.domain.LpContractRecord;
import com.newenv.lpzd.lp.domain.LpDelegation;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;

public class LpContractRecordDao extends DaoParent<LpContractRecord> {

	/**
	 * 同步BMS的成交信息。
	 * @param houseType
	 * @param contractId
	 * @param strategy
	 */
	public void syncInfo(Integer houseType, Integer contractId, String strategy){
		String sql = "";
		if(houseType==1){	//售
			sql = "select h.housenumberid,c.contractdate,null,s.price,c.creatorid,f.number,c.contractnumber,d.id,c.buyercustomerid from xhj_contract c,xhj_housesource h,xhj_sellcontractinfo s, xhj_housesourceforsaling f "
					+ " left join lp_delegation d on d.delegatetype=1 and saleorrentid=f.id "
					+ " where c.housesourceid=f.id and f.housesourceid=h.id and c.id=s.contractid and c.id=" + contractId;
		} else {
			sql = "select h.housenumberid,c.contractdate,s.standardprice,null,c.creatorid,f.number,c.contractnumber,d.id from xhj_contract c,xhj_housesource h,xhj_rentcontractinfo s,xhj_houseinfoforrenting f "
					+ " left join lp_delegation d on d.delegatetype=1 and saleorrentid=f.id "
					+ " where c.housesourceid=f.id and f.housesourceid=h.id and c.id=s.contractid and d.delegatetype=2 and saleorrentid=f.id and c.id=" + contractId;
		}
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		Object[] obj = (Object[])query.execute();
		int index = 0;
		
		LpContractRecord lpContractRecord = new LpContractRecord();
		lpContractRecord.setSource(1);
		lpContractRecord.setHouseinfoid((Integer)obj[index++]);
		lpContractRecord.setContractDate((Date)obj[index++]);
		lpContractRecord.setPrice(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpContractRecord.setTotalPrice(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpContractRecord.setContractors((Integer)obj[index++]);
		lpContractRecord.setHsnumber((String)obj[index++]);
		lpContractRecord.setContractNumber((String)obj[index++]);
		lpContractRecord.setDelegationId((Integer)obj[index++]);
		
		if(lpContractRecord.getDelegationId()!=null)
			pm.newQuery("update " + LpDelegation.class.getName() + " set state==3 where id==" + lpContractRecord.getDelegationId()).execute();
		
		XhjLpfanghao fanghao = (XhjLpfanghao)pm.getObjectById(XhjLpfanghao.class, lpContractRecord.getHouseinfoid());
		if(houseType==1){	//售房成交更改户主资料
			fanghao.setYzid((Integer)obj[index++]);
		}
		if(houseType==1){
			fanghao.setFwzt(fanghao.getFwzt()-1);
		} else if(houseType==2){
			if(fanghao.getFwzt()==3){
				fanghao.setFwzt(2);
			} if(fanghao.getFwzt()==2){
				fanghao.setFwzt(0);
			}
		}
		pm.makePersistentAll(lpContractRecord, fanghao);
		pm.close();
	}
	
	private Double bigDecimalToDouble(BigDecimal v){
		return (v==null?null:v.doubleValue());
	}
}
