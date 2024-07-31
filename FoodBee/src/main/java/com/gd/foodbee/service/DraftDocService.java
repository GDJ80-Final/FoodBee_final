package com.gd.foodbee.service;


import com.gd.foodbee.dto.DraftDocRequestDTO;


public interface DraftDocService {
	//새 기안서 추가 
	void addDraftDoc(DraftDocRequestDTO draftDocRequestDTO);
	
	// 기안서 수정
	void modifyDraftDoc(DraftDocRequestDTO draftDocRequestDTO, int draftDocNo);
}
