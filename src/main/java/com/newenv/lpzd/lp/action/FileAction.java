package com.newenv.lpzd.lp.action;

import static com.aliyun.oss.internal.OSSUtils.OSS_RESOURCE_MANAGER;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.common.utils.IOUtils;
import com.aliyun.oss.model.OSSObject;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.Utils.FileUtil;

public class FileAction extends BaseAction {

	// 上传文件时自动附带的信息 begin
	private File file;
	private String name;
	private String fileFileName;
	private String fileContentType;

	private int chunk;
	private int chunks;
	// 上传文件时自动附带的信息 end

	private String fileName; // 要显示、下载或删除的文件名(不包含基目录)

	/*
	 * KE所需字段
	 */
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

	/**
	 * 外网图片上传文件。
	 * 
	 * @return
	 */
	public String upload() {
		String[] paths = FileUtil.getXhjfwRandomFilename(FileUtil.fileUrl, name);
		File dstFile = new File(paths[0]);

		try {
			FileUtil.uploadFile(file, paths[1]);
		} catch (Exception e) {
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}

		return this.jsonAjaxResult("{\"fileName\":\"" + paths[1] + "\"}");
	}
	

	/**
	 * KE上传文件处理逻辑
	 * 
	 * @return String
	 * @throws Exception
	 */
	public String KEUpload() throws Exception {

		MultiPartRequestWrapper wrapper = (MultiPartRequestWrapper) ServletActionContext.getRequest();
		
		// 获得图片名字
		String imgName = wrapper.getFileNames("imgFile")[0];
		
		String[] paths = FileUtil.getXhjfwRandomFilename(FileUtil.fileUrl, imgName);
		
		// 页面的引用地址
		String savePath = "http://imgbms.xhjfw.com/";
		
		kEUploadImage(ServletActionContext.getRequest(), ServletActionContext.getResponse(), imgFile, paths[1],
				imgTitle, savePath, align, imgWidth, imgHeight);
		return null;
	}

	public void kEUploadImage(HttpServletRequest request, HttpServletResponse response, File imgFile, String imgName,
			String imgTitle, String savePath, String align, String width, String height)
					throws FileNotFoundException, IOException {
		FileUtil.uploadFile(imgFile, imgName);
		// 发送给 KE
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", savePath + imgName);
		obj.put("align", align);
		obj.put("width", width);
		obj.put("height", height);
		obj.put("imgTitle", imgTitle);
		System.out.println(obj.toString());

		response.getWriter().write(obj.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}

	// 上传合同确认扫描附件的图片
	public String uploadConstactImg() {
		String[] paths = FileUtil.getRandomConstractFilename(FileUtil.fileUrl, name);
		File dstFile = new File(paths[0]);

		try {
			FileUtil.uploadFile(file, paths[1]);
		} catch (Exception e) {
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}

		return this.jsonAjaxResult("{\"fileName\":\"" + paths[1] + "\"}");
	}

	public String uploadSetMenu() {
		String[] paths = FileUtil.getRandomMenuFilename(FileUtil.fileUrl, name);
		File dstFile = new File(paths[0]);

		try {
			FileUtil.uploadFile(file, paths[1]);
		} catch (Exception e) {
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}

		return this.jsonAjaxResult("{\"fileName\":\"" + paths[1] + "\"}");
	}

	/**
	 * 显示图片。
	 */
	public String menuImg() {
		if (fileName.indexOf("menuImage") > -1) { // 新图片
			this.getResponse().setContentType("image/*");
			File file = new File(FileUtil.fileUrl + fileName);

			try {
				InputStream fis = new BufferedInputStream(new FileInputStream(file));
				byte[] buffer = new byte[fis.available()];
				fis.read(buffer);
				fis.close();

				OutputStream toClient = new BufferedOutputStream(this.getResponse().getOutputStream());
				toClient.write(buffer);
				toClient.flush();
				toClient.close();
			} catch (Exception e) {
				// ignore
			}

			return null;
		} else {
			try {
				this.getResponse().sendRedirect(FileUtil.filePathOld + fileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	}

	/**
	 * 显示图片。
	 */
	public String img() {
		if (!StringUtils.hasText(fileName)) {
			return null;
		} else if (fileName.indexOf("newimg") > -1) { // 新图片
			this.getResponse().setContentType("image/*");
			File file = new File(FileUtil.fileUrl + fileName);

			try {
				InputStream fis = new BufferedInputStream(new FileInputStream(file));
				byte[] buffer = new byte[fis.available()];
				fis.read(buffer);
				fis.close();

				OutputStream toClient = new BufferedOutputStream(this.getResponse().getOutputStream());
				toClient.write(buffer);
				toClient.flush();
				toClient.close();
			} catch (Exception e) {
				// ignore
			}

			return null;
		} else {
			try {
				this.getResponse().sendRedirect(FileUtil.filePathOld + fileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	}

	/**
	 * 显示附件。
	 */
	public String attach() {
		this.getResponse().setContentType("application/octet-stream");

		try {
			OSSObject object = FileUtil.getOSSClient().getObject(FileUtil.getOssBucketName(), fileName);
			// 获取Object的输入流
			InputStream objectContent = object.getObjectContent();

			OutputStream outputStream = null;
			try {
				outputStream = new BufferedOutputStream(this.getResponse().getOutputStream());
				int bufSize = 1024 * 4;
				byte[] buffer = new byte[bufSize];
				int bytesRead;
				while ((bytesRead = objectContent.read(buffer)) > -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
			} catch (IOException e) {
				throw new ClientException(OSS_RESOURCE_MANAGER.getString("CannotReadContentStream"), e);
			} finally {
				// Close the output stream
				IOUtils.safeClose(outputStream);
				// Close the response stream
				IOUtils.safeClose(objectContent);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 删除文件。
	 * 
	 * @return
	 */
	public String delete() {
		try {
			FileUtil.deleteFile(fileName);
		} catch (Exception e) {
			return this.jsonAjaxFailedResult(e.getLocalizedMessage());
		}
		return this.jsonAjaxSuccessResult("");
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public int getChunk() {
		return chunk;
	}

	public void setChunk(int chunk) {
		this.chunk = chunk;
	}

	public int getChunks() {
		return chunks;
	}

	public void setChunks(int chunks) {
		this.chunks = chunks;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
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

}
