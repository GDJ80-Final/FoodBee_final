package com.gd.foodbee.controller;

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
				HttpServletRequest request,
				HttpSession session,
				Model model) {
		
		log.debug(TeamColor.YELLOW +"msgRequestDTO =>" +msgRequestDTO.toString());
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo );
		msgService.addMsg(msgRequestDTO, request,empNo);
		
		return "redirect:/sentMsgBox";
	}
	//받은쪽지함
	//파라미터 : currentPage, String readYN, HttpSession session, Model model
	//반환값 : 
	@GetMapping("/receivedMsgBox")
	public String receivedMsgBox() {
		
		return "receivedMsgBox";
	}
	//받은쪽지함
	//파라미터 : currentPage, String readYN, HttpSession session,
	//반환값 : List<Map<String,Object>
	//사용페이지 
	@PostMapping("/receivedMsgBox")
	@ResponseBody
	public List<Map<String,Object>> receivedMsgBox(@RequestParam(name="currentPage", defaultValue = "1")int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "currentPage" + currentPage);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		//받은 쪽지 리스트 출력 
		
		return msgService.getReceivedMsgList(currentPage, empNo,readYN);
	}
	
	//보낸쪽지함
	//파라미터 :X
	//반환값 : "sentMsgBox"
	@GetMapping("/sentMsgBox")
	public String sentMsgBox() {
			
		return "sentMsgBox";
	}
	
	//보낸쪽지함 
	//파라미터 : int currentPage,String readYN, HttpSession session
	//반환값 : List<Map<String,Object>>
	//사용페이지 : sentMsgBox
	@PostMapping("/sentMsgBox")
	@ResponseBody
	public List<Map<String,Object>> sentMsgBox(@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgService.getSentMsgList(currentPage, empNo, readYN);
	}
}
