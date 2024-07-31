package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.DraftDocRequestDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.DraftDocService;
import com.gd.foodbee.service.GroupService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalController {
	
	@Autowired
	private DraftDocService draftDocService;
	
	@Autowired
	private GroupService groupService;
	
	// 각 기안서 추가 
	// 파라미터 : HttpSession session
	// 반환 값 : Map<String,Object>
	// 사용 페이지 : /approval/forms/commonForm
	@GetMapping("/approval/forms/commonForm")
	@ResponseBody
	public Map<String,Object> commonForm(HttpSession session) {
		
		//세션에서 값 구해서 기안자 이름 + 부서이름 넣어주기 
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		String empName = emp.getEmpName();
		log.debug(TeamColor.YELLOW + "empName" + empName);
		String dptNo = emp.getDptNo();
		
		String dptName = groupService.getDptName(dptNo);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("empNo", empNo);
		map.put("empName", empName); 
		map.put("dptName", dptName); 

		
		
		return map;
	}
	
	// 각 기안서 추가 
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /approval/forms/revenueForm,basic,dayOffForm,businessTripForm, chargeForm
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
	
	// 기안서 수정
	// 파라미터 :
	@PostMapping("/approval/modifyDraft")
	public String modifyDraft(DraftDocRequestDTO draftDocRequestDTO,
				@RequestParam(name = "draftDocNo") int draftDocNo) {
		
		log.debug(TeamColor.RED + "draftDocRequestDTO =>" + draftDocRequestDTO.toString());
		log.debug(TeamColor.RED + "draftDocNo =>" + draftDocNo);
		
		draftDocService.modifyDraftDoc(draftDocRequestDTO, draftDocNo);
		
		return "redirect:/approval/draftBox";
	
	}
}	
