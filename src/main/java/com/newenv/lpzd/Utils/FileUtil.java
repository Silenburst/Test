package com.newenv.lpzd.Utils;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.GetObjectRequest;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.newenv.bms.utils.DateUtil;


public class FileUtil {

	//阿里云OSS服务器参数
	private static String ossAccessKeyId;
	private static String ossAccessKeySecret;
	private static String ossEndpoint;
	private static String ossBucketName;
	public static String fileUrl;	//访问普通文件的url前缀
	public static String imageUrl;	//访问图片文件的url前缀
	public static String filePathOld ;
	
	private static OSSClient ossClient = null;
	
	//水印图片
	private static Image waterImage = null;
	
	private static Logger log = Logger.getLogger(FileUtil.class);
	
	static{
		Properties props = new Properties();  
		InputStream propFile;
		try {
			//  inputStream = getClass().getResourceAsStream("/baseconfig.properties");  
			//getResourceAsStream 得到是发布后的 \XHJFWWServices\WEB-INF\classes目录
			propFile =FileUtil.class.getClassLoader().getResourceAsStream( "/config/file.properties");
			props.load(propFile);
		    ossAccessKeyId = (String) props.get("oss.accessKeyId");  
		    ossAccessKeySecret=(String) props.get("oss.accessKeySecret"); 
		    ossEndpoint=(String) props.get("oss.endpoint"); 
		    ossBucketName=(String) props.get("oss.bucketName"); 
		    fileUrl=(String) props.get("file.basepath"); 
		    imageUrl=(String) props.get("oss.imageDomain"); 
		    filePathOld=(String) props.get("file.basepath.old"); 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	public static Image pressWaterImage(Image srcImage){

		if(Config.isNeedPressWater()){	//需要打水印
			//原图的大小
			int width = srcImage.getWidth(null);
			int height = srcImage.getHeight(null);
			
			//水印图片的大小
			getWaterImage();
			
			int width_1 = waterImage.getWidth(null);
			int height_1 = waterImage.getHeight(null);
			
			Point waterImagePosition = getWaterImagePosition(srcImage, waterImage);
			
			BufferedImage bufferedImage = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics2D g = bufferedImage.createGraphics();
			g.drawImage(srcImage, 0, 0, width, height, null);
			
			//打水印
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,
					0.5f));
			g.drawImage(waterImage, waterImagePosition.x, waterImagePosition.y, width_1, height_1, null); // 水印文件结束
			g.dispose();
			return bufferedImage;
		} else {
			return srcImage;
		}
	}
	
	
	/**
	 * 获取水印图片的数据。
	 * @return
	 */
	private static Image getWaterImage(){
		if(waterImage == null){
			//TODO 水印图片路径需要修改
			File file = new File(FileUtil.class.getResource("/../../").getPath() + Config.getWaterImage());
			try {
				waterImage =  ImageIO.read(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return waterImage;
	}

	/**
	 * 获取水印应打在原图的哪个位置。
	 * @param image
	 * @param waterImage
	 * @return
	 */
	private static Point getWaterImagePosition(Image image, Image waterImage){
		int position = Config.getWaterImagePosition();
		
		//原图的大小
		int width = image.getWidth(null);
		int height = image.getHeight(null);
		
		//水印图片的大小
		int width_1 = waterImage.getWidth(null);
		int height_1 = waterImage.getHeight(null);
		
		int widthDiff = width - width_1;
		int heightDiff = height - height_1;

		int x = 0, y = 0;
		switch (position) {
		case 1:
			x = 0;
			y = 0;
			break;
		case 2:
			x = widthDiff / 2;
			y = 0;
			break;
		case 3:
			x = widthDiff;
			y = 0;
			break;
		case 4:
			x = 0;
			y = heightDiff / 2;
			break;
		case 5:
			x = widthDiff / 2;
			y = heightDiff / 2;
			break;
		case 6:
			x = widthDiff;
			y = heightDiff / 2;
			break;
		case 7:
			x = 0;
			y = heightDiff;
			break;
		case 8:
			x = widthDiff / 2;
			y = heightDiff;
			break;
		case 9:
			x = widthDiff;
			y = heightDiff;
			break;
		}
		return new Point(x, y);
	}
	
	/**
	 * 产生一个随机文件名。
	 * @param basePath	文件存放的基目录
	 * @param fileName	原文件名
	 * @return 字符串数组，第一项为完整的文件名(包括完成的路径)，第二项为不包括基目录的的文件名。
	 */
	public synchronized static String[] getRandomFilename(String basePath,String fileName){
		String[] paths = new String[2];
		Date now = new Date();
		String datePath = "newimg/" + DateUtil.formatDate(now, "yyyy-MM-dd");
		String path = basePath + "/" + datePath;
		//new File(path).mkdirs();	//使用阿里云后，不需要在本地创建目录了
		String randomFileName = DateUtil.formatDate(now, "yyyyMMddHHmmss")+"-"+(int)(Math.random()*1000) + getExtention(fileName);
		paths[0] = path + "/" + randomFileName;
		paths[1] = datePath + "/" + randomFileName;
		return paths; 
	}
	
	/**
	 * 产生一个随机文件名。
	 * @param basePath	文件存放的基目录
	 * @param fileName	原文件名
	 * @return 字符串数组，第一项为完整的文件名(包括完成的路径)，第二项为不包括基目录的的文件名。
	 */
	public synchronized static String[] getXhjfwRandomFilename(String basePath,String fileName){
		String[] paths = new String[2];
		Date now = new Date();
		String datePath = "xhjfwimg/" + DateUtil.formatDate(now, "yyyy-MM-dd");
		String path = basePath + "/" + datePath;
		//new File(path).mkdirs();	//使用阿里云后，不需要在本地创建目录了
		String randomFileName = DateUtil.formatDate(now, "yyyyMMddHHmmss")+"-"+(int)(Math.random()*1000) + getExtention(fileName);
		paths[0] = path + "/" + randomFileName;
		paths[1] = datePath + "/" + randomFileName;
		return paths; 
	}
	
	/**
	 * 产生一个随机文件名。
	 * @param basePath	文件存放的基目录
	 * @param fileName	原文件名
	 * @return 字符串数组，第一项为完整的文件名(包括完成的路径)，第二项为不包括基目录的的文件名。
	 */
	public synchronized static String[] getRandomMenuFilename(String basePath,String fileName){
		String[] paths = new String[2];
		Date now = new Date();
		String datePath = "menuImage/";
		String path = basePath + "/" + datePath;
		//new File(path).mkdirs();	//使用阿里云后，不需要在本地创建目录了
		String randomFileName = DateUtil.formatDate(now, "yyyyMMddHHmmss")+"-"+(int)(Math.random()*1000) + getExtention(fileName);
		paths[0] = path + "/" + randomFileName;
		paths[1] = datePath + "/" + randomFileName;
		return paths; 
	}
	
	/**
	 * 合同扫描件图片上传，产生一个随机文件名。
	 * @param basePath	文件存放的基目录 d:/data/
	 * @param fileName	原文件名
	 * @return 字符串数组，第一项为完整的文件名(包括完成的路径)，第二项为不包括基目录的的文件名。
	 */
	public synchronized static String[] getRandomConstractFilename(String basePath,String fileName){
		boolean flag=basePath.replaceAll("\\\\","\\/").endsWith("/");
		String[] paths = new String[2];
		Date now = new Date();
		String datePath = "contractImage/"+ DateUtil.formatDate(now, "yyyy-MM-dd");
		String path = basePath + (flag?"":"/") + datePath;
		//new File(path).mkdirs();	//使用阿里云后，不需要在本地创建目录了
		String randomFileName = DateUtil.formatDate(now, "yyyyMMddHHmmss")+"-"+(int)(Math.random()*1000) + getExtention(fileName);
		paths[0] = path + "/"  + randomFileName;
		paths[1] = datePath + "/" + randomFileName;
		return paths; 
	}
	
	/**
	 * 存储文件到目标位置。
	 * @param file
	 * @param destFileName
	 * @throws IOException
	 */
	public static void uploadFile(File file, String destFileName) throws IOException{
		try{
			InputStream content = new FileInputStream(file);
			
	        // 创建上传Object的Metadata
	        ObjectMetadata meta = new ObjectMetadata();
	
	        // 必须设置ContentLength
	        meta.setContentLength(file.length());
	        
	        // 上传Object.
	        getOSSClient().putObject(ossBucketName, destFileName, content, meta);
		} catch (IOException e){
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw, true));
			log.error(sw.toString());
			throw e;
		}
	}
	
	
	/**
	 * 从aliyun服务器下载文件到本地磁盘。
	 * @param destFileName aliyun服务器的文件
	 * @param diskfileName 存放到本地磁盘的文件地址
	 * @throws IOException
	 */
	public static void downFile(String destFileName,String diskfileName) throws IOException{
		// 新建GetObjectRequest
		GetObjectRequest getObjectRequest = new GetObjectRequest(ossBucketName, destFileName);
				
		// 下载Object到文件
		File file=new File(diskfileName);
		//文件目录是否存在
		if(!file.getParentFile().exists()){
			file.getParentFile().mkdirs();
		}
		ObjectMetadata objectMetadata = getOSSClient().getObject(getObjectRequest, new File(diskfileName));
		
	}
	
	
	/**
	 * 删除文件。
	 * @param fileName
	 */
	public static void deleteFile(String fileName){
		getOSSClient().deleteObject(ossBucketName, fileName);
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
	public static String getFileName(String fileName){
		 int pos = fileName.lastIndexOf("/"); 
	        if(pos<0){
	        	return "";
	        }else{
	        	return fileName.substring(pos); 
	        }
	}

	public static String getImageUrl(String fileName){
		return imageUrl+fileName;
	}
	
	public static String getImageUrl(String fileName, String param){
		return imageUrl+fileName + "@" + param;
	} 
	
	public static void setImageUrl(String imageUrl) {
		FileUtil.imageUrl = imageUrl;
	}
	
	public static void setOssAccessKeyId(String ossAccessKeyId) {
		FileUtil.ossAccessKeyId = ossAccessKeyId;
	}

	public static void setOssAccessKeySecret(String ossAccessKeySecret) {
		FileUtil.ossAccessKeySecret = ossAccessKeySecret;
	}

	public static void setOssEndpoint(String ossEndpoint) {
		FileUtil.ossEndpoint = ossEndpoint;
		if(StringUtils.hasText(ossBucketName)){
			fileUrl = "http://" + ossBucketName + "." + ossEndpoint.substring(7) + "/";
		}
	}

	public static void setOssBucketName(String ossBucketName) {
		FileUtil.ossBucketName = ossBucketName;
		if(StringUtils.hasText(ossEndpoint)){
			fileUrl = "http://" + ossBucketName + "." + ossEndpoint.substring(7) + "/";
		}
	}

	public static String getOssBucketName() {
		return ossBucketName;
	}

	public static void setWaterImage(Image waterImage) {
		FileUtil.waterImage = waterImage;
	}
	
	public static OSSClient getOSSClient(){
		if(ossClient==null)
			ossClient = new OSSClient(ossEndpoint,ossAccessKeyId, ossAccessKeySecret);
		return ossClient;
	}
}
