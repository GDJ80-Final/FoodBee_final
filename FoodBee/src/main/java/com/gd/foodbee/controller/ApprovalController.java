package com.gd.foodbee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalController {
	
	@GetMapping("/approval/addBasicDraft")
	public String addBasicDraft() {
		
		return "/approval/addBasicDraft";
	}
}	
