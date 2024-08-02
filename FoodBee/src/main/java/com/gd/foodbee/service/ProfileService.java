package com.gd.foodbee.service;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

public interface ProfileService {

	// 프로필 사진 수정
	String modifyProfileImg(int empNo, MultipartFile file);

	// 프로필 사진 검색
	String getProfileImg(int empNo);
}
