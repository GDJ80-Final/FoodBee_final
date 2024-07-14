package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.gd.foodbee.dto.NoticeDTO;
import com.gd.foodbee.dto.NoticeFileDTO;
import com.gd.foodbee.dto.NoticeRequest;
import com.gd.foodbee.mapper.NoticeFileMapper;
import com.gd.foodbee.mapper.NoticeMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeService {
    @Autowired NoticeMapper noticeMapper;
    @Autowired NoticeFileMapper noticeFileMapper;
    //전체 공지사항리스트
    public List<HashMap<String,Object>> getNoticeList(int currentPage, int rowPerPage, String dptNo){
        
        int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        m.put("dptNo", dptNo);
        
        return noticeMapper.noticeList(m);
    }
    
    //전사원 공지사항리스트
    public List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage, int rowPerPage){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return noticeMapper.allEmpNoticeList(m);
    }
    //부서별 공지사항 리스트
    public List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, int rowPerPage, String dptNo){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        m.put("dptNo", dptNo);
        
        return noticeMapper.allDptNoticeList(m);
    }
    
    //공지사항 총갯수
    public int getCountNoticeList() {
    	int count = noticeMapper.countNoticeList();
    	
    	return count;
    }
    //공지사항 전사원별 총갯수
    //공지사항 부서별 총갯수
 
    //공지사항 내용추가
	public void addNotice(NoticeRequest noticeRequest) {
		NoticeDTO notice = new NoticeDTO();
		
		notice.setWriterEmpNo(noticeRequest.getWriterEmpNo());
		notice.setTitle(noticeRequest.getTitle());
		notice.setContent(noticeRequest.getContent());
		notice.setType(noticeRequest.getType());
		notice.setDptNo(noticeRequest.getDptNo());
		
		int add = noticeMapper.insertNotice(notice);
		
		if(add != 1) {
			throw new RuntimeException("내용입력에실패했음"); 
		}
		
	    MultipartFile[] mfs = noticeRequest.getFiles();
	    //파일 여러개 넣는방법
	    //1. MultipartFile을 배열[]로만든다
	    //2. for문으로 각 파일(mf)에 대한 처리를 해준다.
	    for (MultipartFile mf : mfs) {
	        if (mf.isEmpty()) {
	            continue; // 파일이 없는 경우 스킵
	        }
	        
	        NoticeFileDTO file = new NoticeFileDTO();
	        file.setNoticeNo(notice.getNoticeNo());
	        file.setOriginalFile(mf.getOriginalFilename());
	        file.setType(notice.getType());
	        
	        // setSaveFile() 저장될 파일 이름은 UUID 사용
	        String prefix = UUID.randomUUID().toString().replace("-", "");
	        String suffix = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
	        file.setSaveFile(prefix + suffix);
	        
	        int row2 = noticeFileMapper.insertNoticeFile(file);
	        if (row2 != 1) {
	            throw new RuntimeException("파일입력실패");
	        }
	        
	        // 파일 저장
	        File emptyFile = new File("c:/upload/" + prefix + suffix);
	        try {
	            mf.transferTo(emptyFile);
	        } catch (IOException e) {
	            e.printStackTrace();
	            throw new RuntimeException("파일업로드 실패");
	        }
	    }
	}
	//공지사항 상세보기
	public List<Map<String,Object>> getNoticeOne(int noticeNo){
		
		return noticeMapper.noticeOne(noticeNo);
	}
	
	//공지사항 삭제하기
	public int getDeleteNotice(int noticeNo) {
		int delete = noticeMapper.deleteNotice(noticeNo);
		
		return delete;
	}
	
}