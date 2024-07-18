package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.ScheduleDTO;

public interface ScheduleService {
	//개인일정테이블 리스트
	List<ScheduleDTO>getScheduleList(int empNo);
	//팀일정테이블 리스트
	List<ScheduleDTO>getTeamScheduleList(String dptNo);
	//회의실예약 리스트 
	List<HashMap<String,Object>>getRoomRsvList(String dptNo);
	//팀원휴가 리스트
	List<HashMap<String,Object>>getDayOffList(String dptNo);
	//팀원 출장리스트
	List<HashMap<String,Object>>getBusinessTripList(String dptNo);
	//개일일정 상세
	Map<String,ScheduleDTO>scheduleOne(int scheduleNo);
	//개인일정 수정
	int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO);
	//개인일정 삭제
	int deleteSchedule(int scheduleNo);
	//일정추가
	int addSchedule(ScheduleDTO scheduleDTO);
}
