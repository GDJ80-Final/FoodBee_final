package com.gd.foodbee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.DayOffDTO;
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
	//리스트 페이지
	@GetMapping("/scheduleList")
	public String scheduleList(
	        @RequestParam(name="currentPage", defaultValue="1") int currentPage,
	        Model model, HttpSession session) {
	    
	    EmpDTO emp = (EmpDTO) session.getAttribute("emp");
	    int empNo = 0;
	    String dptNo = null;
	    
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        dptNo = emp.getDptNo();
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("dptNo", dptNo);
	    
	    return "scheduleList";
	}
	//개인일정 전체보기
	@GetMapping("/personalScheduleList")
	@ResponseBody
	public Map<String,Object> personalScheduleList(int currentPage, int empNo){
		
		List<ScheduleDTO> personalList = scheduleService.personalListAll(currentPage, empNo);
		int personLastPage = scheduleService.personLastPage(empNo);
		
		Map<String,Object> personList = new HashMap<String,Object>();
		personList.put("currentPage", currentPage);
		personList.put("personalList", personalList);
		personList.put("personLastPage", personLastPage);
		
		log.debug(TeamColor.PURPLE + "개인일정전체list=>" + personalList);
		
		return personList;
	}
	// 팀일정 전체보기
	@GetMapping("/teamScheduleList")
	@ResponseBody
	public Map<String, Object> teamScheduleList(int currentPage, String dptNo) {
	    List<HashMap<String, Object>> teamListAll = scheduleService.teamListAll(currentPage, dptNo);
	    int teamLastPage = scheduleService.teamLastPage(dptNo);

	    Map<String, Object> teamList = new HashMap<>();
	    teamList.put("dptNo", dptNo);
	    teamList.put("currentPage", currentPage);
	    teamList.put("teamListAll", teamListAll);
	    teamList.put("teamLastPage", teamLastPage);

	    // 디버그 로그 추가
	    log.debug(TeamColor.PURPLE + "teamList==>" + teamList);
	    log.debug("팀일정전체list => " + teamListAll);
	    log.debug("teamLastPage => " + teamLastPage);
	    log.debug("currentPage => " + currentPage);

	    return teamList;
	}
	//회의실 예약 전체보기
	@GetMapping("/roomScheduleList")
	@ResponseBody
	public Map<String,Object> roomScheduleList(int currentPage, String dptNo){
		
		List<HashMap<String,Object>> roomListAll = scheduleService.roomListAll(currentPage, dptNo);
		int roomLastPage = scheduleService.roomLastPage(dptNo);
		
		Map<String,Object> roomList = new HashMap<String,Object>();
		roomList.put("roomListAll", roomListAll);
		roomList.put("currentPage", currentPage);
		roomList.put("roomLastPage", roomLastPage);
		
		log.debug(TeamColor.PURPLE + "회의실 예악일정list=>" + roomListAll);
		
		return roomList;
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
	//팀일정 상세보기
	@GetMapping("/teamScheduleOne")
	public String teamScheduleOne(@RequestParam("scheduleNo")int scheduleNo,
			Model model) {
		
		Map<String,ScheduleDTO> teamOne = scheduleService.teamScheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "팀일정상세보기=>" + teamOne);

		model.addAttribute("scheduleNo", scheduleNo);
		model.addAttribute("teamOne", teamOne);
		
		
		return"teamScheduleOne";
	}
	//휴가내역 상세보기
	@GetMapping("/dayOffScheduleOne")
	public String dayOffScheduleOne(@RequestParam("scheduleNo")int scheduleNo,
			Model model) {
		
		DayOffDTO dayOffOne = scheduleService.dayOffOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "휴가내역상세보기=>" + dayOffOne);
		
		model.addAttribute("dayOffOne", dayOffOne);
		
		return"dayOffScheduleOne";
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
