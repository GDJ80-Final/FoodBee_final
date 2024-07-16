package com.gd.foodbee.service;

import com.gd.foodbee.dto.SignupDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface EmpService {
	
	//사원 인트라넷 등록 (가입) 
	public void updateEmpSignup(SignupDTO signupDTO,HttpServletRequest request);
	
	//사원번호 중복 체크 
	public int selectEmpNoDuplicate(int empNo);
	
}
