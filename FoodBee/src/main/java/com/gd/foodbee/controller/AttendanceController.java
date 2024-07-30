package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.AttendanceDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.service.AttendanceService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class AttendanceController {
	
	@Autowired 
	private AttendanceService attendanceService;
	
	// 근태 출근
	@PostMapping("/attendance/attendanceStartTime")
	public String attendanceStartTime(HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.addStartTime(empNo);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendancePersonal";
	}
	
	// 근태 퇴근
	@PostMapping("/attendance/attendanceEndTime")
	public String attendanceEndTime(HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.modifyEndTime(empNo);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendancePersonal";
	}
	
	// 근태보고
	// 파라미터 : HttpSession session
	// 반환 값 : attendanceDTO, HashMap<String, Object> map
	// 사용 페이지 : /attendance/attendanceReport
	@GetMapping("/attendance/attendanceReport")
	public String attendanceReport(Model model, HttpSession session,
							@RequestParam(name="date", required = false) String date) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();	
		String rankName = emp.getRankName();
        
		HashMap<String, Object> map = new HashMap<>();
		
	    if ("팀장".equals(rankName) || "부서장".equals(rankName) || "지사장".equals(rankName)) {
	        // 팀장이거나 그 이상의 직급이면 CEO 정보
	    	map = attendanceService.getCEO();
	    } else {
	        // 팀장 미만이면 팀장 정보
	    	map = attendanceService.getTeamLeader(dptNo);
	    }
		
		AttendanceDTO attendanceDTO = attendanceService.getTime(empNo, date);
		
		
		model.addAttribute("attendanceDTO", attendanceDTO);
		model.addAttribute("map", map);
		
		return "/attendance/attendanceReport";
	}

	// 근태보고 수정 폼
	// 파라미터 : HttpSession session
	// 반환 값 : attendanceDTO, HashMap<String, Object> map
	// 사용 페이지 : /attendance/attendanceModify
	@GetMapping("/attendance/attendanceModify")
	public String attendanceModify(Model model, HttpSession session,
							@RequestParam(name="date", required = false) String date) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		String rankName = emp.getRankName();
        
		HashMap<String, Object> map = new HashMap<>();
		
	    if ("팀장".equals(rankName) || "부서장".equals(rankName) || "지사장".equals(rankName)) {
	        // 팀장이거나 그 이상의 직급이면 CEO 정보
	    	map = attendanceService.getCEO();
	    } else {
	        // 팀장 미만이면 팀장 정보
	    	map = attendanceService.getTeamLeader(dptNo);
	    }
		AttendanceDTO attendanceDTO = attendanceService.getTime(empNo, date);
		
		model.addAttribute("attendanceDTO", attendanceDTO);
		model.addAttribute("map", map);
		
		return "/attendance/attendanceModify";
	}
	
	// 근태보고 수정 액션
	// 파라미터 : HttpSession session, String updateStartTime, String updateEndTime, String updateReason
	// 반환 페이지 : /attendance/attendanceReport
	// 사용 페이지 : /attendance/attendanceModify
	@PostMapping("/attendance/attendanceModifyAction")
	public String attendanceModifyAction(HttpSession session, 
						@RequestParam(name="updateStartTime") String updateStartTime,
						@RequestParam(name="updateEndTime") String updateEndTime,
						@RequestParam(name="updateReason") String updateReason,
						@RequestParam(name="date", required = false) String date) {
		
		log.debug(TeamColor.GREEN + "updateStartTime => " + updateStartTime);
		log.debug(TeamColor.GREEN + "updateEndTime => " + updateEndTime);
		log.debug(TeamColor.GREEN + "updateReason => " + updateReason);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.modifyTime(updateStartTime, updateEndTime, updateReason, empNo, date);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendancePersonal";
	}
	
	// 개인 근태
	// 파라미터 : HttpSession session, int currentPage, String startDate, String endDate
	// 반환 값 : List<AttendanceDTO> list, HashMap<String, Object> map, int currentPage, int lastPage
	// 사용 페이지 : /attendance/attendancePersonal
	@GetMapping("/attendance/attendancePersonal")
	public String attendancePersonal(Model model, HttpSession session, 
						@RequestParam(name="currentPage", defaultValue="1") int currentPage,
						@RequestParam(name="startDate", required = false) String startDate,
						@RequestParam(name="endDate", required = false) String endDate) {
		
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "startDate => " + startDate);
		log.debug(TeamColor.GREEN + "endDate => " + endDate);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		String rankName = emp.getRankName();
        
		HashMap<String, Object> map = new HashMap<>();
		
	    if ("팀장".equals(rankName) || "부서장".equals(rankName) || "지사장".equals(rankName)) {
	        // 팀장이거나 그 이상의 직급이면 CEO 정보
	    	map = attendanceService.getCEO();
	    } else {
	        // 팀장 미만이면 팀장 정보
	    	map = attendanceService.getTeamLeader(dptNo);
	    }
		List<AttendanceDTO> list = attendanceService.getAttendancePersonal(empNo, currentPage, startDate, endDate);				
		
		int lastPage = attendanceService.getAttendancePersonalCnt(empNo);
		log.debug(TeamColor.GREEN + "lastPage => " + lastPage);
		
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
		
		return "/attendance/attendancePersonal";
	}
	
	// 근태 확정
	// 파라미터 : HttpSession session, String date
	// 반환 페이지 : /attendance/attendancePersonal
	// 사용 페이지 : /attendance/attendanceReport
	@PostMapping("/attendance/attendanceFinalTime")
	public String attendanceFinalTime(HttpSession session, 
							@RequestParam(name="date")String date) {
		
		log.debug(TeamColor.GREEN + "date => " + date);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		log.debug(TeamColor.GREEN + "emp => " + emp.toString());
		
		int empNo = emp.getEmpNo();
		
		int row = attendanceService.modifyAttendanceFinalTime(date, empNo);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "redirect:/attendance/attendancePersonal";
	}
	
	// 팀원 근태
	// 파라미터 : HttpSession session, int currentPage
	// 반환 값 : int empNo, String dptNo
	// 사용 페이지 : /attendance/attendanceTeamMember
	@GetMapping("/attendance/attendanceTeamMember")
	public String attendanceTeamMember(Model model, HttpSession session,
							@RequestParam(name="currentPage", defaultValue="1") int currentPage) {
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		String dptNo = emp.getDptNo();
		
		model.addAttribute("empNo", empNo);
		model.addAttribute("dptNo", dptNo);
		
		return "/attendance/attendanceTeamMember";
	}
	
	// 팀원 근태 전체 출력
	// 파라미터 : int empNo, String dptNo, int currentPage, String search
	// 반환 값 : Map<String, Object> allAttendanceList, int currentPage, int allLastPage
	// 사용 페이지 : /attendance/attendanceTeamMember
	@GetMapping("/attendance/getAttendanceTeamMemberAll")
	@ResponseBody
	public Map<String, Object> getAttendanceTeamMemberAll(int empNo, String dptNo, int currentPage, String search) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "search => " + search);
	    
	    List<HashMap<String, Object>> allList = attendanceService.getAttendanceTeamMember(empNo, dptNo, currentPage, search);
	    int allLastPage = attendanceService.getAttendanceTeamMemberCnt(empNo, dptNo);
	
	    Map<String, Object> allAttendanceList = new HashMap<>();
	    allAttendanceList.put("allList", allList);
	    allAttendanceList.put("currentPage", currentPage);
	    allAttendanceList.put("allLastPage", allLastPage);
	    
	    return allAttendanceList;
	}
	
	// 팀원 근태 승인/미승인 출력
	// 파라미터 : int empNo, String dptNo, int currentPage, String search, String approvalState
	// 반환 값 : Map<String, Object> attendanceList, int currentPage, int lastPage
	// 사용 페이지 : /attendance/attendanceTeamMember
	@GetMapping("/attendance/getAttendanceTeamMemberByStatus")
	@ResponseBody
	public Map<String, Object> getAttendanceTeamMemberByStatus(int empNo, String dptNo, int currentPage, 
																String search, String approvalState) {
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "dptNo => " + dptNo);
		log.debug(TeamColor.GREEN + "currentPage => " + currentPage);
		log.debug(TeamColor.GREEN + "search => " + search);
		log.debug(TeamColor.GREEN + "approvalState => " + approvalState);
	    
	    List<HashMap<String, Object>> list = attendanceService.getAttendanceTeamMemberByStatus(empNo, dptNo, currentPage, search, approvalState);
	    int lastPage = attendanceService.getAttendanceTeamMemberByStatusCnt(empNo, dptNo, approvalState);
	
	    Map<String, Object> attendanceList = new HashMap<>();
	    attendanceList.put("list", list);
	    attendanceList.put("currentPage", currentPage);
	    attendanceList.put("allLastPage", lastPage);
	    
	    return attendanceList;
	}
	
	// 근태 반려
	// 파라미터 : HttpSession session, String date
	// 반환 페이지 : /attendance/attendanceTeamMember
	// 사용 페이지 : /attendance/attendanceTeamMember
	@PostMapping("/attendance/attendanceRejection")
	@ResponseBody
	public String attendanceRejection(@RequestParam(name="date") String date,
							@RequestParam(name="empNo") int empNo,
							@RequestParam(name="approvalReason") String approvalReason) {
		log.debug(TeamColor.GREEN + "date => " + date);
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		log.debug(TeamColor.GREEN + "approvalReason => " + approvalReason);
		
		int row = attendanceService.modifyAttendanceRejection(empNo, date, approvalReason);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "/redirect:/attendance/attendanceTeamMember";
	}
	
	// 근태 승인
	// 파라미터 : HttpSession session, String date
	// 반환 페이지 : /attendance/attendanceTeamMember
	// 사용 페이지 : /attendance/attendanceTeamMember
	@PostMapping("/attendance/attendanceAccept")
	@ResponseBody
	public String attendanceAccept(@RequestParam(name="date") String date,
							@RequestParam(name="empNo") int empNo) {
		log.debug(TeamColor.GREEN + "date => " + date);
		log.debug(TeamColor.GREEN + "empNo => " + empNo);
		
		int row = attendanceService.modifyAttendanceAccept(empNo, date);
		log.debug(TeamColor.GREEN + "row => " + row);
		
		return "/redirect:/attendance/attendanceTeamMember";
	}
	
}
