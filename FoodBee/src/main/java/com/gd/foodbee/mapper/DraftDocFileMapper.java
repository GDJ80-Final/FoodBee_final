package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocFileDTO;

@Mapper
public interface DraftDocFileMapper {
	// 기안문서 파일 추가 
	// 파라미터 : DraftDocFileDTO draftDocFileDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.addDraftDoc
	int insertDraftDocFile(DraftDocFileDTO draftDocFileDTO);
}
