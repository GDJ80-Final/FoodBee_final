package com.gd.foodbee.service;



import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.MsgRequestDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface MsgService {
	
	//새 쪽지 작성
	//파라미터 : MsgDTO msgDTO, MsgRepicientDTO msgRepicientDTO, MsgFileDTO msgFileDTO,HttpServletRequest request
	//반환값 : X
	//사용 클래스 : MsgController.addMsg
	void addMsg(MsgRequestDTO msgRequestDTO,HttpServletRequest request, int empNo);
	
	//받은쪽지함
	//파라미터 : int currentPage, int empNo
	//반환값 : List
	//사용 클래스 :MsgController.receivedMsgBox
	List<Map<String,Object>> getReceivedMsgList(int currentPage,int empNo,String readYN);
	
	//보낸쪽지함
	//파라미터 : int currentPate, int empNo, String readYN
	//반환값 : List
	//사용 클래스 : MsgController.sentMsgBox
	List<Map<String,Object>> getSentMsgList(int currentPage, int empNo, String readYN);
	
}
