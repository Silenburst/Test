import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;

public class Test
{
	public static void main(String[] args)
	{
		String test="it's a test.";
		
		Pattern pattern = Pattern.compile("t");
		Matcher matcher = pattern.matcher(test);
		while(matcher.find())
		{
			
			System.out.println(matcher.group());
		}
		
        String sql="http:\\\\image.58.com\\showphone.aspx?t=v55&v=CEBC5063E8128F3A4A458BEBDAD3E2A28";  
        System.out.println("防SQL注入:"+StringEscapeUtils.escapeSql(sql)); //防SQL注入  
          
        System.out.println("转义HTML,注意汉字:"+StringEscapeUtils.escapeHtml(sql));    //转义HTML,注意汉字  
        System.out.println("反转义HTML:"+StringEscapeUtils.unescapeHtml(sql));  //反转义HTML  
          
        System.out.println("转成Unicode编码："+StringEscapeUtils.escapeJava(sql));     //转义成Unicode编码  
          
        System.out.println("转义XML："+StringEscapeUtils.escapeXml(sql));   //转义xml  
        System.out.println("反转义XML："+StringEscapeUtils.unescapeXml(sql));    //转义xml  
	}

}
