package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;

import com.gd.foodbee.dto.AttendanceDTO;

public interface AttendanceService {
	
	// 최신 근태 기록
	AttendanceDTO getAttendanceRecord(int empNo);
	
	// 근태 출근
	int addStartTime(int empNo);
	
	// 근태 퇴근
	int modifyEndTime(int empNo);
	
	// 근태보고 출력
	AttendanceDTO getTime(int empNo, String date);
	
	// 근태보고(승인자) 출력
	HashMap<String, Object> getTeamLeader(String dptNo);
	
	// CEO 출력
	HashMap<String, Object> getCEO();
	
	// 근태보고 수정
	int modifyTime(String updateStartTime, String updateEndTime, String updateReason, int empNo, String date);
	
	// 개인 근태 출력
	List<AttendanceDTO> getAttendancePersonal(int empNo, int currentPage, String startDate, String endDate);
	
	// 개인 근태 cnt
	int getAttendancePersonalCnt(int empNo);
	
	// 근태 확정
	int modifyAttendanceFinalTime(String date, int empNo);
		
	// 팀원 근태 출력
	List<HashMap<String, Object>> getAttendanceTeamMember(int empNo, String dptNo, int currentPage, String search);
	
	// 팀원 근태 출력 승인 상태별 분기
	List<HashMap<String, Object>> getAttendanceTeamMemberByStatus(int empNo, String dptNo, int currentPage, String search, String approvalState);
	
	// 팀원 근태 cnt
	int getAttendanceTeamMemberCnt(int empNo, String dptNo);

	// 팀원 근태 승인 상태별  cnt
	int getAttendanceTeamMemberByStatusCnt(int empNo, String dptNo, String approvalState);
	
	// 근태 반려
	int modifyAttendanceRejection(int empNo, String date, String approvalReason);
	
	// 근태 승인
	int modifyAttendanceAccept(int empNo, String date);
}
