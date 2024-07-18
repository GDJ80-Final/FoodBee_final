package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.MsgRecipientDTO;

@Mapper
public interface MsgRecipientMapper {
	//쪽지 수신자
	//파라미터 : MsgRecipientDTO
	//반환값 : int
	//사용서비스 : MsgService.addNewMsg
	int insertMsgRecipient(MsgRecipientDTO msgRecipientDTO);
}
