package com.gd.foodbee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;
import com.gd.foodbee.service.BoardService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/community/board/addBoard")
	public String addBoard() {
		return "/community/board/addBoard";
	}
	
	@PostMapping("/community/board/addBoard")
	public String addBoard(BoardDTO boardRequestDTO) {
		log.debug(TeamColor.YELLOW + "boardRequestDTO =>" + boardRequestDTO.toString());
		boardService.addBoard(boardRequestDTO);
		
		return "redirect:/community/board/boardList";
	}
	@GetMapping("/community/board/boardList")
	public String boardList() {
		
		return "/community/board/boardList";
	}
	
	@PostMapping("/community/board/boardList")
	@ResponseBody
	public List<Map<String,Object>> boardList(@RequestParam(name="currentPage",defaultValue = "1")int currentPage,
				@RequestParam(name="category",defaultValue = "all") String category,
				@RequestParam(name="keyword") String keyword) {
		log.debug(TeamColor.YELLOW + "category =>" + category);
		log.debug(TeamColor.YELLOW + "keyword =>" + keyword);
		
		return boardService.getBoardList(currentPage, category, keyword);
	}
	
	@GetMapping("/community/board/boardOne")
	public String boardOne(@RequestParam(name="boardNo")int boardNo,
				Model model) {
		Map<String,Object> m = boardService.getBoardOne(boardNo);
		List<Map<String,Object>> list = boardService.getCommentList(boardNo);
		model.addAttribute("m", m);
		model.addAttribute("list", list);
		
		return "/community/board/boardOne";
	}
	
	
	@PostMapping("/community/board/updateViewCnt")
	@ResponseBody
	public String updateViewCnt(@RequestParam(name="boardNo")int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo );
		
		boardService.updateViewCnt(boardNo);
		
		return "success";
	}
	@PostMapping("/community/board/updateLikeCnt")
	@ResponseBody
	public int updateLikeCnt(@RequestParam(name="boardNo")int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo );
		
		boardService.updateLikeCnt(boardNo);
		Map<String,Object> m = boardService.getBoardOne(boardNo);
		int likeCnt = (int) m.get("likeCnt");
		log.debug(TeamColor.YELLOW + "likeCnt =>" +likeCnt);
		
		
		return likeCnt;
	}
	
	@PostMapping("/community/board/addComment")
	public String addComment(BoardCommentDTO boardCommentRequestDTO,
				@RequestParam(name="boardNo") int boardNo) {
		log.debug(TeamColor.YELLOW + "boardCommentRequestDTO =>"+boardCommentRequestDTO.toString());
		
		boardService.addComment(boardCommentRequestDTO, boardNo);
		
		return "redirect:/community/board/boardOne?boardNo="+boardNo;
	}
	
}
