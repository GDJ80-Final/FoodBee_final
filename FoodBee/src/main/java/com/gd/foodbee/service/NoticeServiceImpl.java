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

import com.gd.foodbee.dto.DraftDocFileDTO;
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
    @Autowired 
    private NoticeMapper noticeMapper;
    
    @Autowired 
    private NoticeFileMapper noticeFileMapper;
    
	@Autowired
	private FilePath filePath;
	
	@Autowired
	private FileFormatter fileFormatter;
    
    private static final int ROW_PER_PAGE = 10;
    
    // 전체 공지사항리스트
	// 파라미터 : int currentPage, String dptNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.noticeList,allNoticeList
    @Override
    public List<HashMap<String,Object>> getNoticeList(int currentPage, String dptNo){
        
        int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return noticeMapper.noticeList(dptNo, beginRow, ROW_PER_PAGE);
    }
    
    // 전사원 공지사항리스트
	// 파라미터 : int currentPage
	// 반환값 : List<>
	// 사용클래스 : NoticeController.allEmpList
    @Override
    public List<HashMap<String,Object>> getAllEmpNoticeList(int currentPage){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

        
        return noticeMapper.allEmpNoticeList(beginRow, ROW_PER_PAGE);
    }
    // 부서별 공지사항 리스트
	// 파라미터 : int currentPage, String dptNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.allDptList
    @Override
    public List<HashMap<String,Object>> getAllDptNoticeList(int currentPage, String dptNo){
    	
    	int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

        return noticeMapper.allDptNoticeList(dptNo, beginRow, ROW_PER_PAGE);
    }
    // 전체 공지사항 마지막페이지
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : NoticeController.allNoticeList
    @Override
    public int allLastPage(String dptNo) {
    	int count = noticeMapper.countNoticeList(dptNo);
    	int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);

    	return lastPage;
    }
    // 사원별 공지사항 마지막페이지
	// 파라미터 : void
	// 반환값 : int
	// 사용클래스 : NoticeController.allEmpList
    @Override
    public int allEmpLastPage() {
    	int countEmp = noticeMapper.countEmpNoticeList();
    	int empLastPage = (int) Math.ceil((double) countEmp / ROW_PER_PAGE);

    	return empLastPage;
    }
    // 부서별 공지사항 마지막페이지
	// 파라미터 : String dptNo
	// 반환값 : int
	// 사용클래스 : NoticeController.allDptList
    @Override
    public int allDptLastPage(String dptNo) {
    	int countDpt = noticeMapper.countDptNoticeList(dptNo);
    	int dptLastPage = (int) Math.ceil((double) countDpt / ROW_PER_PAGE);

    	return dptLastPage;
    }
 
    // 공지사항 내용추가
	// 파라미터 : NoticeRequestDTO noticeRequest, HttpServletRequest request
	// 반환값 : X
	// 사용클래스 : NoticeController.addNoticeAction
    @Override
	public void addNotice(NoticeRequestDTO noticeRequest) {
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
	    		String originalFile = fileFormatter.fileFormatter(mf);
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
		        String path = filePath.getFilePath() + "notice_file/";
		        log.debug(TeamColor.PURPLE + "path => "+path);
		        
		        //경로에 저장
				filePath.saveFile(path, originalFile, mf);
	        }
	    }
    }
	// 공지사항 상세보기
	// 파라미터 : int noticeNo
	// 반환값 : List<>
	// 사용클래스 : NoticeController.noticeOne
    @Override
	public List<Map<String,Object>> getNoticeOne(int noticeNo){
		
		return noticeMapper.noticeOne(noticeNo);
	}
    
    
    // 공지사항 내용수정하기
	// 파라미터 : int noticeNo, NoticeRequestDTO noticeRequest, HttpServletRequest request
	// 반환값 : X
	// 사용클래스 : NoticeController.modifyNoticeAction
    @Override
    public void getModifyNoticeList(int noticeNo, 
    		NoticeRequestDTO noticeRequest) {
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
            if (mf.getOriginalFilename() != null && !mf.getOriginalFilename().isEmpty()) { 
	    		String originalFile = fileFormatter.fileFormatter(mf);
	    		
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
				String path = filePath.getFilePath() + "notice_file/";
				log.debug(TeamColor.PURPLE + "path => "+path);
				//경로에 저장
				filePath.saveFile(path, originalFile, mf);
	        }	
    	}
	}

    // 공지사항 파일 삭제하기
	// 파라미터 : String fileName, int noticeNo, String[] existingFileList
	// 반환값 : X
	// 사용클래스 : NoticeController.deleteNoticeFile
    @Override
    public void getDeleteNoticeFile(String fileName, int noticeNo, String[] existingFileList) {
    	//삭제할 파일이 들어있는 경로
    	String path = filePath.getFilePath() + "notice_file/";
    	List<NoticeFileDTO> fileList = noticeFileMapper.selectNoticeFileList(noticeNo);
		log.debug(TeamColor.PURPLE + "path => "+path);
		log.debug(TeamColor.PURPLE + "fileList=>" + fileList);
		
		int existingFileListLength;
		if(existingFileList == null) {
			existingFileListLength = 0;
			existingFileList = new String[0];
		} else {
			existingFileListLength = existingFileList.length;
		}
		
		// 둘이 같을 경우 기존 파일 변화 x
		if(fileList.size() != existingFileListLength) {
			if(fileList != null) {
				int fileListRow = noticeFileMapper.deleteNoticeFile2(noticeNo);
				if(fileList.size() != fileListRow) {
					log.debug("데이터베이스 파일 삭제 개수 잘못됨");
					throw new RuntimeException();
				}
				for(NoticeFileDTO file : fileList) {
					boolean delete = true;
					for(String existingFile : existingFileList) {
						if(existingFile.equals(file.getOriginalFile())) {
							delete = false;
						}
					}
					if(delete == true) {
						String result = filePath.deleteFile(path, file.getOriginalFile());
						log.debug(TeamColor.RED + "file.getOriginalFile() => " + file.getOriginalFile().toString());
						if(result.equals("fail")) {
							log.debug("파일 삭제 실패");
							throw new RuntimeException();
						}
					} else {
						NoticeFileDTO noticeFileDTO = NoticeFileDTO.builder()
								.noticeNo(noticeNo)
								.originalFile(file.getOriginalFile())
								.saveFile(file.getSaveFile())
								.type(file.getType())
								.build();
						log.debug(TeamColor.RED + "noticeFileDTO =>" + noticeFileDTO.toString());
						int fileRow = noticeFileMapper.insertNoticeFile(noticeFileDTO);
						if(fileRow != 1) {
							throw new RuntimeException();
						}
					}
				}
			}
		}
		
//    	//DTO랑 맞춰주는작업
//        NoticeFileDTO noticeFileDTO = NoticeFileDTO.builder()
//        			.noticeNo(noticeNo)
//        			.saveFile(fileName)
//        			.originalFile(existingFileList)
//        			.build();
        
       // noticeFileMapper.deleteNoticeFile(noticeFileDTO);
    }
	
	// 공지사항 삭제하기
	// 파라미터 : int noticeNo
	// 반환값 : int
	// 사용클래스 : NoticeController.deleteNotice
    @Override
	public int getDeleteNotice(int noticeNo) {
    	List<NoticeFileDTO> fileList = noticeFileMapper.selectNoticeFileList(noticeNo);
		int delete = noticeMapper.deleteNotice(noticeNo);		
	    String path = filePath.getFilePath() + "notice_file/";
	       
	      for(NoticeFileDTO file : fileList) {
	         String result = filePath.deleteFile(path, file.getOriginalFile());
	         log.debug(TeamColor.RED + "file.getOriginalFile() => " + file.getOriginalFile().toString());
	         if(result.equals("fail")) {
	            log.debug("파일 삭제 실패");
	            delete = 0;
	            throw new RuntimeException();
	         }
	      }
	      
		return delete;
	}
}