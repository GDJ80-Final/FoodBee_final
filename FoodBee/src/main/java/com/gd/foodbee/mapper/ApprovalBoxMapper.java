package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;

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
}
