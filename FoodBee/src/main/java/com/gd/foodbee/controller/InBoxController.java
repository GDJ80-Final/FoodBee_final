package com.gd.foodbee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;
import com.gd.foodbee.service.InBoxService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class InBoxController {
	@Autowired 
	InBoxService inBoxService;
	
	@GetMapping("/approval/inBox")
	public String inBox(@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    InBoxStateDTO stateBox = inBoxService.getStateBox(empNo);
	    List<InBoxDTO> referrerList = inBoxService.getReferrerList(currentPage, empNo);
	    
	    log.debug(TeamColor.PURPLE + "stateBox=>" + stateBox);
	    log.debug(TeamColor.PURPLE + "referrerList=>" + referrerList);
	    
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("stateBox", stateBox);
	    model.addAttribute("referrerList", referrerList);
	    
		return"/approval/inBox";
	}
}
