package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

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
	
	// 사원 등록 및 인트라넷 등록 링크 메일 발송
	void addEmp(EmpDTO empDTO, EmailDTO emailDTO);
	
	// 인증번호 생성
	int createAuth(int empNo, String empEmail);
	
	// 사원 목록
	List<EmpSearchDTO> getEmpList(EmpSearchDTO empSearchDTO, int currentPage); 
	
	// 사원번호로 이메일 찾기
	String getEmpEmailByEmpNo(int empNo);
	
	// 사원상세보기(인사 + 개인)
	Map<String, Object> getEmpPersnal(int empNo);
	
	// 사원상세보기(인사)
	Map<String, Object> getEmpHr(int empNo);

	// 사원인사정보 수정
	void modifyEmpHr(EmpDTO empDTO);
	
	// 사원수로 사원 목록 마지막 페이지 구하기
	int getLastPage(EmpSearchDTO empSearchDTO);
	
	// 마이페이지에서 비밀번호 변경
	void modifyEmpPwMyPage(int empNo, String oldPw, String newPw);
	
	// 해당 연도의 총 휴가 구하기
	double getDayOff(int empNo, String targetYear);
}
