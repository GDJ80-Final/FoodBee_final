package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocFileDTO;

@Mapper
public interface DraftDocFileMapper {
	// 기안문서 파일 추가 
	int insertDraftDocFile(DraftDocFileDTO draftDocFileDTO);
}
