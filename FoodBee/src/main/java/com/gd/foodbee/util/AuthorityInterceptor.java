package com.gd.foodbee.util;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.AuthorityService;
import com.gd.foodbee.service.RankService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class AuthorityInterceptor implements HandlerInterceptor {
	
	@Autowired
	private AuthorityService authorityService; 
	
	@Autowired
	private RankService rankService;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        
        log.debug(TeamColor.RED + "RankName =>" + emp.getRankName());
        log.debug(TeamColor.RED + "DptNo =>" + emp.getDptNo());
        
        String requestURI = request.getRequestURI();
        
        
        // 여기서 세션에 저장된 rankName, dptNo를 통해서 각각에 저장된 accessPage를 List<String>으로 받아오기. 그리고 요청 주소가 포함되어있으면 통과 아니면 실패 
        List<String> rankAccessPage = authorityService.getAccessPageListByRankName(emp.getRankName());
        List<String> dptNoAccessPage = authorityService.getAccessPageListByDptNo(emp.getDptNo());
        
        // 직급 권한 코드
        String rankAuthorityCode = rankService.getAuthorityCodeByRankName(emp.getRankName());
        
        log.debug(TeamColor.RED + "requestURI =>" +  requestURI);
        log.debug(TeamColor.RED + "rankAccessPage =>" +  rankAccessPage.toString());
        log.debug(TeamColor.RED + "dptNoAccessPage =>" + dptNoAccessPage.toString());
        log.debug(TeamColor.RED + "rankAuthorityCode =>" + rankAuthorityCode);
        if(!rankAuthorityCode.equals("R-1")) {
        	if(rankAuthorityCode.equals("R-3")) {
        		rankAccessPage.addAll(authorityService.getAccessPageListByAuthorityCode("R-2"));
        		log.debug(TeamColor.RED + "add rankAccessPage =>" + rankAccessPage.toString());
        	}
        	for (String page : rankAccessPage) {
        		if (requestURI.contains(page)) {
        			log.debug(page);
        	        return true;
        	    }
        	}
        }
        
        for (String page : dptNoAccessPage) {
    		if (requestURI.contains(page)) {
    			log.debug(page);
    	        return true;
    	    }
    	}
        
        // ajax요청인지 체크, ajax요청이면 403에러 메세지를 리턴, ajax요청이 아니면 에러 화면으로 리다이렉트
        if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))){
        	response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else {
            response.sendRedirect(request.getContextPath() + "/noAuthorityErrorPage");
        }
        return false;
    }
}
