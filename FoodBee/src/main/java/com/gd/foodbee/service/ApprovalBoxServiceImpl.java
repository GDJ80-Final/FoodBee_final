package com.gd.foodbee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.ApprovalBoxDTO;
import com.gd.foodbee.dto.ApprovalBoxStateDTO;
import com.gd.foodbee.dto.DocReferrerDTO;
import com.gd.foodbee.dto.DraftDocDTO;
import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;
import com.gd.foodbee.mapper.ApprovalBoxMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class ApprovalBoxServiceImpl implements ApprovalBoxService {
	//결재함 전체 리스트
	@Autowired 
	private ApprovalBoxMapper approvalBoxMapper;
	private static final int ROW_PER_PAGE = 10;
	
	//내 결재함 전체리스트
	@Override
	public List<ApprovalBoxDTO> getApprovalListAll(int currentPage, int empNo){
		
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return approvalBoxMapper.getApprovalListAll(empNo, beginRow, ROW_PER_PAGE);
	}
	
	//결재함 미결리스트
	@Override
	public List<ApprovalBoxDTO> getZeroListAll(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return approvalBoxMapper.getZeroListAll(empNo, beginRow, ROW_PER_PAGE);
	}
	
	//결재함 기결리스트
	@Override
	public List<ApprovalBoxDTO> getOneListAll(int currentPage, int empNo){
		int beginRow = 0;
        beginRow = (currentPage -1) * ROW_PER_PAGE;
        
        return approvalBoxMapper.getOneListAll(empNo, beginRow, ROW_PER_PAGE);
	}
	
	//미결 총 갯수
	public int countZeroState(int empNo) {
		return approvalBoxMapper.countZeroTypeList(empNo);
	}
	//기결 총 갯수
	public int countOneState(int empNo) {
		return approvalBoxMapper.countOneTypeList(empNo);
	}
	
	//결재함 전체 Lastpage
	@Override
	public int getAllLastPage(int empNo) {
		int count = approvalBoxMapper.countAllList(empNo);
		int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);
		
		return lastPage;
	}
	
	//미결 LastPage
	@Override
	public int getZeroLastPage(int empNo) {
		int count = approvalBoxMapper.countZeroTypeList(empNo);
		int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);
		
		return lastPage;
	}
	
	//기결 LastPage
	@Override
	public int getOneLastPage(int empNo) {
		int count = approvalBoxMapper.countOneTypeList(empNo);
		int lastPage = (int) Math.ceil((double) count / ROW_PER_PAGE);
		
		return lastPage;
	}
	
	// 결재상태 건수(결재대기, 승인중, 승인완료, 반려) 
	@Override
	public ApprovalBoxStateDTO getStateBox(int empNo) {
		return approvalBoxMapper.getStateBox(empNo);
	}
	
	// 기안서 상세
	@Override
	public Map<String,Object> getDocOne(int draftDocNo) {
		
		return approvalBoxMapper.getDocOne(draftDocNo);
	}

	// 기안서 detail 상세
	@Override
	public DraftDocDetailDTO getDocDetailOne(int draftDocNo) {
		return approvalBoxMapper.getDocDetailOne(draftDocNo);
	}
	
	//기안서 detail List
	@Override
	public List<DraftDocDetailDTO> getDocDetailList(int draftDocNo){
		return approvalBoxMapper.getDocDetailList(draftDocNo);
	}
	
	//기안서 파일상세
	@Override
	public List<DraftDocFileDTO> getDocFileOne(int draftDocNo) {
		return approvalBoxMapper.getDocFileOne(draftDocNo);
	}
	
	//기안서 수신참조자
	@Override
	public Map<String,Object> getDocReferrerOne(int draftDocNo) {
		return approvalBoxMapper.getDocReferrerOne(draftDocNo);
	}
	
	//휴가상세정보
	@Override
	public Map<String,Object> getDayOffOne(int draftDocNo){
		return approvalBoxMapper.getDayOffOne(draftDocNo);
	}
	
	//중간결재 승인
	@Override
	public int updateMidState(int draftDocNo) {
		return approvalBoxMapper.updateMidState(draftDocNo);
	}
	
	//최종결재 승인
	@Override
	public int updateFinalState(int draftDocNo) {
		
		int row = approvalBoxMapper.updateFinalState(draftDocNo);
		
		if(row == 1) {
			Map<String,Object> doc = approvalBoxMapper.getDocOne(draftDocNo);
			DraftDocDetailDTO docDetail = approvalBoxMapper.getDocDetailOne(draftDocNo);
			
			Map<String,Object> m = new HashMap<String,Object>();
			m.put("docDetail", docDetail);
			m.put("doc", doc);
			if((Integer)(doc.get("tmpNo")) == 3) {
				row = approvalBoxMapper.insertBusinessTrip(m);
			}
			if((Integer)(doc.get("tmpNo")) == 1) {
				row = approvalBoxMapper.insertRevenue(m);
			}
			if((Integer)(doc.get("tmpNo")) == 2) {
				row = approvalBoxMapper.insertDayOffTrip(m);
			}
			
			if(row != 1) {
				throw new RuntimeException();
			}
		} else {
			throw new RuntimeException();
		}
		
		
		
		return row;
	}
	
	//중간결재 반려
	@Override
	public int updateMidRejection(int draftDocNo, String rejectionReason) {
		return approvalBoxMapper.updateMidRejection(draftDocNo, rejectionReason);
	}
	
	//최종결재 반려
	@Override
	public int updateFinalRejection(int draftDocNo, String rejectionReason) {
		return approvalBoxMapper.updateFinalRejection(draftDocNo, rejectionReason);
	}
	
}
