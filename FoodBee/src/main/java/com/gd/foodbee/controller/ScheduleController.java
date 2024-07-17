package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.service.ScheduleService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ScheduleController {
	@Autowired ScheduleService scheduleService;
	
	@GetMapping("/schedule")
	public String schdule(
			@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		String dptNo = null;

	    if (emp != null) {
	        empNo = emp.getEmpNo();
	        dptNo = emp.getDptNo();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	        log.debug(TeamColor.PURPLE + "dptNo => " + dptNo);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    //개인일정 불러오기 
	    List<ScheduleDTO> list = scheduleService.getScheduleList(empNo);  
	    //회의실 예약리스트 불러오기
	    List<HashMap<String,Object>> roomRsvList = scheduleService.getRoomRsvList(dptNo);
	    //팀원 휴가리스트
	    List<HashMap<String,Object>> dayOffList = scheduleService.getDayOffList(dptNo);
	    //팀원 출장리스트
	    List<HashMap<String,Object>> businessTripList = scheduleService.getBusinessTripList(dptNo);
	    
	    log.debug(TeamColor.PURPLE + "개인일정list=>" + list);//check
	    log.debug(TeamColor.PURPLE + "회의실예약list=>" + roomRsvList);
	    log.debug(TeamColor.PURPLE + "팀원휴가내역list=>" + dayOffList);
	    log.debug(TeamColor.PURPLE + "팀원출장내역list=>" + businessTripList);
	    
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("list", list);
	    model.addAttribute("roomRsvList", roomRsvList);
	    model.addAttribute("dayOffList", dayOffList);
	    model.addAttribute("businessTripList", businessTripList);
	    
		return"schedule";
	}
}
