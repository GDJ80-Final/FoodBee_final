package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.RevenueDTO;

@Mapper
public interface RevenueMapper {

	// 해당 월 매출액 출력
	List<RevenueDTO> selectMonthRevenue(String referenceMonth);
}
