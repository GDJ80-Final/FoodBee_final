package com.gd.foodbee.service;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.ProfileDTO;
import com.gd.foodbee.mapper.ProfileMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProfileServiceImpl implements ProfileService{

	@Autowired
	private ProfileMapper profileMapper;

	// 프로필 사진 수정
	// 파라미터 : int empNo, MultipartFile file, HttpServletRequest request
	// 반환 값 : String
	// 사용 클래스 : ProfileController
	@Override
	public String modifyProfileImg(int empNo, 
			MultipartFile file, 
			HttpServletRequest request) {
		String originalFile = FileFormatter.fileFormatter(file);
		
		ProfileDTO profileDTO = ProfileDTO.builder()
					.empNo(empNo)
					.originalFile(originalFile)
					.saveFile(file.getOriginalFilename())
					.type(file.getContentType())
					.build();
		
		int row = profileMapper.updateProfileImg(profileDTO);
		
		if(row != 1){
			throw new RuntimeException();
		}
		
		String path = request.getServletContext().getRealPath("/WEB-INF/upload/profile_img/");
		log.debug(TeamColor.RED +"path =>"+ path);
		
		File emptyFile = new File(path+originalFile);
		try {
			file.transferTo(emptyFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} 
		
		return originalFile;
		
	}
	
	
}
