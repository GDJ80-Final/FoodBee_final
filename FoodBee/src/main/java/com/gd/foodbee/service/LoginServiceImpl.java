package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.mapper.EmpMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class LoginServiceImpl implements LoginService{
	@Autowired
	private EmpMapper empMapper;
	
	// 로그인
	// 파라미터 : LoginDTO
	// 반환 값 : EmptDTO
	// 사용 클래스 : LoginController.login
	@Override
	public EmpDTO login(LoginDTO loginDTO) {
		
		return empMapper.selectEmpByNoAndPw(loginDTO);
	}

	// 임시 비밀번호로 변경
	// 파라미터 : int empNo, String empPw
	// 반환 값 : void
	// 사용 클래스 : LoginController.getPw
	@Override
	public void modifyEmpPw(int empNo, String empPw) {
		int row = empMapper.updateEmpPw(empNo, empPw);
		if(row == 0) {
			throw new RuntimeException();
		}
	}

	

}
