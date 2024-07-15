package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.ProfileDTO;

@Mapper
public interface ProfileMapper {
	//프로필 사진 입력
	//파라미터 : ProfileDTO profileDTO
	//반환값 : int
	//사용클래스 : EmpService.updateEmpSignup
	public int insertProfileImg(ProfileDTO profileDTO);
}
