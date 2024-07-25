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
	InBoxMapper inBoxMapper;
	final int rowPerPage = 10;
	
	//내 수신 전체 리스트
	@Override 
	public List<InBoxDTO> getReferrerList(int currentPage, int empNo){
		
		int beginRow = 0;
        beginRow = (currentPage -1) * rowPerPage;
        
        Map<String,Object> m = new HashMap<>();
        m.put("empNo", empNo);
        m.put("beginRow", beginRow);
        m.put("rowPerPage", rowPerPage);
   
		return inBoxMapper.getReferrerList(m);
	}
	
	//결재상태 건수(결재대기, 승인중, 승인완료, 반려)
	@Override
	public InBoxStateDTO getStateBox(int empNo) {
		return inBoxMapper.getStateBox(empNo);
	}
}
