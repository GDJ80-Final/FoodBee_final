package com.gd.foodbee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.foodbee.service.RoomService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/controller")
public class RoomRestController {
	@Autowired RoomService roomService;
	
	// 회의실 번호, 선택된 날짜에 예약된 시간을 출력
	// 파라미터 : int roomNo, String rsvDate
	// 반환 값 : String startTime, String endTime
	@PostMapping("/getReservedTimes")
	public List<Map<String, Object>> getReservedTimes(@RequestParam("roomNo") int roomNo,  
													  @RequestParam(name = "rsvDate", required = false) String rsvDate) {
		log.debug(TeamColor.GREEN+"roomNo:"+roomNo);
		log.debug(TeamColor.GREEN+"rsvDate:"+rsvDate);
		
	    return roomService.getReservedTime(roomNo, rsvDate);
	}
}
