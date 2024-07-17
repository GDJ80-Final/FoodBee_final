package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.ScheduleDTO;

@Mapper
public interface ScheduleMapper {
	//개인일정테이블 리스트 
	//파라미터="HashMap"
	//반환값="com.gd.foodbee.dto.ScheduleDTO"
	List<ScheduleDTO> scheduleList(HashMap<String, Object> m);
	
	//팀별 회의실예약 리스트
	//파라미터="HashMap"
	//반환값="HashMap"
	List<HashMap<String,Object>> roomRsvList(HashMap<String,Object>m);
	
	//팀원휴가내역리스트
	//파라미터="HashMap"
	//반환값="HashMap"
	List<HashMap<String,Object>> dayOffList(HashMap<String,Object>m);
	
	//출장내역리스트
	//파라미터="HashMap"
	//반환값="HashMap"
	List<HashMap<String,Object>> businessTripList(HashMap<String,Object>m);
}
