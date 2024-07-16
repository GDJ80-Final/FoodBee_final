package com.gd.foodbee.service;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.SignupDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface EmpService {
	
	//사원 인트라넷 등록 (가입) 
	public void updateEmpSignup(SignupDTO signupDTO,HttpServletRequest request);
	
	//사원번호 중복 체크 
	public int selectEmpNoDuplicate(int empNo);
	
	// 사원 번호 생성
	int createEmpNo();
	
	// 사원 등록 및 회원가입 링크 메일 발송
	void addEmp(EmpDTO empDTO, EmailDTO emailDTO);
}
