package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;

@Mapper
public interface RoomMapper {
	List<RoomDTO> selectRoomList();
	RoomDTO selectRoomOne(int roomNo); 
	int insertRoomRsv(RoomRsvDTO rsv);
	// 선택한 날짜에 예약된 시간을 출력
	List<RoomRsvDTO> selectReservedTimes(String rsvDate);
	// 선택된 날짜별 전체 예약리스트 출력
	List<RoomRsvDTO> selectRsvListByDate(String rsvDate);
	// 내 예약리스트 출력
	List<RoomRsvDTO> selectRsvListByEmpNo(String empNo);
}
