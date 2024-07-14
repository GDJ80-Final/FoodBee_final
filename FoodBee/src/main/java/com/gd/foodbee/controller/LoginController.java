package com.gd.foodbee.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.service.LoginService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	
	@Autowired
	private LoginService loginService;

	// 로그인 페이지
	// 파라미터 : HttpServletRequest
	// 반환 값 : String(View)
	// 사용 페이지 : /login
	@GetMapping("/login")
	public String loginPage(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("empNo")){
                    request.setAttribute("empNo", cookie.getValue());
                    break;
                }
            }
        }
		return "login";
	}
	
	// 로그인
	// 파라미터 : LoginDTO, HttpServletResponse, HttpSession
	// 반환 값 : String(View)
	// 사용 페이지 : /login
	@PostMapping("/login")
	public String login(LoginDTO loginDto,
				HttpServletResponse response,
				HttpSession session) {
		
		log.debug(TeamColor.RED + "empNo =>" + loginDto.getEmpNo());
		log.debug(TeamColor.RED + "empPw =>" + loginDto.getEmpPw());
		log.debug(TeamColor.RED + "saveId =>" + loginDto.getSaveId());
		
		EmpDTO empDto =  loginService.login(loginDto);
		
		log.debug(TeamColor.RED + "empDto =>" + empDto);
		
		//로그인 성공과 이이디 저장이 함께 눌렸을때 쿠키에 저장.
		if(empDto != null) {
			
			//사원번호, 사원이름, 직급명, 팀번호
			session.setAttribute("emp", empDto);
			
			if(loginDto.getSaveId() != null) {
				Cookie cookie = new Cookie("empNo", "" + loginDto.getEmpNo());
		        cookie.setMaxAge(7 * 24 * 60 * 60); // 1주
		        cookie.setHttpOnly(true);
		        response.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("empNo", "");
		        cookie.setMaxAge(0);
		        cookie.setHttpOnly(true);
		        response.addCookie(cookie);
			}
		} else {
			
			return "redirect:/login";
		}
	
		return "redirect:/home";
	}
	
	// 로그아웃
	// 파라미터 : HttpSession
	// 반환 값 : String(View)
	// 사용 페이지 : 
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/login";
	}
	
	// 비밀번호 찾기 페이지
	// 파라미터 : X
	// 반환 값 : String(View)
	// 사용 페이지 : /findPw
	@GetMapping("/findPw")
	public String findPw() {
		
		return "findPw";
	}
	
	@PostMapping("/getPw")
	@ResponseBody
	public String getPw(int authNum,
			@RequestParam int empNo,
			HttpServletRequest request) {
		
		log.debug(TeamColor.RED + "authNum =>" + authNum);
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		HttpSession session = request.getSession();
	    int sessionAuthNum = (Integer) session.getAttribute("authNum");
		
	    if(authNum == sessionAuthNum) {
	    	Random random = new Random();
	    	String tmpPw = "";

	        for (int i = 0; i < 8; i++) {
	            int index = random.nextInt(3);  // 0, 1, 2 중 하나의 값을 랜덤하게 선택

	            switch (index) {
	                case 0:
	                	tmpPw += (char) (random.nextInt(26) + 'a');  // 소문자
	                    break;
	                case 1:
	                	tmpPw += (char) (random.nextInt(26) + 'A');  // 대문자
	                    break;
	                case 2:
	                	tmpPw += (char) (random.nextInt(10) + '0');  // 숫자
	                    break;
	            }
	        }
	        log.debug(TeamColor.RED + "tmpPw =>" + tmpPw);
	        
	        
	        loginService.modifyEmpPw(empNo, tmpPw);
	        
	        return tmpPw;
	    }
	    
		return "fail";
	}
	
	
	
	//시험용
	@GetMapping("/home")
	public String home(HttpSession session, Model model) {
		EmpDTO emp = (EmpDTO)session.getAttribute("emp");
		
		 model.addAttribute("emp", emp);
		
	    return "home";  
	}
}
