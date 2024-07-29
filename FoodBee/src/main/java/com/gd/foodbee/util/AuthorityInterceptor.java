package com.gd.foodbee.util;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.AuthorityService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AuthorityInterceptor implements HandlerInterceptor {
	
	@Autowired
	private AuthorityService authorityService; 
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        
        String requestURI = request.getRequestURI();
        
        // 여기서 세션에 저장된 rankName, dptNo를 통해서 각각에 저장된 accessPage를 List<String>으로 받아오기. 그리고 요청 주소가 포함되어있으면 통과 아니면 실패 
        List<String> rankAccessPage = authorityService.getAccessPageListByRankName(emp.getRankName());
        List<String> dptNoAccessPage = authorityService.getAccessPageListByDptNo(emp.getDptNo());
        if(emp.getRankName() != "R-1") {
        	for (String page : rankAccessPage) {
        		if (requestURI.endsWith(page)) {
        	        return true;
        	    }
        	}
        }
        
        for (String page : dptNoAccessPage) {
    		if (requestURI.endsWith(page)) {
    	        return true;
    	    }
    	}
        
        return false;
    }
}
