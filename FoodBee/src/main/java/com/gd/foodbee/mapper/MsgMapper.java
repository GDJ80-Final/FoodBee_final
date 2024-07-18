package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;

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
	List<HashMap<String,Object>> selectReceivedMsgList(int empNo,int beginRow,int rowPerPage,String readYN);
	
	//받은쪽지함 전체 갯수
	//파라미터 : X
	//반환값 : int
	//사용 클래스 : MsgService.getReceivedMsgList
	int selectCntReceivedMsg();
	
	
}
