package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DocReferrerDTO;

@Mapper
public interface DraftDocReferrerMapper {
	// 기안문서 수신참조자 
	// 파라미터 : DocReferrerDTO docReferrerDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.addDraftDoc, DraftDocService.modifyDraftDoc
	int insertDraftDocReferrer(DocReferrerDTO docReferrerDTO);
	
	// 기안문서 수신참조자 삭제
	// 파라미터 : DocReferrerDTO docReferrerDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.modifyDraftDoc
	int deleteDraftDocReferrer(int draftDocNo);
}
