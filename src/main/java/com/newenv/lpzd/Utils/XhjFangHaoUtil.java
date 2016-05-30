package com.newenv.lpzd.Utils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjNewhouseinfo;

public class XhjFangHaoUtil {
	public static List<XhjLpfanghao> getXhjLpfanghao(List<Object[]> objes){
		List<XhjLpfanghao> xhjLpfanghaolist= new ArrayList<XhjLpfanghao>();
			for(Object[] objs:objes){
				XhjLpfanghao entity=new XhjLpfanghao();
				if(objs[0]!=null&&!"".equals(objs[0].toString())){
					entity.setId(Integer.parseInt(objs[0].toString()));
				}
				if(objs[1]!=null&&!"".equals(objs[1].toString())){
					entity.setDyId(Integer.parseInt(objs[1].toString()));
				}else{
					entity.setDyId(null);
				}
				if(objs[2]!=null&&!"".equals(objs[2].toString())){
					entity.setFhName(objs[2].toString());
				}else{
					entity.setFhName("");
				}
				if(objs[3]!=null&&!"".equals(objs[3])){
					entity.setNumber(objs[3].toString());
				}else{
					entity.setNumber("");
				}
				if(objs[4]!=null&&!"".equals(objs[4])){
					entity.setFangHao(objs[4].toString());
				}else{
					entity.setFangHao("");
				}
				if(objs[5]!=null&&!"".equals(objs[5])){
					entity.setCqmj(Double.parseDouble(objs[5].toString()));
				}else{
					entity.setCqmj(0.0);
				}
				if(objs[6]!=null&&!"".equals(objs[6])){
					entity.setChaoXiang(Integer.parseInt(objs[6].toString()));
				} else {
					entity.setChaoXiang(0);
				}
				if(objs[7]!=null&&!"".equals(objs[7])){
					entity.setCqxz(Integer.parseInt(objs[7].toString()));
				} else {
					entity.setCqxz(0);
				}
				if(objs[8]!=null&&!"".equals(objs[8])){
					entity.setBeiZhu(objs[8].toString());
				} else {
					entity.setBeiZhu("");
				}
				if(objs[9]!=null&&!"".equals(objs[9])){
					entity.setTnmj(Double.parseDouble(objs[9].toString()));
				} else {
					entity.setTnmj(0.0);
				}
				if(objs[10]!=null&&!"".equals(objs[10])){
					entity.setFwzt(Integer.parseInt(objs[10].toString()));
				}else{
					entity.setFwzt(null);
				}
				if(objs[11]!=null&&!"".equals(objs[11])){
					entity.setWtzt(Integer.parseInt(objs[11].toString()));
				}else{
					entity.setWtzt(0);
				}
				if(objs[12]!=null&&!"".equals(objs[12])){
					entity.setZt(Integer.parseInt(objs[12].toString()));
				}else{
					entity.setZt(0);
				}
				if(objs[13]!=null&&!"".equals(objs[13])){
					entity.setLxfsly(Integer.parseInt(objs[123].toString()));
				}else{
					entity.setLxfsly(0);
				}
				if(objs[14]!=null&&!"".equals(objs[14])){
					entity.setCeng(Integer.parseInt(objs[14].toString()));
				}else{
					entity.setCeng(0);
				}
				if(objs[15]!=null&&!"".equals(objs[15])){
					entity.setCengHao(objs[15].toString());
				}else{
					entity.setCengHao("");
				}
				if(objs[16]!=null&&!"".equals(objs[16])){
					entity.setShi(Integer.parseInt(objs[16].toString()));
				}else{
					entity.setShi(0);
				}
				if(objs[17]!=null&&!"".equals(objs[17])){
					entity.setTing(Integer.parseInt(objs[17].toString()));
				}else{
					entity.setTing(0);
				}
				if(objs[18]!=null&&!"".equals(objs[18])){
					entity.setChu(Integer.parseInt(objs[18].toString()));
				}else{
					entity.setChu(0);
				}
				if(objs[19]!=null&&!"".equals(objs[19])){
					entity.setWei(Integer.parseInt(objs[19].toString()));
				}else{
					entity.setWei(0);
				}
				if(objs[20]!=null&&!"".equals(objs[20])){
					entity.setYang(Integer.parseInt(objs[20].toString()));
				}else{
					entity.setYang(0);
				}
				if(objs[21]!=null&&!"".equals(objs[21])){
					entity.setYzid(Integer.parseInt(objs[21].toString()));
				}else{
					entity.setYzid(0);
				}
			/*	if(objs[22]!=null&&!"".equals(objs[22])){
					try {
						entity.setCreateDate(DateUtils.parseDate(objs[22].toString()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}else{
					entity.setCreateDate(null);
				}*/
				if(objs[23]!=null&&!"".equals(objs[23])){
					try {
						entity.setUpdateDate(DateUtils.parseDateTime(objs[23].toString()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(objs[24]!=null&&!"".equals(objs[24])){
					entity.setLeixing(Integer.parseInt(objs[24].toString()));
				}else{
					entity.setLeixing(0);
				}
				if(objs[25]!=null&&!"".equals(objs[25])){
					entity.setOperatorId(Integer.parseInt(objs[25].toString()));
				}else{
					entity.setOperatorId(0);
				}
				if(objs[26]!=null&&!"".equals(objs[26])){
					entity.setStatuss(Integer.parseInt(objs[26].toString()));
				}else{
					entity.setStatuss(0);
				}
				if(objs[27]!=null&&!"".equals(objs[27])){
					entity.setImagePath(objs[27].toString());
				}else{
					entity.setImagePath("");
				}
				if(objs[28]!=null&&!"".equals(objs[28])){
					entity.setTotalFloor(Integer.parseInt(objs[28].toString()));
				}else{
					entity.setTotalFloor(0);
				}
				if(objs[29]!=null&&!"".equals(objs[29])){
					entity.setPropertyAddress(objs[29].toString());
				}else{
					entity.setPropertyAddress("");
				}
				if(objs[30]!=null&&!"".equals(objs[30])){
					entity.setPropertyNumber(objs[30].toString());
				}else{
					entity.setPropertyNumber("");
				}
				if(objs[31]!=null&&!"".equals(objs[31])){
					entity.setPropertyAge(Integer.parseInt(objs[31].toString()));
				}else{
					entity.setPropertyAge(0);
				}
				if(objs[32]!=null&&!"".equals(objs[32])){
					entity.setResponsibleId(Integer.parseInt(objs[32].toString()));
				}else{
					entity.setResponsibleId(0);
				}
				if(objs[33]!=null&&!"".equals(objs[33])){
					entity.setBuildingAgeId(Integer.parseInt(objs[33].toString()));
				}else{
					entity.setBuildingAgeId(0);
				}
				if(objs[34]!=null&&!"".equals(objs[34])){
					entity.setPropertyFee(Double.parseDouble(objs[34].toString()));
				}else{
					entity.setPropertyFee(0.0);
				}
				if(objs[35]!=null&&!"".equals(objs[35])){
					entity.setPropertyInfo(Integer.parseInt(objs[35].toString()));
				}else{
					entity.setPropertyInfo(0);
				}
				if(objs[36]!=null&&!"".equals(objs[36])){
					entity.setTerritoryInfo(Integer.parseInt(objs[36].toString()));
				}else{
					entity.setTerritoryInfo(0);
				}
				if(objs[37]!=null&&!"".equals(objs[37])){
					entity.setHouselevel(Integer.parseInt(objs[37].toString()));
				}else{
					entity.setHouselevel(0);
				}
				if(objs[38]!=null&&!"".equals(objs[38])){
					entity.setMarketAddress(objs[38].toString());
				}else{
					entity.setMarketAddress("");
				}
				if(objs[39]!=null&&!"".equals(objs[39])){
					entity.setDecorationStandard(Integer.parseInt(objs[39].toString()));
				}else{
					entity.setDecorationStandard(0);
				}
				if(objs[40]!=null&&!"".equals(objs[40])){
					entity.setRecordNumber(objs[40].toString());
				}else{
					entity.setRecordNumber("");
				}
				if(objs[41]!=null&&!"".equals(objs[41])){
					entity.setDecoratedYears(Integer.parseInt(objs[41].toString()));
				}else{
					entity.setDecoratedYears(0);
				}
				if(objs[42]!=null&&!"".equals(objs[42])){
					entity.setIsChangedUnits(Integer.parseInt(objs[42].toString()));
				}else{
					entity.setIsChangedUnits(0);
				}
				if(objs[43]!=null&&!"".equals(objs[43])){
					entity.setIsHaving(Integer.parseInt(objs[43].toString()));
				}else{
					entity.setIsHaving(0);
				}
				if(objs[44]!=null&&!"".equals(objs[44])){
					entity.setSource(Integer.parseInt(objs[44].toString()));
				}else{
					entity.setSource(null);
				}
				if(objs[45]!=null&&!"".equals(objs[45])){
					entity.setCityId(Integer.parseInt(objs[45].toString()));
				}else{
					entity.setCityId(0);
				}
				if(objs[46]!=null&&!"".equals(objs[46])){
					entity.setStressId(Integer.parseInt(objs[46].toString()));
				}else{
					entity.setStressId(null);
				}
				if(objs[47]!=null&&!"".equals(objs[47])){
					entity.setSqId(Integer.parseInt(objs[47].toString()));
				}else{
					entity.setSqId(0);
				}
				if(objs[48]!=null&&!"".equals(objs[48])){
					entity.setLpid(Integer.parseInt(objs[48].toString()));
				}else{
					entity.setLpid(0);
				}
				if(objs[49]!=null&&!"".equals(objs[49])){
					entity.setBuildingId(Integer.parseInt(objs[49].toString()));
				}else{
					entity.setBuildingId(0);
				}
				if(objs[50]!=null&&!"".equals(objs[50])){
					entity.setBuildingType(Integer.parseInt(objs[50].toString()));
				}else{
					entity.setBuildingType(null);
				}
				if(objs[51]!=null&&!"".equals(objs[51])){
					entity.setCountryid(Integer.parseInt(objs[51].toString()));
				}else{
					entity.setCountryid(0);
				}
				if(objs[52]!=null&&!"".equals(objs[52])){
					entity.setProvinceid(Integer.parseInt(objs[52].toString()));
				}else{
					entity.setProvinceid(0);
				}
				xhjLpfanghaolist.add(entity);
			}
		return xhjLpfanghaolist;
	}
	public static List<XhjLpfanghao> getObjectAll(List<Object[]> list) {
		List<XhjLpfanghao> xhjLpfanghaoList = new ArrayList<XhjLpfanghao>();
		for (Object[] obj : list) {
			XhjLpfanghao entity = new XhjLpfanghao();
			if(obj[0]!=null&&!"".equals(obj[0])){
				entity.setId(Integer.parseInt(obj[0].toString()));
			}
			if(obj[1]!=null&&!"".equals(obj[1])){
				entity.setNumber(obj[1].toString());
			}else{
				entity.setNumber("");
			}
			
			if(obj[2]!=null&&!"".equals(obj[2])){
				entity.setLpName(obj[2].toString());
			}else{
				entity.setLpName("");
			}
			
			if(obj[3]!=null&&!"".equals(obj[3])){
				entity.setLeixingStr(obj[3].toString());
			}else{
				entity.setLeixingStr("");
			}
			
			
			if(obj[4]!=null&&!"".equals(obj[4])){
				entity.setShi(Integer.parseInt(obj[4].toString()));
			}else{
				entity.setShi(0);
			}
			
			if(obj[5]!=null&&!"".equals(obj[5])){
				entity.setTing(Integer.parseInt(obj[5].toString()));
			}else{
				entity.setTing(0);
			}
		
			if(obj[6]!=null&&!"".equals(obj[6])){
				entity.setTnmj(Double.parseDouble(obj[6].toString()));
			}else{
				entity.setTnmj(0.0);
			}
			
			if(obj[7]!=null&&!"".equals(obj[7])){
				entity.setChaoXiangName(obj[7].toString());
			}else{
				entity.setChaoXiangName("");
			}
			
			if(obj[8]!=null&&!"".equals(obj[8])){
				if(obj[8].toString().indexOf(".")>=0){
					entity.setUpdateDateStr(obj[8].toString().substring(0, obj[8].toString().indexOf(".")));
				}else{
					entity.setUpdateDateStr(obj[8].toString());
				}
				
			}else{
				entity.setUpdateDateStr("");
			}
			
			if(obj[9]!=null&&!"".equals(obj[9])){
				entity.setFwzt(Integer.parseInt(obj[9].toString()));
			}else{
				entity.setFwzt(null);
			}
			
			if(obj[10]!=null&&!"".equals(obj[10])){
				entity.setSource(Integer.parseInt(obj[10].toString()));
			}else{
				entity.setSource(null);
			}
			
			if(obj[11]!=null&&!"".equals(obj[11])){
				entity.setLpid(Integer.parseInt(obj[11].toString()));
			}else{
				entity.setLpid(0);
			}
			
			if(obj[12]!=null&&!"".equals(obj[12])){
				entity.setImagePath(obj[12].toString());
			}else{
				entity.setImagePath("");
			}
			if(obj[13]!=null&&!"".equals(obj[13])){
				entity.setIsHavingStr(obj[13].toString());
			}else{
				entity.setIsHavingStr("");
			}
			if(obj[14]!=null&&!"".equals(obj[14])){
				entity.setFhName(obj[14].toString());
			}else{
				entity.setFhName("");
			}
			if(obj[15]!=null&&!"".equals(obj[15])){
				entity.setFangHao(obj[15].toString());
			}else{
				entity.setFangHao("");
			}
			if(obj[16]!=null&&!"".equals(obj[16])){
				entity.setCeng(Integer.parseInt(obj[16].toString()));
			}else{
				entity.setCeng(0);
			}
			if(obj[17]!=null&&!"".equals(obj[17])){
				if(obj[17].toString().indexOf("单")>=0){
					entity.setDyName(obj[17].toString());
				}else{
					entity.setDyName(obj[17].toString()+"单元");
				}
			}else{
				entity.setDyName("");
			}
			if(obj[18]!=null&&!"".equals(obj[18])){
				if(obj[18].toString().indexOf("栋")>=0){
					entity.setLpdName(obj[18].toString());
				}else{
					entity.setLpdName(obj[18].toString()+"栋");
				}
				
			}else{
				entity.setLpdName("");
			}
			
			if(obj[19]!=null&&!"".equals(obj[19])){
				entity.setIsHaving(Integer.parseInt(obj[19].toString()));
			}else{
				entity.setIsHaving(0);
			}
			xhjLpfanghaoList.add(entity);
		}
		return xhjLpfanghaoList;
	}
	
	
	public static List<XhjLpschool> getObjectAllxq(List<Object[]> list) {
		List<XhjLpschool> xhjLpschoolList = new ArrayList<XhjLpschool>();
		for (Object[] obj : list) {
			XhjLpschool entity = new XhjLpschool();
			if(obj[0]!=null&&!"".equals(obj[0])){
				entity.setId(Integer.parseInt(obj[0].toString()));
			}
			if(obj[1]!=null&&!"".equals(obj[1])){
				entity.setSchoolName(obj[1].toString());
			}else{
				entity.setSchoolName("");
			}
			
			if(obj[2]!=null&&!"".equals(obj[2])){
				entity.setAddress(obj[2].toString());
			}else{
				entity.setAddress("");
			}
			
			if(obj[3]!=null&&!"".equals(obj[3])){
				entity.setImgPath(obj[3].toString());
			}else{
				entity.setImgPath("");
			}
			
			if(obj[4]!=null&&!"".equals(obj[4])){
				if(obj[4].toString().indexOf(".")>=0){
					entity.setCreateDateStr(obj[4].toString().substring(0,obj[4].toString().indexOf(".")));
				}else{
					entity.setCreateDateStr(obj[4].toString());
				}
				
			}else{
				entity.setCreateDateStr("");
			}
			
			if(obj[5]!=null&&!"".equals(obj[5])){
				entity.setXqnum(Integer.parseInt(obj[5].toString()));
			}else{
				entity.setXqnum(0);
			}
			if(obj[6]!=null&&!"".equals(obj[6])){
				entity.setCsnum(Integer.parseInt(obj[6].toString()));
			}else{
				entity.setCsnum(0);
			}
			if(obj[7]!=null&&!"".equals(obj[7])){
				entity.setCznum(Integer.parseInt(obj[7].toString()));
			}else{
				entity.setCznum(0);
			}
			if(obj[8]!=null&&!"".equals(obj[8])){
				entity.setKznum(Integer.parseInt(obj[8].toString()));
			}else{
				entity.setKznum(0);
			}
			if(obj[9]!=null&&!"".equals(obj[9])){
				entity.setXfnum(Integer.parseInt(obj[9].toString()));
			}else{
				entity.setXfnum(0);
			}
		
			
			xhjLpschoolList.add(entity);
		}
		return xhjLpschoolList;
	}
	public static List<XhjNewhouseinfo> getObjectAllxf(List<Object[]> list) {
		List<XhjNewhouseinfo> xhjNewhouseinfoList = new ArrayList<XhjNewhouseinfo>();
		for (Object[] obj : list) {
			XhjNewhouseinfo entity = new XhjNewhouseinfo();
			if(obj[0]!=null&&!"".equals(obj[0])){
				entity.setId(Integer.parseInt(obj[0].toString()));
			}
			if(obj[1]!=null&&!"".equals(obj[1])){
				entity.setDevelopers(obj[1].toString());
			}else{
				entity.setDevelopers("");
			}
			
			if(obj[2]!=null&&!"".equals(obj[2])){
				entity.setImg(obj[2].toString());
			}else{
				entity.setImg("");
			}
			if(obj[3]!=null&&!"".equals(obj[3])){
				entity.setAvgPrice(Double.parseDouble(obj[3].toString()));
			}else{
				entity.setAvgPrice(0.0);
			}
			
			if(obj[4]!=null&&!"".equals(obj[4])){
				entity.setLpName(obj[4].toString());
			}else{
				entity.setLpName("");
			}
			
			if(obj[5]!=null&&!"".equals(obj[5])){
				entity.setAddress(obj[5].toString());
			}else{
				entity.setAddress("");
			}
			if(obj[6]!=null&&!"".equals(obj[6])){
				entity.setUsagesStr(obj[6].toString());
			}else{
				entity.setUsagesStr("");
			}
			if(obj[7]!=null&&!"".equals(obj[7])){
				entity.setProjectId(Integer.parseInt(obj[7].toString()));
			}else{
				entity.setProjectId(null);
			}
			
			xhjNewhouseinfoList.add(entity);
		}
		return xhjNewhouseinfoList;
	}
	
	public static String equeasParams(Object obj)
	{
		String object = String.valueOf(obj);
		if(object.equals("") || object == null || object.equals("null") || object.equals("Null"))
		{
			return "";
		}
		return object.toString();
	}
	public static void main(String[] args) {
		String s="A1栋";
				System.out.println(s.substring(0, s.indexOf("栋")));
	}
}
