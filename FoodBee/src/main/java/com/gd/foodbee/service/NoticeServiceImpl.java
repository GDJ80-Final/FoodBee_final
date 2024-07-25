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
import com.gd.foodbee.dto.NoticeRequestDTO;
import com.gd.foodbee.mapper.NoticeFileMapper;
import com.gd.foodbee.mapper.NoticeMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
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
    public int allLastPage(String dptNo) {
    	int count = noticeMapper.countNoticeList(dptNo);
    	int lastPage = (int) Math.ceil((double) count / rowPerPage);

    	
    	return lastPage;
    }
    //사원별 공지사항 마지막페이지
    @Override
    public int allEmpLastPage() {
    	int countEmp = noticeMapper.countEmpNoticeList();
    	int empLastPage = (int) Math.ceil((double) countEmp / rowPerPage);

    	return empLastPage;
    }
    //부서별 공지사항 마지막페이지
    @Override
    public int allDptLastPage(String dptNo) {
    	int countDpt = noticeMapper.countDptNoticeList(dptNo);
    	int dptLastPage = (int) Math.ceil((double) countDpt / rowPerPage);

    	return dptLastPage;
    }
 
    //공지사항 내용추가
    @Override
	public void addNotice(NoticeRequestDTO noticeRequest, HttpServletRequest request) {
		NoticeDTO notice = NoticeDTO.builder()
					.writerEmpNo(noticeRequest.getWriterEmpNo())
					.title(noticeRequest.getTitle())
					.content(noticeRequest.getContent())
					.type(noticeRequest.getType())
					.dptNo(noticeRequest.getDptNo())
					.build();
		
		int add = noticeMapper.insertNotice(notice);
		
		if(add != 1) {
			throw new RuntimeException("내용입력에실패했음"); 
		}
		
		MultipartFile[] mfs = noticeRequest.getFiles();
    	
    	if(mfs.length !=0) {
	    
	    	for(MultipartFile mf : mfs) {
	    		String originalFile = FileFormatter.fileFormatter(mf);
	    		log.debug(TeamColor.PURPLE + "originalFile=>" + originalFile);
	    		
	    		  NoticeFileDTO file = NoticeFileDTO.builder()
		        			.noticeNo(notice.getNoticeNo())
		        			.originalFile(originalFile)
		        			.saveFile(mf.getOriginalFilename())
		        			.type(mf.getContentType())
		        			.build();
		        
		        int row2 = noticeFileMapper.insertNoticeFile(file);
		        if (row2 != 1) {
		            throw new RuntimeException("파일입력실패");
		        }
		        
		        // 파일 저장
		        String path = FilePath.getFilePath() + "notice_file/";
		        log.debug(TeamColor.PURPLE + "path => "+path);
		        
		        //경로에 저장
				FilePath.saveFile(path, originalFile, mf);
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
    public void getModifyNoticeList(int noticeNo, 
    		NoticeRequestDTO noticeRequest,
    		HttpServletRequest request) {
    	NoticeDTO notice = NoticeDTO.builder()
    				.noticeNo(noticeNo)
    				.title(noticeRequest.getTitle())
    				.content(noticeRequest.getContent())
    				.type(noticeRequest.getType())
    				.build();    	
    	
    	int update = noticeMapper.updateNotice(notice);
    	
    	if(update != 1) {
    		throw new RuntimeException("내용수정에 실패하였음"); 
    	}
    	
    	MultipartFile[] mfs = noticeRequest.getFiles();
    	//파일이 없는경우
    	if(mfs.length ==0 || mfs == null) {
    		log.debug(TeamColor.PURPLE + "수정할 파일없어요");
    		return;
    	}
    	//파일이 있는경우
    	for(MultipartFile mf : mfs) {
    		String originalFile = FileFormatter.fileFormatter(mf);
    		
    		log.debug(TeamColor.PURPLE + "originalFile=>" + originalFile);
    		
    	    NoticeFileDTO file = NoticeFileDTO.builder()
        			.noticeNo(noticeNo)
        			.originalFile(originalFile)
        			.saveFile(mf.getOriginalFilename())
        			.type(mf.getContentType())
        			.build();
    	    
          int update2 = noticeFileMapper.insertNoticeFile(file);
         
	    	  if (update2 != 1) {
	  	            throw new RuntimeException("파일입력실패");
	  	      }
    	  
    	  	// 파일 저장
			String path = FilePath.getFilePath() + "notice_file/";
			log.debug(TeamColor.PURPLE + "path => "+path);
			//경로에 저장
			FilePath.saveFile(path, originalFile, mf);
        }	
	}

  
   
    //공지사항 파일 삭제하기
    @Override
    public void getDeleteNoticeFile(String fileName, int noticeNo) {
    	//DTO랑 맞춰주는작업
        NoticeFileDTO noticeFileDTO = NoticeFileDTO.builder()
        			.noticeNo(noticeNo)
        			.saveFile(fileName)
        			.build();
        
        noticeFileMapper.deleteNoticeFile(noticeFileDTO);
    }
	
	//공지사항 삭제하기
    @Override
	public int getDeleteNotice(int noticeNo) {
		int delete = noticeMapper.deleteNotice(noticeNo);
		
		return delete;
	}
	
}