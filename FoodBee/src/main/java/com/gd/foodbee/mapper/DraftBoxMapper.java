package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftBoxDTO;
import com.gd.foodbee.dto.DraftBoxStateDTO;

@Mapper
public interface DraftBoxMapper {
	// 전체 기안서리스트
	// 파라미터 : "Map"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxDTO"
	// 사용 : DraftBoxService.getAllDocList
	List<DraftBoxDTO> allDocList(int empNo, int beginRow, int rowPerPage);
	
	// 결재대기리스트
	// 파라미터 : "Map"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxDTO"
	// 사용 : DraftBoxService.getZeroDocList
	List<DraftBoxDTO> zeroTypeDocList(int empNo, int beginRow, int rowPerPage);
	
	// 결재승인중리스트
	// 파라미터 : "Map"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxDTO"
	// 사용 : DraftBoxService.getOneDocList
	List<DraftBoxDTO> oneTypeDocList(int empNo, int beginRow, int rowPerPage);
	
	// 결재승인완료리스트
	// 파라미터 : "Map"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxDTO"
	// 사용 : DraftBoxService.getTwoDocList
	List<DraftBoxDTO> twoTypeDocList(int empNo, int beginRow, int rowPerPage);
	
	// 결재반려상태리스트
	// 파라미터 : "Map"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxDTO"
	// 사용 : DraftBoxService.getNineDocList
	List<DraftBoxDTO> nineTypeDocList(int empNo, int beginRow, int rowPerPage);
	
	// 결재상태들의 총갯수
	// 파라미터 : "int"
	// 반환값 : "com.gd.foodbee.dto.DraftBoxStateDTO"
	DraftBoxStateDTO getStateBox(int empNo);
}