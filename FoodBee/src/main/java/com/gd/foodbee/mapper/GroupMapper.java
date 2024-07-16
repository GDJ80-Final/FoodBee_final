package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.GroupDTO;

@Mapper
public interface GroupMapper {
	
	// 본사/지사 검색
	List<GroupDTO> selectOfficeList();
	
	// 본사/지사에 포함된 부서 검색
	List<GroupDTO> selectDeptList(String dptNo);
	
	// 부서에 포함된 팀 검색
	List<GroupDTO> selectTeamList(String dptNo);
}
