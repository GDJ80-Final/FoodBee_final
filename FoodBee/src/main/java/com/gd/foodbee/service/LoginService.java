package com.gd.foodbee.service;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.LoginDTO;

public interface LoginService {

	// 로그인
	EmpDTO login(LoginDTO loginDTO);
	
	// 비밀번호 찾기 임시 비밀번호로 변경
	void modifyEmpPw(int empNo, String empPw);
}
