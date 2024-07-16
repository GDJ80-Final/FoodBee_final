package com.gd.foodbee.service;

import java.util.List;

import com.gd.foodbee.dto.GroupDTO;

public interface GroupService {

	List<GroupDTO> getOffcieList();
	
	List<GroupDTO> getDeptList(String dptNo);
	
	List<GroupDTO> getTeamist(String dptNo);
	
	
}
