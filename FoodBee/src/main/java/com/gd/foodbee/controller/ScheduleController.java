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
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;
import com.gd.foodbee.service.ScheduleService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ScheduleController {
	@Autowired 
	private ScheduleService scheduleService;
	
	// 캘린더 달력
	// 파라미터 : int currentPage, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 : /calendar/schedule
	@GetMapping("/calendar/schedule")
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
	    
		return"/calendar/schedule";
	}
	// 일정리스트 페이지
	// 파라미터 : int currentPage, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 : /calendar/scheduleList
	@GetMapping("/calendar/scheduleList")
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
	    model.addAttribute("currentPage", currentPage);
	    
	    return "/calendar/scheduleList";
	}
	// 개인일정 전체보기
	// 파라미터 : int currentPage, int empNo, String search
	// 반환값 : Map<>personList
	// 사용페이지 : /calendar/personalScheduleList
	@GetMapping("/calendar/personalScheduleList")
	@ResponseBody
	public Map<String,Object> personalScheduleList(int currentPage, int empNo, String search){
		
		List<ScheduleDTO> personalList = scheduleService.personalListAll(currentPage, empNo, search);
		int personLastPage = scheduleService.personLastPage(empNo);
		
		Map<String,Object> personList = new HashMap<String,Object>();
		personList.put("currentPage", currentPage);
		personList.put("personalList", personalList);
		personList.put("personLastPage", personLastPage);
		
		log.debug(TeamColor.PURPLE + "개인일정전체list=>" + personalList);
		log.debug(TeamColor.PURPLE + "개인일정lastPage" + personLastPage);
		
		return personList;
	}
	// 팀일정 전체보기
	// 파라미터 : int currentPage, int dptNo, String search
	// 반환값 : Map<>teamList
	// 사용페이지 : /calendar/teamScheduleList
	@GetMapping("/calendar/teamScheduleList")
	@ResponseBody
	public Map<String, Object> teamScheduleList(int currentPage, String dptNo, String search) {
	    List<HashMap<String, Object>> teamListAll = scheduleService.teamListAll(currentPage, dptNo, search);
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
	// 회의실 예약 전체보기
	// 파라미터 : int currentPage, int empNo, String search
	// 반환값 : List<>roomList
	// 사용페이지 : /calendar/roomScheduleList
	@GetMapping("/calendar/roomScheduleList")
	@ResponseBody
	public Map<String,Object> roomScheduleList(int currentPage, int empNo, String dptNo, String search){
		
		List<HashMap<String,Object>> roomListAll = scheduleService.roomListAll(currentPage, empNo,dptNo, search);
		int roomLastPage = scheduleService.roomLastPage(dptNo);
		
		Map<String,Object> roomList = new HashMap<String,Object>();
		roomList.put("roomListAll", roomListAll);
		roomList.put("currentPage", currentPage);
		roomList.put("roomLastPage", roomLastPage);
		
		log.debug(TeamColor.PURPLE + "회의실 예악일정list=>" + roomListAll);
		
		return roomList;
	}
	  
	// 일정 상세보기
	// 파라미터 : int scheduleNo, Model model
	// 반환값 : Map<>one
	// 사용페이지 : /calendar/scheduleOne
	@GetMapping("/calendar/scheduleOne")
	public String scheduleOne(@RequestParam("scheduleNo") int scheduleNo,
				Model model) {
		log.debug(TeamColor.PURPLE + "scheduleNo=>" + scheduleNo);
		
		Map<String, ScheduleDTO> one = scheduleService.scheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "상세보기=>" + one);
		
		model.addAttribute("one", one);
		
		return "/calendar/scheduleOne";
	}
	// 팀일정 상세보기
	// 파라미터 : int scheduleNo,Model model
	// 반환값 : Map<ScheduleDTO>
	// 사용페이지 : /calendar/teamScheduleOne
	@GetMapping("/calendar/teamScheduleOne")
	public String teamScheduleOne(@RequestParam("scheduleNo")int scheduleNo,
			Model model) {
		
		Map<String,ScheduleDTO> teamOne = scheduleService.teamScheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "팀일정상세보기=>" + teamOne);

		model.addAttribute("scheduleNo", scheduleNo);
		model.addAttribute("teamOne", teamOne);
		
		
		return"/calendar/teamScheduleOne";
	}
	// 휴가내역 상세보기
	// 파라미터 : int scheduleNo, Model model
	// 반환값 : dayOffOne
	// 사용페이지 : /calendar/dayOffScheduleOne
	@GetMapping("/calendar/dayOffScheduleOne")
	public String dayOffScheduleOne(@RequestParam("scheduleNo")int scheduleNo,
			Model model) {
		
		DayOffDTO dayOffOne = scheduleService.dayOffOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "휴가내역상세보기=>" + dayOffOne);
		
		model.addAttribute("dayOffOne", dayOffOne);
		
		return"/calendar/dayOffScheduleOne";
	}
	
	// 출장내역 상세보기
	// 파라미터 : int scheduleNo, Model model
	// 반환값 : tripHistoryOne
	// 사용페이지 : /calendar/businessTripScheduleOne
	@GetMapping("/calendar/businessTripScheduleOne")
	public String businessTripScheduleOne(@RequestParam("scheduleNo")int scheduleNo,
			Model model) {
		
		TripHistoryDTO tripHistoryOne = scheduleService.tripHistoryOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "출장내역상세보기=>" + tripHistoryOne);
		
		model.addAttribute("tripHistoryOne", tripHistoryOne);
		
		return"/calendar/businessTripScheduleOne";
	}
	
	// 휴가내역 상세보기
	// 파라미터 : int rsvNo, Model model
	// 반환값 : String (view)
	// 사용페이지 : /calendar/roomRsvOne
	@GetMapping("/calendar/roomRsvOne")
	public String roomRsvOne(@RequestParam("rsvNo")int rsvNo,
			Model model) {
		
		RoomRsvDTO roomRsvOne = scheduleService.roomRsvOne(rsvNo);
		
		model.addAttribute("roomRsvOne", roomRsvOne);
		
		return"/calendar/roomRsvOne";
	}
	
	// 일정 수정
	// 파라미터 : int shceduleNo, Model model
	// 반환값 : Map<>one
	// 사용페이지 : /calendar/modifySchedule
	@GetMapping("/calendar/modifySchedule")
	public String modifySchedule(@RequestParam("scheduleNo") int scheduleNo,
				Model model) {
		
		log.debug(TeamColor.PURPLE + "scheduleNo=>" + scheduleNo);
		
		Map<String, ScheduleDTO> one = scheduleService.scheduleOne(scheduleNo);
		log.debug(TeamColor.PURPLE + "수정하기=>" + one);
		
		model.addAttribute("one", one);
		
		return "/calendar/modifySchedule";
	}
	// 개인일정 수정액션
	// 파라미터 : int schdeulNo, ScheduleDTO scheduleDTO
	// 반환값 : int 
	// 사용페이지 : /calendar/modifySchedule
	@PostMapping("/calendar/modifyScheduleAction")
	public String modifyScheduleAction(@RequestParam("scheduleNo")int scheduleNo,
			ScheduleDTO scheduleDTO) {
		
			log.debug(TeamColor.PURPLE + "scheduleDTO=> " + scheduleDTO); 
			
			int update = scheduleService.modifySchedule(scheduleNo, scheduleDTO);
		
		return "redirect:/calendar/scheduleOne?scheduleNo="+scheduleNo;
	}
	// 일정삭제
	// 파라미터 : int schdeulNo
	// 반환값 : /calendar/schedule
	// 사용페이지 : /calendar/deleteSchedule
	@GetMapping("/calendar/deleteSchedule")
	public String deleteSchedule(@RequestParam("scheduleNo")int scheduleNo) {
		log.debug(TeamColor.PURPLE + "일정삭제완료");
		
		scheduleService.deleteSchedule(scheduleNo);
		
		return "redirect:/calendar/schedule";
	}
	
	// 일정추가
	// 파라미터 : Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 : /calendar/addSchedule
	@GetMapping("/calendar/addSchedule")
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
	    
		return"/calendar/addSchedule";
	} 
	// 일정추가
	// 파라미터 : ScheduleDTO scheduleDTO
	// 반환값 : /calendar/schedule
	// 사용페이지 : /calendar/addSchedule
	@PostMapping("/calendar/addScheduleAction")
	public String addScheduleAction(ScheduleDTO scheduleDTO) {
		
		log.debug(TeamColor.PURPLE + "들어왔나?=>" + scheduleDTO);
		
		scheduleService.addSchedule(scheduleDTO);
		
		return "redirect:/calendar/schedule";
	}
	
	
}
