package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.EmpSearchDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.dto.SignupDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface EmpService {
	
	// 로그인
	EmpDTO login(LoginDTO loginDTO);
	
	// 비밀번호 찾기 임시 비밀번호로 변경
	void modifyEmpPw(int empNo, String empPw);
	
	//사원 인트라넷 등록 (가입) 
	void updateEmpSignup(SignupDTO signupDTO,HttpServletRequest request);
	
	//사원번호 중복 체크 
	int selectEmpNoDuplicate(int empNo);
	
	// 사원 번호 생성
	int createEmpNo();
	
	// 사원 등록 및 회원가입 링크 메일 발송
	void addEmp(EmpDTO empDTO, EmailDTO emailDTO);
	
	// 인증번호 생성
	int createAuth(int empNo, String empEmail);
	
	// 사원 목록
	List<EmpSearchDTO> getEmpList(EmpSearchDTO empSearchDTO); 
	
	// 사원번호로 이메일 찾기
	String getEmpEmailByEmpNo(int empNo);
}
