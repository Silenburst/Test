package com.newenv.lpzd.lp.fs.processor;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.TagNode;
import org.htmlcleaner.XPatherException;

import com.newenv.lpzd.Utils.HouseParseConstants;

public class BaseProcessor {
	
	protected String url = "";
	protected String charset = "gbk";
	protected String html = "";
	protected TagNode tagNode = null;
	protected Map<String, Object> map  = new LinkedHashMap<String, Object>();
	
	protected String gValue(String name) {
		return (String) map.get(name);
	}
	
	protected void initValue(String name, String value) {
		if (gValue(name) == null)
			sValue(name, value);
	}
	
	protected void init(String url){
		initvalues();
		String html = getPageSource(url);
		this.html = html;
		this.tagNode = getTagNode(html);
	}

	protected void initvalues(){
		initValue(HouseParseConstants.JBXX_FWMC, "");
		initValue(HouseParseConstants.JBXX_CS, "");
		initValue(HouseParseConstants.JBXX_CQ, "");
		initValue(HouseParseConstants.JBXX_SQ, "");
		initValue(HouseParseConstants.JBXX_HX, "");
		initValue(HouseParseConstants.JBXX_LX, "");
		initValue(HouseParseConstants.JBXX_YT, "");
		initValue(HouseParseConstants.JBXX_CX, "");
		initValue(HouseParseConstants.JBXX_LC, "");
		initValue(HouseParseConstants.JBXX_CQMJ, "");
		initValue(HouseParseConstants.JBXX_SYMJ, "");
		initValue(HouseParseConstants.JBXX_SCDZ, "");
		initValue(HouseParseConstants.JBXX_CQDZ, "");
		initValue(HouseParseConstants.JBXX_JZND, "");
		
		initValue(HouseParseConstants.FWXZ_ZXBZ, "");
		initValue(HouseParseConstants.FWXZ_FWSS, "");
		
		initValue(HouseParseConstants.CZXX_YZDJ, "");
		initValue(HouseParseConstants.CZXX_YF, "");
		initValue(HouseParseConstants.CZXX_ZPFS, "");
	}

	protected void sValue(String name, Object value) {
		map.put(name, value);
	}
	
	/**
	 * 获取网站源码
	 * @param url
	 * @return
	 */
	public String getPageSource(String url){
		this.url = url ;
		CloseableHttpClient httpclient = HttpClients.createDefault();  
		try {
			HttpGet httpget = new HttpGet(url);
			CloseableHttpResponse response = httpclient.execute(httpget);
			HttpEntity entity = response.getEntity();
			String html = EntityUtils.toString(entity,charset);
			return html;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	
	public TagNode getTagNode(String html){
		HtmlCleaner cleaner = new  HtmlCleaner();
		TagNode node = cleaner.clean(html);
		return node;
	}

	/**
	 * Htmlcleaner解析网站源码
	 * @return 
	 */
	public Map<String, Object> parseHtml(){
		return map;
	}
	
    /**
     * 正则匹配
     * @param regEx
     * @param str
     * @return
     */
    protected  String getRegEx(String regEx,String str){
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);
        while(m.find()){
            return m.group();
        }
        return null;
    }
    
    /**
     * Xpath 提取
     * @param node
     * @param xpath
     * @param idx
     * @return
     */
    public String getTagNodeForXpath(TagNode node,String xpath,Integer idx){
    	String res = "";
		try {
			Object[] obj = node .evaluateXPath(xpath);
			if(obj.length > idx){
				res = obj[idx].toString().trim();
			}
		} catch (XPatherException e) {
			e.printStackTrace();
		}
    	return res;
    }
    
    /**
     * 房源户型格式转换
     * @param str
     * @return
     */
    public String convertHuxin(String str){
    	String hx = "{1},{2},{3},{4},{5}";
		if(StringUtils.isNotEmpty(str)){
            String s = getRegEx("\\d室",str);
            hx = hx.replace("{1}", s == null ? "0" : s.replaceAll("[^0-9]",""));
            String t = getRegEx("\\d厅",str);
            hx = hx.replace("{2}", t == null ? "0" : t.replaceAll("[^0-9]",""));
            String c = getRegEx("\\d厨",str);
            hx = hx.replace("{3}", c == null ? "0" : c.replaceAll("[^0-9]",""));
            String w = getRegEx("\\d卫",str);
            hx = hx.replace("{4}", w == null ? "0" : w.replaceAll("[^0-9]",""));
            String yt = getRegEx("\\d阳台",str);
            hx = hx.replace("{5}", yt == null ? "0" : yt.replaceAll("[^0-9]",""));
        }
    	return hx;
    }
}
