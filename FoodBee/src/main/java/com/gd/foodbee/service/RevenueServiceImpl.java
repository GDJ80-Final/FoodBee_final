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
	
	// 해당 월 매출액 출력
	// 파라미터 : String referenceMonth
	// 반환 값 : RevenueDTO
	// 사용 클래스 : RevenueController.MonthRevenue
	@Override
	public List<RevenueDTO> getMonthRevenue(String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth:" + referenceMonth);
		
		return revenueMapper.selectMonthRevenue(referenceMonth);
	}
}
