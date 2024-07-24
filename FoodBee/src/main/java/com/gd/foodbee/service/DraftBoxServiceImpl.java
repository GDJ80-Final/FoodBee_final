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
	@Autowired DraftBoxMapper draftBoxMapper;
	final int rowPerPage= 10;
	 
	//전체 기안리스트
	@Override
	public List<DraftBoxDTO> getAllDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
   
		return draftBoxMapper.allDocList(m);
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
        return (int) Math.ceil((double) totalCount / rowPerPage);
    }
	
	//결재대기 기안서리스트
	@Override
	public List<DraftBoxDTO> getZeroDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return draftBoxMapper.zeroTypeDocList(m);
	}
	//결재대기 리스트 총갯수
	@Override
	public int countZeroDcoList(int empNo) {
		DraftBoxStateDTO stateBox = draftBoxMapper.getStateBox(empNo);
        return stateBox.getZeroState();
	}
	//결재대기 리스트 LastPage
	@Override
	public int getZeroDocLastPage(int empNo) {
		int zeroStateCount = countZeroDcoList(empNo);
        return (int) Math.ceil((double) zeroStateCount / rowPerPage);
	}
	//승인중 기안서리스트
	@Override
	public List<DraftBoxDTO> getOneDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return draftBoxMapper.oneTypeDocList(m);
	}
	//승인완료 기안서리스트
	@Override
	public List<DraftBoxDTO> getTwoDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return draftBoxMapper.twoTypeDocList(m);
	}
	//반려 기안서리스트
	@Override
	public List<DraftBoxDTO> getNineDocList(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
        
        return draftBoxMapper.nineTypeDocList(m);
	}
	
	//결제상태 건수(결제대기,결제진행중,결제완료,반려)
	@Override
	public DraftBoxStateDTO getStateBox(int empNo) {
		return draftBoxMapper.getStateBox(empNo);
	}
}
