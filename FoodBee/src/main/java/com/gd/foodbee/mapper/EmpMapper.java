package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

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
	
	// 회원가입
	// 파라미터 : EmpDTO empDTO
	// 반환 값 : int
	// 사용 클래스 : EmpServiceImpl.updateEmpSignup
	int updateEmpSignup(EmpDTO empDTO);
	
	// 사번 중복 체크
	// 파라미터 : int empNo
	// 반환 값: String
	// 사용 클래스 : EmpServiceImpl.selectEmpNoDuplicate
	String selectEmpNoDuplicate(int empNo);
	
	// 마지막 사원 번호 찾기
    // 파라미터 : X
    // 반환 값 : int
    // 사용 클래스 : EmpServiceImpl.createNo
    int selectEmpNoMax();

    
    // 사원 등록
    int insertEmp(EmpDTO empDTO);
    
    // 사원 목록
    List<EmpSearchDTO> selectEmpList(EmpSearchDTO empSearchDTO, int startRow, int rowPerPage);
    
    //사원번호로 이메일 찾기
    String selectEmpEmailByEmpNo(int empNo);
    
    // 사원상세보기(개인 + 인사정보)
    Map<String, Object> selectEmpPersnal(int empNo);
    
    // 사원상세보기(인사 정보)
    Map<String, Object> selectEmpHr(int empNo);
    
    // 사원인사정보 수정(인사팀만)
    int updateEmpHr(EmpDTO empDTO);
    
    // 사원 인원 카운트
    int selectEmpCount(EmpSearchDTO empSearchDTO);
    
    // 마이 페이지에서 비밀번호 변경
    int updateEmpPwMyPage(int empNo, String oldPw, String newPw);
    
    // 사원 개인정보 수정(마이페이지)
    int updateEmpPersnalMyPage(EmpDTO empDTO);
}
