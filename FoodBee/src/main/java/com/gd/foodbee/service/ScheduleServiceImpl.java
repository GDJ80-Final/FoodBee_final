package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.ScheduleDTO;
import com.gd.foodbee.dto.TripHistoryDTO;
import com.gd.foodbee.mapper.ScheduleMapper;
import com.gd.foodbee.util.TeamColor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired 
	ScheduleMapper scheduleMapper;
	final int rowPerPage= 10;
	
	//개인일정 캘린더리스트
	@Override
	public List<ScheduleDTO>getScheduleList(int empNo){
		/*
		 * int beginRow = 0; beginRow = (currentPage -1) * rowPerPage;
		 */
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("empNo", empNo);
        
		return scheduleMapper.scheduleList(m);
	}
	//팀일정 캘린더리스트
	@Override
	public List<ScheduleDTO>getTeamScheduleList(String dptNo){
		
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("dptNo", dptNo);
		
		return scheduleMapper.teamScheduleList(m);
	}
	//회의실 캘린더예약리스트
	@Override
	public List<HashMap<String,Object>>getRoomRsvList(String dptNo){
       
		HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("dptNo", dptNo);
        
        return scheduleMapper.roomRsvList(m);
	}
	//팀원휴가 캘린더리스트
	@Override
	public List<HashMap<String,Object>>getDayOffList(String dptNo){
		
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("dptNo", dptNo);
		
		return scheduleMapper.dayOffList(m);
	}
	//팀원출장 캘린더리스트
	@Override
	public List<HashMap<String,Object>>getBusinessTripList(String dptNo){
		
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("dptNo", dptNo);
		
		return scheduleMapper.businessTripList(m);
	}
	//개인일정 전체리스트
	@Override
	public List<ScheduleDTO> personalListAll(int currentPage, int empNo, String search){
		log.debug(TeamColor.PURPLE + "empNo=>" + empNo);
		log.debug(TeamColor.PURPLE + "currentPage=>" + currentPage);
		
		HashMap<String,Object> m = new HashMap<>();
		int beginRow = (currentPage-1)*this.rowPerPage;
		
		m.put("beginRow", beginRow);
		m.put("empNo", empNo);
		m.put("rowPerPage", rowPerPage);
		m.put("search", search);
		
		return scheduleMapper.personalList(m);
	}
	//팀일정 전체리스트
	@Override
	public List<HashMap<String,Object>>teamListAll(int currentPage, String dptNo, String search){
		log.debug(TeamColor.PURPLE + "dptNo=>" + dptNo);
		
		HashMap<String,Object> m = new HashMap<>();
		int beginRow = (currentPage -1)*this.rowPerPage;
		
		m.put("dptNo", dptNo);
		m.put("beginRow", beginRow);
		m.put("rowPerPage", rowPerPage);
		m.put("search", search);
		
		return scheduleMapper.teamList(m);
	}
	
	//팀 회의 전체 리스트
	@Override
	public List<HashMap<String,Object>> roomListAll(int currentPage, int empNo, String dptNo, String search){
		
		HashMap<String,Object>m = new HashMap<>();
		int beginRow = (currentPage -1)*this.rowPerPage;
		
		m.put("dptNo", dptNo);
		m.put("empNo", empNo);
		m.put("beginRow", beginRow);
		m.put("rowPerPage", rowPerPage);
		m.put("search", search);
		
		return scheduleMapper.roomList(m);
	}
	//개인일정 lastPage
	@Override
	public int personLastPage(int empNo) {
		int count = scheduleMapper.countPerson(empNo);
    	int lastPage = (int) Math.ceil((double) count / rowPerPage);

    	return lastPage;
	}
	
	//팀일정 lastPage
	@Override
	public int teamLastPage(String dptNo) {
		int count = scheduleMapper.countTeam(dptNo);
    	int lastPage = (int) Math.ceil((double) count / rowPerPage);

    	return lastPage;
	}
	
	//회의실예약일정 lastPage
	@Override
	public int roomLastPage(String dptNo) {
		int count = scheduleMapper.countRoom(dptNo);
    	int lastPage = (int) Math.ceil((double) count / rowPerPage);
    	
    	return lastPage;
	}
	
	//일정 상세보기
	@Override
	public Map<String,ScheduleDTO>scheduleOne(int scheduleNo){
		Map<String, Object> m = new HashMap<>();
		
		m.put("scheduleNo", scheduleNo);
		
		return scheduleMapper.scheduleOne(m);
	}
	//팀일정 상세보기
	@Override
	public Map<String,ScheduleDTO>teamScheduleOne(int scheduleNo){
		
		Map<String,Object> m = new HashMap<>();
		m.put("scheduleNo", scheduleNo);
		
		return scheduleMapper.teamScheduleOne(m);
	}
	//휴가일정 상세보기
	@Override
	public DayOffDTO dayOffOne(int scheduleNo){
		
		Map<String,Object> m = new HashMap<>();
		m.put("scheduleNo", scheduleNo);
		
		return scheduleMapper.dayOffOne(m);
	}
	//출장일정 상세보기
	public TripHistoryDTO tripHistoryOne(int scheduleNo) {
		
		Map<String,Object> m = new HashMap<>();
		m.put("scheduleNo", scheduleNo);
		
		return scheduleMapper.tripHistoryOne(m);
	}
	
	//일정수정
	@Override
	public int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO) {
		Map<String,Object> m = new HashMap<>();
		
		m.put("scheduleNo", scheduleNo);
		m.put("scheduleDTO", scheduleDTO);
		
		return scheduleMapper.modifySchedule(m);
	}
	
	//일정삭제
	@Override
	public int deleteSchedule(int scheduleNo) {
		
		int delete = scheduleMapper.deleteSchedule(scheduleNo);
		log.debug(TeamColor.PURPLE + "delete=>" + delete);
		
		if(delete != 1) {
			log.debug(TeamColor.PURPLE + "일정삭제에 실패했음");
		}
		return delete;
	}
	//일정추가
	@Override
	public int addSchedule(ScheduleDTO scheduleDTO) {
		
		return scheduleMapper.insertSchedule(scheduleDTO);
	}
}
