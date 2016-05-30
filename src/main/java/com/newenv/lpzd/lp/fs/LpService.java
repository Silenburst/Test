package com.newenv.lpzd.lp.fs;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import com.newenv.lpzd.lp.domain.XhjLpdanyuan;
import com.newenv.lpzd.lp.domain.XhjLpdong;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.domain.XhjLpxx;
import com.newenv.lpzd.lp.service.XhjLpxxService;

/**
 * 楼盘相关信息服务。
 *
 */
@Path("/lp")
public class LpService {

	private XhjLpxxService xhjLpxxService;
	
	/**
	 * 获取某个城市的楼盘。
	 * @param cityId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/city/{cityId}")
	public Response findByCity(@PathParam("cityId") Integer cityId) {
		try {
			List<XhjLpxx> lps  = xhjLpxxService.findByCity(cityId);
			if (lps != null) {
				return Response.ok().entity(lps).build();
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
	 * 获取某个区域的楼盘。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/stress/{stressId}")
	public Response findByStress(@PathParam("stressId") Integer stressId) {
		try {
			List<XhjLpxx> lps  = xhjLpxxService.findByStress(stressId);
			if (lps != null) {
				return Response.ok().entity(lps).build();
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
	 * 获取某个商圈的楼盘。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/sq/{sqId}")
	public Response findBySq(@PathParam("sqId") Integer sqId) {
		try {
			List<XhjLpxx> lps  = xhjLpxxService.findBySq(sqId);
			if (lps != null) {
				return Response.ok().entity(lps).build();
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
	 * 查询某城市部门下的楼盘。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/city/{cityId}/{bmid}/{lpName}")
	public Response queryLpByName(@PathParam("cityId") Integer bmid,@PathParam("cityId") Integer cityId, @PathParam("lpName") String lpName) {
		try {
			List<XhjLpxx> queryLpByName = xhjLpxxService.queryLpByName(bmid,cityId, lpName);
			if (queryLpByName != null) {
				return Response.ok().entity(queryLpByName).build();
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
	 * 查询某城市下包含楼盘名的楼盘。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/city/{cityId}/{lpName}")
	public Response findByLpName(@PathParam("cityId") Integer cityId, @PathParam("lpName") String lpName) {
		try {
			List<XhjLpxx> lps  = xhjLpxxService.findByLpName(cityId, lpName);
			if (lps != null) {
				return Response.ok().entity(lps).build();
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
	 * 查询某楼盘下的栋座信息。
	 * @param lpId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/{lpId}/dong")
	public Response findLpDongs(@PathParam("lpId") Integer lpId) {
		try {
			List<Object[]> objs  = xhjLpxxService.getBYLpId(lpId);
			if (objs != null) {
				List<XhjLpdong> dongs = new ArrayList<XhjLpdong>();
				for(Object[] obj : objs){
					dongs.add(new XhjLpdong((Integer)obj[0], (String)obj[1]));
				}
				return Response.ok().entity(dongs).build();
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
	 * 查询某栋座下的单元。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/dong/{dongId}/danyuan")
	public Response findLpDanyuans(@PathParam("dongId") Integer dongId) {
		try {
			List<Object[]> objs  = xhjLpxxService.getDanYuan(dongId);
			if (objs != null) {
				List<XhjLpdanyuan> dys = new ArrayList<XhjLpdanyuan>();
				for(Object[] obj : objs){
					dys.add(new XhjLpdanyuan((Integer)obj[0], (String)obj[1]));
				}
				return Response.ok().entity(dys).build();
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
	 * 查询某单元下的层。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/danyuan/{dyId}/ceng")
	public Response findCengs(@PathParam("dyId") Integer dyId) {
		try {
			List<Object[]> objs  = xhjLpxxService.getCeng(dyId);
			if (objs != null) {
				List<Integer> cengs = new ArrayList<Integer>();
				for(Object[] obj : objs){
					cengs.add((Integer)obj[1]);
				}
				return Response.ok().entity(cengs).build();
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
	 * 查询某单元某层的房号。
	 * @param stressId
	 * @return
	 */
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/danyuan/{dyId}/ceng/{ceng}")
	public Response findFanghaos(@PathParam("dyId") Integer dyId, @PathParam("ceng") Integer ceng) {
		try {
			List<Object[]> objs  = xhjLpxxService.getFanghao(dyId, ceng);
			if (objs != null) {
				List<XhjLpfanghao> fanghaos = new ArrayList<XhjLpfanghao>();
				for(Object[] obj : objs){
					fanghaos.add(new XhjLpfanghao((Integer)obj[0], (String)obj[1]));
				}
				return Response.ok().entity(fanghaos).build();
			} else {
				return Response.status(404).build();
			}
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}

	public XhjLpxxService getXhjLpxxService() {
		return xhjLpxxService;
	}

	public void setXhjLpxxService(XhjLpxxService xhjLpxxService) {
		this.xhjLpxxService = xhjLpxxService;
	}
	
}
