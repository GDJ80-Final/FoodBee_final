package com.gd.foodbee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.RevenueDTO;
import com.gd.foodbee.service.RevenueService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RevenueController {
	@Autowired RevenueService revenueService;
	
	// 해당 월 매출액 출력
	// 사용 페이지 : /monthRevenue
	@GetMapping("/monthRevenue")
	public String monthRevenue() {
		
		return "monthRevenue";
	}	
	
	// 해당 월 매출액 출력
	// 파라미터 : String referenceMonth
	// 반환 값 : RevenueDTO
	// 사용 페이지 : /monthRevenue
	@PostMapping("/getMonthRevenue")
	@ResponseBody
	public List<RevenueDTO> getMonthRevenue(@RequestParam(name="month") String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth:" + referenceMonth);
		
		List<RevenueDTO> list = revenueService.getMonthRevenue(referenceMonth);
		log.debug(TeamColor.GREEN + "list:" + list.toString());
		
		return list;
	}
	
	// 전체/카테고리 매출액 출력
	// 사용 페이지 : /categoryRevenue
	@GetMapping("/categoryRevenue")
	public String categoryRevenue() {
		
		return "categoryRevenue";
	}	
	
	// 전체 매출액 출력
	// 파라미터 : String year
	// 반환 값 : RevenueDTO
	// 사용 페이지 : /totalRevenue
	@PostMapping("/getTotalRevenue")
	@ResponseBody
	public List<RevenueDTO> getTotalRevenue(@RequestParam(name="year") String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth:" + referenceMonth);
		
		List<RevenueDTO> list = revenueService.getTotalRevenue(referenceMonth);
		log.debug(TeamColor.GREEN + "list:" + list.toString());
		
		return list;
	}
	
	// 카테고리 별 매출액 출력
	// 파라미터 : String categoryName
	// 반환 값 : RevenueDTO
	// 사용 페이지 : /totalRevenue
	@PostMapping("/getCategoryRevenue")
	@ResponseBody
	public List<RevenueDTO> getCategoryRevenue(@RequestParam(name="year") String referenceMonth,
											@RequestParam(name="category") String categoryName) {
		log.debug(TeamColor.GREEN + "referenceMonth:" + referenceMonth);
		log.debug(TeamColor.GREEN + "categoryName:" + categoryName);
		
		List<RevenueDTO> list = revenueService.getCategoryRevenue(referenceMonth, categoryName);
		log.debug(TeamColor.GREEN + "list:" + list.toString());
		
		return list;
	}
	
}
