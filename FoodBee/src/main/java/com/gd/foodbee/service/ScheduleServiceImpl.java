package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.mapper.ScheduleMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	final int rowPerPage= 10;
	
	//일정 테이블리스트
	@Override
	public List<ScheduleDTO>getScheduleList(int empNo){
		/*
		 * int beginRow = 0; beginRow = (currentPage -1) * rowPerPage;
		 */
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("empNo", empNo);
        
		return scheduleMapper.scheduleList(m);
	}
	//회의실 예약리스트
	@Override
	public List<HashMap<String,Object>>getRoomRsvList(String dptNo){
        HashMap<String,Object> m = new HashMap<String,Object>();

        m.put("dptNo", dptNo);
        
        return scheduleMapper.roomRsvList(m);
	}
	//팀원휴가 리스트
	@Override
	public List<HashMap<String,Object>>getDayOffList(String dptNo){
		HashMap<String,Object> m = new HashMap<String,Object>();
		
		m.put("dptNo", dptNo);
		
		return scheduleMapper.dayOffList(m);
	}
	//팀원출장 리스트
	@Override
	public List<HashMap<String,Object>>getBusinessTripList(String dptNo){
		HashMap<String,Object> m = new HashMap<String,Object>();
		
		m.put("dptNo", dptNo);
		
		return scheduleMapper.businessTripList(m);
	}
	
	@Override
	public Map<String,ScheduleDTO>scheduleOne(int scheduleNo){
		Map<String, Object> m = new HashMap<>();
		
		m.put("scheduleNo", scheduleNo);
		
		return scheduleMapper.scheduleOne(m);
	}
	
	@Override
	public int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO) {
		Map<String,Object> m = new HashMap<>();
		
		m.put("scheduleNo", scheduleNo);
		m.put("scheduleDTO", scheduleDTO);
		
		return scheduleMapper.modifySchedule(m);
	}
}
