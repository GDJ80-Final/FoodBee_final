package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocDetailDTO;

@Mapper
public interface DraftDocDetailMapper {
	// 기안문서 상세 추가
	// 파라미터 : DraftDocDetailDTO draftDocDetailDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.addDraftDoc
	int insertDraftDocDetail(DraftDocDetailDTO draftDocDetailDTO);
}
