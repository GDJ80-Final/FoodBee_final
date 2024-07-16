package com.gd.foodbee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.dto.GroupDTO;
import com.gd.foodbee.mapper.GroupMapper;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupMapper groupMapper;
	
	@Override
	public List<GroupDTO> getOffcieList() {
		
		return groupMapper.selectOfficeList();
	}

	@Override
	public List<GroupDTO> getDeptList(String dptNo) {
		
		return groupMapper.selectDeptList(dptNo);
	}

	@Override
	public List<GroupDTO> getTeamist(String dptNo) {
		
		return groupMapper.selectTeamList(dptNo);
	}

	
	
}
