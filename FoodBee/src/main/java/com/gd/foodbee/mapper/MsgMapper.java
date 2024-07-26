package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.MsgDTO;

@Mapper
public interface MsgMapper {
	
	// 쪽지쓰기
	// 파라미터 :MsgDTO
	// 반환 값 : int
	// 사용 클래스 :MsgService.addNewMsg
	int insertMsg(MsgDTO msgDTO);
	
	
	// 받은쪽지함
	// 파라미터 :  int empNo,int beginRow,int rowPerPage
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : MsgService.getReceivedMsgList
	List<Map<String,Object>> selectReceivedMsgList(int empNo,int beginRow,int rowPerPage,String readYN);
	
	
	// 받은쪽지함에서 휴지통으로 이동
	// 파라미터 : int msgNo
	// 반환 값 : int
	// 사용 클래스: MsgService.toTrash
	int updateMsgToTrash(int msgNo);
	
	// 보낸쪽지함
	// 파라미터 : int empNo,int beginRow,int rowPerPage
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : MsgService.getSentMsgList
	List<Map<String,Object>> selectSentMsgList(int empNo,int beginRow, int rowPerPage,String readYN);
	
	// 휴지통
	// 파라미터 : int empNo, int beginRow, int rowPerPage
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : MsgService.getTrashList
	List<Map<String,Object>> selectTrashMsgList(int empNo, int beginRow, int rowPerPage);
	
	// 쪽지 상세보기
	// 파라미터 : int msgNo
	// 반환 값 : Map<String,Object>
	// 사용 클래스 : MsgService.getMsgOne
	Map<String,Object> selectMsgOne(int msgNo);
	
	// 휴지통에서 쪽지함으로 이동 
	// 파라미터 : int msgNo
	// 반환 값 : int
	// 사용 클래스: MsgService.toMsgBox
	int updateMsgToMsgBox(int msgNo);
	
	// 쪽지 삭제 (state = 9로 업데이트)
	// 파라미터 : int msgNo
	// 반환 값 : int
	// 사용 클래스 : MsgService.deleteMsg
	int updateMsgDelete(int msgNo);
	
	// 쪽지 자동 삭제(스케줄러)
	// 파라미터 : X
	// 반환 값 : int
	// 사용 클래스 : ScheduleService.deleteMsgAuto
	int updateMsgDeleteAuto();
	
	// 받은 쪽지함 총 쪽지수 구하기
	// 파라미터 : String readYN,int empNo
	// 반환 값 : int
	// 사용 클래스 : MsgService.getLastPageReceivedBox
	int selectMsgCntReceivedBox(String readYN,int empNo);
	
	// 보낸 쪽지함 총 쪽지수 구하기
	// 파라미터 : String readYN,int empNo
	// 반환 값 : int
	// 사용 클래스 : MsgService.getLastPageSentBox
	int selectMsgCntSentBox(String readYN,int empNo);
	
	// 휴지통 총 쪽지수 구하기
	// 파라미터 : int empNo
	// 반환 값 : int
	// 사용 클래스 : MsgService.getLastPageTrashBox
	int selectMsgcntTrashBox(int empNo);
	
}
