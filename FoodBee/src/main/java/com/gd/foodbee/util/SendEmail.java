package com.gd.foodbee.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.gd.foodbee.dto.EmailDTO;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SendEmail {
	
	@Autowired
	private JavaMailSender javaMailSender;

	public String sendEmail(EmailDTO emailDTO) {
		try {
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			
			
			
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	        mimeMessageHelper.setTo(emailDTO.getTo()); // 메일 수신자
            mimeMessageHelper.setSubject(emailDTO.getSubject()); // 메일 제목
            mimeMessageHelper.setText(emailDTO.getMessage(), true); // 메일 본문 내용, HTML 여부
            javaMailSender.send(mimeMessage);

            log.debug(TeamColor.RED + "메일 발송 성공");

            return "success";

			} catch (MessagingException e) {
				log.debug(TeamColor.RED + "메일 발송 실패");
				throw new RuntimeException(e);
	        }
		
	}
}
