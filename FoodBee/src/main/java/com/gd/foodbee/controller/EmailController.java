package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.service.EmailService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmailController {
	
	@Autowired
	private EmailService emailService; 
	
		// 인증번호 메일 발송
		// 파라미터 : int empNo, String empEmail
		// 반환 값 : String
		// 사용 페이지 : /findPw
		@PostMapping("/sendEmail")
		@ResponseBody
		public String sendEmail(@RequestParam int empNo, 
					@RequestParam String empEmail,
					HttpServletRequest request) {
			
			log.debug(TeamColor.RED + empNo);
			log.debug(TeamColor.RED + empEmail);
			
			EmailDTO emailDTO = EmailDTO.builder()
	                .to(empEmail)
	                .subject("[FoodBee] 인증번호")
	                .build();

			int authNum = emailService.sendEmail(empNo, emailDTO);
			
			log.debug(TeamColor.RED + authNum);
			if(authNum != 0) {
				HttpSession session = request.getSession();
			    session.setAttribute("authNum", authNum);
			    session.setMaxInactiveInterval(600);
			    
			    return "success";
			}
			
			
			return "fail";
		}
}
