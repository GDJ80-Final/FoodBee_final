package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.RevenueDTO;

@Mapper
public interface RevenueMapper {
	
	// 해당 월 매출액 출력
	// 파라미터 : String referenceMonth
	// 반환값 : List<RevenueDTO>
	// 사용클래스 : RevenueServiceImpl.getMonthRevenue
	List<RevenueDTO> selectMonthRevenue(String referenceMonth);
	
	// 해당년도 전체 매출
	// 파라미터 : String referenceMonth
	// 반환값 : List<RevenueDTO>
	// 사용클래스 : RevenueServiceImpl.getTotalRevenue
	List<RevenueDTO> selectTotalRevenue(String referenceMonth);
	
	// 카테고리 별 매출
	// 파라미터 : String referenceMonth, String categoryName
	// 반환값 : List<RevenueDTO>
	// 사용클래스 : RevenueServiceImpl.getCategoryRevenue
	List<RevenueDTO> selectCategoryRevenue(String referenceMonth, String categoryName);
	
	// 사용 가능한 연도를 가져옴
	// 파라미터 : X
	// 반환값 : List<String>
	// 사용클래스 : RevenueServiceImpl.
	List<String> selectYear();
}
