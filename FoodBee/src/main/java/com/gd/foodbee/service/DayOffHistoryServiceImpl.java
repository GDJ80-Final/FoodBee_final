package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.mapper.DayOffHistoryMapper;

@Service
public class DayOffHistoryServiceImpl implements DayOffHistoryService{
	
	@Autowired
	private DayOffHistoryMapper dayOffHistoryMapper;
	
	private static final int ROW_PER_PAGE = 2;

	// 휴가 내역 리스트
	// 파라미터 : int empNo, String year, int currentPage
	// 반환 값 : List<Map<String, Object>>
	// 사용 클래스 : DayOffHistoryController.getDayOffHistoryList
	@Override
	public List<Map<String, Object>> getDayOffHistoryList(int empNo, String year, int currentPage) {
		
		int startRow = (currentPage - 1) * ROW_PER_PAGE;
		
		return  dayOffHistoryMapper.selectDayOffHistoryList(empNo, year, startRow, ROW_PER_PAGE);
	}

	// 휴가 내역 마지막 페이지
	// 파라미터 : int empNo, String year
	// 반환 값 : int
	// 사용 클래스 : DayOffHistoryController.getDayOffHistoryList
	@Override
	public int getDayOffLastPage(int empNo, String year) {
		
		int cnt = dayOffHistoryMapper.selectDayOffHistoryCnt(empNo, year);
		
		int lastPage = 0;
		if(cnt % ROW_PER_PAGE == 0) {
			lastPage = cnt / ROW_PER_PAGE;
		} else {
			lastPage = cnt / ROW_PER_PAGE + 1;
		}
		return lastPage;
	}

	// 휴가 내역 개수
	// 파라미터 : int empNo, String year
	// 반환 값 : int
	// 사용 클래스 : DayOffHistoryController.getDayOffHistoryList
	@Override
	public int getDayOffCnt(int empNo, String year) {
		int cnt = dayOffHistoryMapper.selectDayOffHistoryCnt(empNo, year);
		return cnt;
	}

	// 사용 휴가 개수
	// 파라미터 : int empNo, String year
	// 반환 값 : int
	// 사용 클래스 : DayOffHistoryController.getRemainingDayOff
	@Override
	public double getUsedDayOff(int empNo, String year) {
		double cnt = dayOffHistoryMapper.selectDayOffCnt(empNo, year);
		return cnt;
	}


}
