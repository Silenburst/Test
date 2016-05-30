package com.newenv.lpzd.Utils;

import java.io.File;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.net.ssl.SSLException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpRequest;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
/**
 * 远程调用接口工具类
 * @author heyewei
 *
 */
public class HttpClientUtil {

	/** 重试策略 */
	private HttpClientUtilRetryHandler httpClientUtilRetryHandler;
	/** 对象 */
	private static HttpClientUtil httpClientUtil;

	/** 设置重试策略 */
	public HttpClientUtil setHttpClientUtilRetryHandler(
			HttpClientUtilRetryHandler httpClientUtilRetryHandler) {
		this.httpClientUtilRetryHandler = httpClientUtilRetryHandler;
		return this;
	}

	/** 获取 */
	public static HttpClientUtil getInstance() {
		if (httpClientUtil == null) {
			return new HttpClientUtil();
		}
		return httpClientUtil;
	}

	
	/**
	 * 开启重试策略的post
	 * 
	 * @param url
	 * @param encode
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String httpPost(String url, String encode, Map<String, String> params)
			throws Exception {
		try {
			return post(url, encode, params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			if (httpClientUtilRetryHandler == null) {
				throw new Exception("远程调用重试策略未启用");
			}
			int count = 1;
			while (httpClientUtilRetryHandler.retry(count)) {
				count++;
				try {
					return post(url, encode, params);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			throw new Exception("远程调用失败");
		}
	}
	
	/**
	 * 开启重试策略的post
	 * 
	 * @param url
	 * @param encode
	 * @param requestBody
	 * @return
	 * @throws Exception
	 */
	public String httpPost(String url, String encode, String requestBody)
			throws Exception {
		try {
			return post(url, encode, requestBody);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			if (httpClientUtilRetryHandler == null) {
				throw new Exception("远程调用重试策略未启用");
			}
			int count = 1;
			while (httpClientUtilRetryHandler.retry(count)) {
				count++;
				try {
					return post(url, encode, requestBody);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			throw new Exception("远程调用失败");
		}
	}
	
	/**
	 * 开启重试策略的post
	 * 
	 * @param url
	 * @param encode
	 * @param file
	 * @param fileName
	 * @param length
	 * @param contentType
	 * @return
	 * @throws Exception
	 */
	public String httpPost(String url, String encode, File file)
			throws Exception {
		try {
			return post(url, encode, file);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			if (httpClientUtilRetryHandler == null) {
				throw new Exception("远程调用重试策略未启用");
			}
			int count = 1;
			while (httpClientUtilRetryHandler.retry(count)) {
				count++;
				try {
					return post(url, encode, file);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			throw new Exception("远程调用失败");
		}
	}
	
	/**
	 * 开启重试策略的get
	 * 
	 * @param url
	 * @param encode
	 * @return
	 * @throws Exception
	 */
	public String httpGet(String url, String encode) throws Exception {
		try {
			return get(url, encode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			if (httpClientUtilRetryHandler == null) {
				throw new Exception("远程调用重试策略未启用");
			}
			int count = 1;
			while (httpClientUtilRetryHandler.retry(count)) {
				count++;
				try {
					return get(url, encode);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			throw new Exception("远程调用失败");
		}
	}

	
	/**
	 * httpclient get请求
	 * 
	 * @param url
	 * @param encode
	 * @return
	 * @throws Exception
	 */
	private String get(String url, String encode) throws Exception {
		CloseableHttpClient httpclient = HttpClients.custom()
				.setRetryHandler(new CloseableHttpClientRetryHandler()).build();
		HttpGet httpget = new HttpGet(url);
		CloseableHttpResponse response = null;
		// 设置请求和传输超时时间5s,设置cookie策略
		RequestConfig requestconfig = RequestConfig.custom()
				.setSocketTimeout(1000 * 60).setConnectTimeout(1000 * 60)
				.setCookieSpec(CookieSpecs.DEFAULT).build();
		httpget.setConfig(requestconfig);
		try {
			response = httpclient.execute(httpget);
			// 判断访问的状态码
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				// 状态非200
				throw new Exception("远程连接失败");
			}

			HttpEntity entity = response.getEntity();
			String responseStr = "";
			if (entity != null) {
				responseStr = EntityUtils.toString(entity, encode);
			}
			EntityUtils.consume(entity);
			return responseStr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new Exception("远程调用失败");
		} finally {
			try {
				if (response != null) {
					response.close();
				}
				if (httpget != null) {
					httpget.releaseConnection();
				}
				if (httpclient != null) {
					httpclient.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * httpclient post请求
	 * 
	 * @param url
	 * @param encode
	 * @return
	 * @throws Exception
	 */
	private String post(String url, String encode, Map<String, String> params)
			throws Exception {
		CloseableHttpClient httpclient = HttpClients.custom()
				.setRetryHandler(new CloseableHttpClientRetryHandler()).build();
		HttpPost httpPost = new HttpPost(url);
		CloseableHttpResponse response = null;
		RequestConfig requestconfig = RequestConfig.custom()
				.setSocketTimeout(1000 * 60).setConnectTimeout(1000 * 60)
				.setCookieSpec(CookieSpecs.DEFAULT).build();
		httpPost.setConfig(requestconfig);
		try {
			// 将要POST的数据封包
			if (params != null && params.size() > 0) {
				Set<String> paramsSet = params.keySet();
				List<NameValuePair> nvps = new ArrayList<NameValuePair>();
				for (String key : paramsSet) {
					nvps.add(new BasicNameValuePair(key, params.get(key)));
				}
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, encode));
			}
			// execute
			response = httpclient.execute(httpPost);
			// 判断访问的状态码
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				// 状态非200
				throw new Exception("远程连接失败");
			}
			HttpEntity entity = response.getEntity();
			String responseStr = "";
			if (entity != null) {
				responseStr = EntityUtils.toString(entity, encode);
			}
			EntityUtils.consume(entity);
			return responseStr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new Exception("远程调用失败");
		} finally {
			try {
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					httpPost.releaseConnection();
				}
				if (httpclient != null) {
					httpclient.close();
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
	
	/**
	 * httpclient post请求
	 * 
	 * @param url
	 * @param encode
	 * @param file
	 * @param fileName
	 * @param length
	 * @param contentType
	 * @return
	 * @throws Exception
	 */
	private String post(String url, String encode, File file)
			throws Exception {
		CloseableHttpClient httpclient = HttpClients.custom()
				.setRetryHandler(new CloseableHttpClientRetryHandler()).build();
		HttpPost httpPost = new HttpPost(url);
		CloseableHttpResponse response = null;
		RequestConfig requestconfig = RequestConfig.custom()
				.setSocketTimeout(1000 * 60).setConnectTimeout(1000 * 60)
				.setCookieSpec(CookieSpecs.DEFAULT).build();
		httpPost.setConfig(requestconfig);
		try {
			//
			FileBody fileBody = new FileBody(file);
//			StringBody fileNameStringBody = new StringBody(fileName, ContentType.MULTIPART_FORM_DATA);
//			StringBody fileLengthStringBody = new StringBody(String.valueOf(length), ContentType.MULTIPART_FORM_DATA);
//			StringBody contentTypeStringBody = new StringBody(contentType, ContentType.MULTIPART_FORM_DATA);
			MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
			multipartEntityBuilder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			multipartEntityBuilder.addPart("media", fileBody);
//			multipartEntityBuilder.addPart("filename", fileNameStringBody);
//			multipartEntityBuilder.addPart("filelength", fileLengthStringBody);
//			multipartEntityBuilder.addPart("content-type", contentTypeStringBody);
			//
			httpPost.setEntity(multipartEntityBuilder.build());
			// execute
			response = httpclient.execute(httpPost);
			// 判断访问的状态码
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				// 状态非200
				throw new Exception("远程连接失败");
			}
			HttpEntity entity = response.getEntity();
			String responseStr = "";
			if (entity != null) {
				responseStr = EntityUtils.toString(entity, encode);
			}
			EntityUtils.consume(entity);
			return responseStr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new Exception("远程调用失败");
		} finally {
			try {
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					httpPost.releaseConnection();
				}
				if (httpclient != null) {
					httpclient.close();
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
	
	
	/**
	 * httpclient post请求
	 * 
	 * @param url
	 * @param encode
	 * @param requestBody
	 * @return
	 * @throws Exception
	 */
	private String post(String url, String encode, String requestBody)
			throws Exception {
		CloseableHttpClient httpclient = HttpClients.custom()
				.setRetryHandler(new CloseableHttpClientRetryHandler()).build();
		
		HttpPost httpPost = new HttpPost(url);
		CloseableHttpResponse response = null;
		RequestConfig requestconfig = RequestConfig.custom()
				.setSocketTimeout(1000 * 60).setConnectTimeout(1000 * 60)
				.setCookieSpec(CookieSpecs.DEFAULT).build();
		httpPost.setConfig(requestconfig);
		try {
			httpPost.setEntity(new StringEntity(requestBody,encode));
			// execute
			response = httpclient.execute(httpPost);
			// 判断访问的状态码
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				// 状态非200
				throw new Exception("远程连接失败");
			}
			HttpEntity entity = response.getEntity();
			String responseStr = "";
			if (entity != null) {
				responseStr = EntityUtils.toString(entity, encode);
			}
			EntityUtils.consume(entity);
			return responseStr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new Exception("远程调用失败");
		} finally {
			try {
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					httpPost.releaseConnection();
				}
				if (httpclient != null) {
					httpclient.close();
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	
	/**
	 * 重试策略
	 * 
	 * @author heyewei
	 * 
	 */
	static class CloseableHttpClientRetryHandler implements
			HttpRequestRetryHandler {

		@Override
		public boolean retryRequest(IOException exception, int executionCount,
				HttpContext context) {
			// TODO Auto-generated method stub
			// 设置恢复策略，在发生异常时候将自动重试5次
			if (executionCount >= 5) {
				// 如果已经重试了5次，就放弃
				return false;
			}
			if (exception instanceof InterruptedIOException) {
				// 超时
				return true;
			}
			if (exception instanceof UnknownHostException) {
				// 目标服务器不可达
				return true;
			}
			if (exception instanceof ConnectTimeoutException) {
				// 连接被拒绝
				return true;
			}
			if (exception instanceof SSLException) {
				// ssl握手异常
				return false;
			}
			HttpClientContext clientContext = HttpClientContext.adapt(context);
			HttpRequest request = clientContext.getRequest();
			boolean idempotent = !(request instanceof HttpEntityEnclosingRequest);
			if (idempotent) {
				// 如果请求是幂等的，就再次尝试
				return true;
			}
			return false;
		}

	}

	/**
	 * 内部httpclient的重试策略
	 * 
	 * @author heyewei
	 * 
	 */
	public static class HttpClientUtilRetryHandler {

		public boolean retry(int count) {
			if (count > 3) {
				return false;
			}
			return true;
		}

	}
	
}
