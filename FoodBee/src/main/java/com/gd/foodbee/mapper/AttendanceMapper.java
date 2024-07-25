package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.AttendanceDTO;

@Mapper
public interface AttendanceMapper {
	
	// 근태보고 출력
	// 파라미터 : int empNo
	// 반환값 : AttendanceDTO
	// 사용클래스 : AttendanceServiceImpl.getTime
	AttendanceDTO selectTime(int empNo);
	
	// 근태보고(승인자) 출력
	// 파라미터 : String dptNo
	// 반환값 : HashMap<String, Object>
	// 사용클래스 : AttendanceServiceImpl.getTeamLeader
	HashMap<String, Object> selectTeamLeader(String dptNo);
	
	// 근태보고 수정
	// 파라미터 : String updateStartTime, String updateEndTime, String updateReason, int empNo
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyTime
	int updateTime(String updateStartTime, String updateEndTime, String updateReason, int empNo);
	
	// 개인 근태 출력
	// 파라미터 : HashMap<String,Object> m
	// 반환값 : List<AttendanceDTO>
	// 사용클래스 : AttendanceServiceImpl.getAttendancePersonal
	List<AttendanceDTO> selectAttendancePersonal(HashMap<String,Object> m);
	
	// 개인 근태 cnt
	// 파라미터 : int empNo
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.getAttendancePersonalCnt
	int selectAttendancePersonalCnt(int empNo);
	
	// 근태 확정
	// 파라미터 : HashMap<String,Object> m
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyAttendanceFinalTime
	int updateAttendanceFinalTime(HashMap<String,Object> m);
}
