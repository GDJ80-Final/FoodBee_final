package com.gd.foodbee.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	
	@GetMapping("/attendanceReport")
	public String attendanceReport(Model model, HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp:" + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		
		AttendanceDTO attendanceDTO = attendanceService.getTime(empNo);
		HashMap<String, Object> map = attendanceService.getTeamLeader(dptNo);
		
		model.addAttribute("attendanceDTO", attendanceDTO);
		model.addAttribute("map", map);
		
		return "attendanceReport";
	}
}
