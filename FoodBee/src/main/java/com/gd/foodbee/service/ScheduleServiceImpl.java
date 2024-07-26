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
	private ScheduleMapper scheduleMapper;
	private static final int ROW_PER_PAGE = 10;
	
	//개인일정 캘린더리스트
	@Override
	public List<ScheduleDTO>getScheduleList(int empNo){
        
		return scheduleMapper.scheduleList(empNo);
	}
	//팀일정 캘린더리스트
	@Override
	public List<ScheduleDTO>getTeamScheduleList(String dptNo){
		
		return scheduleMapper.teamScheduleList(dptNo);
	}
	//회의실 캘린더예약리스트
	@Override
	public List<HashMap<String,Object>>getRoomRsvList(String dptNo){

        return scheduleMapper.roomRsvList(dptNo);
	}
	//팀원휴가 캘린더리스트
	@Override
	public List<HashMap<String,Object>>getDayOffList(String dptNo){
		
		return scheduleMapper.dayOffList(dptNo);
	}
	//팀원출장 캘린더리스트
	@Override
	public List<HashMap<String,Object>>getBusinessTripList(String dptNo){
		
		return scheduleMapper.businessTripList(dptNo);
	}
	//개인일정 전체리스트
	@Override
	public List<ScheduleDTO> personalListAll(int currentPage, int empNo, String search){
		log.debug(TeamColor.PURPLE + "empNo=>" + empNo);
		log.debug(TeamColor.PURPLE + "currentPage=>" + currentPage);
		
		int beginRow = (currentPage-1)*this.ROW_PER_PAGE;

		return scheduleMapper.personalList(empNo, search, beginRow, ROW_PER_PAGE);
	}
	
	//팀일정 전체리스트
	@Override
	public List<HashMap<String,Object>>teamListAll(int currentPage, String dptNo, String search){
		log.debug(TeamColor.PURPLE + "dptNo=>" + dptNo);
		
		int beginRow = (currentPage -1)*this.ROW_PER_PAGE;
		
		return scheduleMapper.teamList(dptNo, search, beginRow, ROW_PER_PAGE);
	}
	
	//팀 회의 전체 리스트
	@Override
	public List<HashMap<String,Object>> roomListAll(int currentPage, int empNo, String dptNo, String search){
		
		int beginRow = (currentPage -1)*this.ROW_PER_PAGE;

		return scheduleMapper.roomList(empNo, dptNo, search, beginRow, ROW_PER_PAGE);
	}
	//개인일정 lastPage
	@Override
	public int personLastPage(int empNo) {
		int count = scheduleMapper.countPerson(empNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);

    	return lastPage;
	}
	
	//팀일정 lastPage
	@Override
	public int teamLastPage(String dptNo) {
		int count = scheduleMapper.countTeam(dptNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);

    	return lastPage;
	}
	
	//회의실예약일정 lastPage
	@Override
	public int roomLastPage(String dptNo) {
		int count = scheduleMapper.countRoom(dptNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);
    	
    	return lastPage;
	}
	
	//일정 상세보기
	@Override
	public Map<String,ScheduleDTO>scheduleOne(int scheduleNo){
		
		return scheduleMapper.scheduleOne(scheduleNo);
	}
	//팀일정 상세보기
	@Override
	public Map<String,ScheduleDTO>teamScheduleOne(int scheduleNo){
		
		return scheduleMapper.teamScheduleOne(scheduleNo);
	}
	//휴가일정 상세보기
	@Override
	public DayOffDTO dayOffOne(int scheduleNo){
		
		return scheduleMapper.dayOffOne(scheduleNo);
	}
	//출장일정 상세보기
	public TripHistoryDTO tripHistoryOne(int scheduleNo) {
		
		return scheduleMapper.tripHistoryOne(scheduleNo);
	}
	
	//일정수정
	@Override
	public int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO) {
		
		return scheduleMapper.modifySchedule(scheduleNo, scheduleDTO);
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
