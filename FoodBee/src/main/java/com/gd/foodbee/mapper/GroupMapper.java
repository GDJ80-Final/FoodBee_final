package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.GroupDTO;

@Mapper
public interface GroupMapper {
	
	// 본사/지사 리스트
	List<GroupDTO> selectOfficeList();
	
	// 본사/지사에 포함된 부서 리스트
	List<GroupDTO> selectDeptListByOffice(String dptNo);
	
	// 부서에 포함된 팀 리스트
	List<GroupDTO> selectTeamListByDept(String dptNo);
	
	// 부서 리스트
	List<GroupDTO> selectDeptList();
	
	// 팀 리스트
	List<GroupDTO> selectTeamList();
}
