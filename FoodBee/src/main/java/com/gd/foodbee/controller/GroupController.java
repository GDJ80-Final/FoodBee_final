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

	// 전체 본사/지사 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 페이지 : /emp/addEmp, /myPage, /emp/empList
	@GetMapping("/emp/officeList")
	public List<GroupDTO> getOfficeList(){
		
	
		return groupService.getOfficeList();
	}
	
	// 본사/지사에 포함된 부서 리스트
	// 파라미터 : String dptNo
	// 반환 값 : List<GroupDTO>
	// 사용 페이지 : /emp/addEmp, /myPage
	@PostMapping("emp/deptList")
	public List<GroupDTO> getDeptListByOffice(@RequestParam String dptNo){
		log.debug(TeamColor.RED + "dptNo =>" + dptNo);
		
		return groupService.getDeptListByOffice(dptNo);
	}
	
	// 본사/지사에 포함된 부서 리스트
	// 파라미터 : String dptNo
	// 반환 값 : List<GroupDTO>
	// 사용 페이지 : /emp/addEmp, /myPage
	@PostMapping("/emp/teamList")
	public List<GroupDTO> getTeamListByDept(@RequestParam String dptNo){
		log.debug(TeamColor.RED + "dptNo =>" + dptNo);
		
		return groupService.getTeamListByDept(dptNo);
	}
	
	// 전체 부서 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 페이지 : /emp/empList
	@GetMapping("/emp/deptList")
	public List<GroupDTO> getDeptList(){
		
		return groupService.getDeptList();
	}
	
	// 전체 부서 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 페이지 : /emp/empList
	@GetMapping("/emp/teamList")
	public List<GroupDTO> getTeamList(){
		
		return groupService.getTeamList();
	}
}
