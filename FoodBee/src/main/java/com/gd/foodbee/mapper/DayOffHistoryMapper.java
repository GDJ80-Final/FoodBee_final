package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DayOffHistoryMapper {

	// 휴가 내역
	// 파라미터 : int empNo, String year, int startRow, int rowPerPage
	// 반환 값 : List<Map<String, Object>>
	// 사용 클래스 : DayOffHistoryService.getDayOffHistoryList
	List<Map<String, Object>> selectDayOffHistoryList(int empNo, String year, int startRow, int rowPerPage);
	
	// 휴가 내역 개수
	// 파라미터 : int empNo, String year
	// 반환 값 : int
	// 사용 클래스 : DayOffHistoryService.getDayOffLastPage
	int selectDayOffHistoryCnt(int empNo, String year);
	
}
