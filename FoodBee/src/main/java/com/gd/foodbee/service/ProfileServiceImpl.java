package com.gd.foodbee.service;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.ProfileDTO;
import com.gd.foodbee.mapper.ProfileMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProfileServiceImpl implements ProfileService{

	@Autowired
	private ProfileMapper profileMapper;
	
	@Autowired
	private FilePath filePath;
	
	@Autowired
	private FileFormatter fileFormatter;

	// 프로필 사진 수정
	// 파라미터 : int empNo, MultipartFile file
	// 반환 값 : String
	// 사용 클래스 : ProfileController
	@Override
	public String modifyProfileImg(int empNo, 
			MultipartFile file) {
		
		String path = filePath.getFilePath() + "profile_img/";
		log.debug(TeamColor.RED +"path =>"+ path);
		
		// 원래 파일 삭제
		// 디폴트 이미지일 경우 삭제 안함
		String originalFile = profileMapper.selectProfileImg(empNo);
		log.debug(TeamColor.RED + "originalName =>" + originalFile);
		if(originalFile != null) {
			if(originalFile.equals("default.png")){
				log.debug(TeamColor.YELLOW + "디폴트 이미지는 삭제 할 수 없습니다.");
			}else {
				String result = filePath.deleteFile(path, originalFile);
				if(result.equals("fail")) {
					throw new RuntimeException();
				}
			}	
		}
		
		originalFile = fileFormatter.fileFormatter(file);
		
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
		
		
		filePath.saveFile(path, originalFile, file);
		
		return originalFile;
		
	}

	@Override
	public String getProfileImg(int empNo) {
		return profileMapper.selectProfileImg(empNo);
	}
	
	
}
