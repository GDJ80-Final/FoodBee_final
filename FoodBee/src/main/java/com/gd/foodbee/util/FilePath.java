package com.gd.foodbee.util;

import java.io.File;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FilePath {
	public String getFilePath() {
		String path = null;
		try {
			path = System.getProperty("user.dir") + "/src/main/resources/static/upload/";
		} catch(Exception e) {
			throw new RuntimeException("경로 세팅 실패", e);
		}
		
		return path;
	}
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
	
}
