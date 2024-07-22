package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DayOffHistoryMapper {

	List<Map<String, Object>> selectDayOffHistoryList(int empNo, String year, int startRow, int rowPerPage);
	
	int selectDayOffHistoryCnt(int empNo, String year);
	
}
