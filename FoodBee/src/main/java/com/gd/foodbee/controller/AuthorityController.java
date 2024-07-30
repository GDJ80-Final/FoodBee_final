package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gd.foodbee.service.GroupService;
import com.gd.foodbee.service.RankService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class AuthorityController {

	@Autowired
	private RankService rankService;
	
	@Autowired
	private GroupService groupService;
	
	// 직급 권한 코드 구하기
	// 파라미터 : String rankName
	// 반환 값 : String
	// 사용 페이지 : 
	@GetMapping("/auth/getRankAuth")
	public String getRankAuth(String rankName) {
		log.debug(TeamColor.RED + "rankName =>" + rankName);
		
		return rankService.getAuthorityCodeByRankName(rankName);
	}
	
	// 팀 권한 코드 구하기
	// 파라미터 : String dptNo
	// 반환 값 : String
	// 사용 페이지 : /emp/empDetail, /emp/empList
	@GetMapping("/auth/getTeamAuth")
	public String getTeamAuth(String dptNo) {
		log.debug(TeamColor.RED + "dptNo =>" + dptNo);
		
		return groupService.getAuthorityCodeByDptNo(dptNo);
	}
	
}
