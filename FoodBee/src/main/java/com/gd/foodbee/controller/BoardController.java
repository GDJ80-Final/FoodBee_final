package com.gd.foodbee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.foodbee.dto.BoardDTO;
import com.gd.foodbee.service.BoardService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/community/addBoard")
	public String addBoard() {
		return "/community/addBoard";
	}
	
	@PostMapping("/community/addBoard")
	public String addBoard(BoardDTO boardRequestDTO) {
		log.debug(TeamColor.YELLOW + "boardRequestDTO =>" + boardRequestDTO.toString());
		boardService.addBoard(boardRequestDTO);
		
		return "redirect:/community/boardList";
	}
	@GetMapping("/community/boardList")
	public String boardList() {
		
		return "/community/boardList";
	}
}
