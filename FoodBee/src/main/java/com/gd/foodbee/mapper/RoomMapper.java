package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;

@Mapper
public interface RoomMapper {
	
	// 회의실 목록
	// 파라미터 : X
	// 반환값 : List<RoomRsvDTO>
	// 사용클래스 : RoomServiceImpl.getRoomList
	List<RoomDTO> selectRoomList();
	
	// 회의실 상세보기 및 예약폼
	// 파라미터 : int roomNo
	// 반환값 : RoomDTO
	// 사용클래스 : RoomServiceImpl.getRoomOne
	RoomDTO selectRoomOne(int roomNo);
	
	// 회의실 상세보기 이미지
	// 파라미터 : int roomNo
	// 반환값 : RoomDTO
	// 사용클래스 : RoomServiceImpl.getRoomOne
	List<RoomDTO> selectRoomOneImg(int roomNo); 
	
	// 회의실 예약
	// 파라미터 : RoomRsvDTO roomRsvDTO
	// 반환값 : X
	// 사용클래스 : RoomServiceImpl.addRoomRsv
	int insertRoomRsv(RoomRsvDTO roomRsvDTO);
	
	// 선택한 룸번호, 날짜에 예약된 시간을 출력
	// 파라미터 : int roomNo, String rsvDate
	// 반환값 : List<RoomRsvDTO>
	// 사용클래스 : RoomServiceImpl.getReservedTimes
	List<RoomRsvDTO> selectReservedTimes(int roomNo, String rsvDate);
	
	// 선택된 날짜별 전체 예약리스트 출력
	// 파라미터 : HashMap<String,Object> m (beginRow, ROW_PER_PAGE, rsvDate)
	// 반환값 : List<RoomRsvDTO>
	// 사용클래스 : RoomServiceImpl.getRsvListByDate
	List<RoomRsvDTO> selectRsvListByDate( String rsvDate, int beginRow, int rowPerPage);
	
	// 선택된 날짜 예약 총 갯수
	// 파라미터 : String rsvDate
	// 반환값 : int
	// 사용클래스 : RoomServiceImpl.getRsvByDateLastPage
	int selectRsvCntByDate(String rsvDate);
	
	// 내 예약리스트 출력
	// 파라미터 : HashMap<String,Object> m (beginRow, ROW_PER_PAGE, empNo)
	// 반환값 : List<RoomRsvDTO>
	// 사용클래스 : RoomServiceImpl.getRsvListByEmpNo
	List<RoomRsvDTO> selectRsvListByEmpNo(int empNo, int beginRow, int rowPerPage);
	
	// 내 예약 총 갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : RoomServiceImpl.getRsvByEmpNoLastPage
	int selectRsvCntByEmpNo(int empNo);
	
	// 예약 취소
	// 파라미터 : RoomRsvDTO rsv
	// 반환값 : int
	// 사용클래스 : RoomServiceImpl.modifyRoomRsv
	int updateRoomRsv(RoomRsvDTO rsv);
	
	
}
