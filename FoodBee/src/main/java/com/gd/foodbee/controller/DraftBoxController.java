package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.DraftBoxDTO;
import com.gd.foodbee.dto.DraftBoxStateDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.DraftBoxService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DraftBoxController {
	@Autowired DraftBoxService draftBoxService;
	
	//기안함
	@GetMapping("/approval/draftBox")
	public String draftBox(
			@RequestParam(name="currentPage", defaultValue="1") int currentPage,
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
	    
		
		DraftBoxStateDTO stateBox = draftBoxService.getStateBox(empNo);
		log.debug(TeamColor.PURPLE + "stateBox=>"+stateBox);
		model.addAttribute("empNo", empNo);
		model.addAttribute("stateBox",stateBox);
		
		
		return "/approval/draftBox";
	}
	//기안서 전체보기
	@GetMapping("/approval/allDocList")
	@ResponseBody
	public Map<String,Object> allDocList(int currentPage, int empNo) {
	
		List<DraftBoxDTO> allDocList = draftBoxService.getAllDocList(currentPage, empNo);
		log.debug(TeamColor.PURPLE + "allDocList=>" + allDocList);
		//마지막 페이지자리
		int allDocLastPage = draftBoxService.getAllDocLastPage(empNo);
		log.debug(TeamColor.PURPLE + "allDocLastPage=>" + allDocLastPage);
		
		Map<String,Object> docList = new HashMap<String,Object>();
		docList.put("allDocList", allDocList);
		docList.put("allDocLastPage", allDocLastPage);
		
		return docList;
	}
	//결재대기상태 리스트
	@GetMapping("/approval/zeroDocList")
	@ResponseBody
	public Map<String,Object> zeroDocList(int currentPage, int empNo){
		
		//결재대기 기안서리스트
		List<DraftBoxDTO> zeroDocList = draftBoxService.getZeroDocList(currentPage, empNo);
		log.debug(TeamColor.PURPLE + "zeroDocList=>" + zeroDocList);
		//마지막 페이지자리
		int zeroDocLastPage = draftBoxService.getZeroDocLastPage(empNo);
		log.debug(TeamColor.PURPLE + "zeroDocLastPage=>" + zeroDocLastPage);
		
		Map<String,Object>zeroTypeList = new HashMap<String,Object>();
		zeroTypeList.put("zeroDocList", zeroDocList);
		zeroTypeList.put("zeroDocLastPage", zeroDocLastPage);
		
		return zeroTypeList;
	}
	//승인중상태 리스트
	@GetMapping("/approval/oneDocList")
	@ResponseBody
	public Map<String,Object> oneDocList(int currentPage, int empNo){
		
		//승인중 기안서리스트
		List<DraftBoxDTO> oneDocList = draftBoxService.getOneDocList(currentPage, empNo);
		
		Map<String,Object>oneTypeList = new HashMap<String,Object>();
		oneTypeList.put("oneDocList", oneDocList);
		
		return oneTypeList;
	}
	//승인완료상태 리스트
	@GetMapping("/approval/twoDocList")
	@ResponseBody
	public Map<String,Object> twoDocList(int currentPage, int empNo){
		
		//승인중 기안서리스트
		List<DraftBoxDTO> twoDocList = draftBoxService.getTwoDocList(currentPage, empNo);
		log.debug(TeamColor.PURPLE + "twoDocList=>" + twoDocList);
		
		Map<String,Object>twoTypeList = new HashMap<String,Object>();
		twoTypeList.put("twoDocList", twoDocList);
		
		return twoTypeList;
	}
	//반려상태 리스트
	@GetMapping("/approval/nineDocList")
	@ResponseBody
	public Map<String,Object> nineDocList(int currentPage, int empNo){
		
		//승인중 기안서리스트
		List<DraftBoxDTO> nineDocList = draftBoxService.getNineDocList(currentPage, empNo);
		log.debug(TeamColor.PURPLE + "nineDocList=>" + nineDocList);
		
		Map<String,Object>nineTypeList = new HashMap<String,Object>();
		nineTypeList.put("nineDocList", nineDocList);
		
		return nineTypeList;
	}
}
