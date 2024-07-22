package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalSignMapper {

	//전자 서명 추가
	int insertApprovalSign(int empNo);
	
	//전자 서명 수정
	int updateApprovalSign(int empNo);
}
