package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.DraftBoxDTO;
import com.gd.foodbee.dto.DraftBoxStateDTO;

public interface DraftBoxService {
	// 전체 기안서리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<DraftBoxDTO>
	// 사용클래스 : DraftBoxController.allDocList
	List<DraftBoxDTO> getAllDocList(int currentPage, int empNo);
	
	// 결재대기리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<DraftBoxDTO>
	// 사용클래스 : DraftBoxController.zeroDocList
	List<DraftBoxDTO> getZeroDocList(int currentPage, int empNo);
	
	// 결재승인중리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<DraftBoxDTO>
	// 사용클래스 : DraftBoxController.oneDocList
	List<DraftBoxDTO> getOneDocList(int currentPage, int empNo);
	
	// 결재승인완료리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<DraftBoxDTO>
	// 사용클래스 : DraftBoxController.twoDocList
	List<DraftBoxDTO> getTwoDocList(int currentPage, int empNo);
	// 결재반려상태리스트
	// 파라미터 : int currentPage, int empNo
	// 반환값 : List<DraftBoxDTO>
	// 사용클래스 : DraftBoxController.nineDocList
	List<DraftBoxDTO> getNineDocList(int currentPage, int empNo);
	
	// 결재상태(대기,승인중,승인완료,반려) 총갯수
	// 파라미터 : int empNo
	// 반환값 : DraftBoxStateDTO
	// 사용클래스 : DraftBoxController.draftBox
	DraftBoxStateDTO getStateBox(int empNo);
	
	// 전체 기안서리스트 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	int countAllDocList(int empNo);
	
	// 결제대기상태 리스트 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	int countZeroDocList(int empNo);
	
	// 승인중상태 리스트 총갯수
	// 파라미터 : int empNo;
	// 반환값 : int
	int countOneDocList(int empNo);
	
	// 승인완료상태 리스트 총갯수
	// 파라미터 : int empNo;
	// 반환값 : int
	int countTwoDocList(int empNo);
	
	// 반려상태 리스트 총갯수
	// 파라미터 : int empNo;
	// 반환값 : int
	int countNineDocList(int empNo);
	
	// 전체상태 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : DraftBoxController.allDocList
	int getAllDocLastPage(int empNo);
	
	// 대기상태 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : DraftBoxController.zeroDocList
	int getZeroDocLastPage(int empNo);
	
	// 승인중 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : DraftBoxController.zeroDocList
	int getOneDocLastPage(int empNo);
	
	// 승인완료 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : DraftBoxController.twoDocList
	int getTwoDocLastPage(int empNo);
	
	// 반려 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : DraftBoxController.nineDocList
	int getNineDocLastPage(int empNo);
}
