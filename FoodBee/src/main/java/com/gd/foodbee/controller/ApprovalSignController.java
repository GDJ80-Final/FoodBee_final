package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.service.ApprovalSignService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalSignController {

	@Autowired
	private ApprovalSignService approvalSignService;
	
	// 전자 서명 수정
	// 파라미터 : int empNo,  String url, HttpServletRequest request
	// 반환 값 : String
	// 사용 클래스 : /myPage
	@PostMapping("/myPage/saveApprovalSign")
	@ResponseBody
	public String saveApprovalSign(@RequestParam int empNo, 
				@RequestParam String url,
				HttpServletRequest request) {
		
		log.debug(TeamColor.RED + "empNo =>" + empNo);
		log.debug(TeamColor.RED + "url =>" + url);
		
		approvalSignService.saveApprovalSign(empNo, url, request);
		
		return url;
	}
	
	@GetMapping("/approval/getSign")
	@ResponseBody
	public void getSign(@RequestParam int approverNo) {
		log.debug(TeamColor.RED + "approverNo" + approverNo);
		
		String result = approvalSignService.getApprovalSign(approverNo);
		
		if(result.equals("fail")) {
			throw new RuntimeException();
		}
		
	}
}
