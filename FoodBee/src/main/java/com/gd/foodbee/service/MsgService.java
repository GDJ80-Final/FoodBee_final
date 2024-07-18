package com.gd.foodbee.service;


import java.util.HashMap;
import java.util.List;

import com.gd.foodbee.dto.MsgRequestDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface MsgService {
	
	//새 쪽지 작성
	//파라미터 : MsgDTO msgDTO, MsgRepicientDTO msgRepicientDTO, MsgFileDTO msgFileDTO,HttpServletRequest request
	//반환값 : X
	//사용 클래스 : MsgController.addMsg
	void addMsg(MsgRequestDTO msgRequestDTO,HttpServletRequest request);
	
	//받은쪽지함
	//파라미터 : int currentPage, int empNo
	//반환값 : List
	List<HashMap<String,Object>> getReceivedMsgList(int currentPage,int empNo,String readYN);
	
}
