package com.gd.foodbee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {

	
	@GetMapping("/noAuthorityErrorPage")
	public String noAuthorityErrorPage() {
		
		return "noAuthorityErrorPage";
	}
}
