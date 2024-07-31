package com.gd.foodbee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;
import com.gd.foodbee.mapper.InBoxMapper;

@Service
public class InBoxServiceImpl implements InBoxService {
	@Autowired 
	private InBoxMapper inBoxMapper;
	private static final int ROW_PER_PAGE = 10;
	
	// 내 수신 전체 리스트
	// 파라미터 : currentPage, empNo
	// 반환값 : List<InBoxMapper>
	// 사용클래스 : inBoxController.inBox 
	@Override 
	public List<InBoxDTO> getReferrerList(int currentPage, int empNo){
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

		return inBoxMapper.getReferrerList(empNo, beginRow, ROW_PER_PAGE);
	}
	
	// 수신참조된 전체리스트의 총갯수
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : inBoxController.inBox 
	@Override
	public int countAllReferrerList(int empNo) {
		InBoxStateDTO stateBox = inBoxMapper.getStateBox(empNo);
		return stateBox.totalCount();
	}
	
	// 수신참조된 리스트 LastPage
	// 파라미터 : int empNo
	// 반환값 : int
	// 사용클래스 : inBoxController.inBox
	@Override
	public int allReferrerLastPage(int empNo) {
		int totalCount = countAllReferrerList(empNo);
		return (int) Math.ceil((double) totalCount / ROW_PER_PAGE);
	}
	
	// 결재상태 건수(결재대기, 승인중, 승인완료, 반려) 
	// 파라미터 : int empNo
	// 반환값 : InBoxStateDTO
	// 사용클래스 : InBoxController.inBox
	@Override
	public InBoxStateDTO getStateBox(int empNo) {
		return inBoxMapper.getStateBox(empNo);
	}
}
