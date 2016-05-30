package com.newenv.lpzd.lp.fs;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import com.newenv.lpzd.lp.fs.processor.AnjukePageProcessor;
import com.newenv.lpzd.lp.fs.processor.BaseProcessor;
import com.newenv.lpzd.lp.fs.processor.FangPageProcessor;
import com.newenv.lpzd.lp.fs.processor.Fdc0731PageProcessor;
import com.newenv.lpzd.lp.fs.processor.LianjiaPageProcessor;

@Path("/houseparse")
public class HouseParseService {
	
	private Map<String, Object> map  = new LinkedHashMap<String, Object>();
	
	@GET
	@Produces("application/json"+ ";charset=UTF-8")
	@Consumes("application/json")
	@Path("api")
	public Response process(@QueryParam("url") String url) {
		try {
			BaseProcessor pageProcessor = null;
			if(url.indexOf("fang.com") != -1){
                pageProcessor = new FangPageProcessor(url);
            }else if(url.indexOf("anjuke.com") != -1){
                pageProcessor = new AnjukePageProcessor(url);
            }else if(url.indexOf("lianjia.com") != -1){
                pageProcessor = new LianjiaPageProcessor(url);
            }else if(url.indexOf("0731fdc.com") != -1){
                pageProcessor = new Fdc0731PageProcessor(url);
            }
			map = pageProcessor.parseHtml();
			return Response.ok().entity(map).build();
		} catch (javax.jdo.JDOObjectNotFoundException jnfExecption) {
			return Response.status(404).build();
		} catch (Exception e) {
			return Response.status(500).build();
		}
	}


}
