package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuthorityMapper {
	
	// 접근 가능 페이지 리스트(직급)
	// 파라미터 : String rankName
	// 반환 값 : List<String>
	// 사용 클래스 : AuthorityService.getAccessPageListByRankName
	List<String> selectAccessPageListByRankName(String rankName);
	
	// 접근 가능 페이지 리스트(팀)
	// 파라미터 : String dptNo
	// 반환 값 : List<String>
	// 사용 클래스 : AuthorityService.getAccessPageListByDptNo
	List<String> selectAccessPageListByDptNo(String dptNo);
}
