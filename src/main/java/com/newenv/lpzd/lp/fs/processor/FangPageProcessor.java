package com.newenv.lpzd.lp.fs.processor;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.TagNode;

import com.newenv.lpzd.Utils.HouseParseConstants;

public class FangPageProcessor extends BaseProcessor {
	
	private Logger log = Logger.getLogger(FangPageProcessor.class);
	
	public FangPageProcessor(String url) {
		super.url = url;
		super.charset = "gbk";
		super.html = getPageSource(url);
		initvalues();
	}
	
	public Map<String,Object> parseHtml(){
		log.info("Parse URL : " + url);
		if(url.matches(".*/chuzu/.*")){
			parseChuzu();
		}else if(url.matches(".*/chushou/.*")){
			parseChushou();
		}
		return map;
	}
	
	public void parseChuzu(){
		try {
			HtmlCleaner cleaner = new  HtmlCleaner();
			TagNode node = cleaner.clean(html);
			
			Object [] obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul[1]/li[2]/p[2]/text()");
			String jbxx_fwmc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.trim());
			
			obj = node .evaluateXPath("//*[@id=\"dsy_H01_01\"]/div[1]/text()");
			String jbxx_cs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CS, jbxx_cs.trim());
			
			obj = node .evaluateXPath("//*[@class=\"houseInfo\"]/div[3]/ul/li[2]/span[1]/a/text()");
			if(obj.length > 1){
				sValue(HouseParseConstants.JBXX_CQ, obj[obj.length - 2].toString().trim());
				sValue(HouseParseConstants.JBXX_SQ, obj[obj.length - 1].toString().trim());
			}
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul/li[4]/p[2]/text()");
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
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul[1]/li[1]/p[2]/text()");
			String jbxx_yt = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_YT,jbxx_yt.trim());
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul[1]/li[3]/p[2]/text()");
			String jbxx_dz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SCDZ,jbxx_dz.trim());
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul/li[6]/p[2]/text()");
			String jbxx_cqmj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^\\d|^\\.]", "").trim());
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul/li[7]/p[2]/text()");
			String jbxx_cx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CX,jbxx_cx.trim());
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul/li[8]/p[2]/text()");
			String jbxx_lc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_LC,jbxx_lc.trim().replaceAll("[^0-9^\\/]", ""));
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul/li[9]/p[2]/text()");
			String fwxz_zxbz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_ZXBZ, fwxz_zxbz.trim());
			
			obj = node .evaluateXPath("//*[@class=\"houseInfo\"]/div[3]/ul/li/text()");
			for (Object o : obj) {
				String nd = o.toString();
				if(nd.contains("配套设施")){
					sValue(HouseParseConstants.FWXZ_FWSS, nd.replaceAll(".*：", "").trim());
				}
			}
			
			obj = node .evaluateXPath("//*[@id=\"zf_baseInfo_anchor\"]/ul[1]/li[5]/p[2]/text()");
			String czxx_zpfs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.CZXX_ZPFS, czxx_zpfs.trim());
			
			obj = node .evaluateXPath("//*[@class=\"houseInfo\"]/div[3]/ul/li[1]/span/text()");
			String czxx_yzdj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.CZXX_YZDJ, czxx_yzdj.trim());
			
			obj = node .evaluateXPath("//*[@class=\"houseInfo\"]/div[3]/ul/li[1]/text()");
			String czxx_yf = obj.length > 0 ? obj[0].toString() : "";
			czxx_yf = getRegEx("(\\(.+\\)|\\[.+\\])", czxx_yf).replaceAll("[\\(\\)\\[\\]]+", "");
			sValue(HouseParseConstants.CZXX_YF, czxx_yf.trim());
			
			obj = node .evaluateXPath("//*[@class=\"Introduce floatr\"]/p/text()");
			List<String> list = new ArrayList<>();
			for (Object o : obj) {
				String nd = o.toString();
				if(StringUtils.isNotEmpty(nd)){
					list.add(nd.trim());
				}
			}
			sValue(HouseParseConstants.PJXX_YZZS, StringUtils.join(list.subList(0, list.size() - 1), ""));
			
			
	        obj = node .evaluateXPath("//*[@id=\"thumbnail\"]/ul/li/img/@src");
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
			Object [] obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dt[1]/a[1]/text()");
			String jbxx_fwmc = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_FWMC, jbxx_fwmc.trim());
			
			obj = node .evaluateXPath("//*[@id=\"dsy_H01_01\"]/div[1]/text()");
			String jbxx_cs = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CS, jbxx_cs.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[1]/dd[3]/text()");
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
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[1]/dd[4]/span/text()");
			String jbxx_cqmj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQMJ,jbxx_cqmj.replaceAll("[^\\d|^\\.]", "").trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dt[1]/a[2]/text()");
			String jbxx_cq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CQ, jbxx_cq.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dt[1]/a[3]/text()");
			String jbxx_sq = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SQ, jbxx_sq.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[6]/text()");
			String jbxx_yt = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_YT,jbxx_yt.replaceAll(".*：", "").trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[1]/text()");
			String jbxx_zznd = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_JZND,jbxx_zznd.replaceAll(".*：", "").replaceAll("[^\\d]", "").trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[2]/text()");
			String jbxx_cx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_CX,jbxx_cx.replaceAll(".*：", "").trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[3]/text()");
			String jbxx_lc = obj.length > 0 ? obj[0].toString() : "";
			jbxx_lc = jbxx_lc.replaceAll(".*：", "");
			jbxx_lc = jbxx_lc.replaceAll("[\\(]", "/").replaceAll("[^\\d|^\\/]", "");
			sValue(HouseParseConstants.JBXX_LC,jbxx_lc.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[7]/text()");
			String jbxx_lx = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_LX,jbxx_lx.replaceAll(".*：", "").trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dd[5]/text()");
			String fwxz_zxbz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_ZXBZ,fwxz_zxbz.replaceAll(".*：", "").trim());
			
			
			obj = node .evaluateXPath("//*[@id=\"esfcsxq_121\"]/p[1]/text()");
			String jbxx_dz = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.JBXX_SCDZ,jbxx_dz.replaceAll(".*：", "").trim());
			
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[1]/dt/span[2]/text()");
			String wtxx_zj = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.WTXX_ZJ, wtxx_zj.trim());
			
			obj = node .evaluateXPath("//*[@class=\"inforTxt\"]/dl[2]/dt[2]/span[2]/text()");
			String fwxz_fwss = obj.length > 0 ? obj[0].toString() : "";
			sValue(HouseParseConstants.FWXZ_FWSS, fwxz_fwss.trim());
			
	        obj = node .evaluateXPath("//*[@id=\"thumbnail\"]/ul/li/img/@src");
	        Map<Integer,String> map_thumbnail = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	            map_thumbnail.put(i,obj[i].toString());
	        }
	        sValue("thumbnail",map_thumbnail);
	        
	        obj = node .evaluateXPath("//*[@class=\"img_2013\"]/a[1]/img/@src");
	        Map<Integer,String> map_imglist = new LinkedHashMap<>();
	        for (int i = 0; i < obj.length ; i++) {
	        	map_imglist.put(i,obj[i].toString());
	        }
	        sValue("img",map_imglist);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		

	}
}
