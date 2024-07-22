package com.gd.foodbee.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.AttendanceDTO;
import com.gd.foodbee.mapper.AttendanceMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@Transactional
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired AttendanceMapper attendanceMapper;
	
	// 근태보고 출력
	@Override
	public AttendanceDTO getTime(int empNo) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		return attendanceMapper.selectTime(empNo);		
	}
	
	// 근태보고(승인자) 출력
	@Override
	public HashMap<String, Object> getTeamLeader(String dptNo) {
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		
		return attendanceMapper.selectTeamLeader(dptNo);
	}
	
	// 근태보고 수정
	@Override
	public int modifyTime(String updateStartTime, String updateEndTime, String updateReason, int empNo) {
		log.debug(TeamColor.GREEN + "updateStartTime => " + updateStartTime);
		log.debug(TeamColor.GREEN + "updateEndTime => " + updateEndTime);
		log.debug(TeamColor.GREEN + "updateReason => " + updateReason);
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		return attendanceMapper.updateTime(updateStartTime, updateEndTime, updateReason, empNo);
	}
}
