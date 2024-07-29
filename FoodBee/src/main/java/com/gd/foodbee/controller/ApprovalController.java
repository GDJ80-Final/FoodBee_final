package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.foodbee.dto.DraftDocRequestDTO;
import com.gd.foodbee.service.DraftDocService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalController {
	
	@Autowired
	private DraftDocService draftDocService;
	
	
	// 각 기안서 추가 
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /approval/forms/revenueForm,basic,dayOff,businessTripForm, chargeForm
	@GetMapping("/approval/forms/revenueForm")
	public String revenueForm() {
		
		return "/approval/forms/revenueForm";
	}
	@GetMapping("/approval/forms/basicForm")
	public String basicForm() {
		
		return "/approval/forms/basicForm";
	}
	@GetMapping("/approval/forms/dayOffForm")
	public String dayOffForm() {
		
		return "/approval/forms/dayOffForm";
	}
	@GetMapping("/approval/forms/businessTripForm")
	public String businessTripForm() {
		
		return "/approval/forms/businessTripForm";
	}
	@GetMapping("/approval/forms/chargeForm")
	public String chargeForm() {
		
		return "/approval/forms/chargeForm";
	}
	
	
	// 새 기안서 추가 
	// 파라미터  : DraftDocRequestDTO draftDocRequestDTO
	// 반환 값 : String(view)
	// 사용 페이지 : /approval/addDraft
	@PostMapping("/approval/addDraft")
	public String addDraft(DraftDocRequestDTO draftDocRequestDTO) {
		
		log.debug(TeamColor.YELLOW + "draftDocRequestDTO =>" + draftDocRequestDTO.toString());
		
		draftDocService.addDraftDoc(draftDocRequestDTO);
		
		return "redirect:/approval/draftBox";
		
	}
}	
