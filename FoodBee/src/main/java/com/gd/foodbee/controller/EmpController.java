package com.gd.foodbee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.EmpSearchDTO;
import com.gd.foodbee.dto.SignupDTO;
import com.gd.foodbee.service.EmpService;
import com.gd.foodbee.util.SendEmail;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class EmpController {
	
	@Autowired
	EmpService empService;
	
	@Autowired
	private SendEmail sendEmail;
	
	//회원가입 페이지
	//파라미터 : int empNo
	//반환값 : String(view)
	//사용페이지 : /signup
	@GetMapping("/signup")
	public String signup(@RequestParam(name="empNo")int empNo, 
				Model model) {
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		int result = empService.selectEmpNoDuplicate(empNo);
		model.addAttribute("empNo",empNo);
		model.addAttribute("result",result);
		
		
		return "signup";
	}
	
	
	//회원가입값입력
	//파라미터 : signupDTO,Errors errors,HttpServletRequest request,Model model
	//반환값 : String(view)
	//사용페이지: /signup
	@PostMapping("/signup")
	public String signup(@Valid SignupDTO signupDTO,
				Errors errors,
				HttpServletRequest request,
				Model model) {
		
		log.debug(TeamColor.YELLOW +"signupDTO =>" +signupDTO.toString());
		
		if(errors.hasErrors()) {
			//백에서 validation 유효성 검사 후 에러 발견시 true 반환
			log.debug(TeamColor.YELLOW + "hasErrors => "+ errors.hasErrors());
			//에러 난 갯수 확인 
			log.debug(TeamColor.YELLOW + "Errors => "+ errors);
			for(FieldError e : errors.getFieldErrors()) {
				//오류난 필드 디버깅 
				log.debug(TeamColor.YELLOW + "error fieldName =>" + e.getField());
				// 에러메세지 
				log.debug(TeamColor.YELLOW + "error message => " + e.getDefaultMessage());
				// "이름+errorMsg"형태로 모델에 추가
				model.addAttribute(e.getField()+"ErrorMsg", e.getDefaultMessage());
			}
			return "signup"; 
			// 입력 에러 발생시 회원가입폼으로 다시  포워딩(+ 입력된 커맨드객체 내용 + 추가된 필드 에러 메세지
			// 매개값으로 넘겨지는 커맨드객체의 경우에는 별도로 모델에 추가하지 않아도 View에서 사용가능 
		}

		empService.updateEmpSignup(signupDTO,request);
		//가입 성공시 로그인화면으로 이동 
		return "redirect:/login";
	}
	
	//사원 등록 및 초대 페이지
	//파라미터 : X
	//반환값 : String(view)
	//사용페이지 : /addEmp
	@GetMapping("/addEmp")
	   public String addEmp() {
	      
	      return "addEmp";
	   }
	
	//사원 번호 생성
	//파라미터 : X
	//반환값 : int
	//사용페이지 : /addEmp
	@GetMapping("/createEmpNo")
	@ResponseBody
	public int createEmpNo() {
			int empNo = empService.createEmpNo();
	   
			return empNo;
		}
		
	//사원 등록 및 초대
	//파라미터 : EmpDTO empDTO,  Errors errors,HttpServletRequest request,Model model
	//반환값 : String(View)
	//사용페이지 : /addEmp
	@PostMapping("/addEmp")
	public String addEmp(@Valid EmpDTO empDTO,
			Errors errors,
			HttpServletRequest request,
			Model model) {
	 
		log.debug(TeamColor.RED + "empDTO => " +  empDTO.toString());
		 
			
		if(errors.hasErrors()) {
			//백에서 validation 유효성 검사 후 에러 발견시 true 반환
			log.debug(TeamColor.RED + "hasErrors => "+ errors.hasErrors());
			//에러 난 갯수 확인 
			log.debug(TeamColor.RED + "Errors => "+ errors);
			for(FieldError e : errors.getFieldErrors()) {
				//오류난 필드 디버깅 
				log.debug(TeamColor.RED + "error fieldName =>" + e.getField());
				// 에러메세지 
				log.debug(TeamColor.RED + "error message => " + e.getDefaultMessage());
				// "이름+errorMsg"형태로 모델에 추가
				model.addAttribute(e.getField()+"ErrorMsg", e.getDefaultMessage());
			}
			
			return "addEmp";
		}
	 
		String url = "http://localhost/foodbee/signup?empNo=" + empDTO.getEmpNo();
		EmailDTO emailDTO = EmailDTO.builder()
				 .to(empDTO.getEmpEmail())
			     .subject("[FoodBee] 회원가입 링크")
			     .message("회원가입 링크 : <a href=\"" + url + "\">" + url + "</a> 입니다.")
			     .build();
	
		empService.addEmp(empDTO, emailDTO);
			
	 
		    
		    // 사원 목록으로 이동
	 	return "redirect:/empList";
	 }
	 
	// 인증번호 메일 발송
	// 파라미터 : int empNo, String empEmail
	// 반환 값 : String
	// 사용 페이지 : /findPw
	@PostMapping("/sendEmail")
	@ResponseBody
	public String sendAuthEmail(@RequestParam int empNo, 
				@RequestParam String empEmail,
				HttpServletRequest request) {
		
		log.debug(TeamColor.RED + empNo);
		log.debug(TeamColor.RED + empEmail);
		
		int authNum = empService.createAuth(empNo, empEmail);
		
		log.debug(TeamColor.RED + authNum);
		if(authNum != 0) {
			EmailDTO emailDTO = EmailDTO.builder()
	                .to(empEmail)
	                .subject("[FoodBee] 인증번호")
	                .message("인증번호는 " + authNum + " 입니다. ")
	                .build();

			
			sendEmail.sendEmail(emailDTO);
			
			HttpSession session = request.getSession();
		    session.setAttribute("authNum", authNum);
		    session.setMaxInactiveInterval(600);
		    
		    return "success";
		}
		
		
		return "fail";
	}
	
	//사원 목록 페이지
	//파라미터 : X
	//반환값 : String(view)
	//사용페이지 : /empList
	@GetMapping("/empList")
	public String getEmpList() {
		
		return "empList";
	}
	
	//사원 목록 조회
	//파라미터 : EmpSearchDTO empSearchDTO
	//반환값 : List<EmpSearchDTO>
	//사용페이지 : /empList
	@GetMapping("/searchEmp")
	@ResponseBody
	public List<EmpSearchDTO> searhEmpList(EmpSearchDTO empSearchDTO) {
		log.debug(TeamColor.RED + "officeName =>" + empSearchDTO.getOfficeName());
		log.debug(TeamColor.RED + "deptName =>" + empSearchDTO.getDeptName());
		log.debug(TeamColor.RED + "teamName =>" + empSearchDTO.getTeamName());
		log.debug(TeamColor.RED + "rankName =>" + empSearchDTO.getRankName());
		log.debug(TeamColor.RED + "signupYN =>" + empSearchDTO.getSignupYN());
		log.debug(TeamColor.RED + "empNo =>" + empSearchDTO.getEmpNo());
		
		return empService.getEmpList(empSearchDTO);
	}
	
	//
}
