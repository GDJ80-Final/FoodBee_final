package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.NoticeRequest;

public interface NoticeService {
	//전체 공지사항List
	List<HashMap<String,Object>> getNoticeList(int currentPage, int rowPerPage, String dptNo);
	//전사원 공지사항List
	List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage, int rowPerPage);
	//부서별 공지사항List
	List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, int rowPerPage, String dptNo);
	//전체공지사항 count
	int getCountNoticeList();
	//전사원별 공지사항 count
	int getCountEmpNoticeList();
	//부서별 공지사항 count
	int getCountDptNoticeList();
	//공지사항 추가
	void addNotice(NoticeRequest noticeRequest);
	//공지사항 상세보기(다중파일때문에 List로)
	List<Map<String,Object>> getNoticeOne(int noticeNo);
	//공지사항 삭제
	int getDeleteNotice(int noticeNo);
}
