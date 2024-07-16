package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;

@Mapper
public interface RoomMapper {
	
	// 회의실 목록
	List<RoomDTO> selectRoomList();
	
	// 회의실 상세보기 및 예약폼
	RoomDTO selectRoomOne(int roomNo); 
	
	// 회의실 예약
	int insertRoomRsv(RoomRsvDTO rsv);
	
	// 선택한 룸번호, 날짜에 예약된 시간을 출력
	List<RoomRsvDTO> selectReservedTimes(int roomNo, String rsvDate);
	
	// 선택된 날짜별 전체 예약리스트 출력
	List<RoomRsvDTO> selectRsvListByDate(HashMap<String,Object> m);
	
	// 선택된 날짜 예약 총 갯수
	int selectRsvCntByDate(String rsvDate);
	
	// 내 예약리스트 출력
	List<RoomRsvDTO> selectRsvListByEmpNo(HashMap<String,Object> m);
	
	// 내 예약 총 갯수
	int selectRsvCntByEmpNo(int empNo);
	
	// 회의실 번호, 선택된 날짜에 예약된 시간을 출력
	List<Map<String, Object>> selectReservedTime(int roomNo, String rsvDate);
	
	// 예약 취소
	int updateRoomRsv(RoomRsvDTO rsv);
}
