package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.NoticeRequestDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface NoticeService {
	// 전체 공지사항List
	List<HashMap<String,Object>> getNoticeList(int currentPage, String dptNo);
	
	// 전사원 공지사항List
	List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage);
	
	// 부서별 공지사항List
	List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, String dptNo);
	
	// 전체 공지사항 마지막페이지
	int allLastPage(String dptNo);
	
	// 사원별 공지사항 마지막페이지
	int allEmpLastPage();
	
	// 부서별 공지사항 마지막페이지
	int allDptLastPage(String dptNo);
	
	// 공지사항 추가
	void addNotice(NoticeRequestDTO noticeRequest);
	
	// 공지사항 상세보기(다중파일때문에 List로)
	List<Map<String,Object>> getNoticeOne(int noticeNo);
	
	// 공지사항 내용수정하기
	void getModifyNoticeList(int noticeNo, NoticeRequestDTO noticeRequest);
	
	// 공지사항 파일삭제
	void getDeleteNoticeFile(String fileName, int noticeNo);
	
	// 공지사항 삭제
	int getDeleteNotice(int noticeNo);
}
