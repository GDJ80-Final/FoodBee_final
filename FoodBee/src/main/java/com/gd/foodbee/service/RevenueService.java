package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.RevenueDTO;

public interface RevenueService {

	// 해당 월 매출액 출력
	List<RevenueDTO> getMonthRevenue(String referenceMonth);
	
	// 해당년도 전체 매출
	List<RevenueDTO> getTotalRevenue(String referenceMonth);
	
	// 카테고리 별 매출
	List<RevenueDTO> getCategoryRevenue(String referenceMonth, String categoryName);
	
	// 사용 가능한 연도를 가져옴
	List<String> getYear();
}
