package com.gd.foodbee.service;

import java.util.List;

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
	@Override
	public List<RoomDTO> getRoomList() {
		
		return roomMapper.selectRoomList(); 
	}
	
	@Override
	public RoomDTO getRoomOne(int roomNo) {
		log.debug(TeamColor.GREEN+"roomNo:"+roomNo);
		
		return roomMapper.selectRoomOne(roomNo); 
	}
	
	@Override
	public int addRoomRsv(RoomRsvDTO rsv) {
		log.debug(TeamColor.GREEN+"rsv:"+rsv);
		
		return roomMapper.insertRoomRsv(rsv); 
	}
	// 선택한 날짜에 예약된 시간을 출력
	@Override
	public List<RoomRsvDTO> getReservedTimes(String rsvDate) {
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
		return roomMapper.selectReservedTimes(rsvDate); 
	}
	// 선택된 날짜별 전체 예약리스트 출력
	@Override
	public List<RoomRsvDTO> getRsvListByDate(String rsvDate) {
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
		return roomMapper.selectRsvListByDate(rsvDate); 
	}	
	// 내 예약리스트 출력
	@Override
	public List<RoomRsvDTO> getRsvListByEmpNo(String empNo) {
		log.debug(TeamColor.GREEN+"rsvDate:"+empNo);
		
		return roomMapper.selectRsvListByEmpNo(empNo); 
	}	
		
}
