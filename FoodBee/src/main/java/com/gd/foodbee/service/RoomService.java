package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;

public interface RoomService {
	List<RoomDTO> getRoomList();
	RoomDTO getRoomOne(int roomNo);
	int addRoomRsv(RoomRsvDTO rsv);
	// 선택한 날짜에 예약된 시간을 출력
	List<RoomRsvDTO> getReservedTimes(String rsvDate);
	// 선택된 날짜별 전체 예약리스트 출력
	List<RoomRsvDTO> getRsvListByDate(String rsvDate);
	// 내 예약리스트 출력
	List<RoomRsvDTO> getRsvListByEmpNo(String empNo);

}
