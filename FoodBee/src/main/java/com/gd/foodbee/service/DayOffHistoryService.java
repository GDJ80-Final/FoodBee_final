package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

public interface DayOffHistoryService {

	// 휴가 내역 리스트
	List<Map<String, Object>> getDayOffHistoryList(int empNo, String year, int startRow);
	
	// 휴가 내역 마지막 페이지
	int getDayOffLastPage(int empNo, String year);
	
	// 휴가 내역 개수
	int getDayOffCnt(int empNo, String year);
}
