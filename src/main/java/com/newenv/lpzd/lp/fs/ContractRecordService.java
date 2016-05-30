package com.newenv.lpzd.lp.fs;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.service.LpContractRecordService;

/**
 * 成交信息。
 * @author chenky
 *
 */

@Path("/contractRecord")
public class ContractRecordService {

	private LpContractRecordService lpContractRecordService;
	
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("/sync/{houseType}/{contractId}")
	public Response syncInfo(@PathParam("houseType") Integer houseType, @PathParam("contractId") Integer contractId){
		try {
			lpContractRecordService.syncInfo(houseType, contractId);
			return Response.ok().build();
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}

	public LpContractRecordService getLpContractRecordService() {
		return lpContractRecordService;
	}

	public void setLpContractRecordService(
			LpContractRecordService lpContractRecordService) {
		this.lpContractRecordService = lpContractRecordService;
	}
}
