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
	
	//쪽지 휴지통으로 보내기 >>발신자 
	//파라미터 : int [] msgNos
	//반환값 : X
	//사용클래서 : MsgController.toTrash
	void toTrash(int [] msgNos);
	
	//쪽지 휴지통으로 보내기 >>수신자
	//파라미터 : int [] msgNos, int empNo
	//반환값 :X
	//사용클래스 : MsgController.toTrashRecipient
	void toTrashRecipient(int[] msgNos,int empNo);
	
	//휴지통 리스트
	//파라미터 : int empNo
	//반환값: List<Map<STring,Object>>
	//사용클래스 : MsgController.trashMsgBox
	List<Map<String,Object>> getTrashList(int empNo);
	
	
	//휴지통 -> 쪽지함 이동 
	//파라미터 : int[] msgNos,int empNo, String [] results
	//반환값 :X
	//사용클래스 : MsgController.toMsgBoxRecipient
	void updatetoMsgBox(int [] msgNos,int empNo,String [] results);
	
	//쪽지 상세보기
	//파라미터 : int msgNo
	//반환값 : Map<String,Object>
	//사용클래스 : MsgController.msgOne
	Map<String,Object> getMsgOne(int msgNo);
	
	//쪽지 완전삭제
	//파라미터 : int[] msgNos,int empNo, String [] results
	//반환값 : X
	//사용클래스 : MsgController.deleteMsg
	void deleteMsg(int [] msgNos,int empNo,String [] results);
	
	//쪽지 읽음 여부 업데이트
	//파라미터 : int msgNo, int empNo
	//반환값 : X
	//사용클래스 : MsgController.updateReadState
	void updateReadState(int msgNo,int empNo);
	
}
