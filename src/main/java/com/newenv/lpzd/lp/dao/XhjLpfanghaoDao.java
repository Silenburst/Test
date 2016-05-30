package com.newenv.lpzd.lp.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

import org.datanucleus.store.rdbms.query.ForwardQueryResult;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.base.bigdata.dao.DaoParent;
import com.newenv.lpzd.Utils.DateUtils;
import com.newenv.lpzd.Utils.XhjFangHaoUtil;
import com.newenv.lpzd.base.domain.XhjLpschool;
import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.domain.LpContractRecord;
import com.newenv.lpzd.lp.domain.LpDelegation;
import com.newenv.lpzd.lp.domain.LpFacilityofhouse;
import com.newenv.lpzd.lp.domain.LpHouseOperationLog;
import com.newenv.lpzd.lp.domain.LpOperationLog;
import com.newenv.lpzd.lp.domain.XhjCommunicator;
import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpfanghaoimg;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.domain.XhjNewhouseinfo;
import com.newenv.lpzd.lp.domain.XhjPersoninfo;
import com.newenv.lpzd.lp.domain.vo.XhjLpfanghaoVo;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.pagination.PageInfo;

import diqu.Metro;

public class XhjLpfanghaoDao extends DaoParent<XhjLpfanghao>{
	
	private LpHouseOperationLogDao lpHouseOperationLogDao;
	
	//全部房屋
	public PageInfo findByPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String startmj,String endmj){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder("select count(lp.id) ");// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" fh.id, ");
		sql.append(" fh.Number, ");
		sql.append(" lp.LP_Name ,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where  fh.Leixing=sc.id) Leixing, ");
		sql.append(" fh.shi, ");
		sql.append(" fh.ting, ");
		sql.append(" fh.CQMJ, ");
		sql.append("(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang ,");
		sql.append(" fh.UpdateDate, ");
		sql.append(" fh.FWZT, ");
		sql.append(" fh.source,");
		sql.append(" ld.lpid,");
		sql.append(" fh.imagePath, ");
		sql.append(" (select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id) IsHaving,  ");
		sql.append(" fh.FH_Name, ");
		sql.append(" fh.FangHao, ");
		sql.append(" fh.Ceng, ");
		sql.append(" dy.Dy_Name, ");
		sql.append(" ld.Lpd_Name, ");
		sql.append(" fh.IsHaving ");
		sqlCommon.append("  from Xhj_LpFangHao fh ,Xhj_Lpxx lp ,Xhj_LpDanyuan dy ,xhj_lpdong ld   where ld.lpid=lp.id  and ld.id=dy.DZID and dy.id=fh.dyid ");
		sqlCommon.append(" and lp.Statuss =1");
		if(xhjLpfanghao.getStressId()!=null&&xhjLpfanghao.getStressId()!=0){
			sqlCommon.append(" and lp.StressID ="+xhjLpfanghao.getStressId());
		}
		if(xhjLpfanghao.getCityId()!=null&&xhjLpfanghao.getCityId()!=0){
			sqlCommon.append(" and lp.CityID ="+xhjLpfanghao.getCityId());
		}
		if(xhjLpfanghao.getSqId()!=null&&xhjLpfanghao.getSqId()!=0){
			sqlCommon.append(" and lp.SQ_ID ="+xhjLpfanghao.getSqId());
		}
		if(xhjLpfanghao.getProvinceid()!=null&&xhjLpfanghao.getProvinceid()!=0){
			sqlCommon.append(" and lp.provinceid ="+xhjLpfanghao.getProvinceid());
		}
		if(xhjLpfanghao.getCountryid()!=null&&xhjLpfanghao.getCountryid()!=0){
			sqlCommon.append(" and lp.countryid ="+xhjLpfanghao.getCountryid());
		}
		if(xhjLpfanghao.getShi()!=null&&xhjLpfanghao.getShi()!=0){
			sqlCommon.append(" and fh.shi ="+xhjLpfanghao.getShi());
		}
		if(xhjLpfanghao.getTing()!=null&&xhjLpfanghao.getTing()!=0){
			sqlCommon.append(" and fh.ting ="+xhjLpfanghao.getTing());
		}
		if(xhjLpfanghao.getWei()!=null&&xhjLpfanghao.getWei()!=0){
			sqlCommon.append(" and fh.wei ="+xhjLpfanghao.getWei());
		}
		if(xhjLpfanghao.getChaoXiang()!=null&&xhjLpfanghao.getChaoXiang()!=0){
			sqlCommon.append(" and fh.chaoXiang ="+xhjLpfanghao.getChaoXiang());
		}
		if(xhjLpfanghao.getLeixing()!=null&&xhjLpfanghao.getLeixing()!=0){
			sqlCommon.append(" and fh.leixing ="+xhjLpfanghao.getLeixing());
		}
		if(xhjLpfanghao.getDecorationStandard()!=null&&xhjLpfanghao.getDecorationStandard()!=0){
		sqlCommon.append(" and fh.decorationStandard ="+xhjLpfanghao.getDecorationStandard());
		}
		
		if(xhjLpfanghao.getBuildingType()!=null&&xhjLpfanghao.getBuildingType()!=0){
			sqlCommon.append(" and fh.BuildingType ="+xhjLpfanghao.getBuildingType());
			}
		
		if(xhjLpfanghao.getLpid()!=null&&xhjLpfanghao.getLpid()!=0){
			sqlCommon.append(" and ld.Lpid ="+xhjLpfanghao.getLpid());
			}
		if(xhjLpfanghao.getFangHao()!=null&&!"".equals(xhjLpfanghao.getFangHao())&&xhjLpfanghao.getFangHao()!="null"){
			sqlCommon.append(" and fh.FangHao ="+xhjLpfanghao.getFangHao());
			}
		
		if(xhjLpfanghao.getNumber()!=null&&!"".equals(xhjLpfanghao.getNumber())&&xhjLpfanghao.getNumber()!="null"){
			sqlCommon.append(" and fh.Number ='"+xhjLpfanghao.getNumber()+"'");
			}
		if(xhjLpfanghao.getDyId()!=null&&xhjLpfanghao.getDyId()!=0){
			sqlCommon.append(" and dy.id = "+xhjLpfanghao.getDyId());
			}
		if(xhjLpfanghao.getCeng()!=null&&xhjLpfanghao.getCeng()!=0){
			sqlCommon.append(" and fh.ceng = "+xhjLpfanghao.getCeng());
			}
		if(xhjLpfanghao.getDzId()!=null&&xhjLpfanghao.getDzId()!=0){
			sqlCommon.append(" and ld.id = "+xhjLpfanghao.getDzId());
			}
		if(startmj!=null&&!"".equals(startmj)&&!"-1".equals(startmj)){
			sqlCommon.append(" and fh.CQMJ >="+startmj);
			}
		if(endmj!=null&&!"".equals(endmj)){
			sqlCommon.append(" and fh.CQMJ <="+endmj);
		}
//		if(lpTag!=null&&!"".equals(lpTag)){
//			sqlCommon.append(" and lp.LP_Tag like '%,"+lpTag+"%'");
//		}
		if(xhjLpfanghao.getFwzt()!=null&&xhjLpfanghao.getFwzt()!=-1){
			sqlCommon.append(" and fh.FWZT= "+xhjLpfanghao.getFwzt());
		}
		if(xhjLpfanghao.getSchoolid()!=null&&xhjLpfanghao.getSchoolid()!=0){
			sqlCommon.append(" and EXISTS (select lpid from xhj_lplinkschool  where schoolid="+xhjLpfanghao.getSchoolid()+" and lpid=ld.lpid and type=1)");
		}
//		if(ltype!=null&&ltype!=-1){
//			sqlCommon.append(" and lp.l_type="+ltype);
//		}
		//sqlCommon.append("  ORDER BY fh.UpdateDate desc");
		sql.append(sqlCommon);
		sqlCount.append(sqlCommon);
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjLpfanghao> xhjLpfanghaoList = new ArrayList<XhjLpfanghao>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjLpfanghaoList=XhjFangHaoUtil.getObjectAll(list);
			for(XhjLpfanghao entity:xhjLpfanghaoList){
				getSchool(getPersistenceManagerByStratey(DAOConstants.RELATIONAL),entity);
			}
			pageInfo.setGridModel(xhjLpfanghaoList);
		}
		return pageInfo;
	}

	//地铁
	public PageInfo findBydtPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String startmj,String endmj){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder("select count(lp.id) ");// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" fh.id, ");
		sql.append(" fh.Number, ");
		sql.append("lp.LP_Name ,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where  fh.Leixing=sc.id) Leixing, ");
		sql.append(" fh.shi, ");
		sql.append(" fh.ting, ");
		sql.append(" fh.CQMJ, ");
		sql.append("(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang ,");
		sql.append(" fh.UpdateDate, ");
		sql.append(" fh.FWZT, ");
		sql.append(" fh.source,");
		sql.append(" ld.lpid,");
		sql.append(" fh.imagePath, ");
		sql.append(" (select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id) IsHaving,  ");
		sql.append(" fh.FH_Name, ");
		sql.append(" fh.FangHao, ");
		sql.append(" fh.Ceng, ");
		sql.append(" dy.Dy_Name,");
		sql.append("ld.Lpd_Name,  ");
		sql.append("fh.IsHaving ");
		sqlCommon.append("  from xhj_lpxx lp  INNER JOIN xhj_lpdong ld on ld.lpid=lp.id " +
				" INNER JOIN xhj_lplinkxianlu gx on ld.lpid=gx.lpid " +
				" INNER JOIN xhj_lpjiaotongzhantoxian xz ON gx.zhanid=xz.ZhanID " +
				" INNER JOIN xhj_lpjiaotongxian x ON xz.XianID=x.ID " +
				" INNER JOIN Xhj_LpDanyuan dy ON ld.id=dy.DZID " +
				" INNER JOIN  xhj_lpfanghao fh ON dy.id=fh.dyid  where 1=1 ");
		sqlCommon.append(" and lp.Statuss =1");
		if(xhjLpfanghao.getStressId()!=null&&xhjLpfanghao.getStressId()!=0){
			sqlCommon.append(" and lp.StressID ="+xhjLpfanghao.getStressId());
		}
		if(xhjLpfanghao.getSqId()!=null&&xhjLpfanghao.getSqId()!=0){
			sqlCommon.append(" and lp.SQ_ID ="+xhjLpfanghao.getSqId());
		}
		if(xhjLpfanghao.getShi()!=null&&xhjLpfanghao.getShi()!=0){
			sqlCommon.append(" and fh.shi ="+xhjLpfanghao.getShi());
		}
		if(xhjLpfanghao.getTing()!=null&&xhjLpfanghao.getTing()!=0){
			sqlCommon.append(" and fh.ting ="+xhjLpfanghao.getTing());
		}
		if(xhjLpfanghao.getWei()!=null&&xhjLpfanghao.getWei()!=0){
			sqlCommon.append(" and fh.wei ="+xhjLpfanghao.getWei());
		}
		if(xhjLpfanghao.getChaoXiang()!=null&&xhjLpfanghao.getChaoXiang()!=0){
			sqlCommon.append(" and fh.chaoXiang ="+xhjLpfanghao.getChaoXiang());
		}
		if(xhjLpfanghao.getLeixing()!=null&&xhjLpfanghao.getLeixing()!=0){
			sqlCommon.append(" and fh.leixing ="+xhjLpfanghao.getLeixing());
		}
		if(xhjLpfanghao.getDistance()!=null&&!"".equals(xhjLpfanghao.getDistance())&&!"0".equals(xhjLpfanghao.getDistance())){
			sqlCommon.append(" and gx.distance  >="+xhjLpfanghao.getDistance().substring(0, xhjLpfanghao.getDistance().indexOf("-")));
			sqlCommon.append(" and gx.distance <="+xhjLpfanghao.getDistance().substring(xhjLpfanghao.getDistance().indexOf("-")+1,xhjLpfanghao.getDistance().length()));
		}
		if(xhjLpfanghao.getDecorationStandard()!=null&&xhjLpfanghao.getDecorationStandard()!=0){
		sqlCommon.append(" and fh.decorationStandard ="+xhjLpfanghao.getDecorationStandard());
		}
		if(xhjLpfanghao.getBuildingType()!=null&&xhjLpfanghao.getBuildingType()!=0){
			sqlCommon.append(" and fh.BuildingType ="+xhjLpfanghao.getBuildingType());
			}
		if(xhjLpfanghao.getLpid()!=null&&xhjLpfanghao.getLpid()!=0){
			sqlCommon.append(" and ld.Lpid ="+xhjLpfanghao.getLpid());
			}
		
		if(startmj!=null&&!"".equals(startmj)&&!"-1".equals(startmj)){
			sqlCommon.append(" and fh.CQMJ >="+startmj);
			}
		if(endmj!=null&&!"".equals(endmj)){
			sqlCommon.append(" and fh.CQMJ <="+endmj);
		}
			//sqlCommon.append(" and lp.LP_Tag like '%,443%'");
		if(xhjLpfanghao.getXianluId()!=null&&xhjLpfanghao.getXianluId()!=0){
			sqlCommon.append(" and x.id ="+xhjLpfanghao.getXianluId());
		}
		if(xhjLpfanghao.getFwzt()!=null&&xhjLpfanghao.getFwzt()!=-1){
			sqlCommon.append(" and fh.FWZT= "+xhjLpfanghao.getFwzt());
		}
		//sqlCommon.append("  ORDER BY lp.R_Time desc");
		sql.append(sqlCommon);
		sqlCount.append(sqlCommon);
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjLpfanghao> xhjLpfanghaoList = new ArrayList<XhjLpfanghao>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjLpfanghaoList=XhjFangHaoUtil.getObjectAll(list);
			for(XhjLpfanghao entity:xhjLpfanghaoList){
				getSchool(getPersistenceManagerByStratey(DAOConstants.RELATIONAL),entity);
			}
			pageInfo.setGridModel(xhjLpfanghaoList);
		}
		return pageInfo;
	}
	
	//学区
	public PageInfo findByxqPage(XhjLpschool xhjLpschool, PageInfo pageInfo){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder();// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" ls.id, ");
		sql.append(" ls.SchoolName, ");
		sql.append(" ls.Address,  ");
		sql.append(" ls.ImgPath,   ");
		sql.append(" ls.createdate,   ");
		sql.append(" COUNT(gx.lpid) as xq_num, ");
		sql.append("  (SELECT count(1) FROM xhj_lpfanghao fh, xhj_lplinkschool s  where (fh.FWZT=1 or fh.FWZT=3) and fh.lpid=s.lpid and s.type=1 and s.schoolid=ls.id) cs_num,  ");
		sql.append("  (SELECT count(1) FROM xhj_lpfanghao fh, xhj_lplinkschool s  where (fh.FWZT=2 or fh.FWZT=3) and fh.lpid=s.lpid and s.type=1 and s.schoolid=ls.id) cz_num, ");
		sql.append(" (SELECT count(1) FROM xhj_lpfanghao fh, xhj_lplinkschool s  where fh.FWZT=0 and fh.lpid=s.lpid and s.type=1  and s.schoolid=ls.id) kz_num, ");
		sql.append(" (SELECT count(1) from xhj_newhouseinfo lp, xhj_lplinkschool s where  lp.ProjectID=s.lpid and s.type=1 and s.schoolid=ls.id) xf_num ");
		sqlCommon.append("from Xhj_LpSchool ls  LEFT JOIN xhj_lplinkschool gx on  ls.id=gx.schoolid where 1=1 ");
		sqlCommon.append(" and ls. Statuss =1");
		if(xhjLpschool.getQyID()!=null&&xhjLpschool.getQyID()!=0){
			sqlCommon.append(" and ls.QyID  ="+xhjLpschool.getQyID());
		}
		if(xhjLpschool.getSqid()!=null&&xhjLpschool.getSqid()!=0){
			sqlCommon.append(" and ls.sqid  ="+xhjLpschool.getSqid());
		}
			//sqlCommon.append(" and lp.LP_Tag like '%,442%'");
		if(xhjLpschool.getSchoolType()!=null&&xhjLpschool.getSchoolType()!=0){
			sqlCommon.append(" and ls.SchoolType  ="+xhjLpschool.getSchoolType());
		}
		if(xhjLpschool.getSchoolName()!=null&&!"".equals(xhjLpschool.getSchoolName())&&!"null".equals(xhjLpschool.getSchoolName())){
			sqlCommon.append(" and ls.SchoolName  like '%"+xhjLpschool.getSchoolName()+"%'");
		}
		sqlCommon.append("  group by ls.id ");
		sqlCommon.append(" Order by ls.CreateDate "+PageInfo.SORT_ORDER_DESC);
		sql.append(sqlCommon);
		sqlCount.append("select count(*) from ("+sql.toString()+") ss");
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjLpschool> xhjLpschoolList = new ArrayList<XhjLpschool>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjLpschoolList=XhjFangHaoUtil.getObjectAllxq(list);
			pageInfo.setGridModel(xhjLpschoolList);
		}
		return pageInfo;
	}

	//新房
	public PageInfo findByxfPage(XhjNewhouseinfo xhjNewhouseinfo, PageInfo pageInfo,String startAvgprice, String egerendAvgprice){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder();// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" xf.id, ");
		sql.append(" xf.developers,  ");
		sql.append(" lp.Img,");
		sql.append(" xf.AvgPrice,");
		sql.append(" lp.LP_Name,  ");
		sql.append(" lp.Address, ");
		sql.append("(select name from lp_syscs_1 sc where sc.id=xf.usages) usages, ");
		sql.append(" lp.id lpid   ");
		sqlCommon.append("from xhj_newhouseinfo xf,xhj_lpxx lp  where xf.ProjectID=lp.id  ");
		sqlCommon.append(" and lp.Statuss  =1");
		
		if(xhjNewhouseinfo.getStressId()!=null&&xhjNewhouseinfo.getStressId()!=0){
			sqlCommon.append(" and lp.StressID  ="+xhjNewhouseinfo.getStressId());
		}
		if(xhjNewhouseinfo.getSqId()!=null&&xhjNewhouseinfo.getSqId()!=0){
			sqlCommon.append(" and lp.SQ_ID  ="+xhjNewhouseinfo.getSqId());
		}
		
		if(xhjNewhouseinfo.getLpName()!=null&&!"".equals(xhjNewhouseinfo.getLpName())&&!"null".equals(xhjNewhouseinfo.getLpName())){
			sqlCommon.append(" and lp.LP_Name  like '%"+xhjNewhouseinfo.getLpName().trim()+"%'");
		}
		
		if(startAvgprice!=null&&!"".equals(startAvgprice)){
			sqlCommon.append(" and xf.AvgPrice >="+startAvgprice);
			}
		if(egerendAvgprice!=null&&!"".equals(egerendAvgprice)){
			sqlCommon.append(" and xf.AvgPrice <="+egerendAvgprice);
		}
		if(xhjNewhouseinfo.getSchoolid()!=null&&xhjNewhouseinfo.getSchoolid()!=0){
			sqlCommon.append(" and xf.ProjectID in(select lpid from xhj_lplinkschool  where schoolid="+xhjNewhouseinfo.getSchoolid()+")");
		}
		//sqlCommon.append(" order by lp.R_Time  desc ");
		sql.append(sqlCommon);
		sqlCount.append("select count(*) from ("+sql.toString()+") ss");
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjNewhouseinfo> xhjNewhouseinfoList = new ArrayList<XhjNewhouseinfo>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjNewhouseinfoList=XhjFangHaoUtil.getObjectAllxf(list);
			for(XhjNewhouseinfo entity :xhjNewhouseinfoList){
				getxfSchool(this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL),entity);
			}
			pageInfo.setGridModel(xhjNewhouseinfoList);
		}
		return pageInfo;
	}
	//学区房出售 出租 的列表
	public PageInfo findxqcsPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String lpTag,Integer delegateType){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder("select count(*)");// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" fh.id, ");
		sql.append(" fh.Number, ");
		sql.append("lp.LP_Name ,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where  fh.Leixing=sc.id) Leixing, ");
		sql.append(" fh.shi, ");
		sql.append(" fh.ting, ");
		sql.append(" fh.TNMJ, ");
		sql.append("(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang ,");
		sql.append(" fh.UpdateDate, ");
		sql.append(" fh.FWZT, ");
		sql.append(" fh.source,");
		sql.append(" fh.lpid,");
		sql.append(" fh.imagePath, ");
		sql.append(" (select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id) IsHaving,  ");
		sql.append(" fh.FH_Name ");
		sqlCommon.append(" from Xhj_LpFangHao fh ,Xhj_Lpxx  lp,lp_delegation ld   where fh.Lpid=lp.id  and fh.id=ld.HouseInfoID");
		sqlCommon.append(" and fh.Statuss =1");
		if(xhjLpfanghao.getStressId()!=null&&xhjLpfanghao.getStressId()!=0){
			sqlCommon.append(" and fh.stressId ="+xhjLpfanghao.getStressId());
		}
		if(delegateType!=null&&delegateType!=0){
			sqlCommon.append(" and ld.DelegateType="+delegateType);
		}
		
		if(xhjLpfanghao.getSchoolid()!=null&&xhjLpfanghao.getSchoolid()!=0){
			sqlCommon.append(" and fh.Lpid in(select lpid from xhj_lplinkschool  where schoolid="+xhjLpfanghao.getSchoolid()+")");
			}
		
		if(lpTag!=null&&!"".equals(lpTag)){
			sqlCommon.append(" and lp.LP_Tag like '%,"+lpTag+"%'");
		}
		
		sql.append(sqlCommon);
		sqlCount.append(sqlCommon);
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjLpfanghao> xhjLpfanghaoList = new ArrayList<XhjLpfanghao>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjLpfanghaoList=XhjFangHaoUtil.getObjectAll(list);
			for(XhjLpfanghao entity:xhjLpfanghaoList){
				getSchool(getPersistenceManagerByStratey(DAOConstants.RELATIONAL),entity);
			}
			pageInfo.setGridModel(xhjLpfanghaoList);
		}
		return pageInfo;
	}
	
	//学区房空置 新房的列表
	public PageInfo findkzPage(XhjLpfanghao xhjLpfanghao, PageInfo pageInfo,String lpTag,Integer delegateType,Integer ltype){
		StringBuilder sql = new StringBuilder(); //显示字段
		StringBuilder sqlCount = new StringBuilder("select count(*)");// 总数
		StringBuilder sqlCommon = new StringBuilder();//  表名
		sql.append("select ");
		sql.append(" fh.id, ");
		sql.append(" fh.Number, ");
		sql.append("lp.LP_Name ,  ");
		sql.append("(select sc.name from lp_syscs_1 sc where  fh.Leixing=sc.id) Leixing, ");
		sql.append(" fh.shi, ");
		sql.append(" fh.ting, ");
		sql.append(" fh.TNMJ, ");
		sql.append("(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang ,");
		sql.append(" fh.UpdateDate, ");
		sql.append(" fh.FWZT, ");
		sql.append(" fh.source,");
		sql.append(" fh.lpid,");
		sql.append(" fh.imagePath, ");
		sql.append(" (select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id) IsHaving,  ");
		sql.append(" fh.FH_Name ");
		sqlCommon.append(" from Xhj_LpFangHao fh ,Xhj_Lpxx  lp  where fh.Lpid=lp.id ");
		sqlCommon.append(" and fh.Statuss =1");
		if(xhjLpfanghao.getStressId()!=null&&xhjLpfanghao.getStressId()!=0){
			sqlCommon.append(" and fh.stressId ="+xhjLpfanghao.getStressId());
		}
		if(delegateType!=null&&delegateType!=0){
			sqlCommon.append(" and fh.FWZT="+delegateType);
		}
		
		if(xhjLpfanghao.getSchoolid()!=null&&xhjLpfanghao.getSchoolid()!=0){
			sqlCommon.append(" and fh.Lpid in(select lpid from xhj_lplinkschool  where schoolid="+xhjLpfanghao.getSchoolid()+")");
			}
		
		if(ltype!=null&&ltype!=-1){
			sqlCommon.append(" and lp.l_type="+ltype);
		}
		
		if(lpTag!=null&&!"".equals(lpTag)){
			sqlCommon.append(" and lp.LP_Tag like '%,"+lpTag+"%'");
		}
		
		sql.append(sqlCommon);
		sqlCount.append(sqlCommon);
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		if(pageInfo!=null&&pageInfo.getGridModel().size()>0){
			List<XhjLpfanghao> xhjLpfanghaoList = new ArrayList<XhjLpfanghao>();
			List<Object[]> list =(List<Object[]>)pageInfo.getGridModel();
			xhjLpfanghaoList=XhjFangHaoUtil.getObjectAll(list);
			for(XhjLpfanghao entity:xhjLpfanghaoList){
				getSchool(getPersistenceManagerByStratey(DAOConstants.RELATIONAL),entity);
			}
			pageInfo.setGridModel(xhjLpfanghaoList);
		}
		return pageInfo;
	}
	//详情
	public XhjLpfanghao getById(Integer id,String strategy){
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		XhjLpfanghao xhjLpfanghao=pm.getObjectById(XhjLpfanghao.class,id);
		this.getPropertyNameValue(pm,xhjLpfanghao);
		String message = "查看[" + xhjLpfanghao.getFangHao() + "]房号信息";
		lpHouseOperationLogDao.addLpLog("FH1005", message, String.valueOf(id));
		return xhjLpfanghao;
	}
	
	//详情
		public XhjLpfanghao getFangHaoId(Integer id,String strategy){
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			XhjLpfanghao xhjLpfanghao=pm.getObjectById(XhjLpfanghao.class,id);
			return xhjLpfanghao;
		}
	
	//详情
		public XhjLpfanghao getByfangHao(Integer id,String strategy){
			PersistenceManager pm = getPersistenceManagerByStratey(strategy);
			XhjLpfanghao xhjLpfanghao=pm.getObjectById(XhjLpfanghao.class,id);
			this.getPropertyNameValue(pm,xhjLpfanghao);
			return xhjLpfanghao;
		}
	
	public  List<LpFacilityofhouse> getLpFacilityofhouse(Integer houseinfoid ,String strategy){
		String sql ="select pt.id,(select sc.name from lp_syscs_1 sc where sc.id=pt.FacilityID) name,pt.Count,pt.Brand,pt.home_type  from lp_facilityofhouse pt where pt.houseinfoid="+houseinfoid;
		List<LpFacilityofhouse> list = new ArrayList<LpFacilityofhouse>();
		PersistenceManager pm= this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query= pm.newQuery("SQL",sql);
		List<Object[]> objectList=(List<Object[]>) query.execute();
		for(Object[] objs:objectList){
			LpFacilityofhouse entity = new LpFacilityofhouse();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setId(Integer.parseInt(objs[0].toString()));
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setFacilityIdName(objs[1].toString());
			}else{
				entity.setFacilityIdName("");
			}
			if(objs[2]!=null&&!"".equals(objs[2])){
				entity.setCount(Integer.parseInt(objs[2].toString()));
			}else{
				entity.setCount(0);
			}
			if(objs[3]!=null&&!"".equals(objs[3])){
				entity.setBrand(objs[3].toString());
			}else{
				entity.setBrand("");
			}
			
			if(objs[4]!=null&&!"".equals(objs[4])){
				entity.setHometype(Integer.parseInt(objs[4].toString()));
			}else{
				entity.setHometype(0);
			}
			list.add(entity);
		}
		return  list;
		
	}
	
	public  List<LpContractRecord> getlpContractRecords(Integer houseinfoid ,String strategy){
		StringBuffer sql= new StringBuffer();
		sql.append("select cr.hsnumber,cr.contract_number,cr.contract_date ,cr.price,cr.total_price,");
		sql.append("ld.DelegateType,");
		sql.append("u.fullname,u.tel,ul.username,");
		sql.append("(SELECT name from xhj_personinfo where id=fh.YZID) yezhu , cr.source,");
		sql.append("(SELECT telephone from xhj_communicator where personid=(SELECT id from xhj_personinfo where id=fh.YZID) LIMIT 1) yztel ");
		sql.append(" from  lp_contract_record  cr  left join xhj_lpfanghao fh on cr.houseinfoid=fh.ID left join tbl_user_profile u on cr.contractors=u.id left join tbl_user_login ul on u.id=ul.tbl_User_profile_id left  join lp_delegation ld on ld.id=cr.delegation_id ");
		sql.append(" where cr.houseinfoid="+houseinfoid);
		List<LpContractRecord> list = new ArrayList<LpContractRecord>();
		PersistenceManager pm= this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query= pm.newQuery("SQL",sql.toString());
		List<Object[]> objectList=(List<Object[]>) query.execute();
		for(Object[] objs:objectList){
			LpContractRecord entity = new LpContractRecord();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setHsnumber(objs[0].toString());
			}else{
				entity.setHsnumber("");
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setContractNumber(objs[1].toString());
			}else{
				entity.setContractNumber("");
			}
			if(objs[2]!=null&&!"".equals(objs[2])){
				if(objs[2].toString().indexOf(".")>=0){
					entity.setContractDateStr(objs[2].toString().substring(0, objs[2].toString().indexOf(".")));
				}else{
					entity.setContractDateStr(objs[2].toString());
				}
				
			}else{
				entity.setContractDateStr("");
			}
			if(objs[3]!=null&&!"".equals(objs[3])){
				entity.setPrice(Double.parseDouble(objs[3].toString()));
			}else{
				entity.setPrice(0.0);
			}
			if(objs[4]!=null&&!"".equals(objs[4])){
				entity.setTotalPrice(Double.parseDouble(objs[4].toString()));
			}else{
				entity.setTotalPrice(0.0);
			}
			if(objs[5]!=null&&!"".equals(objs[5])){
				entity.setDelegateType(Integer.parseInt(objs[5].toString()));
			}else{
				entity.setDelegateType(null);
			}
			if(objs[6]!=null&&!"".equals(objs[6])){
				entity.setFullname(objs[6].toString());
			}else{
				entity.setFullname("");
			}
			if(objs[7]!=null&&!"".equals(objs[7])){
				entity.setTel(objs[7].toString());
			}else{
				entity.setTel("");
			}
			if(objs[8]!=null&&!"".equals(objs[8])){
				entity.setUsername(objs[8].toString());
			}else{
				entity.setUsername("");
			}
			if(objs[9]!=null&&!"".equals(objs[9])){
				entity.setYezhu(objs[9].toString());
			}else{
				entity.setYezhu("");
			}
			if(objs[10]!=null&&!"".equals(objs[10])){
				switch (Integer.parseInt(objs[10].toString())) {
				case 1:entity.setSourceStr("内部系统");
					break;
				case 2:entity.setSourceStr("外部加盟");
					break;
				default:entity.setSourceStr("其他");
					break;
				}
				
			}else{
				entity.setSourceStr("");
			}
			if(objs[11]!=null&&!"".equals(objs[11])){
				entity.setYztel(objs[11].toString());
			}else{
				entity.setYztel("");
			}
			list.add(entity);
		}
		return  list;
		
	}
	
	public  PageInfo fianByxq(PageInfo pageInfo,Integer lpid ,String strategy){
		StringBuffer sql= new StringBuffer();
		StringBuffer sqlCount= new  StringBuffer();
		sql.append("select cr.hsnumber, cr.contract_number,cr.contract_date ,cr.price,cr.total_price,");
		sql.append("ld.DelegateType,");
		sql.append("u.fullname,u.tel,ul.username , cr.source,");
		sql.append("(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang ,");
		sql.append("(select sc.name from lp_syscs_1 sc where  fh.BuildingType=sc.id) BuildingType, ");
		sql.append(" fh.ImagePath,fh.shi,fh.ting,fh.TNMJ,fh.TotalFloor,fh.BuildingAgeID," +
				" (select sc.name from lp_syscs_1 sc where fh.DecorationStandard=sc.id ) DecorationStandard  ");
		sql.append("from  lp_contract_record  cr  left join xhj_lpfanghao fh on cr.houseinfoid=fh.ID left join tbl_user_profile u on cr.contractors=u.id " +
				"left join tbl_user_login ul on u.id=ul.tbl_User_profile_id left  join lp_delegation ld on ld.id=cr.delegation_id left join xhj_lpxx lp " +
				"on  fh.Lpid=lp.id ");
		sql.append(" where  lp.id="+lpid);
		sqlCount.append("select count(*) from ("+sql.toString()+")ss");
		List<XhjLpfanghaoVo> list = new ArrayList<XhjLpfanghaoVo>();
		PersistenceManager pm= this.getPersistenceManagerByStratey(DAOConstants.RELATIONAL);
		Query query= pm.newQuery("SQL",sql.toString());
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		int size=pageInfo.getGridModel().size();
		for(Object obj:pageInfo.getGridModel()){
			Object[] objs=(Object[])obj;
			XhjLpfanghaoVo entity = new XhjLpfanghaoVo();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setHsnumber(objs[0].toString());
			}else{
				entity.setHsnumber("");
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setContractNumber(objs[1].toString());
			}else{
				entity.setContractNumber("");
			}
			if(objs[2]!=null&&!"".equals(objs[2])){
				if(objs[2].toString().indexOf(".")>=0){
					entity.setContractDateStr(objs[2].toString().substring(0, objs[2].toString().indexOf(".")));
				}else{
					entity.setContractDateStr(objs[2].toString());
				}
				
			}else{
				entity.setContractDateStr("");
			}
			if(objs[3]!=null&&!"".equals(objs[3])){
				entity.setPrice(Double.parseDouble(objs[3].toString()));
			}else{
				entity.setPrice(0.0);
			}
			if(objs[4]!=null&&!"".equals(objs[4])){
				entity.setTotalPrice(Double.parseDouble(objs[4].toString()));
			}else{
				entity.setTotalPrice(0.0);
			}
			if(objs[5]!=null&&!"".equals(objs[5])){
				entity.setDelegateType(Integer.parseInt(objs[5].toString()));
			}else{
				entity.setDelegateType(null);
			}
			if(objs[6]!=null&&!"".equals(objs[6])){
				entity.setFullname(objs[6].toString());
			}else{
				entity.setFullname("");
			}
			if(objs[7]!=null&&!"".equals(objs[7])){
				entity.setTel(objs[7].toString());
			}else{
				entity.setTel("");
			}
			if(objs[8]!=null&&!"".equals(objs[8])){
				entity.setUsername(objs[8].toString());
			}else{
				entity.setUsername("");
			}
			if(objs[9]!=null&&!"".equals(objs[9])){
				switch (Integer.parseInt(objs[9].toString())) {
				case 1:entity.setSourceStr("内部系统");
					break;
				case 2:entity.setSourceStr("外部加盟");
					break;
				default:entity.setSourceStr("其他");
					break;
				}
				
			}else{
				entity.setSourceStr("");
			}
			if(objs[10]!=null&&!"".equals(objs[10])){
				entity.setChaoxiangStr(objs[10].toString());
			}else{
				entity.setChaoxiangStr("");
			}
			if(objs[11]!=null&&!"".equals(objs[11])){
				entity.setBuildingTypeName(objs[11].toString());
			}else{
				entity.setBuildingTypeName("");
			}
			if(objs[12]!=null&&!"".equals(objs[12])){
				entity.setImagePath(objs[12].toString());
			}else{
				entity.setImagePath("");
			}
			if(objs[13]!=null&&!"".equals(objs[13])){
				entity.setShi(Integer.parseInt(objs[14].toString()));
			}else{
				entity.setShi(0);
			}
			if(objs[14]!=null&&!"".equals(objs[14])){
				entity.setTing(Integer.parseInt(objs[14].toString()));
			}else{
				entity.setTing(0);
			}
			if(objs[15]!=null&&!"".equals(objs[15])){
				entity.setTnmj(Double.parseDouble(objs[15].toString()));
			}else{
				entity.setTnmj(0.0);
			}
			if(objs[16]!=null&&!"".equals(objs[16])){
				entity.setTotalPrice(Double.parseDouble(objs[16].toString()));
			}else{
				entity.setTotalPrice(0.0);
			}
			if(objs[17]!=null&&!"".equals(objs[17])){
				entity.setBuildingAgeId(Integer.parseInt(objs[17].toString()));
			}else{
				entity.setBuildingAgeId(0);
			}
			if(objs[18]!=null&&!"".equals(objs[18])){
				entity.setDecorationStandardStr(objs[18].toString());
			}else{
				entity.setDecorationStandardStr("");
			}
			list.add(entity);
		}
			pageInfo.setGridModel(list);

		return  pageInfo;
		
	}
	//房屋动态
	public  PageInfo fianhouselog(PageInfo pageInfo,Integer houseinfoid ,String strategy){
		StringBuffer sql= new StringBuffer();
		StringBuffer sqlCount= new  StringBuffer();
		sql.append("select  p.fullname, (select department_name from tbl_department d where d.id=lh.DepartmentID) DepartmentID ," +
				"lh.OperateDate ,lh.Operationtype ,lh.Message ,(select ImagePath from xhj_lpfanghao lp where lp.id=lh.houseinfoid) ImagePath ,p.tel");
		sql.append(" from  lp_house_operation_log lh,tbl_user_profile p   ");
		sql.append(" where   p.id=lh.OperatorID and lh.houseinfoid  ="+houseinfoid);
		sqlCount.append("select count(*) from ("+sql.toString()+")ss");
		List<LpHouseOperationLog> list = new ArrayList<LpHouseOperationLog>();
		pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
		for(Object obj:pageInfo.getGridModel()){
			Object[] objs=(Object[])obj;
			LpHouseOperationLog entity = new LpHouseOperationLog();
			if(objs[0]!=null&&!"".equals(objs[0])){
				entity.setOperatorIdStr(objs[0].toString());
			}else{
				entity.setOperatorIdStr("");
			}
			if(objs[1]!=null&&!"".equals(objs[1])){
				entity.setDepartmentIdStr(objs[1].toString());
			}else{
				entity.setOperatorIdStr("");
			}
			if(objs[2]!=null&&!"".equals(objs[2])){
				if(objs[2].toString().indexOf(".")>=0){
					entity.setOperateDateStr(objs[2].toString().substring(0, objs[2].toString().indexOf(".")));
				}else{
					entity.setOperateDateStr(objs[2].toString());
				}
				
			}else{
				entity.setOperateDateStr("");
			}
			if(objs[3]!=null&&!"".equals(objs[3])){
				entity.setOperationtype(objs[3].toString());
			}else{
				entity.setOperationtype("");
			}
			if(objs[4]!=null&&!"".equals(objs[4])){
				entity.setMessage(objs[4].toString());
			}else{
				entity.setMessage("");
			}
			if(objs[5]!=null&&!"".equals(objs[5])){
				entity.setImgPath(objs[5].toString());
			}else{
				entity.setImgPath("");
			}
			if(objs[6]!=null&&!"".equals(objs[6])){
				entity.setTel(objs[6].toString());
			}else{
				entity.setTel("");
			}
			list.add(entity);
		}
			pageInfo.setGridModel(list);

		return  pageInfo;
		
	}
	
	
	//新房动态
		public  PageInfo fianxfhouselog(PageInfo pageInfo,Integer  lpid,String strategy){
			StringBuffer sql= new StringBuffer();
			StringBuffer sqlCount= new  StringBuffer();
			sql.append("select  p.fullname, (select department_name from tbl_department d where d.id=lh.DepartmentID) DepartmentID ," +
					"lh.OperateDate ,lh.Operationtype ,lh.Message ,(select img from xhj_lpxx lp where lp.id=lh.lpid) ImagePath ,p.tel");
			sql.append(" from  lp_operation_log  lh,tbl_user_profile p   ");
			sql.append(" where   p.id=lh.OperatorID and lh.lpid  ="+lpid);
			sqlCount.append("select count(*) from ("+sql.toString()+")ss");
			List<LpOperationLog> list = new ArrayList<LpOperationLog>();
			pageInfo = getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
			for(Object obj:pageInfo.getGridModel()){
				Object[] objs=(Object[])obj;
				LpOperationLog entity = new LpOperationLog();
				if(objs[0]!=null&&!"".equals(objs[0])){
					entity.setOperatorIdStr(objs[0].toString());
				}else{
					entity.setOperatorIdStr("");
				}
				if(objs[1]!=null&&!"".equals(objs[1])){
					entity.setDepartmentIdStr(objs[1].toString());
				}else{
					entity.setOperatorIdStr("");
				}
				if(objs[2]!=null&&!"".equals(objs[2])){
					if(objs[2].toString().indexOf(".")>=0){
						entity.setOperateDateStr(objs[2].toString().substring(0, objs[2].toString().indexOf(".")));
					}else{
						entity.setOperateDateStr(objs[2].toString());
					}
					
				}else{
					entity.setOperateDateStr("");
				}
				if(objs[3]!=null&&!"".equals(objs[3])){
					entity.setOperationtype(objs[3].toString());
				}else{
					entity.setOperationtype("");
				}
				if(objs[4]!=null&&!"".equals(objs[4])){
					entity.setMessage(objs[4].toString());
				}else{
					entity.setMessage("");
				}
				if(objs[5]!=null&&!"".equals(objs[5])){
					entity.setImgPath(objs[5].toString());
				}else{
					entity.setImgPath("");
				}
				if(objs[6]!=null&&!"".equals(objs[6])){
					entity.setTel(objs[6].toString());
				}else{
					entity.setTel("");
				}
				list.add(entity);
			}
				pageInfo.setGridModel(list);

			return  pageInfo;
			
		}
	
	public void getPropertyNameValue(PersistenceManager pm,XhjLpfanghao xhjLpfanghao){
		String sql="select (select qy.Qy_Name from xhj_jcstress qy where qy.id=lp.StressID) Qy_Name,(select sq.Sq_Name from xhj_jcsq sq  where sq.id=lp.SQ_ID) Sq_Name,(select cc.City_Name from xhj_jccity cc where cc.id=lp.CityID) City_Name,lp.LP_Name,dy.Dy_Name,ld.Lpd_Name,(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang,";
		sql+="(select sc.name from lp_syscs_1 sc where fh.TerritoryInfo=sc.id ) TerritoryInfo, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.PropertyInfo=sc.id ) PropertyInfo, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.PropertyAge=sc.id ) PropertyAge, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.Leixing=sc.id ) Leixing, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.DecorationStandard=sc.id ) DecorationStandard, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id ) IsHaving, ";
		sql+="(select sc.name from lp_syscs_1 sc where fh.Houselevel=sc.id ) Houselevel,lp.x,lp.y,ld.lpid   ";
		sql +="from Xhj_LpFangHao fh ,Xhj_Lpxx lp ,Xhj_LpDanyuan dy ,xhj_lpdong ld   where ld.lpid=lp.id  and ld.id=dy.DZID and dy.id=fh.dyid  ";
		sql+=" and fh.id="+xhjLpfanghao.getId();
		Query  query = pm.newQuery("SQL",sql);
		ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();
		if(queryResult.size()>0 && queryResult!=null)
		{
			Object[] objs = (Object[])queryResult.get(0);
			xhjLpfanghao.setQyName(XhjFangHaoUtil.equeasParams(objs[0]));
			xhjLpfanghao.setSqName(XhjFangHaoUtil.equeasParams(objs[1]));
			xhjLpfanghao.setCityName(XhjFangHaoUtil.equeasParams(objs[2]));
			xhjLpfanghao.setLpName(XhjFangHaoUtil.equeasParams(objs[3]));
			xhjLpfanghao.setDyName(XhjFangHaoUtil.equeasParams(objs[4]));
			xhjLpfanghao.setZdName(XhjFangHaoUtil.equeasParams(objs[5]));
			xhjLpfanghao.setChaoXiangName(XhjFangHaoUtil.equeasParams(objs[6]));
			xhjLpfanghao.setTerritoryInfoStr(XhjFangHaoUtil.equeasParams(objs[7]));
			xhjLpfanghao.setPropertyInfoStr(XhjFangHaoUtil.equeasParams(objs[8]));
			xhjLpfanghao.setPropertyAgeStr(XhjFangHaoUtil.equeasParams(objs[9]));
			xhjLpfanghao.setLeixingStr(XhjFangHaoUtil.equeasParams(objs[10]));
			xhjLpfanghao.setZxName(XhjFangHaoUtil.equeasParams(objs[11]));
			xhjLpfanghao.setIsHavingStr(XhjFangHaoUtil.equeasParams(objs[12]));
			xhjLpfanghao.setHouselevelStr(XhjFangHaoUtil.equeasParams(objs[13]));
			xhjLpfanghao.setX(XhjFangHaoUtil.equeasParams(objs[14]));
			xhjLpfanghao.setY(XhjFangHaoUtil.equeasParams(objs[15]));
			xhjLpfanghao.setLpid(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[16])));
		}
		
		switch (xhjLpfanghao.getFwzt()!=null?xhjLpfanghao.getFwzt():-1) {
		case 0:xhjLpfanghao.setFwztStr("空置");
			break;
		case 1:xhjLpfanghao.setFwztStr("在售");
			break;
		case 2:xhjLpfanghao.setFwztStr("在租");
			break;
		case 3:xhjLpfanghao.setFwztStr("既租既售");
			break;
		default:xhjLpfanghao.setFwztStr("");
			break;
		}
		
		if(xhjLpfanghao.getUpdateDate()!=null){
			xhjLpfanghao.setUpdateDateStr(DateUtils.getDateStrC(xhjLpfanghao.getUpdateDate()));
		}
	
		
		/*if(xhjLpfanghao.getDyId()!=null){
			XhjLpdanyuan xhjLpdanyuan=pm.getObjectById(XhjLpdanyuan.class,xhjLpfanghao.getDyId());
			String sql ="select ld.Lpd_Name from  Xhj_LpDong ld  where ld.id="+xhjLpdanyuan.getDzid();
			Query query =pm.newQuery("SQL",sql);
			List object=	(List)query.execute();
			String lpDname=null;
			if(!object.isEmpty()){
				lpDname=(String)object.get(0).toString();
			}
			xhjLpdanyuan.setLpDname(lpDname);
			xhjLpfanghao.setDy(xhjLpdanyuan);
			
		}*/
		
		//房屋设施
		List<LpFacilityofhouse> list= getLpFacilityofhouse(xhjLpfanghao.getId(),DAOConstants.RELATIONAL);
		if(list!=null&&list.size()!=0){
			xhjLpfanghao.setLpFacilityofhouse(list);
		}
		//房屋成交 
		List<LpContractRecord> lpContractRecords = this.getlpContractRecords(xhjLpfanghao.getId(), DAOConstants.RELATIONAL);
		if(lpContractRecords!=null&&lpContractRecords.size()!=0){
			xhjLpfanghao.setLpContractRecords(lpContractRecords);
		}
		
	}

	public void getSchool(PersistenceManager pm,XhjLpfanghao xhjLpfanghao){
		String sql ="select s.SchoolName from  XHJ_LpLinkSchool  ls ,Xhj_LpSchool s   where  s.id=ls.schoolid  and  ls.Lpid="+xhjLpfanghao.getLpid();
		String sqldt ="select tz.ZdName,xl.XianLu_Name,lk.distance    from  XHJ_LpLinkXianlu   lk ,Xhj_LpJiaoTongZhan  tz, Xhj_LpJiaoTongZhanToXian  xzl, Xhj_LpJiaoTongXian  xl   where   lk.zhanid =tz.id and tz.id=xzl.ZhanID and xzl.XianID =xl.id  and  lk.Lpid="+xhjLpfanghao.getLpid();
		if(xhjLpfanghao.getLpid()!=null&&xhjLpfanghao.getLpid()!=0){
			Query query=pm.newQuery("SQL",sql);
			Query query2=pm.newQuery("SQL",sqldt);
			List<String> list =(List<String>)query.execute();
			List<Object[]> list2 =(List<Object[]>)query2.execute();
			if(list!=null&&list.size()>0){
				String schoolName="";
				for(String str:list){
					if(str!=null&&!"".equals(str)){
						schoolName +=str+",";
					}
				}
				
				xhjLpfanghao.setSchoolName(schoolName.substring(0, schoolName.length()-1));
			}
			if(list2!=null&&list2.size()>0){
				String ZdName="";
				for(Object[] objs:list2){
					if(objs[0]!=null&&!"".equals(objs[0])){
						if(objs[1]!=null&&!"".equals(objs[1])){
							if(objs[2]!=null&&!"".equals(objs[2])){
								if(objs[2].toString().indexOf(".")>=0){
									ZdName +="距离"+objs[1].toString()+""+objs[0].toString()+""+objs[2].toString().substring(0,objs[2].toString().indexOf("."))+"米,";
								}
								
							}else{
								ZdName +=objs[0].toString()+",";
							}
						}
					
						
					}
					
				}
				xhjLpfanghao.setZdName(ZdName.substring(0,ZdName.length()-1));
			}
		}
		
		switch (xhjLpfanghao.getFwzt()!=null?xhjLpfanghao.getFwzt():-1) {
		case 0:xhjLpfanghao.setFwztStr("空置");
			break;
		case 1:xhjLpfanghao.setFwztStr("在售");
			break;
		case 2:xhjLpfanghao.setFwztStr("在租");
			break;
		case 3:xhjLpfanghao.setFwztStr("既租既售");
			break;
		default:xhjLpfanghao.setFwztStr("");
			break;
		}
		switch (xhjLpfanghao.getSource()!=null?xhjLpfanghao.getSource():-1){
		case 1:xhjLpfanghao.setSourceStr("内部系统");
		break;
		case 2:xhjLpfanghao.setSourceStr("外部加盟");
		break;
		case 3:xhjLpfanghao.setSourceStr("其他");
		break;
		default:xhjLpfanghao.setSourceStr("");
		break;
		}
		
		
		
	}
	
	public void getxfSchool(PersistenceManager pm,XhjNewhouseinfo xhjNewhouseinfo){
		String sql ="select s.SchoolName from  XHJ_LpLinkSchool  ls ,Xhj_LpSchool s   where  s.id=ls.schoolid  and  ls.Lpid="+xhjNewhouseinfo.getProjectId();
		String sqldt ="select tz.ZdName,xl.XianLu_Name,lk.distance    from  XHJ_LpLinkXianlu   lk ,Xhj_LpJiaoTongZhan  tz, Xhj_LpJiaoTongZhanToXian  xzl, Xhj_LpJiaoTongXian  xl   where   lk.zhanid =tz.id and tz.id=xzl.ZhanID and xzl.XianID =xl.id  and  lk.Lpid="+xhjNewhouseinfo.getProjectId();
		if(xhjNewhouseinfo.getProjectId()!=null&&xhjNewhouseinfo.getProjectId()!=0){
			Query query=pm.newQuery("SQL",sql);
			Query query2=pm.newQuery("SQL",sqldt);
			List<String> list =(List<String>)query.execute();
			List<Object[]> list2 =(List<Object[]>)query2.execute();
			if(list!=null&&list.size()>0){
				String schoolName="";
				for(String str:list){
					if(str!=null&&!"".equals(str)){
						schoolName +=str+",";
					}
					
				}
				xhjNewhouseinfo.setSchoolName(schoolName.substring(0,schoolName.length()-1));
			}
			if(list2!=null&&list2.size()>0){
				String zdName ="";
				for(Object[] objs:list2){
					if(objs[0]!=null&&!"".equals(objs[0])){
						if(objs[1]!=null&&!"".equals(objs[1])){
							if(objs[2]!=null&&!"".equals(objs[2])){
								zdName +="距离"+objs[1].toString()+""+objs[0].toString()+""+objs[2].toString()+"米,";
							}else{
								zdName +=objs[0].toString()+",";
							}
						}
					
						
					}
					
				}
				xhjNewhouseinfo.setZdName(zdName.substring(0,zdName.length()-1));
			}
		}
		
		
	}
	
	
	
	
	
	
	
	
	public XhjPersoninfo getXhjPersoninfo(Integer yzid,String strategy){
		PersistenceManager pm =this.getPersistenceManagerByStratey(strategy);
		XhjPersoninfo xhjPersoninfo=pm.getObjectById(XhjPersoninfo.class,yzid);
		String  sql  ="select  xc.Telephone,(select name from  lp_syscs_1 where id= xc.RelationType)relationTypeName  from  xhj_communicator xc where xc.PersonID="+xhjPersoninfo.getId();
	 Query	query =pm.newQuery("SQL",sql);
	 List<Object[]> list =(List<Object[]>)query.execute();
	 List<XhjCommunicator> xhjCommunicators = new ArrayList<XhjCommunicator>();
	 for(Object[] objs:list){
		 XhjCommunicator entity = new XhjCommunicator();
		 if(objs[0]!=null&&!"".equals(objs[0])){
			 entity.setTelephone(objs[0].toString());
		 }else{
			 entity.setTelephone("");
		 }
		 if(objs[1]!=null&&!"".equals(objs[1])){
			 entity.setRelationTypeName(objs[1].toString());
		 }else{
			 entity.setRelationTypeName("");
		 }
		 xhjCommunicators.add(entity);
	 }
		xhjPersoninfo.setXhjCommunicators(xhjCommunicators);
		return xhjPersoninfo;
	}
	
	/*
	 * 单个保存房号
	 */
	public String saveFanghaoSingle( int userid, XhjLpfanghao xhjLpfanghao,String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		XhjLpfanghao lpfanghao = null;
		try {
			tx.begin();
			Query query =pm.newQuery(XhjLpfanghao.class);
			query.setFilter(" fangHao =='"+xhjLpfanghao.getFangHao()+"' && dyId ==" + xhjLpfanghao.getDyId());
			List<XhjLpfanghao> list = (List<XhjLpfanghao>)query.execute();
			if(list == null || list.size() == 0) {
				String lpsql = "select (select Number from xhj_jccity where id =l.CityID),(select number from xhj_jcstress where id=l.StressID) from xhj_lpxx l where id=" + xhjLpfanghao.getLpid();
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
				String number = queryInfo + codeAddOne(maxNumber,8);
				
				lpfanghao = new XhjLpfanghao();
				lpfanghao.setFangHao(xhjLpfanghao.getFangHao());
				lpfanghao.setLeixing(xhjLpfanghao.getLeixing());
				lpfanghao.setDyId(xhjLpfanghao.getDyId());
				lpfanghao.setOperatorId(userid);
				lpfanghao.setNumber(number);
				lpfanghao.setFwzt(0);
				lpfanghao.setCeng(xhjLpfanghao.getCeng());
				lpfanghao.setCreateDate(new Date());
				lpfanghao.setStatuss(1);
				lpfanghao.setLpid(xhjLpfanghao.getLpid());
				lpfanghao.setShi(xhjLpfanghao.getShi());
				lpfanghao.setTing(xhjLpfanghao.getTing());
				lpfanghao.setChu(xhjLpfanghao.getChu());
				lpfanghao.setWei(xhjLpfanghao.getWei());
				lpfanghao.setChaoXiang(xhjLpfanghao.getChaoXiang());
				lpfanghao.setDecorationStandard(xhjLpfanghao.getDecorationStandard());
				lpfanghao.setCqmj(xhjLpfanghao.getCqmj());
				lpfanghao.setTnmj(xhjLpfanghao.getTnmj());
				lpfanghao.setBeiZhu(xhjLpfanghao.getBeiZhu());
				lpfanghao.setTotalFloor(xhjLpfanghao.getTotalFloor());
				lpfanghao = pm.makePersistent(lpfanghao);
			} else {
				throw new Exception("当前房号已存在!");
			}
			tx.commit();
			return lpfanghao.getId() + "";
		} catch (Exception e) {
			tx.rollback();
			throw e;
		}
	}
	
	 private String codeAddOne(Integer maxNumber, int len){
	     maxNumber++;
	     String strHao = maxNumber.toString();
	     while (strHao.length() < len) {
	         strHao = "0" + strHao;
	     }
	     return strHao;
	 }

	/*
	 * 批量保存房号
	 */
	public String saveFanghaoBatch(String datas, int userid,XhjLpfanghao xhjLpfanghao,String relational ) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		Transaction tx = pm.currentTransaction();
		String fanghid = "";
		try {
			String[] floors = datas.split("##");
			String[] fanghaos = null;
			int ceng = 0;
			Integer maxNumber = 0;
			String lpsql = "select (select Number from xhj_jccity where id =l.CityID),(select number from xhj_jcstress where id=l.StressID) from xhj_lpxx l where id=" + xhjLpfanghao.getLpid();
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
			for (Iterator iterator = obj.iterator(); iterator.hasNext();) {
				Object object = (Object) iterator.next();
				if(object != null) {
					maxNumber = Integer.valueOf(object.toString().substring(object.toString().length() - 8));
				}
			}
			for(String floor : floors){
				fanghaos = floor.split("@@");
				ceng = Integer.parseInt(fanghaos[0]);
				for(int i=1;i<fanghaos.length;i++){
					Query query =pm.newQuery(XhjLpfanghao.class);
					query.setFilter(" fangHao =='"+fanghaos[i]+"' && dyId ==" + xhjLpfanghao.getDyId());
					List<XhjLpfanghao> list = (List<XhjLpfanghao>)query.execute();
					if(list == null || list.size() == 0) {
						tx.begin();
						String number = queryInfo + codeAddOne(maxNumber,8);
						XhjLpfanghao lpfanghao = new XhjLpfanghao();
						lpfanghao.setLeixing(xhjLpfanghao.getLeixing());
						lpfanghao.setDyId(xhjLpfanghao.getDyId());
						lpfanghao.setFangHao(fanghaos[i]);
						lpfanghao.setOperatorId(userid);
						lpfanghao.setNumber(number);
						lpfanghao.setFwzt(0);
						lpfanghao.setCeng(Integer.valueOf(ceng));
						lpfanghao.setCreateDate(new Date());
						lpfanghao.setStatuss(1);
						lpfanghao.setLpid(xhjLpfanghao.getLpid());
						lpfanghao.setShi(xhjLpfanghao.getShi());
						lpfanghao.setTing(xhjLpfanghao.getTing());
						lpfanghao.setChu(xhjLpfanghao.getChu());
						lpfanghao.setWei(xhjLpfanghao.getWei());
						lpfanghao.setChaoXiang(xhjLpfanghao.getChaoXiang());
						lpfanghao.setDecorationStandard(xhjLpfanghao.getDecorationStandard());
						lpfanghao.setCqmj(xhjLpfanghao.getCqmj());
						lpfanghao.setTnmj(xhjLpfanghao.getTnmj());
						lpfanghao.setBeiZhu(xhjLpfanghao.getBeiZhu());
						lpfanghao.setTotalFloor(xhjLpfanghao.getTotalFloor());
						lpfanghao = pm.makePersistent(lpfanghao);
						maxNumber++;
						tx.commit();
						fanghid += (!"".equals(fanghid) ? "," + lpfanghao.getId() : lpfanghao.getId());
					}
				}
			}
			return fanghid;
		} catch (Exception e) {
			tx.rollback();
			throw e;
		}
	}

	/**
	 * 获取对应房号
	 * @param fanghId
	 * @return
	 */
	public XhjLpfanghao findFanghaoById(Integer fanghId, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		return pm.getObjectById(XhjLpfanghao.class, fanghId);
	}


	public void doUpdateFanghao(XhjLpfanghao xhjLpfanghao, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpfanghao oldFangh = pm.getObjectById(XhjLpfanghao.class, xhjLpfanghao.getId());
		Transaction tx = pm.currentTransaction();
		try {
			tx.begin();
			if(!oldFangh.getFangHao().equals(xhjLpfanghao.getFangHao())) {
				Query query =pm.newQuery(XhjLpfanghao.class);
				query.setFilter(" fangHao =='"+xhjLpfanghao.getFangHao()+"' && dyId ==" + xhjLpfanghao.getDyId());
				List<XhjLpfanghao> list = (List<XhjLpfanghao>)query.execute();
				if(list == null || list.size() == 0) {
						oldFangh.setFangHao(xhjLpfanghao.getFangHao());
						oldFangh.setFhName(xhjLpfanghao.getFhName());
						oldFangh.setLeixing(xhjLpfanghao.getLeixing());
						oldFangh.setUpdateDate(new Date());
						oldFangh.setShi(xhjLpfanghao.getShi());
						oldFangh.setTing(xhjLpfanghao.getTing());
						oldFangh.setChu(xhjLpfanghao.getChu());
						oldFangh.setWei(xhjLpfanghao.getWei());
						oldFangh.setChaoXiang(xhjLpfanghao.getChaoXiang());
						oldFangh.setDecorationStandard(xhjLpfanghao.getDecorationStandard());
						oldFangh.setCqmj(xhjLpfanghao.getCqmj());
						oldFangh.setTnmj(xhjLpfanghao.getTnmj());
						oldFangh.setBeiZhu(xhjLpfanghao.getBeiZhu());
						oldFangh.setTotalFloor(xhjLpfanghao.getTotalFloor());
					pm.makePersistent(oldFangh);
				} else {
					throw new Exception("当前房号已存在!");
				}
			} else {
					oldFangh.setFangHao(xhjLpfanghao.getFangHao());
					oldFangh.setFhName(xhjLpfanghao.getFhName());
					oldFangh.setLeixing(xhjLpfanghao.getLeixing());
					oldFangh.setUpdateDate(new Date());
					oldFangh.setShi(xhjLpfanghao.getShi());
					oldFangh.setTing(xhjLpfanghao.getTing());
					oldFangh.setChu(xhjLpfanghao.getChu());
					oldFangh.setWei(xhjLpfanghao.getWei());
					oldFangh.setChaoXiang(xhjLpfanghao.getChaoXiang());
					oldFangh.setDecorationStandard(xhjLpfanghao.getDecorationStandard());
					oldFangh.setCqmj(xhjLpfanghao.getCqmj());
					oldFangh.setTnmj(xhjLpfanghao.getTnmj());
					oldFangh.setBeiZhu(xhjLpfanghao.getBeiZhu());
					oldFangh.setTotalFloor(xhjLpfanghao.getTotalFloor());
					pm.makePersistent(oldFangh);
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw e;
		}
	}

	/**
	 * 删除房号
	 * @param id
	 */
	public String deleteFangh(String id, String relational) {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		XhjLpfanghao fangh = pm.getObjectById(XhjLpfanghao.class, Integer.valueOf(id));
		String fanghao = fangh.getFangHao();
		if(fangh != null) {
			pm.deletePersistent(fangh);
		}
		String delImg = "delete from " + XhjLpfanghaoimg.class.getName() + " where fanghaoid==" + id;
		pm.newQuery(delImg).execute();
		return fanghao;
	}
	
	/**
	 * 同步信息。
	 */
	public void syncInfo(HouseSourceKey houseSourceKey, String strategy){
		String sql = "";
		if(houseSourceKey.getHouseType()==1){	//售
			sql = "select f.Number,h.housenumberid,f.housesourcestatus,h.buildingSize,h.orientationId,h.propertyInfo,h.innerSize,h.roomNumber,h.hallNumber,h.kitchenNumber,h.toiletNumber,h.balconyNumber,"
					+ " f.ownerid,h.useage,h.totalFloor,h.propertyNumber,h.marketAddress,h.propertyAddress,h.propertyAge,h.buildingAgeId,h.territoryInfo,f.hlevel,"
					+ " h.decorationStandard,h.decoratedYears,h.isHaving,d.DelegateSourceParentID,d.DelegateSourceID,d.DelegateDate,d.DelegateLimit,d.OwnerPaymentType,d.ShowingTime,d.OccupancyTime, "
					+ " d.CommissionRate,d.TaxAmount,d.OwnerPayTax,d.TaxingType,d.DelegatorID,d.CreateDate,d.State,f.SaleReason, f.IsMortgage,null,null,null,null,null,null,null,null,null,null,null,f.Price,f.TotalPrice "
					+ " from xhj_housesourceforsaling f, xhj_housesource h ,xhj_housesourcedelegation d where f.housesourceid=h.id and h.id=d.housesourceid "
					+ " and f.housetype=" + houseSourceKey.getHouseType() + " and saleorrentid=" + houseSourceKey.getSaleOrRentId() ;
		} else {
			sql = "select f.Number,h.housenumberid,f.housesourcestatus,h.buildingSize,h.orientationId,h.propertyInfo,h.innerSize,h.roomNumber,h.hallNumber,h.kitchenNumber,h.toiletNumber,h.balconyNumber,"
					+ " f.ownerid,h.useage,h.totalFloor,h.propertyNumber,h.marketAddress,h.propertyAddress,h.propertyAge,h.buildingAgeId,h.territoryInfo,f.hlevel,"
					+ " h.decorationStandard,h.decoratedYears,h.isHaving,d.DelegateSourceParentID,d.DelegateSourceID,d.DelegateDate,d.DelegateLimit,d.OwnerPaymentType,d.ShowingTime,d.OccupancyTime, "
					+ " d.CommissionRate,d.TaxAmount,d.OwnerPayTax,d.TaxingType,d.DelegatorID,d.CreateDate,d.State,null, null,f.RentingType,f.DelegatePurpose,f.RentingWay,f.PayingType,f.IsFirstTimeOfRenting,f.DiscountOfRenewal,f.PenaltyAmount,f.MortgageRate,f.PayRate,f.RentBeginDate,f.RentEndDate,f.Price,f.TotalPrice "
					+ " from xhj_houseinfoforrenting f, xhj_housesource h ,xhj_housesourcedelegation d where f.housesourceid=h.id and h.id=d.housesourceid "
					+ " and f.housetype=" + houseSourceKey.getHouseType() + " and saleorrentid=" + houseSourceKey.getSaleOrRentId() ;
		}
		
		PersistenceManager pm = getPersistenceManagerByStratey(strategy);
		Query query = pm.newQuery("SQL", sql);
		query.setUnique(true);
		Object[] obj = (Object[])query.execute();
		int index = 0;
		String houseSourceNumber = (String)obj[index++];
		Integer fanghaoId = (Integer)obj[index++];
		Integer houseSourceStatus = (Integer)obj[index++];
		XhjLpfanghao fangh = pm.getObjectById(XhjLpfanghao.class, fanghaoId);
		fangh.setCqmj(bigDecimalToDouble((BigDecimal)obj[index++]));			//产权面积
		fangh.setChaoXiang((Integer)obj[index++]);		//朝向
		fangh.setPropertyInfo((Integer)obj[index++]);	//产权属性
		fangh.setTnmj(bigDecimalToDouble((BigDecimal)obj[index++]));			//套内面积
		fangh.setShi((Integer)obj[index++]);			//室
		fangh.setTing((Integer)obj[index++]);			//厅
		fangh.setWei((Integer)obj[index++]);			//卫
		fangh.setChu((Integer)obj[index++]);			//厨
		fangh.setYang((Integer)obj[index++]);			//阳台
		fangh.setYzid((Integer)obj[index++]);			//业主ID
		fangh.setLeixing((Integer)obj[index++]);		//类型、用途
		fangh.setTotalFloor((Integer)obj[index++]);		//总楼层
		fangh.setPropertyNumber((String)obj[index++]);	//产权编号
		fangh.setMarketAddress((String)obj[index++]);
		fangh.setPropertyAddress((String)obj[index++]);
		fangh.setPropertyAge((Integer)obj[index++]);
		fangh.setBuildingAgeId((Integer)obj[index++]);
		fangh.setTerritoryInfo((Integer)obj[index++]);
		fangh.setHouselevel((Integer)obj[index++]);
		fangh.setDecorationStandard((Integer)obj[index++]);
		fangh.setDecoratedYears((Integer)obj[index++]);
		fangh.setIsHaving((Integer)obj[index++]);
		fangh.setUpdateDate(new Date());
		fangh.setSource(1);			//来源内部
		
		if(houseSourceStatus==1){
			if(houseSourceKey.getHouseType()==1){
				if(fangh.getFwzt()==0 || fangh.getFwzt()==2){
					fangh.setFwzt(fangh.getFwzt()+1);
				}
			} else if(houseSourceKey.getHouseType()==2){
				if(fangh.getFwzt()==0){
					fangh.setFwzt(2);
				} else if(fangh.getFwzt()==1){
					fangh.setFwzt(3);
				}
			}
		}
		
		//查询委托是否存在
		String jdoql = "select from " + LpDelegation.class.getName() + " where delegateType==" + houseSourceKey.getHouseType() + " && saleOrRentId==" + houseSourceKey.getSaleOrRentId();
		Query delegationQuery = pm.newQuery(jdoql);
		delegationQuery.setUnique(true);
		LpDelegation lpDelegation = (LpDelegation)delegationQuery.execute();
		if(lpDelegation==null){		//新委托
			//将以前有效的委托设为无效
			pm.newQuery("update " + LpDelegation.class.getName() + " set state==0 where houseInfoId==" + fanghaoId + " && state==1").execute();	
			
			lpDelegation = new LpDelegation();
			
		} else {	//已有委托
			
		}
		lpDelegation.setDelegateType(houseSourceKey.getHouseType());
		lpDelegation.setSaleOrRentId(houseSourceKey.getSaleOrRentId());
		lpDelegation.setHouseInfoId(fanghaoId);
		lpDelegation.setIsHaving(fangh.getIsHaving());
		lpDelegation.setDelegateSourceParentId((Integer)obj[index++]);
		lpDelegation.setDelegateSourceId((Integer)obj[index++]);
		lpDelegation.setDelegateDate((Date)obj[index++]);
		lpDelegation.setDelegateLimit((Integer)obj[index++]);
		lpDelegation.setOwnerPaymentType((Integer)obj[index++]);
		lpDelegation.setShowingTime((Integer)obj[index++]);
		lpDelegation.setOccupancyTime((Date)obj[index++]);
		lpDelegation.setCommissionRate((Integer)obj[index++]);
		lpDelegation.setTaxAmount((Integer)obj[index++]);
		lpDelegation.setOwnerPayTax((Integer)obj[index++]);
		lpDelegation.setTaxingType((Integer)obj[index++]);
		lpDelegation.setDelegatorId((Integer)obj[index++]);
		lpDelegation.setCreateDate((Date)obj[index++]);
		lpDelegation.setState((Integer)obj[index++]);
		lpDelegation.setSaleReason((String)obj[index++]);
		lpDelegation.setIsMortgage((Integer)obj[index++]);
		lpDelegation.setRentingType((Integer)obj[index++]);
		lpDelegation.setDelegatePurpose((Integer)obj[index++]);
		lpDelegation.setRentingWay((Integer)obj[index++]);
		lpDelegation.setPayingType((Integer)obj[index++]);
		lpDelegation.setIsFirstTimeOfRenting(booleanToInteger((Boolean)obj[index++]));
		lpDelegation.setDiscountOfRenewal(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpDelegation.setPenaltyAmount(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpDelegation.setMortgageRate(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpDelegation.setPayRate(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpDelegation.setRentBeginDate((Date)obj[index++]);
		lpDelegation.setRentEndDate((Date)obj[index++]);
		lpDelegation.setPrice(bigDecimalToDouble((BigDecimal)obj[index++]));
		lpDelegation.setTotalPrice(bigDecimalToDouble((BigDecimal)obj[index++]));
		
		//图片
		sql = "select img.imagetype,img.imagepath from xhj_surveyofhouse s,xhj_imageofsurvey img where s.id=img.surveyid and s.hosuetype=" + houseSourceKey.getHouseType() + " and s.saleorrentid=" + houseSourceKey.getSaleOrRentId();
		List<Object[]> imgs = (List<Object[]>)pm.newQuery("SQL", sql).execute();
		fangh.setImagePath("");
		if(imgs!=null){
			pm.newQuery("delete from " + XhjLpfanghaoimg.class.getName() + " where fanghaoid==" + fanghaoId).execute();
			XhjLpfanghaoimg fhimg = null;
			for(Object[] img : imgs){
				if((Integer)img[0]==1){	//户型图
					fangh.setImagePath((String)img[1]);
				}
				fhimg = new XhjLpfanghaoimg();
				fhimg.setFanghaoid(fanghaoId);
				fhimg.setImgPath((String)img[1]);
				fhimg.setType((Integer)img[0]);
				fhimg.setStatuss(1);
				pm.makePersistent(fhimg);
			}
		}
		
		pm.makePersistentAll(fangh,lpDelegation);
		pm.close();
		lpHouseOperationLogDao.addLpLog("FH1006", "同步房源"+houseSourceNumber+"的信息", String.valueOf(fanghaoId));
	}
	
	private Double bigDecimalToDouble(BigDecimal v){
		return (v==null?null:v.doubleValue());
	}
	
	private Integer booleanToInteger(Boolean v){
		return (v==null?null:(v?1:0));
	}
	/**
	 * 查询小区成交详情
	 * @param pageInfo
	 * @return
	 */
	public PageInfo findByLpChengjiao(PageInfo pageInfo, int lpid, String type,
			String relational) {
		StringBuffer sql = new StringBuffer("");
		StringBuilder sqlCount = new StringBuilder("");
		sql.append("select f.shi,f.ting,f.wei,f.fanghao,r.hsnumber,r.contract_number,f.tnmj,r.contract_date, total_price,price, ");
		sql.append("(select fullname from tbl_user_profile where id=r.contractors),r.source, (select name from lp_syscs_1 where id=f.DecorationStandard) DecorationStandard  from lp_contract_record r ");
		sql.append(" left join Xhj_LpFangHao f on r.houseinfoid=f.id where lpid=").append(lpid);
		if(type!= null && !"".equals(type)) {
			sql.append(" and con_type=" + type);
		}
		
		sqlCount.append("select count(*) from (").append(sql.toString()).append(") ss");
		return getEntitiesByPaginationWithSql(pageInfo, sql.toString(), sqlCount.toString(), DAOConstants.RELATIONAL);
	}
	
	/**
	 * 地铁交通线
	 * @param strategy
	 * @return  List<XhjLpjiaotongzhantoxian>集合
	 */
	public List finAll(Metro metro,String strategy){
		StringBuffer sql = new StringBuffer();
		sql.append("select jtx.xianLu_Name,jtx.id from Xhj_Lpjiaotongxian jtx, Lp_Syscs_1 sys where jtx.Statuss=1 and jtx.LeiBie_ID = sys.id  and jtx.cityId = "+metro.getCityID()+" and jtx.LeiBie_ID = "+metro.getLeibeiID()+" ");
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
		Query query=pm.newQuery("SQL",sql.toString());
		List<Object[]> objects=  (List<Object[]>) query.execute();
		Metro metr = null;
		List<Metro> list = new ArrayList<Metro>();
		for(Object[] temp : objects){
			metr = new Metro();
			if(temp[0]!=null&&!"".equals(temp[0])){
				metr.setXianLuName(temp[0].toString());
			}
			if(temp[1]!=null&&!"".equals(temp[1])){
				metr.setXianID(temp[1].toString());
			}
			
			list.add(metr);
		}
		pm.close();
		return list;
	}
	
	public List<Object[]> getBYDyid(Integer dyId,String strategy){
		PersistenceManager pm=  this.getPersistenceManagerByStratey(strategy);
			String sql ="select ld.id,ld.Lpd_Name from  Xhj_LpDong ld  where ld.LPID="+dyId;
		Query query =pm.newQuery("SQL",sql);
		List<Object[]> objs = (List<Object[]>)query.execute();
		pm.close();
		return objs;
	}

	public LpHouseOperationLogDao getLpHouseOperationLogDao() {
		return lpHouseOperationLogDao;
	}

	public void setLpHouseOperationLogDao(
			LpHouseOperationLogDao lpHouseOperationLogDao) {
		this.lpHouseOperationLogDao = lpHouseOperationLogDao;
	}

	public void batchDeleteFangh(String idsi, String relational) {
		PersistenceManager pm=getPersistenceManagerByStratey(relational);
		Transaction tx=pm.currentTransaction();
		try {
		    tx.begin();
		    String[] id = idsi.split(",");
		    for (int i = 0; i < id.length; i++) {
		    	XhjLpfanghao fangh = pm.getObjectById(XhjLpfanghao.class, Integer.valueOf(id[i]));
				if(fangh != null) {
					pm.deletePersistent(fangh);
					String delImg = "delete from " + XhjLpfanghaoimg.class.getName() + " where fanghaoid==" + id[i];
					pm.newQuery(delImg).execute();
				}
			}
			tx.commit();
			pm.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public String saveFangHao(XhjLpfanghao fanghao, String relational) throws Exception {
		PersistenceManager pm = getPersistenceManagerByStratey(relational);
		String id = "";
			id = fanghao.getId().toString();
			XhjLpfanghao oldFanghao = pm.getObjectById(XhjLpfanghao.class, fanghao.getId());
				oldFanghao = oldFanghaoPerNewFanghao(oldFanghao, fanghao);
				oldFanghao.setUpdateDate(new Timestamp(new Date().getTime()));
				Transaction tx = pm.currentTransaction();
				try {
					tx.begin();
					pm.makePersistent(oldFanghao);
					String message = "修改[" + oldFanghao.getFangHao() + "]房号信息";
					lpHouseOperationLogDao.addLpLog("FH1003", message, String.valueOf(fanghao.getId()));
					tx.commit();
				} catch (Exception e) {
					tx.rollback();
					throw e;
				}
			
		return id;
	}
	/**
	 * 
	 * @param old 更新对象
	 * @param news 更新前对象
	 */
	private XhjLpfanghao oldFanghaoPerNewFanghao(XhjLpfanghao old, XhjLpfanghao news){
		old.setShi(news.getShi());
		old.setTing(news.getTing());
		old.setWei(news.getWei());
		old.setChu(news.getChu());
		old.setYang(news.getYang());
		old.setCeng(news.getCeng());
		old.setDyId(news.getDyId());
		old.setChaoXiang(news.getChaoXiang());
		old.setCqxz(news.getCqxz());
		old.setTnmj(news.getTnmj());
		old.setLeixing(news.getLeixing());
		old.setPropertyAddress(news.getPropertyAddress());
		old.setPropertyNumber(news.getPropertyNumber());
		old.setPropertyAge(news.getPropertyAge());
		old.setCqmj(news.getCqmj());
		old.setYzid(news.getYzid());
		old.setImagePath(news.getImagePath());
		return old;
		
	}
	
	//房号修改读取信息
			public XhjLpfanghao getxhjFangHao(Integer id,String strategy){
				PersistenceManager pm = getPersistenceManagerByStratey(strategy);
				XhjLpfanghao xhjLpfanghao=pm.getObjectById(XhjLpfanghao.class,id);
				this.getxhjFanghaoValue(pm,xhjLpfanghao);
				return xhjLpfanghao;
			}
			
			public void getxhjFanghaoValue(PersistenceManager pm,XhjLpfanghao xhjLpfanghao){
				String sql="select (select qy.Qy_Name from xhj_jcstress qy where qy.id=lp.StressID) Qy_Name,(select sq.Sq_Name from xhj_jcsq sq  where sq.id=lp.SQ_ID) Sq_Name,(select cc.City_Name from xhj_jccity cc where cc.id=lp.CityID) City_Name,lp.LP_Name,dy.Dy_Name,ld.Lpd_Name,(select sc.name from lp_syscs_1 sc where fh.ChaoXiang=sc.id ) ChaoXiang,";
				sql+="(select sc.name from lp_syscs_1 sc where fh.TerritoryInfo=sc.id ) TerritoryInfo, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.PropertyInfo=sc.id ) PropertyInfo, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.PropertyAge=sc.id ) PropertyAge, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.Leixing=sc.id ) Leixing, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.DecorationStandard=sc.id ) DecorationStandard, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.IsHaving=sc.id ) IsHaving, ";
				sql+="(select sc.name from lp_syscs_1 sc where fh.Houselevel=sc.id ) Houselevel,lp.x,lp.y,ld.lpid,ld.id   ";
				sql +="from Xhj_LpFangHao fh ,Xhj_Lpxx lp ,Xhj_LpDanyuan dy ,xhj_lpdong ld   where ld.lpid=lp.id  and ld.id=dy.DZID and dy.id=fh.dyid  ";
				sql+=" and fh.id="+xhjLpfanghao.getId();
				Query  query = pm.newQuery("SQL",sql);
				ForwardQueryResult queryResult = (ForwardQueryResult)query.execute();
				if(queryResult.size()>0 && queryResult!=null)
				{
					Object[] objs = (Object[])queryResult.get(0);
					xhjLpfanghao.setQyName(XhjFangHaoUtil.equeasParams(objs[0]));
					xhjLpfanghao.setSqName(XhjFangHaoUtil.equeasParams(objs[1]));
					xhjLpfanghao.setCityName(XhjFangHaoUtil.equeasParams(objs[2]));
					xhjLpfanghao.setLpName(XhjFangHaoUtil.equeasParams(objs[3]));
					xhjLpfanghao.setDyName(XhjFangHaoUtil.equeasParams(objs[4]));
					xhjLpfanghao.setZdName(XhjFangHaoUtil.equeasParams(objs[5]));
					xhjLpfanghao.setChaoXiangName(XhjFangHaoUtil.equeasParams(objs[6]));
					xhjLpfanghao.setTerritoryInfoStr(XhjFangHaoUtil.equeasParams(objs[7]));
					xhjLpfanghao.setPropertyInfoStr(XhjFangHaoUtil.equeasParams(objs[8]));
					xhjLpfanghao.setPropertyAgeStr(XhjFangHaoUtil.equeasParams(objs[9]));
					xhjLpfanghao.setLeixingStr(XhjFangHaoUtil.equeasParams(objs[10]));
					xhjLpfanghao.setZxName(XhjFangHaoUtil.equeasParams(objs[11]));
					xhjLpfanghao.setIsHavingStr(XhjFangHaoUtil.equeasParams(objs[12]));
					xhjLpfanghao.setHouselevelStr(XhjFangHaoUtil.equeasParams(objs[13]));
					xhjLpfanghao.setX(XhjFangHaoUtil.equeasParams(objs[14]));
					xhjLpfanghao.setY(XhjFangHaoUtil.equeasParams(objs[15]));
					xhjLpfanghao.setLpid(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[16])));
					xhjLpfanghao.setDzId(Integer.parseInt(XhjFangHaoUtil.equeasParams(objs[17])));
				}
				
			}

	
	public Integer getBydyId(String dyid,String strategy){
		String sql="select count(*) from xhj_lpfanghao where  dyid in("+dyid+")";
		PersistenceManager pm =getPersistenceManagerByStratey(strategy);
		Query  query = pm.newQuery("SQL",sql);
		int fian=0;
		List<Object> list=(List<Object>) query.execute();
		fian = Integer.parseInt(list.get(0).toString());
			return fian;
	}
}

