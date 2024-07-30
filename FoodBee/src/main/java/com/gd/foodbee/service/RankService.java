package com.gd.foodbee.service;

public interface RankService {

	// 직급 이름으로 권한 구하기
	String getAuthorityCodeByRankName(String rankName);
}
