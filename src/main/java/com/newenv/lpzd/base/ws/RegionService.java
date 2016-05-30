package com.newenv.lpzd.base.ws;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import com.newenv.lpzd.Utils.SysConstants;
import com.newenv.lpzd.base.domain.LpCountry;
import com.newenv.lpzd.base.domain.LpProvince;
import com.newenv.lpzd.base.domain.LpSyscs1;
import com.newenv.lpzd.base.domain.XhjJccity;
import com.newenv.lpzd.base.domain.XhjJcsq;
import com.newenv.lpzd.base.domain.XhjJcstress;
import com.newenv.lpzd.base.service.LpCountryService;
import com.newenv.lpzd.base.service.LpProvinceService;
import com.newenv.lpzd.base.service.XhjJccityService;
import com.newenv.lpzd.base.service.XhjJcsqService;
import com.newenv.lpzd.base.service.XhjJcstressService;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpjiaotongxian;
import com.newenv.lpzd.lp.service.LpSyscs1Service;
import com.newenv.lpzd.lp.service.XhjLpfanghaoService;

public class RegionService {

	private LpCountryService lpCountryService;
	private LpProvinceService lpProvinceService;
	private XhjJccityService xhjJccityService;
	private XhjJcstressService xhjJcStressService;
	private XhjJcsqService xhjJcsqService;
	private LpSyscs1Service lpSyscs1Service;
	private XhjLpfanghaoService  xhjLpfanghaoService;
	
	
	/**
	 * 获取所有的国家。
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/country/all")
	public Response country() {
		try {
			List<LpCountry> countries = lpCountryService.findAll();
			if (countries != null) {
				return Response.ok().entity(countries).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	
	/**
	 * 查询某个国家下的省份。
	 * @param countryId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/country/{countryId}/province")
	public Response findProvincesByCountry(@PathParam("countryId") String countryId) {
		try {
			List<LpProvince> provinces = lpProvinceService.findByCountryId(countryId);
			if (provinces != null) {
				return Response.ok().entity(provinces).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 查询某省份下的城市。
	 * @param provinceId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/province/{provinceId}/city")
	public Response findCitiesByProvince(@PathParam("provinceId") String provinceId) {
		try {
			List<XhjJccity> cities = xhjJccityService.findByProvinceId(provinceId);
			if (cities != null) {
				return Response.ok().entity(cities).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 查询某城市下的区域。
	 * @param cityId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/city/{cityId}/stress")
	public Response findStressesByCity(@PathParam("cityId") String cityId) {
		try {
			List<XhjJcstress> stresses = xhjJcStressService.findByCityId(cityId);
			if (stresses != null) {
				return Response.ok().entity(stresses).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 查询某区域下的商圈。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/stress/{stressId}/sq")
	public Response findSqsByStress(@PathParam("stressId") String stressId) {
		try {
			List<XhjJcsq> sqs = xhjJcsqService.findByQyid(stressId);
			if (sqs != null) {
				return Response.ok().entity(sqs).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 查询某城市的地铁钱。
	 * @param cityId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/city/{cityId}/jiaotongxian")
	public Response jiaotongxian(@PathParam("cityId") Integer cityId) {
		try {
			List<XhjLpjiaotongxian> jtxs = xhjJccityService.jiaotongxian(cityId);
			if (jtxs != null) {
				return Response.ok().entity(jtxs).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 获取户型
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/shi")
	public Response findSyscs1es() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_SHI);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 获取面积
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/tnmj")
	public Response findSyscs1esmj() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_MIANJI);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 获取朝向
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/chaoxiang")
	public Response findSyscs1eschaoxiang() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_CHAOXIANG);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	/**
	 * 获取用途
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/yongtou")
	public Response findSyscs1esyongtou() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_FANGWU_YONGTU);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	/**
	 * 获取装修程度
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/zxcd")
	public Response findSyscs1ezxcd() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_ZHUANGXIU_CHENGDU);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	/**
	 * 获取房屋结构
	 * @param 
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/fwjg")
	public Response findSyscs1efwjg() {
		try {
			List<LpSyscs1> lpSyscs1es = lpSyscs1Service.getSyscs1es(SysConstants.SYS_JIANZHU_LEIXING);
			if (lpSyscs1es != null) {
				return Response.ok().entity(lpSyscs1es).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/syscs1es/xhjLpfanghao/{id}")
	public Response getById(@PathParam("id")String id) {
		try {
			XhjLpfanghao entity  = xhjLpfanghaoService.getById(Integer.parseInt(id));
			if (entity != null) {
				return Response.ok().entity(entity).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	public LpCountryService getLpCountryService() {
		return lpCountryService;
	}
	public void setLpCountryService(LpCountryService lpCountryService) {
		this.lpCountryService = lpCountryService;
	}
	public LpProvinceService getLpProvinceService() {
		return lpProvinceService;
	}
	public void setLpProvinceService(LpProvinceService lpProvinceService) {
		this.lpProvinceService = lpProvinceService;
	}
	public XhjJccityService getXhjJccityService() {
		return xhjJccityService;
	}
	public void setXhjJccityService(XhjJccityService xhjJccityService) {
		this.xhjJccityService = xhjJccityService;
	}
	public XhjJcstressService getXhjJcStressService() {
		return xhjJcStressService;
	}
	public void setXhjJcStressService(XhjJcstressService xhjJcStressService) {
		this.xhjJcStressService = xhjJcStressService;
	}
	public XhjJcsqService getXhjJcsqService() {
		return xhjJcsqService;
	}
	public void setXhjJcsqService(XhjJcsqService xhjJcsqService) {
		this.xhjJcsqService = xhjJcsqService;
	}


	public LpSyscs1Service getLpSyscs1Service() {
		return lpSyscs1Service;
	}


	public void setLpSyscs1Service(LpSyscs1Service lpSyscs1Service) {
		this.lpSyscs1Service = lpSyscs1Service;
	}


	public XhjLpfanghaoService getXhjLpfanghaoService() {
		return xhjLpfanghaoService;
	}


	public void setXhjLpfanghaoService(XhjLpfanghaoService xhjLpfanghaoService) {
		this.xhjLpfanghaoService = xhjLpfanghaoService;
	}
	
}
