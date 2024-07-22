package com.gd.foodbee.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.AttendanceDTO;

@Mapper
public interface AttendanceMapper {
	// 근태보고 출력
	AttendanceDTO selectTime(int empNo);
	// 근태보고(승인자) 출력
	HashMap<String, Object> selectTeamLeader(String dptNo);
	
}
