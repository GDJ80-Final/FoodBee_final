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

@Controller
public class DayOffHistoryController {

	@Autowired
	private DayOffHistoryService dayOffHistoryService;
	
	@Autowired
	private EmpService empService;
	
	@PostMapping("/emp/getDayOffHistoryList")
	@ResponseBody
	public Map<String, Object> getdayOffHistoryList(@RequestParam int empNo,
				@RequestParam String year,
				@RequestParam int currentPage){
		
		double dayOff = empService.getDayOff(empNo, year);
		List<Map<String, Object>> list = dayOffHistoryService.getDayOffHistoryList(empNo, year, currentPage);
		int lastPage = dayOffHistoryService.getDayOffLastPage(empNo, year);
		int cnt = dayOffHistoryService.getDayOffCnt(empNo, year);
		
		Map<String, Object> map = new HashMap<>();
		map.put("dayOff", dayOff);
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("cnt", cnt);
		
		return map;
	}
}
