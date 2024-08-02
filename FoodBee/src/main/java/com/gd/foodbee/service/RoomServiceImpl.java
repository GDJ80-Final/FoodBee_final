package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.mapper.RoomMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class RoomServiceImpl implements RoomService{
	@Autowired RoomMapper roomMapper;
	
	private static final int ROW_PER_PAGE = 10;
	
	// 회의실 목록
	// 파라미터 : X
	// 반환 값 : List<RoomDTO>
	// 사용 클래스 : RoomController.roomList
	@Override
	public List<RoomDTO> getRoomList() {
		
		return roomMapper.selectRoomList(); 
	}
	
	// 회의실 상세 및 예약 폼
	// 파라미터 : int roomNo
	// 반환 값 : RoomDTO
	// 사용 클래스 : RoomController.roomOne
	@Override
	public RoomDTO getRoomOne(int roomNo) {
		log.debug(TeamColor.GREEN + "roomNo => " + roomNo);
		
		return roomMapper.selectRoomOne(roomNo); 
	}
	
	// 회의실 예약
	// 파라미터 : RoomRsvDTO rsv
	// 반환 값 : X
	// 사용 클래스 : RoomController.roomRsv
	@Override
	public int addRoomRsv(RoomRsvDTO rsv) {
		log.debug(TeamColor.GREEN + "rsv => " + rsv.toString());
		
		return roomMapper.insertRoomRsv(rsv); 
	}
	
	// 선택한 룸번호, 날짜에 예약된 시간을 출력
	// 파라미터 : int roomNo, String rsvDate
	// 반환 값 : List<RoomRsvDTO>
	// 사용 클래스 : RoomController.roomOne
	@Override
	public List<RoomRsvDTO> getReservedTimes(int roomNo, String rsvDate) {
		log.debug(TeamColor.GREEN + "roomNo => " + roomNo);
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		
		return roomMapper.selectReservedTimes(roomNo, rsvDate); 
	}
	
	// 선택된 날짜별 전체 예약리스트 출력
	// 파라미터 : String rsvDate, int currentPage
	// 반환 값 : List<RoomRsvDTO>
	// 사용 클래스 : RoomController.roomRsvList
	@Override
	public List<RoomRsvDTO> getRsvListByDate(String rsvDate, int currentPage) {
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return roomMapper.selectRsvListByDate(rsvDate, beginRow, ROW_PER_PAGE); 
	}
	
	// 선택된 날짜 예약 총 갯수
	// 파라미터 : String rsvDate
	// 반환 값 : int lastPage
	// 사용 클래스 : RoomController.roomRsvList
	@Override
	public int getRsvByDateLastPage (String rsvDate) {
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		
		int cnt = roomMapper.selectRsvCntByDate(rsvDate);
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		return lastPage; 
	}
	
	// 내 예약리스트 출력
	// 파라미터 : int empNo, int currentPage
	// 반환 값 : List<RoomRsvDTO>
	// 사용 클래스 : RoomController.MyRoomRsvList
	@Override
	public List<RoomRsvDTO> getRsvListByEmpNo(int empNo, int currentPage) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return roomMapper.selectRsvListByEmpNo(empNo, beginRow, ROW_PER_PAGE); 
	}
	
	// 내 예약 총 갯수
	// 파라미터 : int empNo
	// 반환 값 : int lastPage
	// 사용 클래스 : RoomController.MyRoomRsvList
	@Override
	public int getRsvByEmpNoLastPage (int empNo) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		int cnt = roomMapper.selectRsvCntByEmpNo(empNo);
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		return lastPage; 
	}
	
	// 예약 취소
	// 파라미터 : RoomRsvDTO rsv
	// 반환 값 : X
	// 사용 클래스 : RoomController.cancleRoomRsv
	@Override
	public int modifyRoomRsv(RoomRsvDTO rsv) {
		log.debug(TeamColor.GREEN + "rsv => " + rsv.toString());
		
		return roomMapper.updateRoomRsv(rsv); 
	}
	
	// 취소된 예약목록
	// 파라미터 : int currentPage
	// 반환 값 : List<HashMap<String, Object>>
	// 사용 클래스 : RoomController.CancleRsvList
	@Override
	public List<HashMap<String, Object>> getCancleRsvList(int currentPage) {
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        log.debug(TeamColor.GREEN + "beginRow => " + beginRow);
        
		return roomMapper.selectCancleRsvList(beginRow, ROW_PER_PAGE);
	}
	
	// 취소된 예약 cnt
	// 파라미터 : X
	// 반환 값 : int
	// 사용 클래스 : RoomController.CancleRsvList
	@Override
	public int getCancleRsvLastPage() {
		
		int cnt = roomMapper.selectCancleRsvCnt();
		log.debug(TeamColor.GREEN + "cnt => " + cnt);
		
		int lastPage = (int) Math.ceil((double) cnt / ROW_PER_PAGE);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		return lastPage;
	}
}
