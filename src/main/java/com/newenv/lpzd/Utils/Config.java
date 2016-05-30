package com.newenv.lpzd.Utils;

public class Config {

	/**
	 * 是否需要打水印。
	 * @return
	 */
	public static boolean isNeedPressWater(){
		return true;
	}
	
	/**
	 * 图片的最大宽度。
	 * @return
	 */
	public static int getImageMaxWidth(){
		return 600;
	}
	
	/**
	 * 图片的最大高度。
	 * @return
	 */
	public static int getImageMaxHeight(){
		return 480;
	}
	
	/**
	 * 水印图片文件名称。
	 * @return
	 */
	public static String getWaterImage(){
		return "images/water.gif";
	}
	
	/**
	 * 水印打在原图片的哪个位置。
	 * @return
	 */
	public static int getWaterImagePosition(){
		return 9;
	}
}
