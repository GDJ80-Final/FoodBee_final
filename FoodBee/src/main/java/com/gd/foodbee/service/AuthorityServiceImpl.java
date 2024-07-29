package com.gd.foodbee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.mapper.AuthorityMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AuthorityServiceImpl implements AuthorityService{
	
	@Autowired
	private AuthorityMapper authorityMapper;
	
	// 접근 가능 페이지 리스트(직급)
	// 파라미터 : String rankName
	// 반환 값 : List<String>
	// 사용 클래스 : AuthorityInterceptor.preHandle
	@Override
	public List<String> getAccessPageListByRankName(String rankName) {
		
		return authorityMapper.selectAccessPageListByRankName(rankName);
	}

	// 접근 가능 페이지 리스트(직급)
	// 파라미터 : String rankName
	// 반환 값 : List<String>
	// 사용 클래스 : AuthorityInterceptor.preHandle
	@Override
	public List<String> getAccessPageListByDptNo(String dptNo) {
		
		return authorityMapper.selectAccessPageListByDptNo(dptNo);
	}

}
