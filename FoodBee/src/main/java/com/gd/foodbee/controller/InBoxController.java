package com.gd.foodbee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.InBoxDTO;
import com.gd.foodbee.dto.InBoxStateDTO;
import com.gd.foodbee.service.InBoxService;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class InBoxController {
	@Autowired 
	private InBoxService inBoxService;
	
	// 수신함
	// 파라미터 : int currentPage, Model model, HttpSession session
	// 반환값 : Model model
	// 사용페이지 : /approval/inBox
   @GetMapping("/approval/inBox")
    public String inBox(@RequestParam(name="currentPage", defaultValue="1") int currentPage,
                        Model model, HttpSession session) {
        
        EmpDTO emp = (EmpDTO) session.getAttribute("emp");
        int empNo = 0;
        
        if (emp != null) {
            log.debug(TeamColor.PURPLE + "emp => " + emp);
            empNo = emp.getEmpNo();
            log.debug(TeamColor.PURPLE + "empNo => " + empNo);
        } else {
            log.debug(TeamColor.PURPLE + "로그인하지 않았습니다");
        }
        //수신함 stateBox가 0인경우 대비
        InBoxStateDTO stateBox = inBoxService.getStateBox(empNo);
        if (stateBox == null) {
            stateBox = InBoxStateDTO.builder()
            		.zeroState(0)
            		.oneState(0)
            		.twoState(0)
            		.nineState(0)
            		.build();
        }
       
        log.debug(TeamColor.PURPLE + "currentPage=>" + currentPage);
        log.debug(TeamColor.PURPLE + "stateBox=>" + stateBox);


        model.addAttribute("empNo", empNo);
        model.addAttribute("stateBox", stateBox);
        model.addAttribute("currentPage", currentPage);

        return "/approval/inBox";
    }
   // 수신함 총리스트
   // 파라미터 : int currentPage, int empNo
   // 반환값 : Map<>
   // 사용페이지 : /approval/inBox
   @GetMapping("/approval/inBoxList")
   @ResponseBody
   public Map<String,Object> inBoxList(int currentPage, int empNo){
	   
	   //전체 수신함리스트
	   List<InBoxDTO> referrerList = inBoxService.getReferrerList(currentPage, empNo);
	   //마지막페이지
       int listLastPage = inBoxService.allReferrerLastPage(empNo);
       
       log.debug(TeamColor.PURPLE + "referrerList=>" + referrerList);
       log.debug(TeamColor.PURPLE + "listLastPage=>" + listLastPage);
       
       Map<String,Object> referrer = new HashMap<String,Object>();
       referrer.put("referrerList", referrerList);
       referrer.put("listLastPage", listLastPage);
       
       return referrer;
   }
}
