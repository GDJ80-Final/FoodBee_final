package com.gd.foodbee.util;

import java.io.File;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FilePath {
	
	// 파일 경로
	public String getFilePath() {
		String path = null;
		try {
			path = System.getProperty("user.dir") + "/src/main/resources/static/upload/";
		} catch(Exception e) {
			throw new RuntimeException("경로 세팅 실패", e);
		}
		
		return path;
	}
	
	// 파일 저장
	public String saveFile(String path, String originalFile,MultipartFile mf) {
		File emptyFile = new File(path+originalFile);

		try {
			mf.transferTo(emptyFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} 
		
		return "success";
	}
	
	// 파일 삭제
	public String deleteFile(String path, String originalFile) {
		if(originalFile != null) {
			File f = new File(path+originalFile);
			if(f.exists()) {
				f.delete();
				return "success";
			}
		}
		
		return "fail";
	}
	
}
