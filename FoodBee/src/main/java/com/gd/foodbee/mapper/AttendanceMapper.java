package com.gd.foodbee.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.AttendanceDTO;

@Mapper
public interface AttendanceMapper {
	
	// 최신 근태 기록
	// 파라미터 : int empNo
	// 반환값 : AttendanceDTO
	// 사용클래스 : AttendanceServiceImpl.getAttendanceRecord
	AttendanceDTO selectAttendanceRecord(int empNo);
	
	// 근태 출근
	// 파라미터 : int empNo
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.addStartTime
	int insertStartTime(int empNo);
	
	// 근태 퇴근
	// 파라미터 : int empNo
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyEndTime
	int updateEndTime(int empNo);
	
	// 근태보고 출력
	// 파라미터 : int empNo
	// 반환값 : AttendanceDTO
	// 사용클래스 : AttendanceServiceImpl.getTime
	AttendanceDTO selectTime(int empNo, String date);
	
	// 근태보고(승인자) 출력
	// 파라미터 : String dptNo
	// 반환값 : HashMap<String, Object>
	// 사용클래스 : AttendanceServiceImpl.getTeamLeader
	HashMap<String, Object> selectTeamLeader(String dptNo);
	
	// CEO 출력
	// 파라미터 : X
	// 반환값 : HashMap<String, Object>
	// 사용클래스 : AttendanceServiceImpl.getCEO
	HashMap<String, Object> selectCEO();
	
	// 근태보고 수정
	// 파라미터 : String updateStartTime, String updateEndTime, String updateReason, int empNo, String date
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyTime
	int updateTime(String updateStartTime, String updateEndTime, String updateReason, int empNo, String date);
	
	// 개인 근태 출력
	// 파라미터 : int empNo, String startDate, String endDate, int beginRow, int rowPerPage
	// 반환값 : List<AttendanceDTO>
	// 사용클래스 : AttendanceServiceImpl.getAttendancePersonal
	List<AttendanceDTO> selectAttendancePersonal(int empNo, String startDate, String endDate, int beginRow, int rowPerPage);
	
	// 개인 근태 cnt
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : AttendanceServiceImpl.getAttendancePersonalCnt
	int selectAttendancePersonalCnt(int empNo);
	
	// 근태 확정
	// 파라미터 : int empNo, String date
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyAttendanceFinalTime
	int updateAttendanceFinalTime(int empNo, String date);
	
	// 팀원 근태 출력
	// 파라미터 : int empNo, String dptNo, int beginRow, int rowPerPage, String search
	// 반환값 : List<HashMap<String, Object>>
	// 사용클래스 : AttendanceServiceImpl.getAttendanceTeamMember
	List<HashMap<String, Object>> selectAttendanceTeamMember(int empNo, String dptNo, int beginRow, int rowPerPage, String search);
	
	// 팀원 근태 출력 승인 상태별 분기
	// 파라미터 : int empNo, String dptNo, int beginRow, int rowPerPage, String search, String approvalState
	// 반환값 : List<HashMap<String, Object>>
	// 사용클래스 : AttendanceServiceImpl.getAttendanceTeamMember
	List<HashMap<String, Object>> selectAttendanceTeamMemberByStatus(int empNo, String dptNo, int beginRow, int rowPerPage, String search, String approvalState);
	
	// 팀원 근태 cnt
	// 파라미터 : int empNo, String dptNo
	// 반환값 : int
	// 사용클래스 : AttendanceServiceImpl.getAttendanceTeamMemberCnt
	int selectAttendanceTeamMemberCnt(int empNo, String dptNo);

	// 팀원 근태 승인 상태별 cnt
	// 파라미터 : int empNo, String dptNo, String approvalState
	// 반환값 : int
	// 사용클래스 : AttendanceServiceImpl.getAttendanceTeamMemberByStatusCnt
	int selectAttendanceTeamMemberByStatusCnt(int empNo, String dptNo, String approvalState);
	
	// 근태 반려
	// 파라미터 : int empNo, String date, String approvalReason
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyAttendanceRejection
	int updateAttendanceRejection(int empNo, String date, String approvalReason);
	
	// 근태 승인
	// 파라미터 : int empNo, String date
	// 반환값 : X
	// 사용클래스 : AttendanceServiceImpl.modifyAttendanceAccept
	int updateAttendanceAccept(int empNo, String date);
	
}
