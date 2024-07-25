package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.service.ProfileService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProfileController {

	@Autowired
	private ProfileService profileService;
	
	// 프로필 사진 수정
	// 파라미터 : int empNo, MultipartFile file, HttpServletRequest request
	// 반환 값 : String
	// 사용 페이지 : /myPage 
	@PostMapping("/myPage/modifyProfileImg")
	@ResponseBody
	public String modifyProfileImg(@RequestParam int empNo,
				@RequestParam MultipartFile file,
				HttpServletRequest request) {
		
		return profileService.modifyProfileImg(empNo, file, request);
	}
}
