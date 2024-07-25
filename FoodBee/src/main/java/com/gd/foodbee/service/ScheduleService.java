package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;

public interface ScheduleService {
	// 개인일정테이블 리스트
	// 파라미터 : int empNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	List<ScheduleDTO>getScheduleList(int empNo);
	
	// 팀일정테이블 리스트
	// 파라미터 : String dptNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	List<ScheduleDTO>getTeamScheduleList(String dptNo);
	
	// 회의실예약 리스트 
	// 파라미터 : String dptNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	List<HashMap<String,Object>>getRoomRsvList(String dptNo);
	
	// 팀원휴가 리스트
	// 파라미터 : String dptNo
	// 반환값 : List<>
	// 사용클래스 : ScheduleController.schedule
	List<HashMap<String,Object>>getDayOffList(String dptNo);
	
	// 팀원 출장리스트
	// 파라미터 : String dptNo
	// 반환값 : List<>
	// 사용클래스 : ScheduleController.schedule
	List<HashMap<String,Object>>getBusinessTripList(String dptNo);
	
	// 개일일정 상세
	// 파라미터 : int scheduleNo
	// 반환값 : Map<ScheduleDTO>
	// 사용클래스 : ScheduleController.scheduleOne
	Map<String,ScheduleDTO>scheduleOne(int scheduleNo);
	
	// 팀일정 상세
	// 파라미터 : int scheduleNo
	// 반환값 : Map<ScheduleDTO>
	// 사용클래스 : ScheduleController.teamScheduleOne
	Map<String,ScheduleDTO>teamScheduleOne(int scheduleNo);
	
	// 휴가내역 상세
	// 파라미터 : scheduleNo
	// 반환값 : DayOffDTO
	// 사용크랠스 : ScheduleController.dayOffSchduleOne
	DayOffDTO dayOffOne(int scheduleNo);
	
	// 출장내역 상세
	// 파라미터 : int scheduleNo
	// 반환값 : TripHistoryDTO
	// 사용클래스 : ScheduleController.businessTripScheduleOne
	TripHistoryDTO tripHistoryOne(int scheduleNo);
	
	// 개인일정 전체 리스트
	// 파라미터 : int cureentPage, int empNo, String search
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.personalScheduleList
	List<ScheduleDTO> personalListAll(int currentPage, int empNo, String search);
	
	// 팀일정 전체 리스트
	// 파라미터 : int currentPage, String dptNo, String search
	// 반환값 : List<>
	// 사용클래스 :  ScheduleController.teamScheduleList
	List<HashMap<String,Object>>teamListAll(int currentPage, String dptNo, String search);
	
	// 회의실 일정 전체 리스트
	// 파라미터 : int currentPage, int empNo, String dptNo, String search
	// 반환값 : List<>
	// 사용클래스 :  ScheduleController.roomScheduleList
	List<HashMap<String,Object>> roomListAll(int currentPage, int empNo, String dptNo, String search);
	
	// 개인일정 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 :  ScheduleController.personalScheduleList
	int personLastPage(int empNo);
	
	// 팀일정 총갯수
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.teamScheduleList
	int teamLastPage(String dptNo);
	
	// 회의 일정 총갯수 
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.roomScheduleList
	int roomLastPage(String dptNo);
	
	// 개인일정 수정
	// 파라미터 : int scheduleNo, ScheduleDTO scheduleDTO
	// 반환값 : int
	// 사용클래스 :  ScheduleController.modifySchedule
	int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO);
	
	// 개인일정 삭제
	// 파라미터 : int scheduleNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.deleteSchedule
	int deleteSchedule(int scheduleNo);
	
	// 일정추가
	// 파라미터 : ScheduleDTO scheduleDTO
	// 반환값 : int
	// 사용클래스 : ScheduleController.addSchedule
	int addSchedule(ScheduleDTO scheduleDTO);
}
