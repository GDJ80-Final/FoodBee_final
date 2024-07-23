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
	
	//수신자 -> 휴지통에서 쪽지함으로 복구 
	//파라미터 : Map-> int msgNo,int empNo
	//반환값 : int
	//사용서비스 :MsgService.toMsgBox
	int updatetoMsgBoxRecipient(int msgNo,int empNo);
	
	//쪽지 삭제 (state = 9로 업데이트)
	//파라미터 : int msgNo, int empNo;
	//반환값 : int
	//사용클래스 : MsgService.deleteMsg
	int updateMsgDelete(int msgNo,int empNo);
	
	//읽음여부 업데이트 (N -> Y)
	//파라미터 : int msgNo, int empNo
	//반환값 : int
	//사용클래스 : MsgService.updateReadState
	int updateReadYN(int msgNo,int empNo);
	
	
}
