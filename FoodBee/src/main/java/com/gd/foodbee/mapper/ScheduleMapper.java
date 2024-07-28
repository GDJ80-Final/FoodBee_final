package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;

@Mapper
public interface ScheduleMapper {
	// 개인일정테이블 리스트 
	// 파라미터 : empNo
	// 반환값 : "com.gd.foodbee.dto.ScheduleDTO"
	List<ScheduleDTO> scheduleList(int empNo);
	
	// 팀일정테이블 리스트
	// 파라미터 : dptNo
	// 반환값 : "com.gd.foodbee.dto.ScheduleDTO"
	List<ScheduleDTO> teamScheduleList(String dptNo);
	
	// 팀별 회의실예약 리스트
	// 파라미터 : dptNo
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> roomRsvList(String dptNo);
	
	// 팀원휴가내역리스트
	// 파라미터 : dptNo
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> dayOffList(String dptNo);
	
	// 출장내역리스트
	// 파라미터 : dptNo
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> businessTripList(String dptNo);
	
	// 개인일정 전체리스트
	// 파라미터 : empNo, search, beginRow, rowPerPage
	// 반환값 : com.gd.foodbee.dto.ScheduleDTO
	List<ScheduleDTO>personalList(int empNo, String search, int beginRow, int rowPerPage);
	
	// 팀일정 전체 리스트
	// 파라미터  : dptNo, search, beginRow, rowPerPage
	// 반환값  :  "HashMap"
	List<HashMap<String,Object>>teamList(String dptNo, String search, int beginRow, int rowPerPage);
	
	// 회의일정 전체리스트
	// 파라미터  : empNo, dptNo, search, beginRow, rowPerPage
	// 반환값  :  "HashMap"
	List<HashMap<String,Object>>roomList(int empNo, String dptNo, String search, int beginRow, int rowPerPage);
	
	// 개인일정 총갯수
	// 파라미터  :  "empNo"
	// 반환값  :  "int"
	int countPerson(int empNo);
	
	// 전체 팀일정 총갯수
	// 파라미터 : "dtpNo"
	// 반환값  : "int"
	int countTeam(String dptNo);
	
	// 전체 팀회의실예약일정 총갯수
	// 파라미터  :  "dptNo"
	// 반환값  :  "int"
	int countRoom(String dptNo);
	
	// 개인일정
	// 파라미터 : scheduleNo
	// 반환값 : "Map"
	Map<String, ScheduleDTO> scheduleOne(int scheduleNo);
	
	// 팀일정상세보기
	// 파라미터 : scheduleNo
	// 반환값 : "Map"
	Map<String,ScheduleDTO> teamScheduleOne(int scheduleNo);
	
	// 휴가일정 상세보기
	// 파라미터  : scheduleNo
	// 반환값 : "com.gd.foodbee.dto.DayOffDTO"
	DayOffDTO dayOffOne(int scheduleNo);
	
	// 출장일정 상세보기
	// 파라미터  :  scheduleNo
	// 반환값  :  "com.gd.foodbee.dto.TripHistoryDTO"
	TripHistoryDTO tripHistoryOne(int scheduleNo);
	
	// 회의실예약 상세보기
	// 파라미터 : rsvNo
	// 반환값 : com.gd.foodbee.dto.RoomRsvDTO
	RoomRsvDTO roomRsvOne(int rsvNo);
	
	// 개인일정 수정하기
	// 파라미터 : scheduleNo, scheduleDTO
	// 반환값 : "int"
	int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO);
	
	// 일정삭제하기
	// 파라미터 : "int"
	// 반환값 : "int"
	int deleteSchedule(int scheduleNo);
	
	// 일정추가
	// 파라미터 : scheduleDTO
	// 반환값 : "int"
	int insertSchedule(ScheduleDTO scheduleDTO);
}
