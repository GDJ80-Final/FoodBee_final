package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.MsgRequestDTO;
import com.gd.foodbee.service.MsgService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MsgController {
	
	@Autowired
	private MsgService msgService;
	
	//새쪽지쓰기
	@GetMapping("/addMsg")
	public String addMsg() {
		
		return "addMsg";
	}
	
	@PostMapping("/addMsg")
	public String addMsg(MsgRequestDTO msgRequestDTO, 
				HttpServletRequest request) {
		
		log.debug(TeamColor.YELLOW +"signupDTO =>" +msgRequestDTO.toString());
		
		
		msgService.addMsg(msgRequestDTO, request);
		
		return "redirect:/sentMsgBox";
	}
	
	@GetMapping("/receivedMsgBox")
	public String receivedMsgList(@RequestParam(name="currentPage", defaultValue = "1")int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session,
				Model model) {
		log.debug(TeamColor.YELLOW + "currentPage" + currentPage);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		//받은 쪽지 리스트 출력 
		List<HashMap<String,Object>> list = msgService.getReceivedMsgList(currentPage, empNo,readYN);
		
		model.addAttribute("list", list);
		
		return "receivedMsgBox";
	}
	
}
