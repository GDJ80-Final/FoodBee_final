package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.MsgDTO;

@Mapper
public interface MsgMapper {
	
	//쪽지쓰기
	//파라미터 :MsgDTO
	//반환값 : int
	//사용클래스 :MsgService.addNewMsg
	int insertMsg(MsgDTO msgDTO);
	
	
	//받은쪽지함
	//파라미터 :  int empNo,int beginRow,int rowPerPage
	//반환값 : List
	//사용클래스 : MsgService.getReceivedMsgList
	List<Map<String,Object>> selectReceivedMsgList(int empNo,int beginRow,int rowPerPage,String readYN);
	
	//받은쪽지함 전체 갯수
	//파라미터 : X
	//반환값 : int
	//사용 클래스 : MsgService.getReceivedMsgList
	int selectCntReceivedMsg();
	
	//받은쪽지함에서 휴지통으로 이동
	//파라미터 : int msgNo
	//반환값 : int
	//사용클래스: MsgService.toTrash
	int updateMsgToTrash(int msgNo);
	
	//보낸쪽지함
	//파라미터 : int empNo,int beginRow,int rowPerPage
	//반환값 : List
	//사용클래스 : MsgService.getSentMsgList
	List<Map<String,Object>> selectSentMsgList(int empNo,int beginRow, int rowPerPage,String readYN);
	
	//휴지통
	//파라미터 : int empNo
	//반환값 : List
	//사용클래스 : MsgService.getTrashList
	List<Map<String,Object>> selectTrashMsgList(int empNo);
	
	//쪽지 상세보기
	//파라미터 : int msgNo
	//반환값 : Map
	//사용클래스 : MsgService.getMsgOne
	Map<String,Object> selectMsgOne(int msgNo);
	//휴지통에서 쪽지함으로 이동 
	//파라미터 : int msgNo
	//반환값 : int
	//사용클래스: MsgService.toMsgBox
	int updateMsgToMsgBox(int msgNo);
	
}
