package com.gd.foodbee.service;

import com.gd.foodbee.dto.EmailDTO;

public interface EmailService {
	
	// 인증번호 메일 발송
	int sendEmail(int empNo, EmailDTO emailDTO);
}
