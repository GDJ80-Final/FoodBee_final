package com.gd.foodbee.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.RoomDTO;
import com.gd.foodbee.dto.RoomRsvDTO;
import com.gd.foodbee.mapper.RoomMapper;
import com.gd.foodbee.service.RoomService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RoomController {
	
	@Autowired 
	private RoomService roomService;
	
	@Autowired
	private RoomMapper roomMapper;

	// 회의실 목록
	// 파라미터 : X
	// 반환 값 : List<RoomDTO>
	// 사용 페이지 : /room/roomList
	@GetMapping("/room/roomList")	
	public String roomList(Model model) {		
		
		List<RoomDTO> list = roomService.getRoomList();
		log.debug(TeamColor.GREEN + "list => " + list.toString()); 
		
		model.addAttribute("list", list);
		return "/room/roomList";
	}
	
	// 회의실 상세보기 및 예약폼
	// 파라미터 : int roomNo, String rsvDate
	// 반환 값 : RoomDTO roomDTO, int roomNo, String rsvDate, List<RoomDTO> roomImg
	// 사용 페이지 : /room/roomOne
	@GetMapping("/room/roomOne")
	public String roomOne(Model model, @RequestParam(name= "roomNo") int roomNo, 
									   @RequestParam(name = "date", required = false) String rsvDate) {
		log.debug(TeamColor.GREEN + "roomNo => " + roomNo);
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		
		// 회의실 상세보기 및 예약폼
		RoomDTO roomDTO = roomService.getRoomOne(roomNo);
		log.debug(TeamColor.GREEN + "roomDTO => " + roomDTO.toString());
		
		List<RoomDTO> roomImg = roomMapper.selectRoomOneImg(roomNo);
		log.debug(TeamColor.GREEN + "roomImg => " + roomImg.toString());
		
		model.addAttribute("roomDTO",roomDTO);
		model.addAttribute("roomImg",roomImg);
		model.addAttribute("roomNo",roomNo);
		model.addAttribute("rsvDate",rsvDate);
		return "/room/roomOne";
	}
	
	// 회의실 번호, 선택된 날짜에 예약된 시간을 출력 / 예약시간 필터링
	// 파라미터 : int roomNo, String rsvDate
	// 반환 값 : String startTime, String endTime
	// 사용 페이지 : /room/roomOne
	@PostMapping("/room/getReservedTimes")
	@ResponseBody
	public List<RoomRsvDTO> getReservedTimes(@RequestParam("roomNo") int roomNo,  
											@RequestParam(name = "rsvDate", required = false) String rsvDate) {
		log.debug(TeamColor.GREEN + "roomNo => " + roomNo);
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		
	    return roomService.getReservedTimes(roomNo, rsvDate);
	}
	
	// 회의실 예약
	// 파라미터 : RoomRsvDTO
	// 반환 페이지 : /room/roomList
	// 사용 페이지 : /room/roomOne
	@PostMapping("/room/roomRsv")
	public String roomRsv(RoomRsvDTO rsv, HttpSession session) {
		log.debug(TeamColor.GREEN + "request rsv => " + rsv.toString());
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "empNo => " + emp.getEmpNo());
		
		int empNo = emp.getEmpNo();
		rsv.setEmpNo(empNo);
		
		int row = roomService.addRoomRsv(rsv);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/room/roomList";
	}
	
	// 날짜별 예약목록
	// 파라미터 : String rsvDate,  int currentPage
	// 반환 값 : List<RoomRsvDTO> rsvListByDate, String rsvDate, int currentPage, int lastPage
	// 사용 페이지 : /room/roomRsvList
	@GetMapping("/room/roomRsvList")
	public String roomRsvList(Model model, @RequestParam(name = "date", required = false) String rsvDate,
										   @RequestParam(name="currentPage", defaultValue="1") int currentPage) {
		log.debug(TeamColor.GREEN + "rsvDate => " + rsvDate);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		if (rsvDate == null || rsvDate.isEmpty()) {
            // 기본값으로 오늘 날짜 설정
			rsvDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        }
		
		List<RoomRsvDTO> rsvListByDate = roomService.getRsvListByDate(rsvDate, currentPage);		
		log.debug(TeamColor.GREEN + "rsvListByDate => " + rsvListByDate.toString());
		
		int lastPage = roomService.getRsvByDateLastPage(rsvDate);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage); 
		
		model.addAttribute("rsvListByDate",rsvListByDate);
		model.addAttribute("rsvDate", rsvDate);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);

		return "/room/roomRsvList";
	}
	
	// 내 예약목록
	// 파라미터 : HttpSession session, int currentPage
	// 반환 값 : List<RoomRsvDTO> rsvListByEmpNo, int lastPage, int currentPage
	// 사용 페이지 : /room/myRoomRsvList
	@GetMapping("/room/myRoomRsvList")
	public String myRoomRsvList(Model model, HttpSession session,
			   					@RequestParam(name="currentPage", defaultValue="1") int currentPage) {
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		List<RoomRsvDTO> rsvListByEmpNo = roomService.getRsvListByEmpNo(empNo, currentPage);
		log.debug(TeamColor.GREEN + rsvListByEmpNo.toString()); 			
		
		int lastPage = roomService.getRsvByEmpNoLastPage(empNo);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		model.addAttribute("rsvListByEmpNo",rsvListByEmpNo);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("lastPage",lastPage);

		return "/room/myRoomRsvList";
	}
	
	// 예약 취소
	// 파라미터 : RoomRsvDTO
	// 반환 페이지 : /room/roomRsvList
	// 사용 페이지 : /room/myRoomRsvList
	@PostMapping("/room/cancleRoomRsv")
	public String cancleRoomRsv(RoomRsvDTO rsv) {
		log.debug(TeamColor.GREEN + "request rsv => " + rsv.toString());
		
		int row = roomService.modifyRoomRsv(rsv);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/room/roomRsvList";
	}
}
