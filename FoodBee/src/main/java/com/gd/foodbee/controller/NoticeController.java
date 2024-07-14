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

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.dto.NoticeRequest;
import com.gd.foodbee.service.LoginService;
import com.gd.foodbee.service.NoticeService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticeController {
	@Autowired NoticeService noticeService;
	
	@GetMapping("/noticeList")//전체List
	public String noticeList(
			@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			@RequestParam(name="rowPerPage", defaultValue="10") int rowPerPage,
			Model model, HttpSession session) {

		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		String dptNo = null;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        dptNo = emp.getDptNo();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	        log.debug(TeamColor.PURPLE + "dptNo => " + dptNo);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
		
		log.debug(TeamColor.PURPLE + "currentPage =>" + currentPage );
		log.debug(TeamColor.PURPLE + "rowPerPage =>" + rowPerPage);
		
		List<HashMap<String,Object>> list = noticeService.getNoticeList(currentPage, rowPerPage, dptNo);
		List<HashMap<String,Object>> allEmpList = noticeService.getAllEmpNoticeList(currentPage, rowPerPage);
		List<HashMap<String,Object>> allDptList = noticeService.getAllDptNoticeList(currentPage, rowPerPage, dptNo);
		
		log.debug(TeamColor.PURPLE + "list=>" + list);
		log.debug(TeamColor.PURPLE + "allEmpList=>" + allEmpList);
		log.debug(TeamColor.PURPLE + "allDptList=>" + allDptList);
		
		//총 공지사항의 갯수
		int cntNotice = noticeService.getCountNoticeList();
		log.debug(TeamColor.PURPLE + "cntNotice=>" + cntNotice);
		
		model.addAttribute("dptNo", dptNo);
		model.addAttribute("list", list);
		model.addAttribute("allEmpList", allEmpList);
		model.addAttribute("allDptList", allDptList);
	return "noticeList";
	}
	
	@GetMapping("/addNotice")//공지사항 추가
	public String addNotice() {
	return "addNotice";
	}
	
	@PostMapping("/addNoticeAction")//공지사항 추가action
	public String addNoticeAction(NoticeRequest noticeRequest) {
		log.debug(TeamColor.PURPLE + "noticeRequest=>" + noticeRequest);
		
		noticeService.addNotice(noticeRequest);
		
	return"redirect:/noticeList";
	
	}
	
	@GetMapping("/noticeOne")
    public String noticeOne(
    		@RequestParam("noticeNo") int noticeNo,
    		Model model) {
   
		log.debug(TeamColor.PURPLE + "noticeOne.noticeNo=>" + noticeNo);
		
		List<Map<String, Object>> one = noticeService.getNoticeOne(noticeNo);
		log.debug(TeamColor.PURPLE + "noticeOne.one=>" + one);
		
		model.addAttribute("one", one);
		
    return "noticeOne"; 
    }
	
	@PostMapping("/deleteNotice")
	public String deleteNotice(@RequestParam("noticeNo") int noticeNo) {
		log.debug(TeamColor.PURPLE + "delete.noticeNo=>" + noticeNo);
		
		noticeService.getDeleteNotice(noticeNo);
	return"redirect:/noticeList";
	}
}
