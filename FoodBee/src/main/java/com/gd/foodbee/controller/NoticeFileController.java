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

import com.gd.foodbee.service.NoticeService;

import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
public class NoticeFileController {
	@Autowired NoticeService noticeService;
	
	@GetMapping("/download")
	   public ResponseEntity<InputStreamResource> downloadFile(@RequestParam("file") String filename) {
	        //inputStream = 클라이언트에게 데이터를 전송할때 많이사용
	       
	        log.info("file : " + "c:/upload/" + filename);
	        File file = new File("c:/upload/" + filename);

	        if (!file.exists()) {
	            return ResponseEntity.notFound().build();
	        }

	        try {
	            InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
	            return ResponseEntity.ok()
	                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + file.getName())
	                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                    .contentLength(file.length())
	                    .body(resource);
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	            return ResponseEntity.status(500).build();
	        }
	    }
}
