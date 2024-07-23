package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.AttendanceDTO;

@Mapper
public interface AttendanceMapper {
	
	// 근태보고 출력
	AttendanceDTO selectTime(int empNo);
	
	// 근태보고(승인자) 출력
	HashMap<String, Object> selectTeamLeader(String dptNo);
	
	// 근태보고 수정
	int updateTime(String updateStartTime, String updateEndTime, String updateReason, int empNo);
	
	// 개인 근태 출력
	List<AttendanceDTO> selectAttendancePersonal(HashMap<String,Object> m);
	
	// 개인 근태 cnt
	int selectAttendancePersonalCnt(int empNo);
	
	// 근태 확정
	int updateAttendanceFinalTime(HashMap<String,Object> m);
}
