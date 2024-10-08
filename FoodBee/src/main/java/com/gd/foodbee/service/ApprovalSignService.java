package com.gd.foodbee.service;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

public interface ApprovalSignService {

	// 전자서명 수정
	void saveApprovalSign(int empNo, String url, HttpServletRequest request);
	
	// 전자서명 유무 체크
	String getApprovalSign(int empNo);
}
