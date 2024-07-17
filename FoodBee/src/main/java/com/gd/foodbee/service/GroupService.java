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
}
