package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.NoticeDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeMapper {
	// 전체 공지사항
    // 파라미터 : "HashMap" 
  	// 반환값 : "HashMap"
	// 사용클래스 : NoticeService.getNoticeList
    List<HashMap<String, Object>> noticeList(String dptNo, int beginRow, int rowPerPage);
    
    //전사원별 공지사항
    //파라미터:"HashMap" 
  	//반환값:"HashMap"
    //사용클래스:NoticeService.getAllEmpNoticeList
    List<HashMap<String,Object>> allEmpNoticeList(int beginRow, int rowPerPage);
    
    // 부서별 공지사항
    // 파라미터 : "HashMap" 
  	// 반환값 : "HashMap"
    // 사용클래스 : NoticeService.getAllDptNoticeList
    List<HashMap<String,Object>> allDptNoticeList(String dptNo, int beginRow, int rowPerPage);
   
    // 전체공지사항의 총갯수 구하기
    // 반환값 : "int"
    // 사용클래스 : NoticeService.getCountnoticeList
    int countNoticeList(String dptNo);
    
    // 전사원별공지사항 총갯수 구하기
    // 반환값 : "int"
    // 사용클래스 : NoticeService.getCountEmpNoticeList
    int countEmpNoticeList();
    
    // 부서별공지사항 총갯수 구하기
    // 반환값 : "int"
    // 사용클래스 : NoticeService.getCountDptNoticeList
    int countDptNoticeList(String DptNo);
    
    // 공지사항 추가하기
    // 반환값 : "int"
    // 사용클래스 : NoticeService.addNotice
    int insertNotice(NoticeDTO noticeDTO);
    
    // 공지사항 상세보기
    // 파라미터 : "int"
    // 반환값 : "List<Map<String,Object>"
    // 사용클래스 : "NoticeService."
    List<Map<String,Object>> noticeOne(int noticeNo);
    
    // 공지사항 내용수정하기
    // 파라미터 : "int"
    // 사용클래스 : NoticeService.getModifyNoticeList
    int updateNotice(NoticeDTO noticeDTO);
    
    // 공지사항 삭제하기
    // 파라미터 : "int"
    // 반환값 : "int"
    // 사용클래스 : "NoticeService.get
    int deleteNotice(int noticeNo);
}