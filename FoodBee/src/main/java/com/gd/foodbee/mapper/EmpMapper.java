package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.EmpSearchDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.dto.SignupDTO;

@Mapper
public interface EmpMapper {
	
	// 로그인
	// 파라미터 : LoginDTO
	// 반환 값 : EmptDTO
	// 사용 클래스 : LoginServiceimpl.login
	EmpDTO selectEmpByNoAndPw(LoginDTO loginDTO);
	
	// 이메일 발송
	// 파라미터 : int empNo, String empEmail
	// 반환 값 : EmptDTO
	// 사용 클래스 : EmailServiceimpl.sendEmail
	EmpDTO selectEmpByNoAndEmail(int empNo, String empEmail);
	
	// 임시비밀번호로 변경
	// 파라미터 : int empNo, String empPw
	// 반환 값 : int
	// 사용 클래스 : LoginServiceImpl.modifyEmpPw
	int updateEmpPw(int empNo, String empPw);
	
	//회원가입
	//파라미터 : EmpDTO empDTO
	//반환 값 : int
	//사용 클래스 : EmpServiceImpl.updateEmpSignup
	int updateEmpSignup(EmpDTO empDTO);
	
	//사번 중복 체크
	//파라미터 : int empNo
	//반환값: String
	//사용클래스 : EmpServiceImpl.selectEmpNoDuplicate
	String selectEmpNoDuplicate(int empNo);
	
	// 마지막 사원 번호 찾기
    // 파라미터 : X
    // 반환 값 : int
    // 사용 클래스 : EmpServiceImpl.createNo
    int selectEmpNoMax();

    
    // 사원 등록
    int insertEmp(EmpDTO empDTO);
    
    // 사원 목록
    List<EmpSearchDTO> selectEmpList(EmpSearchDTO empSearchDTO);
    
    //사원번호로 이메일 찾기
    String selectEmpEmailByEmpNo(int empNo);
}
