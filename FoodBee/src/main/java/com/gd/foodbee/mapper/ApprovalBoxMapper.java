package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;
import com.gd.foodbee.dto.DocReferrerDTO;
import com.gd.foodbee.dto.DraftDocDTO;
import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;

@Mapper
public interface ApprovalBoxMapper {
	// 결재함 전체 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxController.approvalListAll
	List<ApprovalBoxDTO> getApprovalListAll(int empNo,int beginRow, int rowPerPage);
	
	// 결재함 미결 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxController.approvalListAll
	List<ApprovalBoxDTO> getZeroListAll(int empNo, int beginRow, int rowPerPage);
	
	// 결재함 기결 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<ApprovalBoxDTO>
	// 사용클래스 : ApprovalBoxController.approvalListAll
	List<ApprovalBoxDTO> getOneListAll(int empNo, int beginRow, int rowPerPage);
	
	// 결재함 전체 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	int countAllList(int empNo);
	
	// 결재함 미결 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	int countZeroTypeList(int empNo);
	
	// 결재함 기결 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	int countOneTypeList(int empNo);
	
	// 결재함 기안문서 상태 총갯수
	// 파라미터 : int empNo
	//반환값 : com.gd.foodbee.dto.ApprovalBoxStateDTO
	ApprovalBoxStateDTO getStateBox(int empNo);
	
	// 기안서 상세보기
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocDTO
	Map<String,Object> getDocOne(int draftDocNo);
	
	// 기안서 detail 상세보기
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocDetailDTO
	DraftDocDetailDTO getDocDetailOne(int draftDocNo);
	
	// 기안서 detailList로 출력 
	List<DraftDocDetailDTO> getDocDetailList(int draftDocNo);
	
	// 기안서 파일 상세
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DraftDocFileDTO
	List<DraftDocFileDTO> getDocFileOne(int draftDocNo);
	
	// 기안서 수신참조자
	// 파라미터 : int draftDocNo
	// 반환값 : com.gd.foodbee.dto.DocReferrerDTO
	Map<String,Object> getDocReferrerOne(int draftDocNo);
	
	// 휴가 상세보기
	// 파라미터
	// 반환값
	Map<String,Object> getDayOffOne(int draftDocNo);
}
