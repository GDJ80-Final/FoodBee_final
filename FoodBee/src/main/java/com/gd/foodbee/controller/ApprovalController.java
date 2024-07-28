package com.gd.foodbee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalController {
	
	@GetMapping("/approval/addDraft")
	public String addBasicDraft() {
		
		return "/approval/addDraft";
	}
}	
