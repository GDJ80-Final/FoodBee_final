package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RankMapper {
	
	// 직급이름으로 권한 구하기
	// 파라미터 : String rankName
	// 반환 값 : String
	// 사용 클래스 : RankService.getAuthorityCodeByRankName
	String selectAuthorityCodeByRankName(String rankName);
}
