package com.gd.foodbee.service;

import java.util.List;

public interface AuthorityService {

	// 접근 가능 페이지 리스트(직급)
	List<String> getAccessPageListByRankName(String rankName);
	
	// 접근 가능 페이지 리스트(팀)
	List<String> getAccessPageListByDptNo(String dptNo);

	// 접근 가능 페이지 리스트(권한코드)
	List<String> getAccessPageListByAuthorityCode(String authorityCode);
}
