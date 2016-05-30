package com.newenv.lpzd.lp.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.XhjFangHaoUtil;
import com.newenv.lpzd.lp.domain.LpDelegation;

public class LpDelegationDao extends DaoParent<LpDelegation> {
	public List<LpDelegation> getByHouseInfoId(Integer houseInfoId, String strategy){
		PersistenceManager pm = this.getPersistenceManagerByStratey(strategy);
	 	Query query =pm.newQuery(LpDelegation.class);
	 	query.setFilter(" state ==1 && houseInfoId =="+houseInfoId);
	 	List<LpDelegation> list=	(List<LpDelegation>)query.execute();
	 	for(LpDelegation ld:list){
	 		getPropertyNameValue(pm,ld);
	 	}
	 	pm.close();
		return list;
	}
	
	private void getPropertyNameValue(PersistenceManager pm,LpDelegation lpDelegation){
		switch (lpDelegation.getDelegateType()) {
		case 1:lpDelegation.setDelegateTypeName("出售");
			break;
		case 2:lpDelegation.setDelegateTypeName("出租");
		break;
		default:lpDelegation.setDelegateTypeName("");
			break;
		}
		String sql="select (select name from lp_syscs_1 where  id=ld.TaxingType) TaxingType," +
				"(select name from lp_syscs_1 where id=ld.RentingType) RentingType," +
				"(select name from lp_syscs_1 where id=ld.RentingWay) RentingWay, " +
				"(select name from lp_syscs_1 where id=ld.PayingType) PayingType, " +
				" (select name from lp_syscs_1 where id=ld.DelegatePurpose) DelegatePurpose," +
				" (select name from lp_syscs_1 where id=ld.OwnerPaymentType) OwnerPaymentType, " +
				"  (select name from lp_syscs_1 where id=ld.OwnerPayTax) OwnerPayTax, " +
				"(select name from lp_syscs_1 where id=ld.TaxAmount) TaxAmount," +
				" (select name from lp_syscs_1 where id=ld.CommissionRate) CommissionRate, " +
				"(select name from lp_syscs_1 where id=ld.DelegateSourceID) DelegateSourceID," +
				" (select name from lp_syscs_1 where id=ld.DelegateSourceParentID) DelegateSourceParentID, " +
				"(select name from lp_syscs_1 where id=ld.ShowingTime) ShowingTime " +
				"from lp_delegation ld where ld.id="+lpDelegation.getId();
	
	Query query=pm.newQuery("SQL",sql);
	ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();
	if(queryResult.size()>0 && queryResult!=null)
	{
		Object[] objs = (Object[])queryResult.get(0);
			lpDelegation.setTaxingTypeName(XhjFangHaoUtil.equeasParams(objs[0]));
			lpDelegation.setRentingTypeStr(XhjFangHaoUtil.equeasParams(objs[1]));
			lpDelegation.setRentingWayStr(XhjFangHaoUtil.equeasParams(objs[2]));
			lpDelegation.setPayingTypeStr(XhjFangHaoUtil.equeasParams(objs[3]));
			lpDelegation.setDelegatePurposeStr(XhjFangHaoUtil.equeasParams(objs[4]));
			lpDelegation.setOwnerPaymentTypeStr(XhjFangHaoUtil.equeasParams(objs[5]));
			lpDelegation.setOwnerPayTaxStr(XhjFangHaoUtil.equeasParams(objs[6]));
			lpDelegation.setTaxAmounStr(XhjFangHaoUtil.equeasParams(objs[7]));
			lpDelegation.setCommissionRateStr(XhjFangHaoUtil.equeasParams(objs[8]));
			lpDelegation.setDelegateSourceIdStr(XhjFangHaoUtil.equeasParams(objs[9]));
			lpDelegation.setDelegateSourceParentIdStr(XhjFangHaoUtil.equeasParams(objs[10]));
			lpDelegation.setShowingTimeStr(XhjFangHaoUtil.equeasParams(objs[11]));
	}
		
	}
}
