package com.gd.foodbee.util;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gd.foodbee.dto.EmpDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor{

	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        
        if (emp == null) {
            response.sendRedirect(request.getContextPath() +"/login");
            return false;
        }
        
        return true;
    }

}
