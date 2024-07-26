package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;

@Mapper
public interface InBoxMapper {
	// 내 수신 전체 리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<InBoxDTO>
	// 사용클래스 : InBoxController.inbox
	List<InBoxDTO> getReferrerList(int empNo, int beginRow, int rowPerPage);
	
	// 결재상태 총갯수
	// 파라미터 : int empNo
	// 반환값 : InBoxStateDTO
	// 사용클래스 : 
	InBoxStateDTO getStateBox(int empNo);
}
