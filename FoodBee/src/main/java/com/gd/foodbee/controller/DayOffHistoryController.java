package com.gd.foodbee.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.service.DayOffHistoryService;
import com.gd.foodbee.service.EmpService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DayOffHistoryController {

	@Autowired
	private DayOffHistoryService dayOffHistoryService;
	@Autowired
	private EmpService empService;
	
	// 휴가내역리스트
	// 파라미터 : int empNo, String year, int currentPage
	// 반환값 : Map<String, Object>
	// 사용 페이지 : /myPage
	@PostMapping("/emp/getDayOffHistoryList")
	@ResponseBody
	public Map<String, Object> getDayOffHistoryList(@RequestParam int empNo,
				@RequestParam String year,
				@RequestParam int currentPage){
		
		double dayOff = empService.getDayOff(empNo, year);
		List<Map<String, Object>> list = dayOffHistoryService.getDayOffHistoryList(empNo, year, currentPage);
		int lastPage = dayOffHistoryService.getDayOffLastPage(empNo, year);
		double cnt = dayOffHistoryService.getUsedDayOff(empNo, year);
		
		log.debug(TeamColor.RED + "dayOff=>" + dayOff);
		log.debug(TeamColor.RED + "list=>" + list);
		log.debug(TeamColor.RED + "lastPage=>" + lastPage);
		log.debug(TeamColor.RED + "cnt=>" + cnt);
		
		Map<String, Object> map = new HashMap<>();
		map.put("dayOff", dayOff);
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("cnt", cnt);
		
		return map;
	}
	
	// 잔여 휴가
	// 파라미터 : int empNo
	// 반환 값 : int
	// 사용 페이지 : 
	@PostMapping("/emp/getRemainingDayOff")
	@ResponseBody
	public double getRemainingDayOff(@RequestParam int empNo, 
			@RequestParam String year) {
		double dayOff = empService.getDayOff(empNo, year);
		double cnt = dayOffHistoryService.getUsedDayOff(empNo, year);
		
		return dayOff - cnt;
	}
}
