package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.foodbee.dto.AttendanceDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.AttendanceService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class AttendanceController {
	@Autowired AttendanceService attendanceService;
	
	// 근태보고
	// 파라미터 : session
	// 반환 값 : attendanceDTO, map
	// 사용 페이지 : /attendance/attendanceReport
	@GetMapping("/attendance/attendanceReport")
	public String attendanceReport(Model model, HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		
		AttendanceDTO attendanceDTO = attendanceService.getTime(empNo);
		HashMap<String, Object> map = attendanceService.getTeamLeader(dptNo);
		
		model.addAttribute("attendanceDTO", attendanceDTO);
		model.addAttribute("map", map);
		
		return "/attendance/attendanceReport";
	}

	// 근태보고 수정 폼
	// 파라미터 : session
	// 반환 값 : attendanceDTO, map
	// 사용 페이지 : /attendance/attendanceModify
	@GetMapping("/attendance/attendanceModify")
	public String attendanceModify(Model model, HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		
		AttendanceDTO attendanceDTO = attendanceService.getTime(empNo);
		HashMap<String, Object> map = attendanceService.getTeamLeader(dptNo);
		
		model.addAttribute("attendanceDTO", attendanceDTO);
		model.addAttribute("map", map);
		
		return "/attendance/attendanceModify";
	}
	
	// 근태보고 수정 액션
	// 파라미터 : session, String updateStartTime, String updateEndTime, String updateReason
	// 반환 페이지 : /attendance/attendanceReport
	@PostMapping("/attendance/attendanceModifyAction")
	public String attendanceModifyAction(HttpSession session, 
						@RequestParam(name="updateStartTime") String updateStartTime,
						@RequestParam(name="updateEndTime") String updateEndTime,
						@RequestParam(name="updateReason") String updateReason) {
		
		log.debug(TeamColor.GREEN + "updateStartTime => " + updateStartTime);
		log.debug(TeamColor.GREEN + "updateEndTime => " + updateEndTime);
		log.debug(TeamColor.GREEN + "updateReason => " + updateReason);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.modifyTime(updateStartTime, updateEndTime, updateReason, empNo);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendanceReport";
	}
	
	// 개인 근태
	// 파라미터 : session, int currentPage, String startDate, String endDate
	// 반환 값 : list, map, currentPage, lastPage
	// 사용 페이지 : /attendance/attendancePersonal
	@GetMapping("/attendance/attendancePersonal")
	public String attendancePersonal(Model model, HttpSession session, 
			 			@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			 			@RequestParam(name="startDate", required = false) String startDate,
			 			@RequestParam(name="endDate", required = false) String endDate) {
		
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "startDate => " + startDate);
		log.debug(TeamColor.GREEN + "endDate => " + endDate);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		
		List<AttendanceDTO> list = attendanceService.getAttendancePersonal(empNo, currentPage, startDate, endDate);				
		HashMap<String, Object> map = attendanceService.getTeamLeader(dptNo);
		
		int lastPage = attendanceService.getAttendancePersonalCnt(empNo);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
		
		return "/attendance/attendancePersonal";
	}
	
	// 근태 확정
	// 파라미터 : session, String date
	// 반환 페이지 : /attendance/attendancePersonal
	@PostMapping("/attendance/attendanceFinalTime")
	public String attendanceFinalTime(HttpSession session, 
						@RequestParam(name="date")String date) {
		
		log.debug(TeamColor.GREEN + "date => " + date);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.modifyAttendanceFinalTime(date, empNo);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendancePersonal";
	}
	
}
