package com.gd.foodbee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.RevenueDTO;
import com.gd.foodbee.mapper.RevenueMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class RevenueServiceImpl implements RevenueService{
	@Autowired RevenueMapper revenueMapper;
	
	// 해당 년월 카테고리
	// 파라미터 : String referenceMonth
	// 반환 값 : List<String>
	// 사용 클래스 : RevenueController.
	@Override
	public List<String> getCategory(String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		return revenueMapper.selectRevenueCategoriesByMonth(referenceMonth);
	}
	
	// 해당 월 매출액 출력
	// 파라미터 : String referenceMonth
	// 반환 값 : List<RevenueDTO>
	// 사용 클래스 : RevenueController.MonthRevenue
	@Override
	public List<RevenueDTO> getMonthRevenue(String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		return revenueMapper.selectMonthRevenue(referenceMonth);
	}
	
	// 해당년도 전체 매출
	// 파라미터 : String referenceMonth
	// 반환 값 : List<RevenueDTO>
	// 사용 클래스 : RevenueController.getTotalRevenue
	@Override
	public List<RevenueDTO> getTotalRevenue(String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		return revenueMapper.selectTotalRevenue(referenceMonth);
	}
	
	// 카테고리 별 매출
	// 파라미터 : String referenceMonth, String categoryName
	// 반환 값 : List<RevenueDTO>
	// 사용 클래스 : RevenueController.getCategoryRevenue
	@Override
	public List<RevenueDTO> getCategoryRevenue(String referenceMonth, String categoryName) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		log.debug(TeamColor.GREEN + "categoryName => " + categoryName);
		
		return revenueMapper.selectCategoryRevenue(referenceMonth, categoryName);
	}
	
	// 사용 가능한 연도를 가져옴
	// 파라미터 : X
	// 반환 값 : List<String>
	// 사용 클래스 : RevenueController.
	@Override
	public List<String> getYear() {
		
		return revenueMapper.selectYear();
	}
	
}
