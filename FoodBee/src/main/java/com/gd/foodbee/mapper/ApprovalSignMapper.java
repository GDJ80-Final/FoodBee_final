package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalSignMapper {

	//전자 서명 추가
	int insertApprovalSign(int empNo, String approvalSign);
	
	//전자 서명 수정
	int updateApprovalSign(int empNo, String approvalSign);
	
	//전자 서명 검색
	String selectApprovalSign(int empNo);
}
