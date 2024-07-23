package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.foodbee.dto.GroupDTO;
import com.gd.foodbee.service.GroupService;
import com.gd.foodbee.util.TeamColor;

import java.util.*;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class GroupController {
	
	@Autowired
	private GroupService groupService;

	@GetMapping("/emp/officeList")
	public List<GroupDTO> getOfficeList(){
		
	
		return groupService.getOfficeList();
	}
	
	@PostMapping("emp/deptList")
	public List<GroupDTO> getDeptListByOffice(@RequestParam String dptNo){
		log.debug(TeamColor.RED + "dptNo =>" + dptNo);
		
		return groupService.getDeptListByOffice(dptNo);
	}
	
	@PostMapping("/emp/teamList")
	public List<GroupDTO> getTeamListByDept(@RequestParam String dptNo){
		log.debug(TeamColor.RED + "dptNo =>" + dptNo);
		
		return groupService.getTeamListByDept(dptNo);
	}
	
	@GetMapping("/emp/deptList")
	public List<GroupDTO> getDeptList(){
		
		return groupService.getDeptList();
	}
	
	@GetMapping("/emp/teamList")
	public List<GroupDTO> getTeamList(){
		
		return groupService.getTeamList();
	}
}
