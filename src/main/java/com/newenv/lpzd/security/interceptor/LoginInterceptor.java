package com.newenv.lpzd.security.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.util.CollectionUtils;
import org.springframework.web.util.WebUtils;

import com.newenv.bms.utils.AppConstants;
import com.newenv.lpzd.security.action.LoginAction;
import com.newenv.lpzd.security.domain.HRPermission;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor  extends AbstractInterceptor{
	
	
	public String intercept(ActionInvocation invocation) throws Exception {
		 HttpServletRequest request = ServletActionContext.getRequest();  
	        //HttpSession session = request.getSession(true);  
	        //Object user =  session.getAttribute(AppConstants.CURRENT_USER);  
	        Object user = WebUtils.getSessionAttribute(request, AppConstants.CURRENT_USER);
	        ActionSupport action = (ActionSupport) invocation.getAction();  
	          
	        //BaseAction action = (BaseAction)invocation.getProxy().getAction();
	        
	        if (action instanceof LoginAction){  
	            return invocation.invoke();  
	        }
	        
	        if (user != null ){
	        	Map<String, HRPermission> map= SecurityUserHolder.getCurrentUserLogin().getPermissions();
	        	if(CollectionUtils.isEmpty(map) ){//无权限
	        		return "index";
	        	}else{
	        		return invocation.invoke();  
	        	}
	        }else {  
	            return Action.LOGIN;   
	        }  
	  
	    }  
}
