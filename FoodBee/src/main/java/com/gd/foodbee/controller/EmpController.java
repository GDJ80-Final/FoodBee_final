package com.gd.foodbee.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
	private EmpService empService;
	
	@Autowired
	private SendEmail sendEmail;
	
	//회원가입 페이지
	//파라미터 : int empNo
	//반환 값 : String(view)
	//사용 페이지 : /signup
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
	//반환 값 : String(view)
	//사용 페이지: /signup
	@PostMapping("/signup")
	public String signup(@Valid SignupDTO signupDTO,
				Errors errors,
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

		empService.updateEmpSignup(signupDTO);
		//가입 성공시 로그인화면으로 이동 
		return "redirect:/login";
	}
	
	//사원 등록 및 초대 페이지
	//파라미터 : X
	//반환 값 : String(view)
	//사용 페이지 : /emp/addEmp
	@GetMapping("/emp/addEmp")
	   public String addEmp() {
	      
	      return "/emp/addEmp";
	   }
	
	//사원 번호 생성
	//파라미터 : X
	//반환 값 : int
	//사용 페이지 : /emp/addEmp
	@GetMapping("/emp/createEmpNo")
	@ResponseBody
	public int createEmpNo() {
			int empNo = empService.createEmpNo();
	   
			return empNo;
		}
		
	//사원 등록 및 초대
	//파라미터 : EmpDTO empDTO,  Errors errors,HttpServletRequest request,Model model
	//반환 값 : String(View)
	//사용 페이지 : /emp/addEmp
	@PostMapping("/emp/addEmp")
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
			
			return "emp/addEmp";
		}
	 
		
		
		String url = "http://localhost/foodbee/signup?empNo=" + empDTO.getEmpNo();
		EmailDTO emailDTO = EmailDTO.builder()
				 .to(empDTO.getEmpEmail())
			     .subject("[FoodBee] 인트라넷 등록 링크")
			     .message("<!DOCTYPE html>\n"
			    		 + "<html lang=\"ko\">\n"
			    		 + "<head>\n"
			    		 + " <meta charset=\"UTF-8\">\n"
			    		 + " <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
			    		 + " <title>인트라넷 등록 안내</title>\n"
			    		 + "</head>\n"
			    		 + "<body style=\"font-family: 'Arial', sans-serif; line-height: 1.6; color: #333;\">\n"
			    		 + " <div style=\"max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;\">\n"
			    		 + " <div style=\"background-color: #f4f4f4; padding: 10px; text-align: center;\">\n"
			    		 + " <h1>인트라넷 등록안내</h1>\n"
			    		 + " </div>\n"
			    		 + " <div style=\"padding: 20px 0;\">\n"
			    		 + " <p>안녕하세요,</p>\n"
			    		 + " <p>FoodBee 인트라넷 등록 링크입니다.</p>\n"
			    		 + " <a href=\"" + url + "\" style=\"display: inline-block; padding: 10px 20px; background-color: #007bff; color: #ffffff; text-decoration: none; border-radius: 5px; margin-top: 20px;\">인트라넷 등록</a>\n"
			    		 + " <p>본 이메일을 요청하지 않으셨다면, 이 메시지를 무시하셔도 됩니다.</p>\n"
			    		 + " <p>문의사항이 있으시면 언제든 연락 주시기 바랍니다.</p>\n"
			    		 + " <p>감사합니다.</p>\n"
			    		 + " </div>\n"
			    		 + " </div>\n"
			    		 + "</body>\n"
			    		 + "</html>")
			     .build();
	
		empService.addEmp(empDTO, emailDTO);
			
	 
		    
	    // 사원 목록으로 이동
	 	return "redirect:/emp/empList";
	 }
	 
	// 인증번호 메일 발송
	// 파라미터 : int empNo, String empEmail
	// 반환 값 : String
	// 사용 페이지 : /findPw
	@PostMapping("/sendEmail")
	@ResponseBody
	public String sendAuthEmail(@RequestParam int empNo, 
				@RequestParam String empEmail,
				HttpServletRequest request) throws Exception {
		
		log.debug(TeamColor.RED + empNo);
		log.debug(TeamColor.RED + empEmail);
		
		int authNum = empService.createAuth(empNo, empEmail);
		
		log.debug(TeamColor.RED + authNum);
		if(authNum != 0) {
			
			
			EmailDTO emailDTO = EmailDTO.builder()
	                .to(empEmail)
	                .subject("[FoodBee] 인증번호")
	                .message("<!DOCTYPE html>\n"
	                		+ "<html lang=\"ko\">\n"
	                		+ "<head>\n"
	                		+ " <meta charset=\"UTF-8\">\n"
	                		+ " <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
	                		+ " <title>인증번호 안내</title>\n"
	                		+ "</head>\n"
	                		+ "<body style=\"font-family: 'Arial', sans-serif; line-height: 1.6; color: #333;\">\n"
	                		+ " <div style=\"max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;\">\n"
	                		+ " <div style=\"background-color: #f4f4f4; padding: 10px; text-align: center;\">\n"
	                		+ " <h1>인증번호 안내</h1>\n"
	                		+ " </div>\n"
	                		+ " <div style=\"padding: 20px 0;\">\n"
	                		+ " <p>안녕하세요,</p>\n"
	                		+ " <p>FoodBee 비밀번호 찾기 인증번호입니다</p>\n"
	                		+ " <div style=\"font-size: 24px; font-weight: bold; color: #007bff; text-align: center; padding: 10px; border: 2px dashed #007bff; margin: 20px 0;\">\n"
	                		+ authNum
	                		+ " </div>\n"
	                		+ " <p>이 인증번호는 10분 동안 유효합니다. 인증 페이지에서 위의 번호를 입력해 주세요.</p>\n"
	                		+ " <p>본 이메일을 요청하지 않으셨다면, 이 메시지를 무시하셔도 됩니다.</p>\n"
	                		+ " <p>감사합니다.</p>\n"
	                		+ " </div>\n"
	                		+ " </div>\n"
	                		+ "</body>\n"
	                		+ "</html>")
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
	//파라미터 : Model model, HttpSession session
	//반환 값 : String(view)
	//사용 페이지 : /emp/empList
	@GetMapping("/emp/empList")
	public String getEmpList(Model model,
				HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		
		model.addAttribute("emp", emp);
		return "emp/empList";
	}
	
	//사원 목록 조회
	//파라미터 : EmpSearchDTO empSearchDTO
	//반환 값 : List<EmpSearchDTO>
	//사용 페이지 : /emp/empList
	@GetMapping("/emp/searchEmp")
	@ResponseBody
	public Map<String, Object> searhEmpList(EmpSearchDTO empSearchDTO,
				@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
				HttpSession session) {
		log.debug(TeamColor.RED + "officeName =>" + empSearchDTO.getOfficeName());
		log.debug(TeamColor.RED + "deptName =>" + empSearchDTO.getDeptName());
		log.debug(TeamColor.RED + "teamName =>" + empSearchDTO.getTeamName());
		log.debug(TeamColor.RED + "rankName =>" + empSearchDTO.getRankName());
		log.debug(TeamColor.RED + "signupYN =>" + empSearchDTO.getSignupYN());
		log.debug(TeamColor.RED + "empNo =>" + empSearchDTO.getEmpNo());
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		int lastPage = empService.getLastPage(empSearchDTO, empNo);

		log.debug(TeamColor.RED + "lastPage =>" + lastPage);
		
		Map<String, Object> map = new HashMap<>();
		map.put("empList", empService.getEmpList(empSearchDTO, currentPage,empNo));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage); 
		return map;
	}
	
	// 비밀번호 초기화
	// 파라미터 : int empNo, String empEmail
	// 반환 값 : String
	// 사용 페이지 : /emp/empList
	@PostMapping("/emp/resetPw")
	@ResponseBody
	public String resetEmpPw(@RequestParam(name = "empNo") int empNo,
			@RequestParam String empEmail) {
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
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
	
	//이메일 재발송
	// 파라미터 : int empNo
	// 반환 값 : String
	// 사용 페이지 : /emp/empList
	@PostMapping("/emp/resendEmail")
	@ResponseBody
	public String resendEmail(@RequestParam(name = "empNo") int empNo) {
		
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		String empEmail = empService.getEmpEmailByEmpNo(empNo);
		
		String url = "http://localhost/foodbee/signup?empNo=" + empNo;
		EmailDTO emailDTO = EmailDTO.builder()
				 .to(empEmail)
			     .subject("[FoodBee] 인트라넷 등록 링크")
			     .message("<!DOCTYPE html>\n"
			    		 + "<html lang=\"ko\">\n"
			    		 + "<head>\n"
			    		 + " <meta charset=\"UTF-8\">\n"
			    		 + " <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
			    		 + " <title>인트라넷 등록 안내</title>\n"
			    		 + "</head>\n"
			    		 + "<body style=\"font-family: 'Arial', sans-serif; line-height: 1.6; color: #333;\">\n"
			    		 + " <div style=\"max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;\">\n"
			    		 + " <div style=\"background-color: #f4f4f4; padding: 10px; text-align: center;\">\n"
			    		 + " <h1>인트라넷 등록안내</h1>\n"
			    		 + " </div>\n"
			    		 + " <div style=\"padding: 20px 0;\">\n"
			    		 + " <p>안녕하세요,</p>\n"
			    		 + " <p>FoodBee 인트라넷 등록 링크입니다.</p>\n"
			    		 + " <a href=\"" + url + "\" style=\"display: inline-block; padding: 10px 20px; background-color: #007bff; color: #ffffff; text-decoration: none; border-radius: 5px; margin-top: 20px;\">인트라넷 등록</a>\n"
			    		 + " <p>본 이메일을 요청하지 않으셨다면, 이 메시지를 무시하셔도 됩니다.</p>\n"
			    		 + " <p>문의사항이 있으시면 언제든 연락 주시기 바랍니다.</p>\n"
			    		 + " <p>감사합니다.</p>\n"
			    		 + " </div>\n"
			    		 + " </div>\n"
			    		 + "</body>\n"
			    		 + "</html>")
			     .build();
	
		sendEmail.sendEmail(emailDTO);
		
		return empEmail;
	}
	
	// 사원 상세보기 페이지
	// 파라미터 : int empNo, Model model, HttpSession session
	// 반환 값 : String(view)
	// 사용 페이지 : /emp/empDetail
	@GetMapping("/emp/empDetail")
	public String empDetail(@RequestParam int empNo,
				Model model,
				HttpSession session) {
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		EmpDTO emp = (EmpDTO)session.getAttribute("emp");
		
		model.addAttribute("emp", emp);
		model.addAttribute("empNo", empNo);
		return "emp/empDetail";
	}
	
	// 사원 상세보기(개인 + 인사)
	// 파라미터 : int empNo
	// 반환 값 : String(view)
	// 사용 페이지 : /emp/empDetail
	@GetMapping("/emp/getEmpPersnal")
	@ResponseBody
	public Map<String, Object> getEmpPersnal(@RequestParam int empNo){
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		return empService.getEmpPersnal(empNo);
	}
	
	// 사원 상세보기(인사)
	// 파라미터 : int empNo
	// 반환 값 : Map<String, Object>
	// 사용 페이지 : /emp/empDetail	
	@GetMapping("/emp/getEmpHr")
	@ResponseBody
	public Map<String, Object> getEmpHr(@RequestParam int empNo){
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		return empService.getEmpHr(empNo);
	}
	// 사원 수정 페이지
	// 파라미터 : int empNo, Model model
	// 반환 값 : String(view)
	// 사용 페이지 : /emp/modifyEmpHr		
	@GetMapping("/emp/modifyEmpHr")
	public String modifyEmpHrPage(@RequestParam int empNo,
				Model model) {
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		
		Map<String, Object> empHr = empService.getEmpHr(empNo);
		
		model.addAttribute("empHr", empHr);
		return "emp/modifyEmpHr";
	}
	
	// 사원 수정
	// 파라미터 : EmpDTO empDTO
	// 반환 값 : String(view)
	// 사용 페이지 : /emp/modifyEmpHr		
	@PostMapping("/emp/modifyEmpHr")
	public String modifyEmpHr(EmpDTO empDTO) {
		
		empService.modifyEmpHr(empDTO);
		
		return "redirect:/emp/empDetail?empNo=" + empDTO.getEmpNo();
	}
	
	// 마이페이지
	// 파라미터 : HttpSession session, Model model
	// 반환 값 : String(view)
	// 사용 페이지 : /myPage	
	@GetMapping("/myPage")
	public String myPage(HttpSession session,
				Model model) {
		
		EmpDTO emp = (EmpDTO)session.getAttribute("emp");
		model.addAttribute("emp", emp);
		return "myPage";
	}
	
	// 마이페이지에서 비밀번호 수정
	// 파라미터 : int empNo, String oldPw, String newPw
	// 반환 값 : String
	// 사용 페이지 : /myPage		
	@PostMapping("/myPage/modifyEmpPw")
	@ResponseBody
	public String modifyEmpPwMyPage(@RequestParam int empNo,
				@RequestParam String oldPw,
				@RequestParam String newPw) {
		
		empService.modifyEmpPwMyPage(empNo, oldPw, newPw);
		
		return "success";
	}
	
	// 마이페이지에서 개인정보 수정
	// 파라미터 : int empNo, String empEmail, String contact, String postNo, String address, String addressDetail
	// 반환 값 : String
	// 사용 페이지 : /myPage		
	@PostMapping("/myPage/modifyEmpPersnal")
	@ResponseBody
	public String modifyEmpPersnalMyPage(@RequestParam int empNo,
				@RequestParam String empEmail,
				@RequestParam String contact, 
				@RequestParam String postNo,
				@RequestParam String address,
				@RequestParam String addressDetail) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("empEmail", empEmail);
		map.put("contact", contact);
		map.put("postNo", postNo);
		map.put("address", address);
		map.put("addressDetail", addressDetail);
		
		empService.modifyEmpPersnalMyPage(map);
		
		return "success";
	}
}
