package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.MsgFileDTO;

@Mapper
public interface MsgFileMapper {
	
	// 쪽지쓰기시 파일첨부
	// 파라미터 : MsgFileDTO msgFileDTO
	// 반환 값 : int
	// 사용 클래스 : MsgService.addNewMsg
	int insertMsgFile(MsgFileDTO msgFileDTO);
}
