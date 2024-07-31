package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;
import com.gd.foodbee.mapper.InBoxMapper;

public interface InBoxService {
	// 전체 수신 리스트
	List<InBoxDTO> getReferrerList(int currentPage, int empNo);
	
	// 수신 참조된 리스트 총갯수
	int countAllReferrerList(int empNo);
	
	// 수신 참조된 리스트 LastPage
	int allReferrerLastPage(int empNo);
	
	// 결재상태(결재대기, 승인중, 승인완료, 반려) 총갯수
	InBoxStateDTO getStateBox(int empNo);
}
