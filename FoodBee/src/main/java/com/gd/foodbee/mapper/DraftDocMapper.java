package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocDTO;

@Mapper
public interface DraftDocMapper {
	//기안서 작성 
	// 파라미터 : DraftDocDTO draftDocDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.addDraftDoc
	int insertDraftDoc(DraftDocDTO draftDocDTO);
	
}
