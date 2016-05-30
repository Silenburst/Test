package com.newenv.lpzd.security.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.util.AppConstants;

public class SessionFilter implements Filter {

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;  
		UserLogin userLogin = (UserLogin)request.getSession().getAttribute(AppConstants.CURRENT_USER);  
	    if (userLogin != null) {  
	    	//重新设值session
	    	SecurityUserHolder.setCurrentUserLogin(userLogin);;  
	    }    
	    chain.doFilter(req, resp);    
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
