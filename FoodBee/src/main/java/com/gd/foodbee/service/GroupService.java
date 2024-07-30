package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.GroupDTO;

public interface GroupService {

	// 전체 본사/지사 리스트
	List<GroupDTO> getOfficeList();
	
	// 본사/지사에 포함된 부서 리스트
	List<GroupDTO> getDeptListByOffice(String dptNo);
	
	// 부서에 포함된 팀 리스트
	List<GroupDTO> getTeamListByDept(String dptNo);
	
	// 전체 부서 리스트
	List<GroupDTO> getDeptList();
	
	// 전체 팀 리스트
	List<GroupDTO> getTeamList();
	
	// 부서번호로 부서이름 구하기
	String getDptName(String dptNo);
	
	// 부서번호로 권한코드 구하기
	String getAuthorityCodeByDptNo(String dptNo);
}
