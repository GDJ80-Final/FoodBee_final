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
	
	@PostMapping("/modifyProfileImg")
	@ResponseBody
	public String modifyProfileImg(@RequestParam int empNo,
				@RequestParam MultipartFile file,
				HttpServletRequest request) {
		
		profileService.modifyProfileImg(empNo, file, request);
		
		// 이미지 주소 값(미완성)
		return "success";
	}
}
