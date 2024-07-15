package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;

public interface RoomService {
	
	// 회의실 목록
	List<RoomDTO> getRoomList();
	
	// 회의실 상세보기 및 예약폼
	RoomDTO getRoomOne(int roomNo);
	
	// 회의실 예약
	int addRoomRsv(RoomRsvDTO rsv);
	
	// 선택한 룸번호, 날짜에 예약된 시간을 출력
	List<RoomRsvDTO> getReservedTimes(int roomNo, String rsvDate);
	
	// 선택된 날짜별 전체 예약리스트 출력
	List<RoomRsvDTO> getRsvListByDate(String rsvDate);
	
	// 내 예약리스트 출력
	List<RoomRsvDTO> getRsvListByEmpNo(String empNo);
	
	// 회의실 번호, 선택된 날짜에 예약된 시간을 출력
	List<Map<String, Object>> getReservedTime(int roomNo, String rsvDate);
}
