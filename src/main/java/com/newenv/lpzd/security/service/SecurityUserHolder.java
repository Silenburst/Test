package com.newenv.lpzd.security.service;

import com.newenv.lpzd.security.domain.UserLogin;

public class SecurityUserHolder {

	//声明  
    private static ThreadLocal<UserLogin> local = new ThreadLocal<UserLogin>();  
    
	/**
	 * 赋值
	 * @param session
	 */
    public static void setCurrentUserLogin(UserLogin session) {  
        local.set(session);  
    }  
    /**
     * 取值
     * @return
     */
    public static UserLogin getCurrentUserLogin() {  
        return local.get();  
    } 
    
    /**
     * 移除
     */
    public static void remove(){
    	local.remove();
    }
    
    
}
