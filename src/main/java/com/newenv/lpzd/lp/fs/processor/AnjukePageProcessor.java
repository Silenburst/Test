package com.newenv.lpzd.lp.fs.processor;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.TagNode;

import com.newenv.lpzd.Utils.HouseParseConstants;

public class AnjukePageProcessor extends BaseProcessor {
	
	private Logger log = Logger.getLogger(AnjukePageProcessor.class);
	
	public AnjukePageProcessor(String url) {
		super.url = url;
		super.charset = "gbk";
		super.html = getPageSource(url);
		initvalues();
	}
	
	public Map<String,Object> parseHtml(){
		log.info("Parse URL : " + url);
		if(url.matches(".*fangyuan.*")){
			parseChuzu();
		}else if(url.matches(".*prop/view.*")){
			parseChushou();
		}
		return map;
	}
	
	public void parseChuzu(){
		try {
			HtmlCleaner cleaner = new  HtmlCleaner();
			TagNode node = cleaner.clean(html);
			
			Object [] obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[1]/h5/text()");
			String jbxx_fwmc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.trim());
			
			obj = node .evaluateXPath("//*[@id=\"switch_apf_id_6\"]/span[1]/text()");
			String jbxx_cs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CS, jbxx_cs.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[6]/dd/a[1]/text()");
			String jbxx_cq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQ, jbxx_cq.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[6]/dd/a[2]/text()");
			String jbxx_sq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SQ, jbxx_sq.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[3]/dd/text()");
			String jbxx_hx = obj.length > 0 ? obj[0].toString() : "";
			String hx = "{1},{2},{3},{4},{5}";
			if(StringUtils.isNotEmpty(jbxx_hx)){
	            String s = getRegEx("\\d室",jbxx_hx);
	            hx = hx.replace("{1}", s == null ? "0" : s.replaceAll("[^0-9]",""));
	            String t = getRegEx("\\d厅",jbxx_hx);
	            hx = hx.replace("{2}", t == null ? "0" : t.replaceAll("[^0-9]",""));
	            String c = getRegEx("\\d厨",jbxx_hx);
	            hx = hx.replace("{3}", c == null ? "0" : c.replaceAll("[^0-9]",""));
	            String w = getRegEx("\\d卫",jbxx_hx);
	            hx = hx.replace("{4}", w == null ? "0" : w.replaceAll("[^0-9]",""));
	            String yt = getRegEx("\\d阳台",jbxx_hx);
	            hx = hx.replace("{5}", yt == null ? "0" : yt.replaceAll("[^0-9]",""));
	            sValue(HouseParseConstants.JBXX_HX,hx);
	        }
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/dl[6]/dd/text()");
			String jbxx_yt = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_YT,jbxx_yt.trim());
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul[1]/li[3]/p[2]/text()");
			String jbxx_dz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SCDZ,jbxx_dz.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/dl[3]/dd/text()");
			String jbxx_cqmj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^\\d|^\\.]", "").trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/dl[4]/dd/text()");
			String jbxx_cx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CX,jbxx_cx.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/dl[5]/dd/text()");
			String jbxx_lc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_LC,jbxx_lc.trim().replaceAll("[^0-9^\\/]", ""));
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/dl[2]/dd/text()");
			String fwxz_zxbz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_ZXBZ, fwxz_zxbz.trim());
			
			obj = node .evaluateXPath("//*[@id=\"proLinks\"]/p/span/text()");
			sValue(HouseParseConstants.FWXZ_FWSS, StringUtils.join(obj,","));
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[4]/dd/text()");
			String czxx_zpfs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.CZXX_ZPFS, czxx_zpfs.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[1]/dd/strong/span/text()");
			String czxx_yzdj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.CZXX_YZDJ, czxx_yzdj.trim());
			
			obj = node .evaluateXPath("//*[@id=\"content\"]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/dl[2]/dd/text()");
			String czxx_yf = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.CZXX_YF, czxx_yf.trim());
			
			obj = node .evaluateXPath("//*[@id=\"propContent\"]/div/text()");
			String pjxx_yzzs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.PJXX_YZZS, pjxx_yzzs.trim());
			
			
	        obj = node .evaluateXPath("//*[@id=\"photoSlide\"]/div/div[1]/div[1]/div/ul/li/a/img/@src");
	        Map<Integer,String> map_thumbnail = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	            map_thumbnail.put(i,obj[i].toString());
	        }
	        sValue("thumbnail",map_thumbnail);
	        
	        obj = node .evaluateXPath("//*[@name=\"ImgList\"]/@src");
	        Map<Integer,String> map_imglist = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	        	map_imglist.put(i,obj[i].toString());
	        }
	        sValue("img",map_imglist);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void parseChushou(){
		HtmlCleaner cleaner = new  HtmlCleaner();
		TagNode node = cleaner.clean(html);
		try {
			Object [] obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[1]/dl[5]/dd/a[1]/text()");
			String jbxx_fwmc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.trim());
			
			obj = node .evaluateXPath("//*[@id=\"switch_apf_id_6\"]/span[1]/text()");
			String jbxx_cs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CS, jbxx_cs.trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[1]/dd/text()");
			String jbxx_hx = obj.length > 0 ? obj[0].toString() : "";
			String hx = "{1},{2},{3},{4},{5}";
			if(StringUtils.isNotEmpty(jbxx_hx)){
	            String s = getRegEx("\\d室",jbxx_hx);
	            hx = hx.replace("{1}", s == null ? "0" : s.replaceAll("[^0-9]",""));
	            String t = getRegEx("\\d厅",jbxx_hx);
	            hx = hx.replace("{2}", t == null ? "0" : t.replaceAll("[^0-9]",""));
	            String c = getRegEx("\\d厨",jbxx_hx);
	            hx = hx.replace("{3}", c == null ? "0" : c.replaceAll("[^0-9]",""));
	            String w = getRegEx("\\d卫",jbxx_hx);
	            hx = hx.replace("{4}", w == null ? "0" : w.replaceAll("[^0-9]",""));
	            String yt = getRegEx("\\d阳台",jbxx_hx);
	            hx = hx.replace("{5}", yt == null ? "0" : yt.replaceAll("[^0-9]",""));
	            sValue(HouseParseConstants.JBXX_HX,hx);
	        }
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[2]/dd/text()");
			String jbxx_cqmj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^\\d|^\\.]", "").trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[1]/dl[6]/dd/a[1]/text()");
			String jbxx_cq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQ, jbxx_cq.trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[1]/dl[6]/dd/a[2]/text()");
			String jbxx_sq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SQ, jbxx_sq.trim());
			
			obj = node .evaluateXPath("//*[@id=\"commmap\"]/div[2]/div[2]/div[1]/dl[6]/dd/text()");
			String jbxx_yt = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_YT,jbxx_yt.trim());
			
			obj = node .evaluateXPath("//*[@id=\"commmap\"]/div[2]/div[2]/div[2]/dl[3]/dd/text()");
			String jbxx_jznd = obj.length > 0 ? obj[0].toString() : "";
			jbxx_jznd = getRegEx("\\d{4}", jbxx_jznd);
			sValue(HouseParseConstants.JBXX_JZND,jbxx_jznd);
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[3]/dd/text()");
			String jbxx_cx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CX,jbxx_cx.trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[4]/dd/text()");
			String jbxx_lc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_LC,jbxx_lc.trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[6]/dd/text()");
			String jbxx_lx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_LX,jbxx_lx.trim());
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[2]/dl[5]/dd/text()");
			String fwxz_zxbz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_ZXBZ,fwxz_zxbz.trim());
			
			
			obj = node .evaluateXPath("//*[@id=\"commmap\"]/div[2]/div[2]/div[1]/dl[3]/dd/text()");
			String jbxx_scdz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SCDZ,jbxx_scdz.replaceAll("\\(.*\\)", "").trim());
			
			
			obj = node .evaluateXPath("//*[@id=\"prop_infor\"]/div[1]/div[1]/dl[1]/dd/strong/span/text()");
			String wtxx_zj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.WTXX_ZJ, wtxx_zj.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dt[2]/span[2]/text()");
			String fwxz_fwss = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_FWSS, fwxz_fwss.trim());
			
	        obj = node .evaluateXPath("//*[@class=\"tabscon tnow\"]/div/div/div/ul/li/a/img/@src");
	        Map<Integer,String> map_thumbnail = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	            map_thumbnail.put(i,obj[i].toString());
	        }
	        sValue("thumbnail",map_thumbnail);
	        
	        Map<Integer,String> map_imglist = new LinkedHashMap<>();
	        obj = node .evaluateXPath("//*[@class=\"tabscon tnow\"]/div/div/ul/li/a/img/@src");
	        for (int i = 0; i < obj.length ; i++) {
	        	String img_src = obj[i].toString();
	        	if(img_src.contains("ajkimg.com")){
	        		map_imglist.put(i,obj[i].toString());
	        	}
	        }
	        obj = node .evaluateXPath("//*[@class=\"tabscon tnow\"]/div/div/ul/li/a/img/@data-src");
	        for (int i = 0; i < obj.length ; i++) {
	        	String img_src = obj[i].toString();
	        	if(StringUtils.isNotEmpty(img_src.trim())){
	        		map_imglist.put(i,obj[i].toString());
	        	}
	        }
	        sValue("img",map_imglist);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		

	}
}
