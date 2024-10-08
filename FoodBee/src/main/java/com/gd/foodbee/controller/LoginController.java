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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.service.EmpService;
import com.gd.foodbee.util.SendEmail;
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
	private EmpService empService;
	
	@Autowired
	private SendEmail sendEmail;

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
	// 파라미터 : LoginDTO, Model model, HttpServletResponse, HttpSession
	// 반환 값 : String(View)
	// 사용 페이지 : /login
	@PostMapping("/login")
	public String login(LoginDTO loginDto,
				RedirectAttributes redirectAttributes,
				HttpServletResponse response,
				HttpSession session) {
		
		log.debug(TeamColor.RED + "empNo =>" + loginDto.getEmpNo());
		log.debug(TeamColor.RED + "empPw =>" + loginDto.getEmpPw());
		log.debug(TeamColor.RED + "saveId =>" + loginDto.getSaveId());
		
		EmpDTO empDto =  empService.login(loginDto);
		
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
			redirectAttributes.addFlashAttribute("msg", "사원번호 또는 비밀번호가 잘못되었습니다.");
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
	
	// 비밀번호 찾기
	// 파라미터 : int authNum, int empNo, String empEmail, HttpServletRequest request
	// 반환 값 : String
	// 사용 페이지 : /findPw
	@PostMapping("/getPw")
	@ResponseBody
	public String getPw(@RequestParam int authNum,
			@RequestParam int empNo,
			@RequestParam String empEmail,
			HttpServletRequest request) {
		
		log.debug(TeamColor.RED + "authNum =>" + authNum);
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		log.debug(TeamColor.RED + "empEmail =>" + empEmail);
		
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
	        
	        
	        empService.modifyEmpPw(empNo, tmpPw);
	        
	        EmailDTO emailDTO = EmailDTO.builder()
					 .to(empEmail)
				     .subject("[FoodBee] 임시 비밀번호")
				     .message("<!DOCTYPE html>\n"
		                		+ "<html lang=\"ko\">\n"
		                		+ "<head>\n"
		                		+ " <meta charset=\"UTF-8\">\n"
		                		+ " <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
		                		+ " <title>임시 비밀번호 안내</title>\n"
		                		+ "</head>\n"
		                		+ "<body style=\"font-family: 'Arial', sans-serif; line-height: 1.6; color: #333;\">\n"
		                		+ " <div style=\"max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;\">\n"
		                		+ " <div style=\"background-color: #f4f4f4; padding: 10px; text-align: center;\">\n"
		                		+ " <h1>임시 비밀번호 안내</h1>\n"
		                		+ " </div>\n"
		                		+ " <div style=\"padding: 20px 0;\">\n"
		                		+ " <p>안녕하세요,</p>\n"
		                		+ " <p>FoodBee 계정의 임시 비밀번호 입니다.</p>\n"
		                		+ " <div style=\"font-size: 24px; font-weight: bold; color: #007bff; text-align: center; padding: 10px; border: 2px dashed #007bff; margin: 20px 0;\">\n"
		                		+ tmpPw
		                		+ " </div>\n"
		                		+ " <p>본 이메일을 요청하지 않으셨다면, 이 메시지를 무시하셔도 됩니다.</p>\n"
		                		+ " <p>감사합니다.</p>\n"
		                		+ " </div>\n"
		                		+ " </div>\n"
		                		+ "</body>\n"
		                		+ "</html>")
				     .build();
		
			sendEmail.sendEmail(emailDTO);
	        
	        return "success";
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
