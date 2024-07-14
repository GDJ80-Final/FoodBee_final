package com.gd.foodbee.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.mapper.EmpMapper;
import com.gd.foodbee.util.TeamColor;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class EmailServiceImpl implements EmailService{
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	// 인증번호 이메일 발송
	// 파라미터 : int empNo, EmailDTO emailDTO
	// 반환 값 : int
	// 사용 클래스 : LoginController.login
	@Override
	public int sendEmail(int empNo, EmailDTO emailDTO) {
		
		
		EmpDTO empDTO = empMapper.selectEmpByNoAndEmail(empNo, emailDTO.getTo());
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		
		if(empDTO != null) {
			
			Random random = new Random();
			int authNum = random.nextInt(9000) + 1000;
			//인증번호 생성 후 이메일 발송
			try {
		           MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
		           mimeMessageHelper.setTo(emailDTO.getTo()); // 메일 수신자
		           mimeMessageHelper.setSubject(emailDTO.getSubject()); // 메일 제목
		           mimeMessageHelper.setText("인증번호는 " + authNum + "입니다."); // 메일 본문 내용, HTML 여부
		           javaMailSender.send(mimeMessage);

		           log.debug(TeamColor.RED + "메일 발송 성공");

		           return authNum;

				} catch (MessagingException e) {
					log.debug(TeamColor.RED + "메일 발송 실패");
					throw new RuntimeException(e);
		        }
			
		}
		// empDTO가 없으면 사원번호나 이메일이 틀리다는 것이므로 틀렸다는 표시로 0을 넘김.
		return 0;
	}

}
