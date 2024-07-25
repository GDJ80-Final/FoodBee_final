package com.gd.foodbee.controller;

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
	
	@PostMapping("/emp/getDayOffHistoryList")
	@ResponseBody
	// 휴가내역리스트
	// 파라미터 : int empNo, String year, int currentPage
	// 반환값 : Map<String, Object>
	// 사용 페이지 : /myPage
	public Map<String, Object> getDayOffHistoryList(@RequestParam int empNo,
				@RequestParam String year,
				@RequestParam int currentPage){
		
		double dayOff = empService.getDayOff(empNo, year);
		List<Map<String, Object>> list = dayOffHistoryService.getDayOffHistoryList(empNo, year, currentPage);
		int lastPage = dayOffHistoryService.getDayOffLastPage(empNo, year);
		int cnt = dayOffHistoryService.getDayOffCnt(empNo, year);
		
		log.debug(TeamColor.PURPLE + "list=>" + list);
		log.debug(TeamColor.PURPLE + "lastPage=>" + lastPage);
		log.debug(TeamColor.PURPLE + "cnt=>" + cnt);
		
		Map<String, Object> map = new HashMap<>();
		map.put("dayOff", dayOff);
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("cnt", cnt);
		
		return map;
	}
}
