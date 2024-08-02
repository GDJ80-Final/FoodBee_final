package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocFileDTO;

@Mapper
public interface DraftDocFileMapper {
	// 기안문서 파일 추가 
	// 파라미터 : DraftDocFileDTO draftDocFileDTO
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.addDraftDoc
	int insertDraftDocFile(DraftDocFileDTO draftDocFileDTO);
	
	// 기안문서 파일 삭제 
	// 파라미터 : int draftDocFileNo
	// 반환 값 : int
	// 사용 클래스 : DraftDocService.modifyDraftDoc
	int deleteDraftDocFile(int draftDocNo);
	
	// 기안문서 파일 검색 
	// 파라미터 : int darftDocNo
	// 반환 값 : List<String>
	// 사용 클래스 : DraftDocService.modifyDraftDoc
	List<DraftDocFileDTO> selectDraftDocFileList(int darftDocNo);
	
	
	
}
