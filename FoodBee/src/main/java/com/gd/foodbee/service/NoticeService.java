package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.NoticeRequestDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface NoticeService {
	// 전체 공지사항List
	// 파라미터 : int currentPage, String dptNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.noticeList,allNoticeList
	List<HashMap<String,Object>> getNoticeList(int currentPage, String dptNo);
	
	// 전사원 공지사항List
	// 파라미터 : int currentPage
	// 반환값 : List<>
	// 사용클래스 : NoticeController.allEmpList
	List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage);
	
	// 부서별 공지사항List
	// 파라미터 : int currentPage, String dptNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.allDptList
	List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, String dptNo);
	
	
	// 전체 공지사항 마지막페이지
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : NoticeController.allNoticeList
	int allLastPage(String dptNo);
	
	// 사원별 공지사항 마지막페이지
	// 파라미터 : X
	// 반환값 : int
	// 사용클래스 : NoticeController.allEmpList
	int allEmpLastPage();
	
	// 부서별 공지사항 마지막페이지
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : NoticeController.allDptList
	int allDptLastPage(String dptNo);
	
	// 공지사항 추가
	// 파라미터 : NoticeRequestDTO noticeRequest, HttpServletRequest request
	// 반환값 : X
	// 사용클래스 : NoticeController.addNoticeAction
	void addNotice(NoticeRequestDTO noticeRequest, HttpServletRequest request);
	
	// 공지사항 상세보기(다중파일때문에 List로)
	// 파라미터 : int noticeNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.noticeOne
	List<Map<String,Object>> getNoticeOne(int noticeNo);
	
	// 공지사항 내용수정하기
	// 파라미터 : int noticeNo, NoticeRequestDTO noticeRequest, HttpServletRequest request
	// 반환값 : X
	// 사용클래스 : NoticeController.modifyNoticeAction
	void getModifyNoticeList(int noticeNo, NoticeRequestDTO noticeRequest, HttpServletRequest request);
	
	// 공지사항 파일삭제
	// 파라미터 : String fileName, int noticeNo
	// 반환값 : X
	// 사용클래스 : NoticeController.deleteNoticeFile
	void getDeleteNoticeFile(String fileName, int noticeNo);
	
	// 공지사항 삭제
	// 파라미터 : int noticeNo
	// 반환값 : int
	// 사용클래스 : NoticeController.deleteNotice
	int getDeleteNotice(int noticeNo);
}
