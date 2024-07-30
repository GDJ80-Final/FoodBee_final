package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalSignMapper {

	// 전자 서명 추가
	// 파라미터 : int empNo, String approvalSign
	// 반환 값 : int
	// 사용 클래스 : ApprovalSignService.saveApprovalSign
	int insertApprovalSign(int empNo, String approvalSign);
	
	// 전자 서명 수정
	// 파라미터 : int empNo, String approvalSign
	// 반환 값 : int
	// 사용 클래스 : ApprovalSignService.saveApprovalSign	
	int updateApprovalSign(int empNo, String approvalSign);
	
	// 전자 서명 검색
	// 파라미터 : int empNo
	// 반환 값 : String
	// 사용 클래스 : ApprovalSignService.saveApprovalSign, ApprovalSignService.getApprovalSign
	String selectApprovalSign(int empNo);
}
