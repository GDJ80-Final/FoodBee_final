package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;

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
	
	private static final int ROW_PER_PAGE = 10;
	
	// 근태보고 출력
	// 파라미터 : int empNo
	// 반환 값 : AttendanceDTO
	// 사용 클래스 : AttendanceController.attendanceReport & attendanceModify
	@Override
	public AttendanceDTO getTime(int empNo) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		return attendanceMapper.selectTime(empNo);		
	}
	
	// 근태보고(승인자) 출력
	// 파라미터 : String dptNo
	// 반환 값 : HashMap<String, Object> 
	// 사용 클래스 : AttendanceController.attendanceReport & attendanceModify
	@Override
	public HashMap<String, Object> getTeamLeader(String dptNo) {
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		
		return attendanceMapper.selectTeamLeader(dptNo);
	}
	
	// 근태보고 수정
	// 파라미터 : String updateStartTime, String updateEndTime, String updateReason, int empNo
	// 반환 값 : X
	// 사용 클래스 : AttendanceController.attendanceModify
	@Override
	public int modifyTime(String updateStartTime, String updateEndTime, String updateReason, int empNo) {
		log.debug(TeamColor.GREEN + "updateStartTime => " + updateStartTime);
		log.debug(TeamColor.GREEN + "updateEndTime => " + updateEndTime);
		log.debug(TeamColor.GREEN + "updateReason => " + updateReason);
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		return attendanceMapper.updateTime(updateStartTime, updateEndTime, updateReason, empNo);
	}
	
	// 개인 근태 출력
	// 파라미터 : int empNo, int currentPage, String startDate, String endDate
	// 반환 값 : List<AttendanceDTO>
	// 사용 클래스 : AttendanceController.attendancePersonal
	@Override
	public List<AttendanceDTO> getAttendancePersonal(int empNo, int currentPage, String startDate, String endDate) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "startDate => " + startDate);
		log.debug(TeamColor.GREEN + "endDate => " + endDate);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return attendanceMapper.selectAttendancePersonal(empNo, startDate, endDate, beginRow, ROW_PER_PAGE);
	}
	
	// 개인 근태 cnt
	// 파라미터 : int empNo
	// 반환 값 : X
	// 사용 클래스 : AttendanceController.attendancePersonal
	@Override
	public int getAttendancePersonalCnt(int empNo) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		int cnt = attendanceMapper.selectAttendancePersonalCnt(empNo);
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		 
		return lastPage;
	}
	
	// 근태 확정
	// 파라미터 : String date, int empNo
	// 반환 값 : X
	// 사용 클래스 : AttendanceController.attendanceFinalTime
	@Override
	public int modifyAttendanceFinalTime(String date, int empNo) {
		log.debug(TeamColor.GREEN + "date => " + date);
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		return attendanceMapper.updateAttendanceFinalTime(empNo, date);
	}
	
	// 팀원 근태 출력
	// 파라미터 : int empNo, String dptNo
	// 반환 값 : List<HashMap<String, Object>>
	// 사용 클래스 : AttendanceController.
	@Override
	public List<HashMap<String, Object>> getAttendanceTeamMember(int empNo, String dptNo, int currentPage, String search) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "search => " + search);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return attendanceMapper.selectAttendanceTeamMember(empNo, dptNo, beginRow, ROW_PER_PAGE, search);
	}
	
	// 팀원 근태 출력 승인 상태별 분기
	// 파라미터 : int empNo, String dptNo
	// 반환 값 : List<HashMap<String, Object>>
	// 사용 클래스 : AttendanceController.
	@Override
	public List<HashMap<String, Object>> getAttendanceTeamMemberByStatus(int empNo, String dptNo, int currentPage, String search, String approvalState) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "search => " + search);
		log.debug(TeamColor.GREEN + "approvalState => " + approvalState);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return attendanceMapper.selectAttendanceTeamMemberByStatus(empNo, dptNo, beginRow, ROW_PER_PAGE, search, approvalState);
	}
	
	// 팀원 근태 cnt
	// 파라미터 : int empNo
	// 반환 값 : X
	// 사용 클래스 : AttendanceController.attendanceTeamMember
	public int getAttendanceTeamMemberCnt(int empNo, String dptNo) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		
		int cnt = attendanceMapper.selectAttendanceTeamMemberCnt(empNo, dptNo);
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		return lastPage;
	}
	
	// 팀원 근태 승인 상태별  cnt
	// 파라미터 : int empNo
	// 반환 값 : X
	// 사용 클래스 : AttendanceController.attendanceTeamMember
	public int getAttendanceTeamMemberByStatusCnt(int empNo, String dptNo, String approvalState) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		log.debug(TeamColor.GREEN + "approvalState => " + approvalState);
	
		int cnt = attendanceMapper.selectAttendanceTeamMemberByStatusCnt(empNo, dptNo, approvalState);
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		return lastPage;
	}
}
