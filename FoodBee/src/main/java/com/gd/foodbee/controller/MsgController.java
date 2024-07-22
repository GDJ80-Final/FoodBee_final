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
	@GetMapping("/msg/addMsg")
	public String addMsg() {
		
		return "/msg/addMsg";
	}
	
	@PostMapping("/msg/addMsg")
	public String addMsg(MsgRequestDTO msgRequestDTO, 
				HttpServletRequest request,
				HttpSession session,
				Model model) {
		
		log.debug(TeamColor.YELLOW +"msgRequestDTO =>" +msgRequestDTO.toString());
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo );
		msgService.addMsg(msgRequestDTO, request,empNo);
		
		return "redirect:/msg/sentMsgBox";
	}
	//받은쪽지함
	//파라미터 : currentPage, String readYN, HttpSession session, Model model
	//반환값 : 
	@GetMapping("/msg/receivedMsgBox")
	public String receivedMsgBox() {
		
		return "/msg/receivedMsgBox";
	}
	//받은쪽지함
	//파라미터 : currentPage, String readYN, HttpSession session,
	//반환값 : List<Map<String,Object>
	//사용페이지 
	@PostMapping("/msg/receivedMsgBox")
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
	@GetMapping("/msg/sentMsgBox")
	public String sentMsgBox() {
			
		return "/msg/sentMsgBox";
	}
	
	//보낸쪽지함 
	//파라미터 : int currentPage,String readYN, HttpSession session
	//반환값 : List<Map<String,Object>>
	//사용페이지 : sentMsgBox
	@PostMapping("/msg/sentMsgBox")
	@ResponseBody
	public List<Map<String,Object>> sentMsgBox(@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgService.getSentMsgList(currentPage, empNo, readYN);
	}
	//휴지통 이동 >> 보낸편지함
	//파라미터 : int [] msgNos
	//반환값 : X
	//사용페이지 : receivedMsgBox, sentMsgBox
	@PostMapping("/msg/toTrash")
	@ResponseBody
	public String toTrash(@RequestParam(name="msgNos")int[] msgNos) {
		log.debug(TeamColor.YELLOW + "msgNos" + msgNos[0]);
		msgService.toTrash(msgNos);
		
		return "success";
	}
	
	//휴지통 이동 >> 받음편지함 
	//파라미터 : int [] msgNos,session
	//반환값 : X
	//사용페이지 : receivedMsgBox, sentMsgBox
	@PostMapping("/msg/toTrashRecipient")
	@ResponseBody
	public String toTrashRecipient(@RequestParam(name="msgNos")int[] msgNos,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNos" + msgNos[0]);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		msgService.toTrashRecipient(msgNos, empNo);
			
		return "success";
	}
	//휴지통 리스트
	//파라미터 : session => int empNo
	//반환값 : List<Map<String,Object>> 
	//사용페이지 : trashMsgBox
	
	@GetMapping("/msg/trashMsgBox")
	public String trashMsgBox(@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
			HttpSession session,
			Model model) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		String empName = emp.getEmpName();
		log.debug(TeamColor.YELLOW + "empName =>" +empName);
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo);
		List<Map<String,Object>> list =  msgService.getTrashList(empNo);
		log.debug(TeamColor.YELLOW + "list => " + list.toString());
		model.addAttribute("list", list);
		model.addAttribute("empName", empName);
		return "/msg/trashMsgBox";
		
	}
	@PostMapping("/msg/toMsgBox")
	@ResponseBody
	public String toMsgBox(@RequestParam(name="msgNos")int[] msgNos,
				@RequestParam(name="results") String[] results,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNos[0] => " + msgNos[0]);
		log.debug(TeamColor.YELLOW + "result[0] => " + results[0]);
		log.debug(TeamColor.YELLOW + "result =>"+results);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		msgService.updatetoMsgBox(msgNos,empNo, results);
		
		return "success";
		
	
	}
	@GetMapping("/msg/msgOne")
	public String msgOne(@RequestParam(name="msgNo")int msgNo,
				Model model) {
		log.debug(TeamColor.YELLOW + "msgNo => "+ msgNo);
	
		Map<String,Object> m = msgService.getMsgOne(msgNo);
		model.addAttribute("m", m);
		
		return "/msg/msgOne";
	}
}
