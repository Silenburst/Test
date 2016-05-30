package com.newenv.lpzd.person.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Alignment;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
import jxl.write.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.struts2.ServletActionContext;
import org.datanucleus.util.StringUtils;
import org.hsqldb.lib.StringUtil;

import com.newenv.base.action.impl.BaseAction;

public class ExcelUtil extends BaseAction {  
    // username属性用来封装用户名  
    private String username;  
      
    // myFile属性用来封装上传的文件  
    private File myFile;  
    
    /**
     *  采用上面myFile名字+ContentType 将会获取到文件类型  固定写法
     */
    // myFileContentType属性用来封装上传文件的类型 
    private String myFileContentType;  
    /**
     *  采用上面myFile名字+FileName 将会获取到文件名字  固定写法
     */
    // myFileFileName属性用来封装上传文件的文件名  
    private String myFileFileName;  
  
      
    //获得username值  
    public String getUsername() {  
        return username;  
    }  
  
    //设置username值  
    public void setUsername(String username) {  
        this.username = username;  
    }  
  
    //获得myFile值  
    public File getMyFile() {  
        return myFile;  
    }  
  
    //设置myFile值  
    public void setMyFile(File myFile) {  
        this.myFile = myFile;  
    }  
  
    //获得myFileContentType值  
    public String getMyFileContentType() {  
        return myFileContentType;  
    }  
  
    //设置myFileContentType值  
    public void setMyFileContentType(String myFileContentType) {  
        this.myFileContentType = myFileContentType;  
    }  
  
    //获得myFileFileName值  
    public String getMyFileFileName() {  
        return myFileFileName;  
    }  
  
    //设置myFileFileName值  
    public void setMyFileFileName(String myFileFileName) {  
        this.myFileFileName = myFileFileName;  
    }  
    /**
     * @return
     * @throws BiffException
     * @throws IOException
     */
  //读Excel文件
  	public String readExcel() throws BiffException, IOException{
    	String json = "{\"status\" : \"success\"}";
	    try{
	  		 //创建一个list 用来存储读取的内容
	  		  List list = new ArrayList();
	  		  Workbook rwb = null;
	  		  Cell cell = null;
	  		  
	  		  //创建输入流
	  		  InputStream stream = new FileInputStream(myFile);
	  		  
	  		  //获取Excel文件对象
	  		  rwb = Workbook.getWorkbook(stream);
	  		  
	  		  //获取文件的指定工作表 默认的第一个
	  		  Sheet[] sheets = rwb.getSheets();
	  		  int length = sheets.length;
//	  		  Sheet sheet = rwb.getSheet(0);  
	  		  for (Sheet sheet : sheets) {
	  			boolean empty = StringUtils.isEmpty(StringUtil.arrayToString(sheet));
	  			  if(null == sheet)
	  			  {
	  				  continue;
	  			  }
	  			  //行数(表头的目录不需要，从1开始)
	  			  for(int i=0; i<sheet.getRows(); i++){
	  				  //创建一个数组 用来存储每一列的值
	  				  String[] str = new String[sheet.getColumns()];
	  				  //列数
	  				  for(int j=0; j<sheet.getColumns(); j++){
	  					  //获取第i行，第j列的值
	  					  cell = sheet.getCell(j,i);    
	  					  str[j] = cell.getContents();
	  				  }
	  				  //把刚获取的列存入list
	  				  list.add(str);
	  			  }
	  			  for(int i=0;i<list.size();i++){
	  				  String[] str = (String[])list.get(i);
	  				  for(int j=0;j<str.length;j++){
	  					  System.out.println(str[j]);
	  				  }
	  			  }
			}
	      } catch (Exception e) {
				json = "{\"status\" : \""+e.getMessage()+"\"}";
		  }
	    return jsonAjaxResult(json);
	}
    
  	
  	//在本地创建文件夹并上传excel文件
    public String bendiUpload(){  
    	String json = "{\"status\" : \"success\"}";
	    try{
		        //基于myFile创建一个文件输入流  
		        InputStream is = new FileInputStream(myFile);  
		        
		        // 设置上传文件目录  
		        String uploadPath = ServletActionContext.getServletContext().getRealPath("/person/uploadxls");  
		          
		        // 设置目标文件  
		        File toFile = new File(uploadPath); 
		        boolean exists = toFile.exists();
		        File file = null;
		        if(!exists)
		        {
		        	boolean mkdir = toFile.mkdir();
		        	if(!mkdir)
		        	{
		        		throw new Exception("目录文件创建失败.");
		        	}
		        }
		        file = new File(toFile.getPath(),this.getMyFileFileName());  
		       
		        System.out.println(file.toString());
		     //   ExcelHelper.readExcel(toFile.);
		     //   ExcelHelper.readExcel(toFile.);
		        // 创建一个输出流  
		        OutputStream os = new FileOutputStream(file);  
		        
		  
		        //设置缓存  
		        byte[] buffer = new byte[1024];  
		  
		        int length = 0;  
		  
		        //读取myFile文件输出到toFile文件中  
		        while ((length = is.read(buffer)) > 0) {  
		            os.write(buffer, 0, length);  
		        }  
		        System.out.println("上传用户"+username);  
		        System.out.println("上传文件名"+myFileFileName);  
		        System.out.println("上传文件类型"+myFileContentType);  
		        //关闭输入流  
		        is.close();  
		        //关闭输出流  
		        os.close();  
	      } catch (Exception e) {
				json = "{\"status\" : \""+e.getMessage()+"\"}";
		  }
      return jsonAjaxResult(json);
    }
    
    
    
  //写Excel文件
  	public static void writeExcel(String filePath){
  		 String[] title = {"编号","产品名称","产品价格","产品数量","生产日期","产地","是否出口"};   
//  		 String[] title = {"小区名称","栋座","单元","楼层","房号","业主姓名","电话"};   

  	        try {   
  	            // 获得开始时间   
  	            long start = System.currentTimeMillis();   
  	            // 输出的excel的路径   
//  	            String filePath = "d:\\sssss\\测试批量导入1.xls";   
  	             // 创建Excel工作薄   
  	            WritableWorkbook wwb;   
  	             // 新建立一个jxl文件,即在d盘下生成testJXL.xls   
  	            OutputStream os = new FileOutputStream(filePath);   
  	            wwb=Workbook.createWorkbook(os);    
  	            // 添加第一个工作表并设置第一个Sheet的名字   
  	            WritableSheet sheet = wwb.createSheet("产品清单", 0);   
  	            Label label;   
  	            for(int i=0;i<title.length;i++){   
  	                // Label(x,y,z) 代表单元格的第x+1列，第y+1行, 内容z   
  	                // 在Label对象的子对象中指明单元格的位置和内容   
  	                label = new Label(i,0,title[i]); 
  	                label = new Label(i,0,title[i], getHeader());
  	                // 将定义好的单元格添加到工作表中   
  	                sheet.addCell(label);   
  	            }   
  	            // 下面是填充数据   
  	             /*   
  	              * 保存数字到单元格，需要使用jxl.write.Number 
  	              * 必须使用其完整路径，否则会出现错误 
  	             * */ 
  	           // 填充第一列数据 产品编号
  	            jxl.write.Number number = new jxl.write.Number(0,1,20071001);   
  	            sheet.addCell(number);   
  	            //填充第二列数据产品名称
  	            label = new Label(1,1,"金鸽瓜子");   
  	            sheet.addCell(label);   
  				 /* 
  				  * 定义对于显示金额的公共格式 
  				  * jxl会自动实现四舍五入 
  				  * 例如 2.456会被格式化为2.46,2.454会被格式化为2.45 
  				  */ 
  	            jxl.write.NumberFormat nf = new jxl.write.NumberFormat("#,###.00");   
  	            jxl.write.WritableCellFormat wcf = new jxl.write.WritableCellFormat(nf);   
  	             // 填充第三列产品金额
  	            jxl.write.Number nb = new jxl.write.Number(2,1,200000.45,wcf);   
  	            sheet.addCell(nb);   
  	            // 填充第四列产品数量   
  	             jxl.write.Number numb = new jxl.write.Number(3,1,200);   
  	            sheet.addCell(numb);   
  	            /* 
  	              * 定义显示日期的公共格式 
  	            * 如:yyyy-MM-dd hh:mm 
  	             * */ 
  	           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
  	           String newdate = sdf.format(new Date());   
  	           // 填充第五列出产日期   
  	           label = new Label(4,1,newdate);   
  	           sheet.addCell(label);   
  	           // 填充第六列产地   
  	           label = new Label(5,1,"陕西西安");   
  	           sheet.addCell(label);  
  	           
  	           // 填充第七列产地  
  	           /* 
  	            * 显示布尔值 
  	            * */ 
  	           jxl.write.Boolean bool = new jxl.write.Boolean(6,1,true);   
  	           sheet.addCell(bool);   
  	            /**
  	            ****************************************************************
  	            * 合并单元格 
  	            * 通过writablesheet.mergeCells(int x,int y,int m,int n);来实现的 
  	            * 表示将从第x+1列，y+1行到m+1列，n+1行合并 
  	            ****************************************************************
  	            **/ 
  	           sheet.mergeCells(0,3,2,3);   
  	           
  	           WritableCellFormat wc = new WritableCellFormat();   
  	           // 设置居中   
  	           wc.setAlignment(Alignment.CENTRE);   
  	           // 设置边框线   
  	           wc.setBorder(Border.ALL, BorderLineStyle.THIN);   
  	           // 设置单元格的背景颜色   
  	           wc.setBackground(jxl.format.Colour.RED);  
  	           label = new Label(0,3,"合并了三个单元格",wc);   
  	           sheet.addCell(label);   
  	            /**
  	            **************************************************************** 
  	            * 定义公共字体格式 
  	            * 通过获取一个字体的样式来作为模板 
  	            * 首先通过web.getSheet(0)获得第一个sheet 
  	            * 然后取得第一个sheet的第二列，第一行也就是"产品名称"的字体   
  	            ****************************************************************
  	            **/ 
//  	           CellFormat cf = wwb.getSheet(0).getCell(1, 0).getCellFormat();   
//  	           WritableCellFormat wc = new WritableCellFormat();   
  	           // 设置居中   
  	           wc.setAlignment(Alignment.CENTRE);   
  	           // 设置边框线   
  	           wc.setBorder(Border.ALL, BorderLineStyle.THIN);   
  	           // 设置单元格的背景颜色   
  	           wc.setBackground(jxl.format.Colour.RED);   
  	           label = new Label(1,5,"字体",wc);   
  	           sheet.addCell(label);   
  	            // 设置字体   
  	           jxl.write.WritableFont wfont = new jxl.write.WritableFont(WritableFont.createFont("隶书"),20);   
  	           WritableCellFormat font = new WritableCellFormat(wfont);
  	           //第二列第六行的格子
  	           label = new Label(2,6,"隶书",font);   
  	           sheet.addCell(label);   
  	           // 写入数据   
  	           wwb.write();   
  	            // 关闭文件   
  	           wwb.close();   
  	           long end = System.currentTimeMillis();   
  	           System.out.println("----完成该操作共用的时间是:"+(end-start)/1000);   
  	        } catch (Exception e) {   
  	           System.out.println("---出现异常---");   
  	           e.printStackTrace();   
  	       }   
  	}
  	
  	/**
  	  * 设置头的样式
  	  * @return
  	  */
  	 public static WritableCellFormat getHeader(){
  	  WritableFont font = new  WritableFont(WritableFont.TIMES, 10 ,WritableFont.BOLD);//定义字体
  	  try {
  	   font.setColour(Colour.BLUE);//蓝色字体
  	  } catch (WriteException e1) {
  	   // TODO 自动生成 catch 块
  	   e1.printStackTrace();
  	  }
  	  WritableCellFormat format = new  WritableCellFormat(font);
  	  try {
  	   format.setAlignment(jxl.format.Alignment.CENTRE);//左右居中
  	   format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//上下居中
  	   format.setBorder(Border.ALL,BorderLineStyle.THIN,Colour.BLACK);//黑色边框
  	   format.setBackground(Colour.YELLOW);//黄色背景
  	  } catch (WriteException e) {
  	   // TODO 自动生成 catch 块
  	   e.printStackTrace();
  	  }
  	  return format;
  	 }
  	 
  	 
}  