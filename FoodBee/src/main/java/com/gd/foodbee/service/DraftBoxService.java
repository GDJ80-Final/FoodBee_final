package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.DraftBoxDTO;
import com.gd.foodbee.dto.DraftBoxStateDTO;

public interface DraftBoxService {
	// 전체 기안서리스트
	List<DraftBoxDTO> getAllDocList(int currentPage, int empNo);
	
	// 결재대기리스트
	List<DraftBoxDTO> getZeroDocList(int currentPage, int empNo);
	
	// 결재승인중리스트
	List<DraftBoxDTO> getOneDocList(int currentPage, int empNo);
	
	// 결재승인완료리스트
	List<DraftBoxDTO> getTwoDocList(int currentPage, int empNo);
	
	// 결재반려상태리스트
	List<DraftBoxDTO> getNineDocList(int currentPage, int empNo);
	
	// 결재상태(대기,승인중,승인완료,반려) 총갯수
	DraftBoxStateDTO getStateBox(int empNo);
	
	// 전체 기안서리스트 총갯수
	int countAllDocList(int empNo);
	
	// 결제대기상태 리스트 총갯수
	int countZeroDocList(int empNo);
	
	// 승인중상태 리스트 총갯수
	int countOneDocList(int empNo);
	
	// 승인완료상태 리스트 총갯수
	int countTwoDocList(int empNo);
	
	// 반려상태 리스트 총갯수
	int countNineDocList(int empNo);
	
	// 전체상태 리스트 LastPage
	int getAllDocLastPage(int empNo);
	
	// 대기상태 리스트 LastPage
	int getZeroDocLastPage(int empNo);
	
	// 승인중 리스트 LastPage
	int getOneDocLastPage(int empNo);
	
	// 승인완료 리스트 LastPage
	int getTwoDocLastPage(int empNo);
	
	// 반려 리스트 LastPage
	int getNineDocLastPage(int empNo);
}
