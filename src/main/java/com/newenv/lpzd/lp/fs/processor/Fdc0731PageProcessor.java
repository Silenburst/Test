package com.newenv.lpzd.lp.fs.processor;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.newenv.lpzd.Utils.HouseParseConstants;

public class Fdc0731PageProcessor extends BaseProcessor {
	
	private Logger log = Logger.getLogger(Fdc0731PageProcessor.class);
	
	public Fdc0731PageProcessor(String url) {
		init(url);
	}
	
	public Map<String,Object> parseHtml(){
		log.info("Parse URL : " + url);
		if(url.matches(".*/rent/.*")){
			parseChuzu();
		}else if(url.matches(".*/sale/.*")){
			parseChushou();
		}
		return map;
	}
	
	public void parseChuzu(){
		String jbxx_fwmc = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[1]/span[2]/text()", 0);
		sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.replaceAll(".*：", ""));
		
		String jbxx_cs = "";
		sValue(HouseParseConstants.JBXX_CS, jbxx_cs);
		String jbxx_cq = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[1]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CQ, jbxx_cq.replaceAll(".*：", ""));
		String jbxx_sq = "";
		sValue(HouseParseConstants.JBXX_SQ, jbxx_sq);
		
		String jbxx_hx = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[2]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_HX,convertHuxin(jbxx_hx));
		
		String jbxx_yt = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[3]/span[2]/text()", 0);
		sValue(HouseParseConstants.JBXX_YT,jbxx_yt.replaceAll(".*：", ""));
		
		String jbxx_cx = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[3]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CX,jbxx_cx.replaceAll(".*：", ""));
		
		String jbxx_lc = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[4]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_LC,jbxx_lc.replaceAll("[^0-9^\\/]", ""));
		
		String jbxx_cqmj = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[3]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^0-9^\\.]", ""));
		
		String jbxx_scdz = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[2]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_SCDZ,jbxx_scdz.replaceAll(".*：", ""));
		
		String fwxz_zxbz = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[4]/span[2]/text()", 0);
		sValue(HouseParseConstants.FWXZ_ZXBZ,fwxz_zxbz.replaceAll(".*：", ""));
		
		String fwxz_fwss = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[5]/span[1]/text()", 0);
		sValue(HouseParseConstants.FWXZ_FWSS,fwxz_fwss.replaceAll(".*：", "").replaceAll("\\s+",","));
		
		String czxx_yzdj = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[1]/span[1]/text()", 0);
		sValue(HouseParseConstants.CZXX_YZDJ,czxx_yzdj.replaceAll(".*：", "").replaceAll("[^\\d^\\.]", ""));
		
		String czxx_zpfs = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[3]/span[2]/text()", 0);
		sValue(HouseParseConstants.CZXX_ZPFS,czxx_zpfs.replaceAll(".*：", ""));
		
		try {
			Object [] obj = tagNode.evaluateXPath("//*[@class='house-remark-cont']/div[4]/ul/li/img/@src");
	        Map<Integer,String> map_imglist = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	        	map_imglist.put(i,"http://esf.0731fdc.com"+obj[i].toString());
	        }
	        sValue("img",map_imglist);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void parseChushou(){
		String jbxx_fwmc = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[1]/span[2]/text()", 0);
		sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.replaceAll(".*：", ""));
		
		String jbxx_cs = "";
		sValue(HouseParseConstants.JBXX_CS, jbxx_cs);
		String jbxx_cq = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[1]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CQ, jbxx_cq.replaceAll(".*：", ""));
		String jbxx_sq = "";
		sValue(HouseParseConstants.JBXX_SQ, jbxx_sq);
		
		String jbxx_hx = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[2]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_HX,convertHuxin(jbxx_hx));
		
		String jbxx_jznd = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[3]/span[2]/text()", 0);
		sValue(HouseParseConstants.JBXX_JZND,jbxx_jznd.replaceAll(".*：", "").replaceAll("[^0-9]", ""));
		
		String jbxx_cx = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[3]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CX,jbxx_cx.replaceAll(".*：", ""));
		
		String jbxx_lc = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[4]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_LC,jbxx_lc.replaceAll("[^0-9^\\/]", ""));
		
		String jbxx_cqmj = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[3]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^0-9^\\.]", ""));
		
		String jbxx_scdz = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[2]/span[1]/text()", 0);
		sValue(HouseParseConstants.JBXX_SCDZ,jbxx_scdz.replaceAll(".*：", ""));
		
		String fwxz_zxbz = getTagNodeForXpath(tagNode, "//*[@class='house-position']/ul/li[4]/span[2]/text()", 0);
		sValue(HouseParseConstants.FWXZ_ZXBZ,fwxz_zxbz.replaceAll(".*：", ""));
		
		String wtxx_zj = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[1]/span[1]/text()", 0);
		sValue(HouseParseConstants.WTXX_ZJ,wtxx_zj.replaceAll(".*：", "").replaceAll("[^\\d^\\.]", ""));
		
		String czxx_zpfs = getTagNodeForXpath(tagNode, "//*[@class='house-money']/ul/li[3]/span[2]/text()", 0);
		sValue(HouseParseConstants.CZXX_ZPFS,czxx_zpfs.replaceAll(".*：", ""));
		
		try {
			Object [] obj = tagNode.evaluateXPath("//*[@class='house-remark-cont']/div[4]/ul/li/img/@src");
	        Map<Integer,String> map_imglist = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	        	map_imglist.put(i,"http://esf.0731fdc.com"+obj[i].toString());
	        }
	        sValue("img",map_imglist);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
