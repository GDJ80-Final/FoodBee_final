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
	
	//수신자 -> 쪽지 휴지통 이동
	//파라미터 : Map-> int msgNo,int empNo
	//반환값 : int
	//사용서비스 :MsgService.toTrashRecipient
	int updateMsgToTrash(int msgNo,int empNo);
}
