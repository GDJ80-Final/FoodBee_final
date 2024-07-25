package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;

@Mapper
public interface ScheduleMapper {
	// 개인일정테이블 리스트 
	// 파라미터 : "HashMap"
	// 반환값 : "com.gd.foodbee.dto.ScheduleDTO"
	List<ScheduleDTO> scheduleList(HashMap<String, Object> m);
	
	// 팀일정테이블 리스트
	// 파라미터 : "HashMap"
	// 반환값 : "com.gd.foodbee.dto.ScheduleDTO"
	List<ScheduleDTO> teamScheduleList(HashMap<String,Object>m);
	
	// 팀별 회의실예약 리스트
	// 파라미터 : "HashMap"
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> roomRsvList(HashMap<String,Object>m);
	
	// 팀원휴가내역리스트
	// 파라미터 : "HashMap"
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> dayOffList(HashMap<String,Object>m);
	
	// 출장내역리스트
	// 파라미터 : "HashMap"
	// 반환값 : "HashMap"
	List<HashMap<String,Object>> businessTripList(HashMap<String,Object>m);
	
	// 개인일정 전체리스트
	// 파라미터 : "HashMap"
	// 반환값 : com.gd.foodbee.dto.ScheduleDTO
	List<ScheduleDTO>personalList(HashMap<String,Object>m);
	
	// 팀일정 전체 리스트
	// 파라미터  :  "HashMap"
	// 반환값  :  "HashMap"
	List<HashMap<String,Object>>teamList(HashMap<String,Object>m);
	
	// 회의일정 전체리스트
	// 파라미터  :  "HashMap"
	// 반환값  :  "HashMap"
	List<HashMap<String,Object>>roomList(HashMap<String,Object>m);
	
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
	// 파라미터 : "Map"
	// 반환값 : "Map"
	Map<String, ScheduleDTO> scheduleOne(Map<String,Object>m);
	
	// 팀일정상세보기
	// 파라미터 : "Map"
	// 반환값 : "Map"
	Map<String,ScheduleDTO> teamScheduleOne(Map<String,Object>m);
	
	// 휴가일정 상세보기
	// 파라미터  : "Map"
	// 반환값 : "com.gd.foodbee.dto.DayOffDTO"
	DayOffDTO dayOffOne(Map<String,Object>m);
	
	// 출장일정 상세보기
	// 파라미터  :  "Map"
	// 반환값  :  "com.gd.foodbee.dto.TripHistoryDTO"
	TripHistoryDTO tripHistoryOne(Map<String,Object>m);
	
	// 개인일정 수정하기
	// 파라미터 : "Map"
	// 반환값 : "int"
	int modifySchedule(Map<String,Object>m);
	
	// 일정삭제하기
	// 파라미터 : "int"
	// 반환값 : "int"
	int deleteSchedule(int scheduleNo);
	
	// 일정추가
	// 파라미터 : "com.gd.foodbee.dto.ScheduleDTO"
	// 반환값 : "int"
	int insertSchedule(ScheduleDTO scheduleDTO);
}
