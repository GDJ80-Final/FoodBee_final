package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;
import com.gd.foodbee.mapper.InBoxMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class InBoxServiceImpl implements InBoxService {
	@Autowired 
	private InBoxMapper inBoxMapper;
	private static final int ROW_PER_PAGE = 10;
	
	// 내 수신 전체 리스트
	@Override 
	public List<InBoxDTO> getReferrerList(int currentPage, int empNo){
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

		return inBoxMapper.getReferrerList(empNo, beginRow, ROW_PER_PAGE);
	}
	
	// 수신참조된 전체리스트의 총갯수
	@Override
	public int countAllReferrerList(int empNo) {
		InBoxStateDTO stateBox = inBoxMapper.getStateBox(empNo);
		return stateBox.totalCount();
	}
	
	// 수신참조된 리스트 LastPage
	@Override
	public int allReferrerLastPage(int empNo) {
		int totalCount = countAllReferrerList(empNo);
		return (int) Math.ceil((double) totalCount / ROW_PER_PAGE);
	}
	
	// 결재상태 건수(결재대기, 승인중, 승인완료, 반려) 
	@Override
	public InBoxStateDTO getStateBox(int empNo) {
		return inBoxMapper.getStateBox(empNo);
	}
}
