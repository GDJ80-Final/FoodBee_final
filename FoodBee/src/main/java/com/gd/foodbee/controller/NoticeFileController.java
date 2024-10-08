package com.gd.foodbee.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticeFileController {
	
	@Autowired
	private FilePath filePath;
	
    
	// 파일 다운로드
	// 파라미터 : String fileName 
	// 반환값 : ResponseEntity
	// 사용페이지 : noticeOne
    @GetMapping("/download")
    public ResponseEntity<InputStreamResource> downloadFile(@RequestParam(name="file") String filename,
			@RequestParam(name="saveFile") String saveFileName) {
	
	    // 실제 파일이 저장된 경로
	    String path = filePath.getFilePath()+"notice_file/";
	    File file = new File(path + File.separator + filename);
	
	    // 로그로 경로 확인
	    log.debug(TeamColor.YELLOW + "file =>" + file.getAbsolutePath());
	
	    // 파일 존재 여부 확인
	    if (!file.exists()) {
	        return ResponseEntity.notFound().build();
	    }
	
	    try {
	        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
	        return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + saveFileName)
	                .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                .contentLength(file.length())
	                .body(resource);
	    } catch (FileNotFoundException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).build();
	    }
	}   
}