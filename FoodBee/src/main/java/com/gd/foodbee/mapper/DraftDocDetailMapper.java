package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocDetailDTO;

@Mapper
public interface DraftDocDetailMapper {
	// 기안문서 상세 추가
	int insertDraftDocDetail(DraftDocDetailDTO draftDocDetailDTO);
}
