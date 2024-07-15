package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.mapper.RoomMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class RoomServiceImpl implements RoomService{
	@Autowired RoomMapper roomMapper;
	
	// 회의실 목록
	// 파라미터 : X
	// 반환 값 : RoomDTO
	// 사용 클래스 : RoomController.roomList
	@Override
	public List<RoomDTO> getRoomList() {
		
		return roomMapper.selectRoomList(); 
	}
	
	// 회의실 상세 및 예약 폼
	// 파라미터 : int roomNo
	// 반환 값 : RoomDTO
	// 사용 클래스 : RoomController.roomOne
	@Override
	public RoomDTO getRoomOne(int roomNo) {
		log.debug(TeamColor.GREEN+"roomNo:"+roomNo);
		
		return roomMapper.selectRoomOne(roomNo); 
	}
	
	// 회의실 얘약
	// 파라미터 : RoomRsvDTO
	// 사용 클래스 : RoomController.roomRsv
	@Override
	public int addRoomRsv(RoomRsvDTO rsv) {
		log.debug(TeamColor.GREEN+"rsv:"+rsv);
		
		return roomMapper.insertRoomRsv(rsv); 
	}
	
	// 선택한 룸번호, 날짜에 예약된 시간을 출력
	// 파라미터 : String rsvDate
	// 반환 값 : RoomRsvDTO
	// 사용 클래스 : RoomController.roomOne
	@Override
	public List<RoomRsvDTO> getReservedTimes(int roomNo, String rsvDate) {
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
		return roomMapper.selectReservedTimes(roomNo, rsvDate); 
	}
	
	// 선택된 날짜별 전체 예약리스트 출력
	// 파라미터 : String rsvDate
	// 반환 값 : RoomRsvDTO
	// 사용 클래스 : RoomController.roomRsvList
	@Override
	public List<RoomRsvDTO> getRsvListByDate(String rsvDate) {
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
		return roomMapper.selectRsvListByDate(rsvDate); 
	}
	
	// 내 예약리스트 출력
	@Override
	public List<RoomRsvDTO> getRsvListByEmpNo(String empNo) {
		log.debug(TeamColor.GREEN+"empNo:"+empNo);
		
		return roomMapper.selectRsvListByEmpNo(empNo); 
	}
	
	// 회의실 번호, 선택된 날짜에 예약된 시간을 출력
	// 파라미터 : int roomNo, String rsvDate
	// 반환 값 : String startTime, String endTime
	// 사용 클래스 : RoomRestController.getReservedTimes
	@Override
	public List<Map<String, Object>> getReservedTime(int roomNo, String rsvDate) {
		log.debug(TeamColor.GREEN+"roomNo:"+roomNo);
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
		return roomMapper.selectReservedTime(roomNo, rsvDate); 
	}
		
}
