package com.gd.foodbee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@Autowired 
	private RevenueService revenueService;
	
	// 해당 월 매출액 출력
	// 사용 페이지 : /monthRevenue
	@GetMapping("/revenue/monthRevenue")
	public String monthRevenue() {
		
		return "/revenue/monthRevenue";
	}	
	
	// 해당 월 매출액 출력
	// 파라미터 : String referenceMonth
	// 반환 값 : List<RevenueDTO>
	// 사용 페이지 : /monthRevenue
	@PostMapping("/revenue/getMonthRevenue")
	@ResponseBody
	public List<RevenueDTO> getMonthRevenue(@RequestParam(name="month") String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		List<RevenueDTO> list = revenueService.getMonthRevenue(referenceMonth);
		log.debug(TeamColor.GREEN + "list => " + list.toString());
		
		return list;
	}
	
	// 해당 월 카테고리 출력
	// 파라미터 : String referenceMonth
	// 반환 값 : List<String>
	// 사용 페이지 : /monthRevenue
	@PostMapping("/revenue/getCategory")
	@ResponseBody
	public List<String> getCategory(@RequestParam(name="YearMonth") String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		List<String> list = revenueService.getCategory(referenceMonth);
		log.debug(TeamColor.GREEN + "list => " + list.toString());
		
		return list;
	}
	
	// 전체/카테고리 매출액 출력
	// 사용 페이지 : /categoryRevenue
	@GetMapping("/revenue/categoryRevenue")
	public String categoryRevenue() {
		
		return "/revenue/categoryRevenue";
	}	
	
	// 전체 매출액 출력
	// 파라미터 : String referenceMonth (매출 해당 년도)
	// 반환 값 : List<RevenueDTO>
	// 사용 페이지 : /totalRevenue
	@PostMapping("/revenue/getTotalRevenue")
	@ResponseBody
	public List<RevenueDTO> getTotalRevenue(@RequestParam(name="year") String referenceMonth) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		
		List<RevenueDTO> list = revenueService.getTotalRevenue(referenceMonth);
		log.debug(TeamColor.GREEN + "list => " + list.toString());
		
		return list;
	}
	
	// 카테고리 별 매출액 출력
	// 파라미터 : String referenceMonth, String categoryName
	// 반환 값 : List<RevenueDTO>
	// 사용 페이지 : /totalRevenue
	@PostMapping("/revenue/getCategoryRevenue")
	@ResponseBody
	public List<RevenueDTO> getCategoryRevenue(@RequestParam(name="year") String referenceMonth,
											@RequestParam(name="category") String categoryName) {
		log.debug(TeamColor.GREEN + "referenceMonth => " + referenceMonth);
		log.debug(TeamColor.GREEN + "categoryName => " + categoryName);
		
		List<RevenueDTO> list = revenueService.getCategoryRevenue(referenceMonth, categoryName);
		log.debug(TeamColor.GREEN + "list => " + list.toString());
		
		return list;
	}
	
	// 사용 가능한 연도를 가져옴
	// 파라미터 : X
	// 반환 값 : List<String>
	// 사용 페이지 : /categoryRevenue
    @GetMapping("/revenue/getAvailableYears")
    @ResponseBody
    public List<String> getAvailableYears() {
    	
        List<String> years = revenueService.getYear();
        log.debug(TeamColor.GREEN + "Available years => " + years.toString());
        
        return years;
    }
}
