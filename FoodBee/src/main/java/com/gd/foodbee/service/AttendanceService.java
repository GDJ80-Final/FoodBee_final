package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;

import com.gd.foodbee.dto.AttendanceDTO;

public interface AttendanceService {
	
	// 근태보고 출력
	AttendanceDTO getTime(int empNo);
	
	// 근태보고(승인자) 출력
	HashMap<String, Object> getTeamLeader(String dptNo);
	
	// 근태보고 수정
	int modifyTime(String updateStartTime, String updateEndTime, String updateReason, int empNo);
	
	// 개인 근태 출력
	List<AttendanceDTO> getAttendancePersonal(int empNo);
		
}
