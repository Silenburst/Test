package com.newenv.lpzd.jdo;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.newenv.lpzd.security.service.UserLoginService;

public class JDOServletContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		
	}

	/**
	 * 在应用初始化后调用某个service方法以初始化数据库连接池。
	 */
	@Override
	public void contextInitialized(ServletContextEvent event) {   
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
		UserLoginService userLoginService = (UserLoginService)ctx.getBean("userLoginService");
		userLoginService.findAllTitleNamesByUsername("admin");
	}

}
