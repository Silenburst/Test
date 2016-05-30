package com.newenv.lpzd.lp.action;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;

import com.alibaba.fastjson.JSONObject;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.bms.utils.DateUtil;
import com.newenv.lpzd.Utils.FileUtil;

public class KindEditorAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7781843779542000567L;

	// 图片对象
	private File imgFile;
	// 图片宽度
	private String imgWidth;
	// 图片高度
	private String imgHeight;
	// 图片对齐方式
	private String align;
	// 图片标题
	private String imgTitle;

	public String uploadImage() throws Exception {
		
		MultiPartRequestWrapper wrapper = (MultiPartRequestWrapper) ServletActionContext.getRequest();

		// 获得图片名字
		String imgName = wrapper.getFileNames("imgFile")[0];
		
		String[] paths = FileUtil.getXhjfwRandomFilename(FileUtil.fileUrl, imgName);

		// 获得图片后缀名
		String fileExt = imgName.substring(imgName.lastIndexOf(".")).toLowerCase();

		// 重新生成图片名字
		String imgN = new Date().getTime() + fileExt;

		// 图片在服务器上的绝对路径。编辑器并没有提供删除图片功能，此路径以后可以用于后台程序对图片的操作
		String serverPath = "http://imgbms.xhjfw.com/";
		// 页面的引用地址
		String savePath = "http://imgbms.xhjfw.com/";
		// 实际应用中鉴于地址的可变性，此处的两个path可以动态生成或从配置文件读取

//		kEUploadImage(ServletActionContext.getRequest(), ServletActionContext.getResponse(), imgFile, imgTitle,
//				imgWidth, imgHeight, paths[0], savePath, serverPath);
		
		kEUploadImage(ServletActionContext.getRequest(), ServletActionContext.getResponse(),imgFile,paths[1],imgTitle, savePath);

		return null;
	}

//	public void kEUploadImage(HttpServletRequest request, HttpServletResponse response, File imgFile, String imgTitle,
//			String imgWidth, String imgHeight, String imgName, String savePath, String serverPath)
//					throws FileNotFoundException, IOException {
//
//		// 将图片写入服务器
//		ImageUtils.uploadToServer(imgFile, serverPath, imgName);
//
//		// 页面回显
////		String id = "content";
////		String url = savePath + imgName;
////		String border = "0";
//		// String result ="<mce:script type='text/javaScript'>" +
//		// parent.KE.plugin[/"image/"].insert(/""
//		// + id
//		// + "/",/""
//		// + url
//		// + "/",/""
//		// + imgTitle
//		// + "/",/""
//		// + imgWidth
//		// + "/",/""
//		// + imgHeight
//		// + "/",/""
//		// + border + "/""
//		// +");
//		// </mce:script>";
//		// PrintWriter out = null;
//		// out = encodehead(request, response);
//		// out.write(id + url + border);
//		// out.close();
//
//		// 发送给 KE
//		JSONObject obj = new JSONObject();
//		obj.put("error", 0);
//		obj.put("url", savePath + imgName);
//		System.out.println(obj.toString());
//
//		response.getWriter().write(obj.toString());
//		response.getWriter().flush();
//		response.getWriter().close();
//	}
	
	public void kEUploadImage(HttpServletRequest request, HttpServletResponse response, File imgFile, String imgName,String imgTitle,String savePath)
					throws FileNotFoundException, IOException {
		FileUtil.uploadFile(imgFile, imgName);
		// 发送给 KE
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", savePath + imgName);
		System.out.println(obj.toString());

		response.getWriter().write(obj.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}

	PrintWriter encodehead(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			return response.getWriter();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 产生一个随机文件名。
	 * @param basePath	文件存放的基目录
	 * @param fileName	原文件名
	 * @return 字符串数组，第一项为完整的文件名(包括完成的路径)，第二项为不包括基目录的的文件名。
	 */
	public synchronized static String[] getXhjfwRandomFilename(String fileName){
		String[] paths = new String[1];
		Date now = new Date();
		String datePath = "xhjfwimg\\" + DateUtil.formatDate(now, "yyyy-MM-dd");
//		String path = basePath + "/" + datePath;
		//new File(path).mkdirs();	//使用阿里云后，不需要在本地创建目录了
		String randomFileName = DateUtil.formatDate(now, "yyyyMMddHHmmss")+"-"+(int)(Math.random()*1000) + getExtention(fileName);
//		paths[0] = path + "/" + randomFileName;
		paths[0] = datePath + "\\" + randomFileName;
		return paths; 
	}
	
	/**
	 * 获取文件名的后缀。
	 * @param fileName
	 * @return
	 */
	private static String getExtention(String fileName)  { 
        int pos = fileName.lastIndexOf("."); 
        if(pos<0){
        	return "";
        }else{
        	return fileName.substring(pos); 
        }
	}
	

	public File getImgFile() {
		return imgFile;
	}

	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	public String getImgWidth() {
		return imgWidth;
	}

	public void setImgWidth(String imgWidth) {
		this.imgWidth = imgWidth;
	}

	public String getImgHeight() {
		return imgHeight;
	}

	public void setImgHeight(String imgHeight) {
		this.imgHeight = imgHeight;
	}

	public String getAlign() {
		return align;
	}

	public void setAlign(String align) {
		this.align = align;
	}

	public String getImgTitle() {
		return imgTitle;
	}

	public void setImgTitle(String imgTitle) {
		this.imgTitle = imgTitle;
	}

	public static void main(String [] args){
		for(int i=0;i<1000000;i++){
			System.out.println(Math.random());
		}
	}
}
