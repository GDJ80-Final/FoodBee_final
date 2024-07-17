package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.RevenueDTO;

public interface RevenueService {

	// 해당 월 매출액 출력
	List<RevenueDTO> getMonthRevenue(String referenceMonth);
}
