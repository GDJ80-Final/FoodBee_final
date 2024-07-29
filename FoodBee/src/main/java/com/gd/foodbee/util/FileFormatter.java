package com.gd.foodbee.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileFormatter {
	public String fileFormatter(MultipartFile mf) {
		
		log.debug(TeamColor.YELLOW +"fileName => " + mf.toString());
		
		LocalDateTime now = LocalDateTime.now();
		//현재 년월일시분초 구하기 
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
		String suffix = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		log.debug(TeamColor.YELLOW +"suffix =>"+suffix);
		
		String originalFile = now.format(formatter) + suffix;
		log.debug(TeamColor.YELLOW +"original_file =>"+originalFile);
		
		return originalFile;
	}
}
