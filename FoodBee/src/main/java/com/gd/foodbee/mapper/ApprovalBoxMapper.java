package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;

import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;

@Mapper
public interface ApprovalBoxMapper {
	// 결재함 전체 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxService.getApprovalListAll
	List<ApprovalBoxDTO> getApprovalListAll(int empNo,int beginRow, int rowPerPage);
	
	// 결재함 미결 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxService.getZeroListAll
	List<ApprovalBoxDTO> getZeroListAll(int empNo, int beginRow, int rowPerPage);
	
	// 결재함 기결 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxService.getOneListAll
	List<ApprovalBoxDTO> getOneListAll(int empNo, int beginRow, int rowPerPage);
	
	// 결재함 전체 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : ApprovalBoxService.getAllLastPage
	int countAllList(int empNo);
	
	// 결재함 미결 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : approvalBoxService.countZeroState
	int countZeroTypeList(int empNo);
	
	// 결재함 기결 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : approvalBoxService.countOneState
	int countOneTypeList(int empNo);
	
	// 결재함 기안문서 상태 총갯수
	// 파라미터 : int empNo
	// 반환값 : com.gd.foodbee.dto.ApprovalBoxStateDTO
	// 사용클래스 : approvalBoxService.getStateBox
	ApprovalBoxStateDTO getStateBox(int empNo);
	
	// 기안서 상세보기
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocDTO
	// 사용클래스 : approvalBoxService.getDocOne
	Map<String,Object> getDocOne(int draftDocNo);
	
	// 기안서 detail 상세보기
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocDetailDTO
	// 사용클래스 : approvalBoxService.getDocDetailOne
	DraftDocDetailDTO getDocDetailOne(int draftDocNo);
	
	// 기안서 detailList로 출력 
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocDetailDTO
	// 사용클래스 : approvalBoxService.getDocDetailList
	List<DraftDocDetailDTO> getDocDetailList(int draftDocNo);
	
	// 기안서 파일 상세
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocFileDTO
	// 사용클래스 : ApprovalBoxService.getDocFileOne
	List<DraftDocFileDTO> getDocFileOne(int draftDocNo);
	
	// 기안서 수신참조자
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DocReferrerDTO
	// 사용클래스 : approvalBoxService.getDocReferrerOne
	Map<String,Object> getDocReferrerOne(int draftDocNo);
	
	// 휴가 상세보기
	// 파라미터 : int draftDocNo
	// 반환값 : Map
	// 사용클래스 : approvalBoxService.getDayOffOne
	Map<String,Object> getDayOffOne(int draftDocNo);
	
	// 중간결재 승인
	// 파라미터 : int draftDocNo
	// 반환값 : int
	// 사용클래스 : approvalBoxService.updateMidState
	int updateMidState(int draftDocNo);
	
	// 최종결재 승인
	// 파라미터 : int draftDocNo
	// 반환값 : int
	// 사용클래스 : approvalBoxService.updateFinalState
	int updateFinalState(int draftDocNo);
	
	// 중간결재 반려
	// 파라미터 : draftDocNo, rejectionReason
	// 반환값 : int
	// 사용클래스 : approvalBoxService.updateMidState
	int updateMidRejection(int draftDocNo, String rejectionReason);
	
	// 최종결재 반려
	// 파라미터 : draftDocNo, rejectionReason
	// 반환값 : int
	// 사용클래스 : approvalBoxService.updateMidRejection
	int updateFinalRejection(int draftDocNo, String rejectionReason);
	
	// 출장 테이블insert
	// 파라미터 : Map
	// 반환값 : int
	int insertBusinessTrip(Map<String, Object> m);
	
	// 휴가테이블 insert
	// 파라미터 : Map
	// 반환값 : int
	int insertDayOffTrip(Map<String, Object> m);
	
	// 매출테이블 insert
	// 파라미터 : Map
	// 반환값 : int
	int insertRevenue(Map<String, Object> m);
}
