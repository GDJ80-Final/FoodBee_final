package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.DayOffDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
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
	
	// 개인일정 캘린더리스트
	// 파라미터 : int empNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	@Override
	public List<ScheduleDTO>getScheduleList(int empNo){
        
		return scheduleMapper.scheduleList(empNo);
	}
	// 팀일정 캘린더리스트
	// 파라미터 : String dptNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	@Override
	public List<ScheduleDTO>getTeamScheduleList(String dptNo){
		
		return scheduleMapper.teamScheduleList(dptNo);
	}
	// 회의실 캘린더예약리스트
	// 파라미터 : String dptNo
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.schedule
	@Override
	public List<HashMap<String,Object>>getRoomRsvList(String dptNo){

        return scheduleMapper.roomRsvList(dptNo);
	}
	// 팀원휴가 캘린더리스트
	// 파라미터 : String dptNo
	// 반환값 : List<>
	// 사용클래스 : ScheduleController.schedule
	@Override
	public List<HashMap<String,Object>>getDayOffList(String dptNo){
		
		return scheduleMapper.dayOffList(dptNo);
	}
	// 팀원출장 캘린더리스트
	// 파라미터 : String dptNo
	// 반환값 : List<>
	// 사용클래스 : ScheduleController.schedule
	@Override
	public List<HashMap<String,Object>>getBusinessTripList(String dptNo){
		
		return scheduleMapper.businessTripList(dptNo);
	}
	// 개인일정 전체리스트
	// 파라미터 : int cureentPage, int empNo, String search
	// 반환값 : List<ScheduleDTO>
	// 사용클래스 : ScheduleController.personalScheduleList
	@Override
	public List<ScheduleDTO> personalListAll(int currentPage, int empNo, String search){
		log.debug(TeamColor.PURPLE + "empNo=>" + empNo);
		log.debug(TeamColor.PURPLE + "currentPage=>" + currentPage);
		
		int beginRow = (currentPage-1)*this.ROW_PER_PAGE;

		return scheduleMapper.personalList(empNo, search, beginRow, ROW_PER_PAGE);
	}
	
	// 팀일정 전체리스트
	// 파라미터 : int currentPage, String dptNo, String search
	// 반환값 : List<>
	// 사용클래스 :  ScheduleController.teamScheduleList
	@Override
	public List<HashMap<String,Object>>teamListAll(int currentPage, String dptNo, String search){
		log.debug(TeamColor.PURPLE + "dptNo=>" + dptNo);
		
		int beginRow = (currentPage -1)*this.ROW_PER_PAGE;
		
		return scheduleMapper.teamList(dptNo, search, beginRow, ROW_PER_PAGE);
	}
	
	// 개인 + 팀 일정 전체리스트
	// 파라미터
	// 반환값 : List<>
	// 사용클래스 : ScheduleController.personalTeamList
	 @Override
	 public List<HashMap<String,Object>> personalTeamList(int currentPage, int empNo, String dptNo){
		 int rowPerPage = 4;
		 int beginRow = (currentPage -1)*rowPerPage;
		 
		 return scheduleMapper.personalTeamList(empNo, dptNo, beginRow, rowPerPage);
	 }
	
	// 팀 회의 전체 리스트
	// 파라미터 : int currentPage, int empNo, String dptNo, String search
	// 반환값 : List<>
	// 사용클래스 :  ScheduleController.roomScheduleList
	@Override
	public List<HashMap<String,Object>> roomListAll(int currentPage, int empNo, String dptNo, String search){
		log.debug(TeamColor.PURPLE + empNo + "<==empNo");
		log.debug(TeamColor.PURPLE + dptNo + "<==dptNo");
		log.debug(TeamColor.PURPLE + currentPage + "<==currentPage");
		
		
		int beginRow = (currentPage -1)*this.ROW_PER_PAGE;

		return scheduleMapper.roomList(empNo, dptNo, search, beginRow, ROW_PER_PAGE);
	}
	// 개인일정 lastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 :  ScheduleController.personalScheduleList
	@Override
	public int personLastPage(int empNo) {
		int count = scheduleMapper.countPerson(empNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);

    	return lastPage;
	}
	
	// 팀일정 lastPage
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.teamScheduleList
	@Override
	public int teamLastPage(String dptNo) {
		int count = scheduleMapper.countTeam(dptNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);

    	return lastPage;
	}
	
	// 회의실예약일정 lastPage
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.roomScheduleList
	@Override
	public int roomLastPage(String dptNo) {
		int count = scheduleMapper.countRoom(dptNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);
    	
    	return lastPage;
	}
	
	// 일정 상세보기
	// 파라미터 : int scheduleNo
	// 반환값 : Map<ScheduleDTO>
	// 사용클래스 : ScheduleController.scheduleOne
	@Override
	public Map<String,ScheduleDTO>scheduleOne(int scheduleNo){
		
		return scheduleMapper.scheduleOne(scheduleNo);
	}
	// 팀일정 상세보기
	// 파라미터 : int scheduleNo
	// 반환값 : Map<ScheduleDTO>
	// 사용클래스 : ScheduleController.teamScheduleOne
	@Override
	public Map<String,ScheduleDTO>teamScheduleOne(int scheduleNo){
		
		return scheduleMapper.teamScheduleOne(scheduleNo);
	}
	// 휴가일정 상세보기
	// 파라미터 : scheduleNo
	// 반환값 : DayOffDTO
	// 사용클래스 : ScheduleController.dayOffSchduleOne
	@Override
	public DayOffDTO dayOffOne(int scheduleNo){
		
		return scheduleMapper.dayOffOne(scheduleNo);
	}
	// 회의일정 상세보기
	// 파라미터 : int rsvNo
	// 반환값 : roomRsvDTO
	// 사용클래스 : scheduleController.roomRsvOne
	@Override
	public RoomRsvDTO roomRsvOne(int scheduleNo) {
		
		return scheduleMapper.roomRsvOne(scheduleNo);
	}
	// 출장일정 상세보기
	// 파라미터 : int scheduleNo
	// 반환값 : TripHistoryDTO
	// 사용클래스 : ScheduleController.businessTripScheduleOne
	public TripHistoryDTO tripHistoryOne(int rsvNo) {
		
		return scheduleMapper.tripHistoryOne(rsvNo);
	}
	
	// 일정수정
	// 파라미터 : int scheduleNo, ScheduleDTO scheduleDTO
	// 반환값 : int
	// 사용클래스 :  ScheduleController.modifySchedule
	@Override
	public int modifySchedule(int scheduleNo, ScheduleDTO scheduleDTO) {
		
		return scheduleMapper.modifySchedule(scheduleNo, scheduleDTO);
	}
	
	// 일정삭제
	// 파라미터 : int scheduleNo
	// 반환값 : int
	// 사용클래스 : ScheduleController.deleteSchedule
	@Override
	public int deleteSchedule(int scheduleNo) {
		
		int delete = scheduleMapper.deleteSchedule(scheduleNo);
		log.debug(TeamColor.PURPLE + "delete=>" + delete);
		
		if(delete != 1) {
			log.debug(TeamColor.PURPLE + "일정삭제에 실패했음");
		}
		return delete;
	}
	// 일정추가
	// 파라미터 : ScheduleDTO scheduleDTO
	// 반환값 : int
	// 사용클래스 : ScheduleController.addSchedule
	@Override
	public int addSchedule(ScheduleDTO scheduleDTO) {
		
		return scheduleMapper.insertSchedule(scheduleDTO);
	}
}
