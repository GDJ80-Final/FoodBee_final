package com.gd.foodbee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	    //팀 일정 불러오기
	    List<ScheduleDTO> teamList = scheduleService.getTeamScheduleList(dptNo);
	    //회의실 예약리스트 불러오기
	    List<HashMap<String,Object>> roomRsvList = scheduleService.getRoomRsvList(dptNo);
	    //팀원 휴가리스트
	    List<HashMap<String,Object>> dayOffList = scheduleService.getDayOffList(dptNo);
	    //팀원 출장리스트
	    List<HashMap<String,Object>> businessTripList = scheduleService.getBusinessTripList(dptNo);
	    
	    log.debug(TeamColor.PURPLE + "팀일정list=>" + teamList);
	    log.debug(TeamColor.PURPLE + "개인일정list=>" + list);//check
	    log.debug(TeamColor.PURPLE + "회의실예약list=>" + roomRsvList);
	    log.debug(TeamColor.PURPLE + "팀원휴가내역list=>" + dayOffList);
	    log.debug(TeamColor.PURPLE + "팀원출장내역list=>" + businessTripList);
	    
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("list", list);
	    model.addAttribute("teamList", teamList);
	    model.addAttribute("roomRsvList", roomRsvList);
	    model.addAttribute("dayOffList", dayOffList);
	    model.addAttribute("businessTripList", businessTripList);
	    
		return"schedule";
	}
	//개인일정 리스트 전체
	@GetMapping("/scheduleList")
	public String scheduleList(
	        @RequestParam(name="currentPage", defaultValue="1") int currentPage,
	        Model model, HttpSession session) {
	    
	    EmpDTO emp = (EmpDTO) session.getAttribute("emp");
	    int empNo = 0;
	    
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    List<ScheduleDTO> personalList = scheduleService.personalListAll(currentPage, empNo);
	    
	    log.debug(TeamColor.PURPLE + "personalList=>" + personalList);
	    
	    model.addAttribute("personalList", personalList);
	    
	    return "scheduleList";
	}
	  
	//일정 상세보기
	@GetMapping("/scheduleOne")
	public String scheduleOne(@RequestParam("scheduleNo") int scheduleNo,
				Model model) {
		log.debug(TeamColor.PURPLE + "scheduleNo=>" + scheduleNo);
		
		Map<String, ScheduleDTO> one = scheduleService.scheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "상세보기=>" + one);
		
		model.addAttribute("one", one);
		
		return "scheduleOne";
	}
	
	//일정 수정
	@GetMapping("/modifySchedule")
	public String modifySchedule(@RequestParam("scheduleNo") int scheduleNo,
				Model model) {
		
		log.debug(TeamColor.PURPLE + "scheduleNo=>" + scheduleNo);
		
		Map<String, ScheduleDTO> one = scheduleService.scheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "수정하기=>" + one);
		
		model.addAttribute("one", one);
		
		return "modifySchedule";
	}
	//개인일정 수정액션
	@PostMapping("/modifyScheduleAction")
	public String modifyScheduleAction(@RequestParam("scheduleNo")int scheduleNo,
			ScheduleDTO scheduleDTO) {
		
			log.debug(TeamColor.PURPLE + "scheduleDTO=> " + scheduleDTO); 
			
			int update = scheduleService.modifySchedule(scheduleNo, scheduleDTO);
		
		return "redirect:/scheduleOne?scheduleNo="+scheduleNo;
	}
	//일정삭제
	@GetMapping("/deleteSchedule")
	public String deleteSchedule(@RequestParam("scheduleNo")int scheduleNo) {
		log.debug(TeamColor.PURPLE + "일정삭제완료");
		
		scheduleService.deleteSchedule(scheduleNo);
		
		return "redirect:/schedule";
	}
	
	//일정추가
	@GetMapping("/addSchedule")
	public String addSchedule(Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		String rankName = null;
		String empName = null;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        empName = emp.getEmpName();
	        rankName = emp.getRankName();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	        log.debug(TeamColor.PURPLE + "empName=>" + empName);
	        log.debug(TeamColor.PURPLE + "rankName=>" + rankName);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("empName", empName);
	    model.addAttribute("rankName", rankName);
	    
		return"addSchedule";
	}
	//일정추가
	@PostMapping("/addScheduleAction")
	public String addScheduleAction(ScheduleDTO scheduleDTO) {
		
		log.debug(TeamColor.PURPLE + "들어왔나?=>" + scheduleDTO);
		
		scheduleService.addSchedule(scheduleDTO);
		
		return "redirect:/schedule";
	}
	

	
}
