package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.mapper.RankMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RankServiceImpl implements RankService{
	
	@Autowired
	private RankMapper rankMapper;
	
	// 직급 이름으로 권한 구하기
	// 파라미터 : String rankName
	// 반환 값 : String
	// 사용 클래스 : AythorityInterceptor.prehandle
	@Override
	public String getAuthorityCodeByRankName(String rankName) {
		
		return rankMapper.selectAuthorityCodeByRankName(rankName);
	}

	
}
