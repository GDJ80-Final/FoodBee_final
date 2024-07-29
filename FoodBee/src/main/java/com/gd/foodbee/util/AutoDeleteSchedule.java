package com.gd.foodbee.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.mapper.MsgMapper;
import com.gd.foodbee.mapper.MsgRecipientMapper;




@Transactional
@Component
public class AutoDeleteSchedule {
	
	@Autowired
	private MsgMapper msgMapper;
	
	@Autowired
	private MsgRecipientMapper msgRecipientMapper;
	
	//cron = "초 분 시 일 월 년"
	//매일 자정에 스케쥴러 실행
	@Scheduled(cron= "0 0 0 * * *",zone="Asia/Seoul")
	public void deleteMsgAuto() {
		
		msgMapper.updateMsgDeleteAuto();
		System.out.println(TeamColor.YELLOW + "deleteMsgAuto 스케쥴러 실행완료");
		

	}
	
	@Scheduled(cron="0 0 0 * * *",zone="Asia/Seoul")
	public void deleteMsgAutoRecipient() {
		
		msgRecipientMapper.updateMsgDeleteAuto();
		System.out.println(TeamColor.YELLOW + "deleteMsgAutoRecipient 스케쥴러 실행완료");
	}
	
}
