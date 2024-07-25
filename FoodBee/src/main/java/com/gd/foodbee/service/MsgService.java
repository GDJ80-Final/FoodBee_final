package com.gd.foodbee.service;



import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.MsgRequestDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface MsgService {
	
	//새 쪽지 작성
	void addMsg(MsgRequestDTO msgRequestDTO,HttpServletRequest request, int empNo);
	
	//받은쪽지함
	List<Map<String,Object>> getReceivedMsgList(int currentPage,int empNo,String readYN);
	
	//보낸쪽지함
	List<Map<String,Object>> getSentMsgList(int currentPage, int empNo, String readYN);
	
	//쪽지 휴지통으로 보내기 >>발신자 
	void toTrash(int [] msgNos);
	
	//쪽지 휴지통으로 보내기 >>수신자
	void toTrashRecipient(int[] msgNos,int empNo);
	
	//휴지통 리스트
	List<Map<String,Object>> getTrashList(int empNo);
	
	//휴지통 -> 쪽지함 이동 
	void updatetoMsgBox(int [] msgNos,int empNo,String [] results);
	
	//쪽지 상세보기
	Map<String,Object> getMsgOne(int msgNo);
	
	//쪽지 완전삭제
	void deleteMsg(int [] msgNos,int empNo,String [] results);
	
	//쪽지 읽음 여부 업데이트
	void updateReadState(int msgNo,int empNo);
	
}
