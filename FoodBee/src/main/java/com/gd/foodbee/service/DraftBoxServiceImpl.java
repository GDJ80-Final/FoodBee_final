package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.DraftBoxDTO;
import com.gd.foodbee.dto.DraftBoxStateDTO;
import com.gd.foodbee.mapper.DraftBoxMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DraftBoxServiceImpl implements DraftBoxService {
	@Autowired 
	DraftBoxMapper draftBoxMapper;
	private static final int ROW_PER_PAGE = 10;
	 
	//전체 기안리스트
	@Override
	public List<DraftBoxDTO> getAllDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
		return draftBoxMapper.allDocList(empNo, beginRow, ROW_PER_PAGE);
	}
	//*전체 기안리스트의 총갯수
	@Override
	public int countAllDocList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
		return stateBox.totalCount();
	}
	//*전체 기안리스트의 Lastpage
	@Override
	 public int getAllDocLastPage(int empNo) {
        int totalCount = countAllDocList(empNo);
        return (int) Math.ceil((double) totalCount / ROW_PER_PAGE);
    }
	
	//결재대기 기안서리스트
	@Override
	public List<DraftBoxDTO> getZeroDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return draftBoxMapper.zeroTypeDocList(empNo, beginRow, ROW_PER_PAGE);
	}
	//*결재대기 리스트 총갯수
	@Override
	public int countZeroDocList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
        return stateBox.getZeroState();
	}
	//*결재대기 리스트 LastPage
	@Override
	public int getZeroDocLastPage(int empNo) {
		int zeroStateCount = countZeroDocList(empNo);
        return (int) Math.ceil((double) zeroStateCount / ROW_PER_PAGE);
	}
	
	//승인중 기안서리스트
	@Override
	public List<DraftBoxDTO> getOneDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

        return draftBoxMapper.oneTypeDocList(empNo, beginRow, ROW_PER_PAGE);
	}
	//*승인중 리스트 총갯수
	@Override
	public int countOneDocList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
        return stateBox.getOneState();
	}
	//*승인중 리스트 LastPage
	@Override
	public int getOneDocLastPage(int empNo) {
		int oneStateCount = countOneDocList(empNo);
        return (int) Math.ceil((double) oneStateCount / ROW_PER_PAGE);
	}
	
	//승인완료 기안서리스트
	@Override
	public List<DraftBoxDTO> getTwoDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;

        
        return draftBoxMapper.twoTypeDocList(empNo, beginRow, ROW_PER_PAGE);
	}
	//*승인완료 리스트 총갯수
	@Override
	public int countTwoDocList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
        return stateBox.getTwoState();
	}
	//*승인완료 리스트 LastPage
	@Override
	public int getTwoDocLastPage(int empNo) {
		int twoStateCount = countTwoDocList(empNo);
        return (int) Math.ceil((double) twoStateCount / ROW_PER_PAGE);
	}
	
	//반려 기안서리스트
	@Override
	public List<DraftBoxDTO> getNineDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return draftBoxMapper.nineTypeDocList(empNo, beginRow, ROW_PER_PAGE);
	}
	//*반려 리스트 총갯수
	@Override
	public int countNineDocList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
        return stateBox.getNineState();
	}
	//*반려 리스트 LastPage
	@Override
	public int getNineDocLastPage(int empNo) {
		int twoStateCount = countNineDocList(empNo);
        return (int) Math.ceil((double) twoStateCount / ROW_PER_PAGE);
	}
	
	//결재상태 건수(결재대기, 승인중, 승인완료, 반려)
	@Override
	public DraftBoxStateDTO getStateBox(int empNo) {
		return draftBoxMapper.getStateBox(empNo);
	}
}
