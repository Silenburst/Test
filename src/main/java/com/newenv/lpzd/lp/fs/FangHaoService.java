package com.newenv.lpzd.lp.fs;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import com.newenv.lpzd.Utils.FanghaoForRentVo;
import com.newenv.lpzd.Utils.HouseConstants;
import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.domain.XhjLpfanghao;
import com.newenv.lpzd.lp.service.XhjLpfanghaoService;

@Path("/fanghao")
public class FangHaoService {
	private XhjLpfanghaoService  xhjLpfanghaoService;
	private Map<String, Object> map  = new HashMap<String, Object>();
	private FanghaoForRentVo fanghaoForRentVo;

	public XhjLpfanghaoService getXhjLpfanghaoService() {
		return xhjLpfanghaoService;
	}

	public void setXhjLpfanghaoService(XhjLpfanghaoService xhjLpfanghaoService) {
		this.xhjLpfanghaoService = xhjLpfanghaoService;
	}
	private String gValue(String name) {

		return (String) map.get(name);
	}

	private void sValue(String name, Object value) {

		map.put(name, value);
	}
	
	
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/{id}")
	public Response getById(@PathParam("id") Integer id) {
		try {
			XhjLpfanghao entity  = xhjLpfanghaoService.getById(id);
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
	
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/sync/{houseType}/{saleOrRentId}")
	public Response syncInfo(@PathParam("houseType") Integer houseType, @PathParam("saleOrRentId") Integer saleOrRentId){
		try {
			xhjLpfanghaoService.syncInfo(new HouseSourceKey(houseType, saleOrRentId));
			return Response.ok().build();
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}
	
	/**
	 * 处理查询参数。
	 */
	private void initList(Map<String, Object> map){
		initvalues();
	//	map = getRequestMap(map);

		if (fanghaoForRentVo == null) {
			fanghaoForRentVo = new FanghaoForRentVo();
		}
		// 区域
		this.fanghaoForRentVo.setStressID(gValue(HouseConstants.SESSION_QY));
		if (gValue(HouseConstants.SESSION_QY).equals("0"))
			this.fanghaoForRentVo.setStressID("");

		// 商圈
		this.fanghaoForRentVo.setSqID(gValue(HouseConstants.SESSION_SQ));
		if (gValue(HouseConstants.SESSION_SQ).equals("0"))
			this.fanghaoForRentVo.setSqID("");

		// 自定义户型-室
		if (gValue(HouseConstants.SESSION_HXS).isEmpty()) {
			if (gValue(HouseConstants.SESSION_HX).equals("-1")
					|| gValue(HouseConstants.SESSION_HX).equals("0"))
				this.fanghaoForRentVo.setRoomNumber("");
			else
				this.fanghaoForRentVo
						.setRoomNumber(gValue(HouseConstants.SESSION_HX));
		} else
			this.fanghaoForRentVo
					.setRoomNumber(gValue(HouseConstants.SESSION_HXS));

		// 自定义户型-厅
		if (gValue(HouseConstants.SESSION_HXT).isEmpty())
			this.fanghaoForRentVo.setHallNumber("");
		else
			this.fanghaoForRentVo
					.setHallNumber(gValue(HouseConstants.SESSION_HXT));

		// 自定义户型-卫
		if (gValue(HouseConstants.SESSION_HXW).isEmpty())
			this.fanghaoForRentVo.setToiletNumber("");
		else
			this.fanghaoForRentVo
					.setToiletNumber(gValue(HouseConstants.SESSION_HXW));
		// 自定义面积
		if (!"-1".equals(gValue(HouseConstants.SESSION_MJ))
				&& !"0".equals(gValue(HouseConstants.SESSION_MJ))
				&& !"".equals(gValue(HouseConstants.SESSION_MJ))) {
			this.fanghaoForRentVo.setStart_buildingSize(gValue(
					HouseConstants.SESSION_MJ).split("-")[0]);
			this.fanghaoForRentVo.setEnd_buildingSize(gValue(
					HouseConstants.SESSION_MJ).split("-")[1]);

		} else {
			this.fanghaoForRentVo
					.setStart_buildingSize(gValue(HouseConstants.SESSION_MJX));
			this.fanghaoForRentVo
					.setEnd_buildingSize(gValue(HouseConstants.SESSION_MJD));
		}

		

	

		// 朝向
		if (gValue(HouseConstants.SESSION_CX).equals("0")
				|| gValue(HouseConstants.SESSION_CX).equals("-1"))
			this.fanghaoForRentVo.setOrientationID("");
		else
			this.fanghaoForRentVo
					.setOrientationID(gValue(HouseConstants.SESSION_CX));

		// 用途
		if (gValue(HouseConstants.SESSION_YT).equals("0")
				|| gValue(HouseConstants.SESSION_YT).equals("-1"))
			this.fanghaoForRentVo.setUseage("");
		else
			this.fanghaoForRentVo.setUseage(gValue(HouseConstants.SESSION_YT));

		// 装修程度
		if (gValue(HouseConstants.SESSION_ZX).equals("0")
				|| gValue(HouseConstants.SESSION_ZX).equals("-1"))
			this.fanghaoForRentVo.setDecorationStandard("");
		else
			this.fanghaoForRentVo
					.setDecorationStandard(gValue(HouseConstants.SESSION_ZX));

		// 房屋结构,建筑类型
		if (gValue(HouseConstants.SESSION_FWJG).equals("0")
				|| gValue(HouseConstants.SESSION_FWJG).equals("-1")) {
			this.fanghaoForRentVo.setBuildingType("");
			this.fanghaoForRentVo.setBuildingID("");
		} else
			this.fanghaoForRentVo
					.setBuildingType(gValue(HouseConstants.SESSION_FWJG));

		// 附加条件-室
		if (gValue(HouseConstants.SESSION_FSX).isEmpty()
				|| gValue(HouseConstants.SESSION_FSX).equals("-1"))
			this.fanghaoForRentVo.setStart_roomNumber("");
		else
			this.fanghaoForRentVo
					.setStart_roomNumber(gValue(HouseConstants.SESSION_FSX));

		if (gValue(HouseConstants.SESSION_FSD).isEmpty()
				|| gValue(HouseConstants.SESSION_FSD).equals("-1"))
			this.fanghaoForRentVo.setEnd_roomNumber("");
		else
			this.fanghaoForRentVo
					.setEnd_roomNumber(gValue(HouseConstants.SESSION_FSD));

		// 附加条件-厅
		if (gValue(HouseConstants.SESSION_FTX).isEmpty()
				|| gValue(HouseConstants.SESSION_FTX).equals("-1"))
			this.fanghaoForRentVo.setStart_hallNumber("");
		else
			this.fanghaoForRentVo
					.setStart_hallNumber(gValue(HouseConstants.SESSION_FTX));

		if (gValue(HouseConstants.SESSION_FTD).isEmpty()
				|| gValue(HouseConstants.SESSION_FTD).equals("-1"))
			this.fanghaoForRentVo.setEnd_hallNumber("");
		else
			this.fanghaoForRentVo
					.setEnd_hallNumber(gValue(HouseConstants.SESSION_FTD));

			this.fanghaoForRentVo.setOrderSize("2");
		if (gValue(HouseConstants.SESSION_OMJ).equals("1"))
			this.fanghaoForRentVo.setOrderSize("1");

	}
	private void initValue(String name, String value) {

		if (gValue(name) == null)
			sValue(name, value);
	}
	private void initvalues(){
		initValue(HouseConstants.SESSION_FANGHAO, "");
		initValue(HouseConstants.SESSION_QY, "0");
		initValue(HouseConstants.SESSION_SQ, "0");
		initValue(HouseConstants.SESSION_HX, "0");
		initValue(HouseConstants.SESSION_MJ, "0");
		initValue(HouseConstants.SESSION_ZJ, "0");
		initValue(HouseConstants.SESSION_HXS, "");
		initValue(HouseConstants.SESSION_HXT, "");
		initValue(HouseConstants.SESSION_HXW, "");
		initValue(HouseConstants.SESSION_MJX, "");
		initValue(HouseConstants.SESSION_MJD, "");
		initValue(HouseConstants.SESSION_ZJX, "");
		initValue(HouseConstants.SESSION_ZJD, "");
		initValue(HouseConstants.SESSION_CX, "");
		initValue(HouseConstants.SESSION_YT, "");
		initValue(HouseConstants.SESSION_ZX, "");
		initValue(HouseConstants.SESSION_FWJG, "");
		initValue(HouseConstants.SESSION_BQ, "");
		initValue(HouseConstants.SESSION_JM, "");
		initValue(HouseConstants.SESSION_FJTJ, "1");
		initValue(HouseConstants.SESSION_LPID, "");
		initValue(HouseConstants.SESSION_DZID, "");
		initValue(HouseConstants.SESSION_DYID, "");
		initValue(HouseConstants.SESSION_FYBH, "");
		initValue(HouseConstants.SESSION_LCX, "");
		initValue(HouseConstants.SESSION_LCD, "");
		initValue(HouseConstants.SESSION_FSX, "");
		initValue(HouseConstants.SESSION_FSD, "");
		initValue(HouseConstants.SESSION_FTX, "");
		initValue(HouseConstants.SESSION_FTD, "");
		initValue(HouseConstants.SESSION_YZDH, "");
		initValue(HouseConstants.SESSION_GSDZ, "");
		initValue(HouseConstants.SESSION_JJR, "");
		initValue(HouseConstants.SESSION_LRSJX, "");
		initValue(HouseConstants.SESSION_LRSJD, "");
		initValue(HouseConstants.SESSION_OZJ, "");
		initValue(HouseConstants.SESSION_ODJ, "");
		initValue(HouseConstants.SESSION_OMJ, "");
	}
}
