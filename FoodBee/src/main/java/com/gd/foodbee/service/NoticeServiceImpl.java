package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
public class NoticeServiceImpl implements NoticeService{
    @Autowired NoticeMapper noticeMapper;
    @Autowired NoticeFileMapper noticeFileMapper;
    final int rowPerPage= 10;
    
    //전체 공지사항리스트
    @Override
    public List<HashMap<String,Object>> getNoticeList(int currentPage, String dptNo){
        
        int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        m.put("dptNo", dptNo);
        
        return noticeMapper.noticeList(m);
    }
    
    //전사원 공지사항리스트
    @Override
    public List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return noticeMapper.allEmpNoticeList(m);
    }
    //부서별 공지사항 리스트
    @Override
    public List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, String dptNo){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        HashMap<String,Object> m = new HashMap<String,Object>();
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        m.put("dptNo", dptNo);
        
        return noticeMapper.allDptNoticeList(m);
    }
    //전체 공지사항 마지막페이지
    @Override
    public int allLastPage() {
    	int count = noticeMapper.countNoticeList();
    	int lastPage = (int) Math.ceil((double) count / rowPerPage);
    	
    	if(lastPage % 2 != 0) {
	    	lastPage = lastPage +1;
	    }
    	
    	return lastPage;
    }
    //사원별 공지사항 마지막페이지
    @Override
    public int allEmpLastPage() {
    	int countEmp = noticeMapper.countEmpNoticeList();
    	int empLastPage = (int) Math.ceil((double) countEmp / rowPerPage);
    	
    	if(empLastPage % 2 != 0) {
	    	empLastPage = empLastPage +1;
	    }
    	
    	return empLastPage;
    }
    //부서별 공지사항 마지막페이지
    @Override
    public int allDptLastPage() {
    	int countDpt = noticeMapper.countDptNoticeList();
    	int dptLastPage = (int) Math.ceil((double) countDpt / rowPerPage);
    	
    	if(dptLastPage % 2 != 0) {
	    	dptLastPage = dptLastPage +1;
	    }
    	return dptLastPage;
    }
 
    //공지사항 내용추가
    @Override
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
	        
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
	        String prefix = now.format(formatter);
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
    @Override
	public List<Map<String,Object>> getNoticeOne(int noticeNo){
		
		return noticeMapper.noticeOne(noticeNo);
	}
    
    
    //공지사항 내용수정하기
    @Override
    public void getModifyNoticeList(int noticeNo, NoticeRequest noticeRequest) {
    	NoticeDTO notice = new NoticeDTO();
    	notice.setNoticeNo(noticeNo);
    	notice.setTitle(noticeRequest.getTitle());
    	notice.setContent(noticeRequest.getContent());
    	notice.setType(noticeRequest.getType());
    
    	int update = noticeMapper.updateNotice(notice);
    	
    	if(update != 1) {
    		throw new RuntimeException("내용수정에 실패하였음"); 
    	}
    	
    	MultipartFile[] mfs = noticeRequest.getFiles();
    	
    	for(MultipartFile mf : mfs) {
    		 if (mf.isEmpty()) {
  	            continue; // 파일이 없는 경우 스킵
  	        }
  	        
  	        NoticeFileDTO file = new NoticeFileDTO();
  	        file.setNoticeNo(noticeNo);
  	        file.setOriginalFile(mf.getOriginalFilename());
  	        file.setType("default"); 
  	        
  	      LocalDateTime now = LocalDateTime.now();
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
          String prefix = now.format(formatter);

          String suffix = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
          file.setSaveFile(prefix + suffix);
		
          int update2 = noticeFileMapper.insertNoticeFile(file);
         
    	  if (update2 != 1) {
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
   
    //공지사항 파일 삭제하기
    @Override
    public void getDeleteNoticeFile(String fileName, int noticeNo) {
    	//DTO랑 맞춰주는작업
        NoticeFileDTO noticeFileDTO = new NoticeFileDTO();
        noticeFileDTO.setNoticeNo(noticeNo);
        noticeFileDTO.setSaveFile(fileName);
        
        noticeFileMapper.deleteNoticeFile(noticeFileDTO);
    }
	
	//공지사항 삭제하기
    @Override
	public int getDeleteNotice(int noticeNo) {
		int delete = noticeMapper.deleteNotice(noticeNo);
		
		return delete;
	}
	
}