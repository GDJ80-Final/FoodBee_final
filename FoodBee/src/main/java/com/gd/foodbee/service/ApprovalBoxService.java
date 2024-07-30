package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;
import com.gd.foodbee.dto.DocReferrerDTO;
import com.gd.foodbee.dto.DraftDocDTO;
import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;

public interface ApprovalBoxService {
	
	// 결재함 전체 리스트
	List<ApprovalBoxDTO> getApprovalListAll(int currentPage, int empNo);
	
	// 미결 리스트
	List<ApprovalBoxDTO> getZeroListAll(int currentPage, int empNo);
	
	// 기결 리스트
	List<ApprovalBoxDTO> getOneListAll(int currentPage, int empNo);
	
	//전체 LastPage
	int getAllLastPage(int empNo);
	
	//기결 LastPage
	int getZeroLastPage(int empNo);
	
	//미결 LastPage
	int getOneLastPage(int empNo);
	
	//전체 상태값
	ApprovalBoxStateDTO getStateBox(int empNo);
	
	//미결 총갯수
	int countZeroState(int empNo);
	
	//기결 총갯수
	int countOneState(int empNo);
	
	//기안서 상세
	Map<String,Object> getDocOne(int draftDocNo);
	
	//기안서 detail 상세
	DraftDocDetailDTO getDocDetailOne(int draftDocNo);
	
	//기안서 detail상세리스트
	List<DraftDocDetailDTO> getDocDetailList(int draftDocNo);
	
	//기안서 파일상세
	List<DraftDocFileDTO> getDocFileOne(int draftDocNo);
	
	//기안서 수신참조자
	Map<String,Object> getDocReferrerOne(int draftDocNo);
	
	//휴가 상세 
	Map<String,Object> getDayOffOne(int draftDocNo);
	
	//중간결재 승인
	int updateMidState(int draftDocNo);
	
	//최종결재 승인
	int updateFinalState(int draftDocNo);
	
	//중간결재 반려
	int updateMidRejection(int draftDocNo, String rejectionReason);
	
	//최종결재 반려
	int updateFinalRejection(int draftDocNo, String rejectionReason);
	
}
