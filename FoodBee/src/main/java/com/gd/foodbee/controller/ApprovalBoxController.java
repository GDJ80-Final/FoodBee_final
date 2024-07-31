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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;
import com.gd.foodbee.dto.DocReferrerDTO;
import com.gd.foodbee.dto.DraftDocDTO;
import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.ApprovalBoxService;
import com.gd.foodbee.service.ApprovalSignService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalBoxController {
	
	@Autowired
	private ApprovalBoxService approvalBoxService;
	
	@Autowired
	private ApprovalSignService approvalSignService;
	
	// 결재함
	// 파라미터 : int currentPage, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 
	@GetMapping("/approval/approvalBox")
	public String approvalBox(@RequestParam(name="currentPage", defaultValue="1") int currentPage,
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
		//결재함 StateBox
        ApprovalBoxStateDTO stateBox = approvalBoxService.getStateBox(empNo);
        if (stateBox == null) {
            stateBox = ApprovalBoxStateDTO.builder()
            		.zeroState(0)
            		.oneState(0)
            		.twoState(0)
            		.nineState(0)
            		.build();
        }
        //미결 총갯수
        int countZeroState = approvalBoxService.countZeroState(empNo);
        //기결 총갯수
        int countOneState = approvalBoxService.countOneState(empNo);
        
        log.debug(TeamColor.PURPLE + "stateBox=>" + stateBox);
        log.debug(TeamColor.PURPLE + "countZeroState=>" + countZeroState);
        log.debug(TeamColor.PURPLE + "countOneState=>" + countOneState);
        
        model.addAttribute("empNo", empNo);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("stateBox", stateBox);
        model.addAttribute("countZeroState", countZeroState);
        model.addAttribute("countOneState", countOneState);
        
		return"/approval/approvalBox";
	}
	
	// 결재함 전체 리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : Map<>allList
	// 사용페이지 : /approval/approvalBox
	@GetMapping("/approval/approvalList")
	@ResponseBody
	public Map<String,Object>approvalListAll(int currentPage, int empNo){
		
		//전체 결재함 리스트
		List<ApprovalBoxDTO> approvalList = approvalBoxService.getApprovalListAll(currentPage, empNo);
		//마지막 페이지 
		int allLastPage = approvalBoxService.getAllLastPage(empNo);
		
		log.debug(TeamColor.PURPLE + "approvalList=>" + approvalList);
		log.debug(TeamColor.PURPLE + "allLastPage=>" + allLastPage);
		
		Map<String,Object> allList = new HashMap<String,Object>();
		allList.put("approvalList", approvalList);
		allList.put("allLastPage", allLastPage);
		
		return allList;
	}
	//결재함 미결 리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : Map<>allZeroList
	//사용페이지
	@GetMapping("/approval/approvalZeroList")
	@ResponseBody
	public Map<String,Object>approvalZeroList(int currentPage, int empNo){
		
		//전체 미결 리스트
		List<ApprovalBoxDTO> zeroListAll = approvalBoxService.getZeroListAll(currentPage, empNo);
		// 미결 마지막페이지
		int zeroLastPage = approvalBoxService.getZeroLastPage(empNo);
		
		log.debug(TeamColor.PURPLE + "zeroListAll=>" + zeroListAll);
		log.debug(TeamColor.PURPLE + "zeroLastPage=>" + zeroLastPage);
		
		Map<String,Object> allZeroList = new HashMap<String,Object>();
		allZeroList.put("zeroListAll", zeroListAll);
		allZeroList.put("zeroLastPage", zeroLastPage);
		
		return allZeroList;
	}
	//결재함 기결 리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : Map<>OneZeroList
	//사용페이지
	@GetMapping("/approval/approvalOneList")
	@ResponseBody
	public Map<String,Object>approvalOneList(int currentPage, int empNo){
		//전체 기결 리스트
		List<ApprovalBoxDTO> oneListAll = approvalBoxService.getOneListAll(currentPage, empNo);
		//기결 마지막페이지
		int oneLastPage = approvalBoxService.getOneLastPage(empNo);
		
		log.debug(TeamColor.PURPLE + "oneListAll=>" + oneListAll);
		log.debug(TeamColor.PURPLE + "oneLastPage=>" + oneLastPage);
		
		Map<String,Object> allOneList = new HashMap<String,Object>();
		allOneList.put("oneListAll", oneListAll);
		allOneList.put("oneLastPage", oneLastPage);
		
		return allOneList;
	}
	// 매출보고 상세보기페이지
	// 파라미터 : int draftDocNo
	// 반환값 : String(view)
	// 사용페이지 
	@GetMapping("/approval/revenueOne")
	public String revenueOne(@RequestParam("draftDocNo") int draftDocNo,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = emp.getEmpNo();

		// 기안서상세, detail, 파일
        Map<String,Object> revenueOne = approvalBoxService.getDocOne(draftDocNo);
        List<DraftDocDetailDTO> revenueDetailOne = approvalBoxService.getDocDetailList(draftDocNo);
        List<DraftDocFileDTO> revenueFileOne = approvalBoxService.getDocFileOne(draftDocNo);
        Map<String,Object> revenueReferrer = approvalBoxService.getDocReferrerOne(draftDocNo);
        
        log.debug(TeamColor.PURPLE + "revenueOne=>" + revenueOne);
        log.debug(TeamColor.PURPLE + "revenueDetailOne=>" + revenueDetailOne);
        log.debug(TeamColor.PURPLE + "revenueFileOne=>" + revenueFileOne);
		
        model.addAttribute("empNo", empNo);
        model.addAttribute("revenueOne", revenueOne);
        model.addAttribute("revenueDetailOne", revenueDetailOne);
        model.addAttribute("revenueFileOne", revenueFileOne);
        model.addAttribute("refenueReferrer", revenueReferrer);
        
		return "/approval/revenueOne";
	}
	// 휴가신청 상세보기페이지
	// 파라미터 : int draftDocNo, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 
	@GetMapping("/approval/dayOffOne")
	public String dayOffOne(@RequestParam("draftDocNo") int draftDocNo,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = emp.getEmpNo();

		// 기안서상세, detail, 파일
        Map<String,Object> dayOffOne = approvalBoxService.getDocOne(draftDocNo);
        DraftDocDetailDTO dayOffDetailOne = approvalBoxService.getDocDetailOne(draftDocNo);
        List<DraftDocFileDTO> dayOffFileOne = approvalBoxService.getDocFileOne(draftDocNo);
        Map<String,Object> dayOffReferrer = approvalBoxService.getDocReferrerOne(draftDocNo);
        
        log.debug(TeamColor.PURPLE + "dayOffReferrer=>" + dayOffReferrer);
        log.debug(TeamColor.PURPLE + "dayOffOne=>" + dayOffOne);
        log.debug(TeamColor.PURPLE + "dayOffDetailOne=>" + dayOffDetailOne);
        log.debug(TeamColor.PURPLE + "dayOffFileOne=>" + dayOffFileOne);
		
        model.addAttribute("empNo", empNo);
        model.addAttribute("dayOffOne", dayOffOne);
        model.addAttribute("dayOffDetailOne", dayOffDetailOne);
        model.addAttribute("dayOffFileOne", dayOffFileOne);
        model.addAttribute("dayOffReferrer", dayOffReferrer);
        
		return "/approval/dayOffOne";
	}
	// 출장신청 상세보기페이지
	// 파라미터 : int draftDocNo, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 
	@GetMapping("/approval/businessTripOne")
	public String businessTripOne(@RequestParam("draftDocNo") int draftDocNo,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = emp.getEmpNo();

		// 기안서상세, detail, 파일
        Map<String,Object> businessTripOne = approvalBoxService.getDocOne(draftDocNo);
        DraftDocDetailDTO businessTripDetailOne = approvalBoxService.getDocDetailOne(draftDocNo);
        List<DraftDocFileDTO> businessTripFileOne = approvalBoxService.getDocFileOne(draftDocNo);
        Map<String,Object> businessTripReferrer = approvalBoxService.getDocReferrerOne(draftDocNo);
        
        log.debug(TeamColor.PURPLE + "empNo=>" + empNo);
        log.debug(TeamColor.PURPLE + "businessTripOne=>" + businessTripOne);
        log.debug(TeamColor.PURPLE + "businessTripDetailOne=>" +  businessTripDetailOne);
        log.debug(TeamColor.PURPLE + "businessTripFileOne=>" + businessTripFileOne);
		
        model.addAttribute("empNo", empNo);
        model.addAttribute("businessTripOne", businessTripOne);
        model.addAttribute("businessTripDetailOne",  businessTripDetailOne);
        model.addAttribute("businessTripFileOne", businessTripFileOne);
        model.addAttribute("businessTripReferrer", businessTripReferrer);
        
		return "/approval/businessTripOne";
	}
	// 기본기안서 상세보기페이지
	// 파라미터 : int draftDocNo Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지 
	@GetMapping("/approval/basicFormOne")
	public String docOne(@RequestParam("draftDocNo") int draftDocNo,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = emp.getEmpNo();

		// 기안서상세, detail,수신자, 파일
        Map<String,Object> basicFormOne = approvalBoxService.getDocOne(draftDocNo);
        DraftDocDetailDTO basicFormDetailOne = approvalBoxService.getDocDetailOne(draftDocNo);
        List<DraftDocFileDTO> basicFormFileOne = approvalBoxService.getDocFileOne(draftDocNo);
        Map<String,Object> basicReferrerOne = approvalBoxService.getDocReferrerOne(draftDocNo);
        
        log.debug(TeamColor.PURPLE + "basicFormOne=>" + basicFormOne);
        log.debug(TeamColor.PURPLE + " basicFormDetailOne=>" + basicFormDetailOne);
        log.debug(TeamColor.PURPLE + "basicFormFileOne=>" + basicFormFileOne);
        log.debug(TeamColor.PURPLE + "basicReferrerOne=>" + basicReferrerOne);
		
        model.addAttribute("basicFormOne", basicFormOne);
        model.addAttribute("basicFormDetailOne", basicFormDetailOne);
        model.addAttribute("basicFormFileOne", basicFormFileOne);
        model.addAttribute("basicReferrerOne", basicReferrerOne); 
        model.addAttribute("empNo", empNo);
        
		return"/approval/basicFormOne";
	}
	// 지출결의 상세보기페이지
	// 파라미터 : int draftDocNo, Model model, HttpSession session
	// 반환값 : String(view)
	// 사용페이지
	@GetMapping("/approval/chargeOne")
	public String chargeOne(@RequestParam("draftDocNo") int draftDocNo,
			Model model, HttpSession session) {
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = emp.getEmpNo();

		// 기안서상세, detail, 파일
        Map<String,Object>chargeOne = approvalBoxService.getDocOne(draftDocNo);
        List<DraftDocDetailDTO> chargeDetailOne = approvalBoxService.getDocDetailList(draftDocNo);
        List<DraftDocFileDTO> chargeFileOne = approvalBoxService.getDocFileOne(draftDocNo);
        Map<String,Object> chargeReferrer = approvalBoxService.getDocReferrerOne(draftDocNo);
        
        log.debug(TeamColor.PURPLE + "chargeOne=>" + chargeOne);
        log.debug(TeamColor.PURPLE + "chargeDetailOne=>" + chargeDetailOne);
        log.debug(TeamColor.PURPLE + "chargeFileOne=>" + chargeFileOne);
		
        model.addAttribute("empNo", empNo);
        model.addAttribute("chargeOne", chargeOne);
        model.addAttribute("chargeDetailOne", chargeDetailOne);
        model.addAttribute("chargeFileOne", chargeFileOne);
        model.addAttribute("chargeReferrer", chargeReferrer);
        
		return "/approval/chargeOne";
	}
	// 중간승인 업데이트
	// 파라미터 : int draftDocNo
	// 반환값 : /approval/approvalBox
	// 사용페이지 
	@GetMapping("/approval/updateMidState")
	public String updateMidApprove(@RequestParam("draftDocNo") int draftDocNo) {
		
		approvalBoxService.updateMidState(draftDocNo);
		
		return "redirect:/approval/approvalBox";
	}
	
	// 최종승인 업데이트
	// 파라미터 : int draftDocNo
	// 반환값 : String view(approvalBox)
	// 사용페이지
	@GetMapping("/approval/updateFinalState")
	public String updateFinalApprove(@RequestParam("draftDocNo") int draftDocNo) {
		log.debug(TeamColor.PURPLE + "draftDocNo="+ draftDocNo);
		
		approvalBoxService.updateFinalState(draftDocNo);
		
		return"redirect:/approval/approvalBox";
	}
	
	// 중간반려 업데이트
	// 파라미터 : int draftDocNo
	// 반환값 : /approval/approvalBox
	@PostMapping("/approval/updateMidRejection")
	public String updateMidRejection(@RequestParam("draftDocNo") int draftDocNo,
			@RequestParam("rejectionReason") String rejectionReason) {
		log.debug(TeamColor.PURPLE + "rejectionReason=>" + rejectionReason);
		
		
		approvalBoxService.updateMidRejection(draftDocNo, rejectionReason);
		
		return "redirect:/approval/approvalBox";
	}
	
	// 최종반려 업데이트
	// 파라미터 : int draftDocNo
	// 반환값 : /approval/approvalBox
	// 사용페이지 
	@PostMapping("/approval/updateFinalRejection")
	public String updateFinalRejection(@RequestParam("draftDocNo") int draftDocNo,
			@RequestParam("rejectionReason") String rejectionReason) {
		log.debug(TeamColor.PURPLE + "rejectionReason=>" + rejectionReason);
		
		
		approvalBoxService.updateFinalRejection(draftDocNo, rejectionReason);
		
		return"redirect:/approval/approvalBox";
	}
	
	// 최종승인
	// 파라미터 : int draftDocNo
	// 반환값 : /approval/approvalBox
	// 사용페이지 
	@GetMapping("/approval/updateTripFinalState")
	public String updateFinalState(@RequestParam("draftDocNo") int draftDocNo) {
		log.debug(TeamColor.PURPLE + "draftDocNo=>" + draftDocNo);
		
		approvalBoxService.updateFinalState(draftDocNo);		
		
		return"redirect:/approval/approvalBox";
	}
}
