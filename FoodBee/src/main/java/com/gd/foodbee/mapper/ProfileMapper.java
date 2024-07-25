package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.ProfileDTO;

@Mapper
public interface ProfileMapper {
	
	// 프로필 사진 입력
	// 파라미터 : ProfileDTO profileDTO
	// 반환 값 : int
	// 사용 클래스 : EmpService.updateEmpSignup
	int insertProfileImg(ProfileDTO profileDTO);
	
	//프로필 사진 수정
	int updateProfileImg(ProfileDTO profileDTO);

}
