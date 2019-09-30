package com.simple.project2;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class AOP {
	
	@Autowired
	private mainService service;

	@Pointcut("execution(public * com.simple.project2.*Controller.*(..))")
	public void getIP() {
	}
	
	@Before("getIP()")
	public void getIP(JoinPoint joinPoint) {
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
		HttpSession session = request.getSession();
		String ip = (String) session.getAttribute("userIP");
		if (ip == null || ip == "") {
			Logger getIPLogger= LoggerFactory.getLogger("getIPLogger");

			/*
			String ip = request.getHeader("X-Forwarded-For");
			getIPLogger.debug(">>>> X-FORWARDED-FOR : " + ip);
	 
	        if (ip == null) {
	            ip = request.getHeader("Proxy-Client-IP");
	            getIPLogger.debug(">>>> Proxy-Client-IP : " + ip);
	        }
	        if (ip == null) {
	            ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
	            getIPLogger.debug(">>>> WL-Proxy-Client-IP : " + ip);
	        }
	        if (ip == null) {
	            ip = request.getHeader("HTTP_CLIENT_IP");
	            getIPLogger.debug(">>>> HTTP_CLIENT_IP : " + ip);
	        }
	        if (ip == null) {
	            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	            getIPLogger.debug(">>>> HTTP_X_FORWARDED_FOR : " + ip);
	        }
	        if (ip == null) {
	            ip = request.getRemoteAddr();
	        }
	        getIPLogger.debug(">>>> Result : IP Address : "+ip);
			*/
			
			try {
				InetAddress local = InetAddress.getLocalHost();
				ip = local.getHostAddress();
				getIPLogger.debug(">>>> Result : IP Address : "+ip);
				session.setAttribute("userIP", ip);

				service.insertUserIP(ip);
				
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
			 
		}

	}
	
}
