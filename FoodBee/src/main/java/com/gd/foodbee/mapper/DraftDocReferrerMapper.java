package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DocReferrerDTO;

@Mapper
public interface DraftDocReferrerMapper {
	// 기안문서 수신참조자 
	int insertDraftDocReferrer(DocReferrerDTO docReferrerDTO);
}
