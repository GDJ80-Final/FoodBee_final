package com.gd.foodbee.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.MsgRequestDTO;
import com.gd.foodbee.service.MsgService;
import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MsgController {
	
	@Autowired
	private MsgService msgService;
	

	
	// 새 쪽지 쓰기
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/addMsg
	@GetMapping("/msg/addMsg")
	public String addMsg() {
		
		return "/msg/addMsg";
	}
	// 새 쪽지 쓰기
	// 파라미터 : msgRequestDTO msgRequestDTO, HttpServletRequest request, HttpSession session, Model model
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/addMsg
	@PostMapping("/msg/addMsg")
	public String addMsg(MsgRequestDTO msgRequestDTO, 
				HttpServletRequest request,
				HttpSession session,
				Model model) {
		
		log.debug(TeamColor.YELLOW +"msgRequestDTO =>" +msgRequestDTO.toString());
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo );
		msgService.addMsg(msgRequestDTO, request,empNo);
		
		return "redirect:/msg/sentMsgBox";
	}
	// 받은 쪽지함
	// 파라미터 : int currentPage, String readYN, HttpSession session, Model model
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/receivedMsgBox
	@GetMapping("/msg/receivedMsgBox")
	public String receivedMsgBox() {
		
		return "/msg/receivedMsgBox";
	}
	// 받은 쪽지함
	// 파라미터 : int currentPage, String readYN, HttpSession session
	// 반환 값 : Map<String,Object>
	// 사용 페이지 : /msg/receivedMsgBox
	@PostMapping("/msg/receivedMsgBox")
	@ResponseBody
	public Map<String,Object> receivedMsgBox(@RequestParam(name="currentPage", defaultValue = "1")int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "currentPage" + currentPage);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		int lastPage = msgService.getLastPageReceivedBox(empNo, readYN);
		Map<String, Object> map = new HashMap<>();
		map.put("msgList", msgService.getReceivedMsgList(currentPage, empNo,readYN));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage); 
		//받은 쪽지 리스트 출력 
		
		return map;
	}
	
	// 보낸 쪽지함
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/sentMsgBox
	@GetMapping("/msg/sentMsgBox")
	public String sentMsgBox() {
			
		return "/msg/sentMsgBox";
	}
	
	// 보낸 쪽지함 
	// 파라미터 : int currentPage,String readYN, HttpSession session
	// 반환 값 : Map<String,Object>
	// 사용 페이지 : /msg/sentMsgBox
	@PostMapping("/msg/sentMsgBox")
	@ResponseBody
	public Map<String,Object> sentMsgBox(@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
				@RequestParam(name="readYN",defaultValue = "all") String readYN,
				HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		int lastPage = msgService.getLastPageSentBox(empNo, readYN);
		Map<String, Object> map = new HashMap<>();
		map.put("msgList", msgService.getSentMsgList(currentPage, empNo, readYN));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage); 
		
		return map;
	}
	// 휴지통 이동 >> 보낸 편지함
	// 파라미터 : int [] msgNos
	// 반환 값 : String
	// 사용 페이지 : /msg/receivedMsgBox
	@PostMapping("/msg/toTrash")
	@ResponseBody
	public String toTrash(@RequestParam(name="msgNos")int[] msgNos) {
		log.debug(TeamColor.YELLOW + "msgNos" + msgNos[0]);
		msgService.toTrash(msgNos);
		
		return "success";
	}
	
	// 휴지통 이동 >> 받음 편지함 
	// 파라미터 : int [] msgNos,HttpSession session
	// 반환 값 : String
	// 사용 페이지 : /msg/sentMsgBox
	@PostMapping("/msg/toTrashRecipient")
	@ResponseBody
	public String toTrashRecipient(@RequestParam(name="msgNos")int[] msgNos,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNos" + msgNos[0]);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		msgService.toTrashRecipient(msgNos, empNo);
			
		return "success";
	}
	
	// 휴지통 리스트
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/trashMsgBox
	@GetMapping("/msg/trashMsgBox")
	public String trashMsgBox() {
		
		return "/msg/trashMsgBox";
	}
	// 휴지통 리스트
	// 파라미터 : int currentPage,HttpSession session
	// 반환 값 : Map<String,Object>
	// 사용 페이지 : /msg/trashMsgBox
	@PostMapping("/msg/trashMsgBox")
	@ResponseBody
	public Map<String,Object> trashMsgBox(@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
				HttpSession session) {
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		String empName = emp.getEmpName();
		
		log.debug(TeamColor.YELLOW + "empName =>" +empName);
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo);
	
		
		int lastPage = msgService.getLastPageTrashBox(empNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("msgList", msgService.getTrashList(currentPage, empNo));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage);
		
		return map;
		
	}
	// 휴지통 >> 쪽지함 으로 복구
	// 파라미터 : int[] msgNos, String [] results, HttpSession session
	// 반환 값 : String
	// 사용 페이지 : /msg/trashMsgBox
	@PostMapping("/msg/toMsgBox")
	@ResponseBody
	public String toMsgBox(@RequestParam(name="msgNos")int[] msgNos,
				@RequestParam(name="results") String[] results,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNos[0] => " + msgNos[0]);
		log.debug(TeamColor.YELLOW + "result[0] => " + results[0]);
		log.debug(TeamColor.YELLOW + "result =>"+results);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		msgService.updatetoMsgBox(msgNos,empNo, results);
		
		return "success";
		
	
	}
	// 쪽지 상세보기
	// 파라미터 : int msgNo,HttpSession session, Model model 
	// 반환 값 : String(view)
	// 사용 페이지 : /msg/msgOne
	@GetMapping("/msg/msgOne")
	public String msgOne(@RequestParam(name="msgNo")int msgNo,
				HttpSession session,
				Model model) {
		log.debug(TeamColor.YELLOW + "msgNo => "+ msgNo);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		String empName = emp.getEmpName();
		log.debug(TeamColor.YELLOW + "empName =>" +empName);
		Map<String,Object> m = msgService.getMsgOne(msgNo);
		model.addAttribute("m", m);
		model.addAttribute("empName", empName);
		
		return "/msg/msgOne";
	}
	// 쪽지 삭제
	// 파라미터 : int [] msgNos,String [] results, HttpSession session
	// 반환 값 : String 
	// 사용 페이지 : /msg/trashMsgBox
	@PostMapping("/msg/deleteMsg")
	@ResponseBody
	public String deleteMsg(@RequestParam(name="msgNos")int[] msgNos,
				@RequestParam(name="results")String[]results,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNos[0] => " + msgNos[0]);
		log.debug(TeamColor.YELLOW + "result[0] => " + results[0]);
		log.debug(TeamColor.YELLOW + "result =>"+results);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		msgService.deleteMsg(msgNos, empNo, results);
		
		return "success";
		
	}
	// 쪽지 읽음 여부 업데이트
	// 파라미터 : int msgNo, HttpSession session
	// 반환 값 : String 
	// 사용 페이지 : /msg/msgOne
	@PostMapping("/msg/updateReadYN")
	@ResponseBody
	public String updateReadYN(@RequestParam(name="msgNo")int msgNo,
				HttpSession session) {
		log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
		EmpDTO emp = (EmpDTO) session.getAttribute("emp");
		int empNo = emp.getEmpNo();
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		msgService.updateReadState(msgNo, empNo);
		
		return "success";
		
	}
	// 파일 다운로드
	@GetMapping("/msg/download")
    public ResponseEntity<InputStreamResource> downloadFile(@RequestParam(name="file") String filename) {
		
        // 실제 파일이 저장된 경로
        String path = FilePath.getFilePath()+"msg_file/";
        File file = new File(path + File.separator + filename);

        // 로그로 경로 확인
        log.debug(TeamColor.YELLOW + "file =>" + file.getAbsolutePath());

        // 파일 존재 여부 확인
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        try {
            InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + file.getName())
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .contentLength(file.length())
                    .body(resource);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }
}
