package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;

public interface ScheduleService {
	// 개인일정테이블 리스트
	List<ScheduleDTO>getScheduleList(int empNo);
	
	// 팀일정테이블 리스트
	List<ScheduleDTO>getTeamScheduleList(String dptNo);
	
	// 회의실예약 리스트 
	List<HashMap<String,Object>>getRoomRsvList(String dptNo);
	
	// 팀원휴가 리스트
	List<HashMap<String,Object>>getDayOffList(String dptNo);
	
	// 팀원 출장리스트
	List<HashMap<String,Object>>getBusinessTripList(String dptNo);
	
	// 개일일정 상세
	Map<String,ScheduleDTO>scheduleOne(int scheduleNo);
	
	// 팀일정 상세
	Map<String,ScheduleDTO>teamScheduleOne(int scheduleNo);
	
	// 휴가내역 상세
	DayOffDTO dayOffOne(int scheduleNo);
	
	// 출장내역 상세
	TripHistoryDTO tripHistoryOne(int scheduleNo);
	
	// 회의일정 상세
	RoomRsvDTO roomRsvOne(int rsvNo);
	
	// 개인일정 전체 리스트
	List<ScheduleDTO> personalListAll(int currentPage, int empNo, String search);
	
	// 팀일정 전체 리스트
	List<HashMap<String,Object>>teamListAll(int currentPage, String dptNo, String search);
	
	// 회의실 일정 전체 리스트
	List<HashMap<String,Object>> roomListAll(int currentPage, int empNo, String dptNo, String search);
	
	// 개인일정 총갯수
	int personLastPage(int empNo);
	
	// 팀일정 총갯수
	int teamLastPage(String dptNo);
	
	// 회의 일정 총갯수 
	int roomLastPage(String dptNo);
	
	// 개인일정 수정
	int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO);
	
	// 개인일정 삭제
	int deleteSchedule(int scheduleNo);
	
	// 일정추가
	int addSchedule(ScheduleDTO scheduleDTO);
}
