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
import com.gd.foodbee.dto.NoticeRequest;
import com.gd.foodbee.service.NoticeService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticeController {
	@Autowired NoticeService noticeService;
	
	@GetMapping("/community/notice/noticeList")//전체List
	public String noticeList(
			@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			Model model, HttpSession session) {

		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		String dptNo = null;
		String rankName = null;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        dptNo = emp.getDptNo();
	        rankName = emp.getRankName();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	        log.debug(TeamColor.PURPLE + "dptNo => " + dptNo);
	        log.debug(TeamColor.PURPLE + "rankName=>" + rankName);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
		
		log.debug(TeamColor.PURPLE + "currentPage =>" + currentPage );

		
		List<HashMap<String,Object>> list = noticeService.getNoticeList(currentPage, dptNo);
		
		log.debug(TeamColor.PURPLE + "list=>" + list);
		
		//공지사항 마지막페이지
		int lastPage = noticeService.allLastPage(dptNo);
		
		model.addAttribute("dptNo", dptNo);
		model.addAttribute("rankName", rankName);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
	return "/community/notice/noticeList";
	}
	
	@GetMapping("/community/notice/allNoticeList") // [버튼] 전체 공지사항
	@ResponseBody
	public Map<String,Object> allNoticeList(int currentPage, String dptNo) {
		
	    List<HashMap<String,Object>> list = noticeService.getNoticeList(currentPage, dptNo);
	    
	    int lastPage = noticeService.allLastPage(dptNo);
	    
	    Map<String,Object> allList = new HashMap<String,Object>();
	    	allList.put("list", list);
	    	allList.put("lastPage", lastPage);
	    	allList.put("currnetPage", currentPage);
	  
	    	
    	log.debug(TeamColor.PURPLE + "list=>" + list);
    	log.debug(TeamColor.PURPLE + "lastPage=>" + lastPage);

    	
	    return allList;
	}
	
	@GetMapping("/community/notice/allEmpList")//[버튼]전사원 공지사항
	@ResponseBody
	public Map<String,Object> allEmpList(int currentPage) {
		
		List<HashMap<String,Object>> allEmpList = noticeService.getAllEmpNoticeList(currentPage);
		
		int empLastPage = noticeService.allEmpLastPage();
		
		Map<String,Object> empList = new HashMap<String,Object>();
			empList.put("allEmpList", allEmpList);
			empList.put("empLastPage", empLastPage);
			empList.put("currentPage", currentPage);
			
		log.debug(TeamColor.PURPLE + "allEmpList=>" + allEmpList);
			
		return empList;
	}
	@GetMapping("/community/notice/allDptList")
	@ResponseBody
	public Map<String, Object> allDptList(int currentPage, String dptNo) {
	    List<HashMap<String, Object>> allDptList = noticeService.getAllDptNoticeList(currentPage, dptNo);
	    int dptLastPage = noticeService.allDptLastPage(dptNo);

	    Map<String, Object> dptList = new HashMap<>();
	    dptList.put("allDptList", allDptList);
	    dptList.put("dptLastPage", dptLastPage);
	    dptList.put("currentPage", currentPage);

	    log.debug(TeamColor.PURPLE + "allDptList=>" + allDptList);
	    log.debug(TeamColor.PURPLE + "dptLastPage=>" + dptLastPage);

	    return dptList;
	}

	
	@GetMapping("/community/notice/addNotice")//공지사항 추가
	public String addNotice(Model model, 
			HttpSession session, 
			HttpServletRequest request) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = 0;
		String dptNo = null;
		String empName = null;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empNo = emp.getEmpNo();
	        empName = emp.getEmpName();
	        dptNo = emp.getDptNo();
	        log.debug(TeamColor.PURPLE + "empNo => " + empNo);
	        log.debug(TeamColor.PURPLE + "dptNo => " + dptNo);
	        log.debug(TeamColor.PURPLE + "empName=>" + empName);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
	    
	    model.addAttribute("dptNo", dptNo);
	    model.addAttribute("empNo", empNo);
	    model.addAttribute("empName", empName);
	return "/community/notice/addNotice";
	}
	
	@PostMapping("/community/notice/addNoticeAction")//공지사항 추가action
	public String addNoticeAction(NoticeRequest noticeRequest, HttpServletRequest request) {
		log.debug(TeamColor.PURPLE + "noticeRequest=>" + noticeRequest);
		
		try{
			noticeService.addNotice(noticeRequest, request);
	    } catch (Exception e) {
	        log.error("공지사항 수정 중 오류 발생", e);
	    }		
	return"redirect:/community/notice/noticeList";
	}
	@GetMapping("/community/notice/noticeOne")
    public String noticeOne(
    		@RequestParam("noticeNo") int noticeNo,
    		Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		String empName = null;
		String rankName = null;
		
	    if (emp != null) {
	        log.debug(TeamColor.PURPLE + "emp => " + emp);
	        empName = emp.getEmpName();
	        rankName = emp.getRankName();
	        
	        log.debug(TeamColor.PURPLE + "empName =>" + empName);
	        log.debug(TeamColor.PURPLE + "rankName=>" + rankName);
	    } else {
	        log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
	    }
   
		log.debug(TeamColor.PURPLE + "noticeOne.noticeNo=>" + noticeNo);
		
		List<Map<String, Object>> one = noticeService.getNoticeOne(noticeNo);
		log.debug(TeamColor.PURPLE + "noticeOne.one=>" + one);
		
		model.addAttribute("one", one);
		model.addAttribute("empName", empName);
		model.addAttribute("rankName", rankName);
		
    return "/community/notice/noticeOne"; 
    }
	//공지사항 수정
	@GetMapping("/community/notice/modifyNotice")
	public String modifyNotice(@RequestParam("noticeNo") int noticeNo,
				Model model) {
		log.debug(TeamColor.PURPLE + "changeNotice.noticeNo=>" + noticeNo);
		
		List<Map<String, Object>> one = noticeService.getNoticeOne(noticeNo);
		log.debug(TeamColor.PURPLE + "noticeOne.one=>" + one);
		
		model.addAttribute("one", one);
		return "/community/notice/modifyNotice";
	}
	//공지사항 수정액션
	@PostMapping("/community/notice/modifyNoticeAction")
	public String modifyNoticeAction(@RequestParam("noticeNo") int noticeNo,
			NoticeRequest noticeRequest, HttpServletRequest request) {
		log.debug(TeamColor.PURPLE + "noticeRequest뭘로들어오나=>" + noticeRequest);
		log.debug(TeamColor.PURPLE + "file값 있는지확인=>" + noticeRequest.getFiles());
		
	  try{
	        noticeService.getModifyNoticeList(noticeNo, noticeRequest, request);
	    } catch (Exception e) {
	        log.error("공지사항 수정 중 오류 발생", e);
	    }
		
	    return "redirect:/community/notice/noticeOne?noticeNo=" + noticeNo;
	}
	
	//공지사항 파일삭제
	@PostMapping("/deleteNoticeFile")
	public String deleteNoticeFile(@RequestParam("file") String fileName, 
			@RequestParam("noticeNo") int noticeNo) {
	    
	    noticeService.getDeleteNoticeFile(fileName, noticeNo);
	    
	    return "redirect:/community/notice/modifyNotice?noticeNo=" + noticeNo;
	}
	
	//공지사항 삭제
	@PostMapping("/community/notice/deleteNotice")
	public String deleteNotice(@RequestParam("noticeNo") int noticeNo) {
		log.debug(TeamColor.PURPLE + "delete.noticeNo=>" + noticeNo);
		
		noticeService.getDeleteNotice(noticeNo);
	return"redirect:/community/notice/noticeList";
	}
}
