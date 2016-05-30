package com.newenv.lpzd.Utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;


public class ConfigReader {

	/**
	 * log
	 */
	private static Logger log = Logger.getLogger(ConfigReader.class);
	public final static String CS_TYPE="csType";
	public final static String CZ_TYPE="czType";
	

	/**
	 * Field that hold the configure property file (file path :
	 * /prober.properties).
	 */
	private static Properties prop = null;
	static {
		InputStream configStream = null;
		try {
			if (prop == null) {
				prop = new Properties();
				configStream = ConfigReader.class.getClassLoader()
						.getResourceAsStream(
								"/config/config.properties");
				prop.load(configStream);
			}
		} catch (Exception e) {
			log.error("Cannot read config file : config.properties.", e);
		} finally {
			if (configStream != null) {
				try {
					configStream.close();
				} catch (IOException e) {
					log.error("close config file :config.properties error", e);
				}
			}
		}
	}

	/**
	 * Fetch a integer value from configure property file (file path :
	 * /prober.properties).
	 * 
	 * @param key
	 *            Key will used to find the corresponding string value.
	 * @return If there no value found with the specified key, a
	 *         <code>null</code> will be returned.
	 */
	public static String readString(String keyString) {
		String result = prop.getProperty(keyString);
		if (result == null) {
			return keyString;
		}
		return result;
	}

	/**
	 * Fetch a integer value from configure property file (file path :
	 * /prober.properties).
	 * 
	 * @param key
	 *            Key will used to find the corresponding integer value.
	 * @return If there no value found with the specified key, a
	 *         <code>null</code> will be returned.
	 */
	public static Integer readInteger(String keyString) {
		//按传入的键获取值
		String result = prop.getProperty(keyString);
		if (result != null) {
			//是否是数字
			if (StringUtils.isNumeric(result)) {
				return Integer.parseInt(result);
			}
		}
		return null;
	}

	public static List<KeyValue> readJsonList(String keyString) {
		ObjectMapper mapper = new ObjectMapper();
		List<KeyValue> list = new ArrayList<KeyValue>();
		try {
			list = mapper.readValue(readString(keyString),
					new TypeReference<List<KeyValue>>() {
					});
		} catch (Exception e) {
			log.error(e);
		}
		return list;
	}

	public static String readJsonValue(List<KeyValue> list, Object name) {
		if (list != null) {
			for (KeyValue keyValue : list) {
				if (keyValue.getName().equals(name.toString()))
					return keyValue.getValue();
			}
		}
		return "";
	}
	
public static void main(String[] args) {
	System.out.println(ConfigReader.readString(ConfigReader.CS_TYPE));
}
}
