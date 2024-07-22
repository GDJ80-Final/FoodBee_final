package com.gd.foodbee.service;

import java.util.HashMap;

import com.gd.foodbee.dto.AttendanceDTO;

public interface AttendanceService {
	
	// 근태보고 출력
	AttendanceDTO getTime(int empNo);
	
	// 근태보고(승인자) 출력
	HashMap<String, Object> getTeamLeader(String dptNo);
	
}
