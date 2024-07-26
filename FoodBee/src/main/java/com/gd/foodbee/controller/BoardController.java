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

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;
import com.gd.foodbee.service.BoardService;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	// 새 게시글 작성 폼
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /community/board/addBoard
	@GetMapping("/community/board/addBoard")
	public String addBoard() {
		return "/community/board/addBoard";
	}
	// 새 게시글 작성
	// 파라미터 : BoardDTO boardRequestDTO
	// 반환 값 : String(view)
	// 사용 페이지 : /community/board/addBoard
	@PostMapping("/community/board/addBoard")
	public String addBoard(BoardDTO boardRequestDTO) {
		log.debug(TeamColor.YELLOW + "boardRequestDTO =>" + boardRequestDTO.toString());
		boardService.addBoard(boardRequestDTO);
		
		return "redirect:/community/board/boardList";
	}
	// 게시글 리스트
	// 파라미터 : X
	// 반환 값 : String(view)
	// 사용 페이지 : /community/board/boardList
	@GetMapping("/community/board/boardList")
	public String boardList() {
		
		return "/community/board/boardList";
	}
	// 게시글 리스트 데이터 뿌리기
	// 파라미터 : int currentPage, String category, String keyword
	// 반환 값 : List<Map<String,Object>>
	// 사용 페이지 : /community/board/boardList
	@PostMapping("/community/board/boardList")
	@ResponseBody
	public Map<String,Object> boardList(@RequestParam(name="currentPage",defaultValue = "1")int currentPage,
				@RequestParam(name="category",defaultValue = "all") String category,
				@RequestParam(name="keyword") String keyword) {
		log.debug(TeamColor.YELLOW + "category =>" + category);
		log.debug(TeamColor.YELLOW + "keyword =>" + keyword);
		
		int lastPage = boardService.getLastPageBoard(category, keyword);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("boardList", boardService.getBoardList(currentPage, category, keyword));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage); 
		
		
		return map;
	}
	// 게시글 상세보기 
	// 파라미터 : int boardNo, Model model
	// 반환 값 : String(view)
	// 사용 페이지 : /community/board/boardOne
	@GetMapping("/community/board/boardOne")
	public String boardOne(@RequestParam(name="boardNo")int boardNo,
				Model model) {
		Map<String,Object> m = boardService.getBoardOne(boardNo);
		
		model.addAttribute("m", m);
		
		
		return "/community/board/boardOne";
	}
	
	// 게시글 상세보기에서 댓글 리스트 뽑기
	// 파라미터 : int currentPage,int boardNo
	// 반환 값 : String
	// 사용 페이지 : /community/board/boardOne
	@PostMapping("/community/board/commentList")
	@ResponseBody
	public Map<String,Object> commentList(@RequestParam(name="currentPage",defaultValue = "1") int currentPage,
				@RequestParam(name="boardNo")int boardNo) {
		log.debug(TeamColor.YELLOW + "currentPage => " +  currentPage);
		log.debug(TeamColor.YELLOW + "boardNo => " +  boardNo);
		
		int lastPage = boardService.getLastPageComment(boardNo);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("commentList", boardService.getCommentList(currentPage, boardNo));
		map.put("currentPage", currentPage); 
		map.put("lastPage", lastPage); 
		
		
		return map;
		
		
		
	}
	
	// 게시글 조회수 업데이트
	// 파라미터 : int boardNo
	// 반환 값 : String
	// 사용 페이지 : /community/board/boardList
	@PostMapping("/community/board/updateViewCnt")
	@ResponseBody
	public String updateViewCnt(@RequestParam(name="boardNo")int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo );
		
		boardService.updateViewCnt(boardNo);
		
		return "success";
	}
	// 게시글 좋아요 업데이트 
	// 파라미터 : int boardNo
	// 반환 값 : int
	// 사용 페이지 : /community/board/boardOne
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
	// 게시글 댓글 추가 
	// 파라미터 : BoardCommentDTO boardCommentRequestDTO,int boardNo
	// 반환 값 : String(view)
	// 사용 페이지 : /community/board/boardOne
	@PostMapping("/community/board/addComment")
	public String addComment(BoardCommentDTO boardCommentRequestDTO,
				@RequestParam(name="boardNo") int boardNo) {
		log.debug(TeamColor.YELLOW + "boardCommentRequestDTO =>"+boardCommentRequestDTO.toString());
		
		boardService.addComment(boardCommentRequestDTO, boardNo);
		
		return "redirect:/community/board/boardOne?boardNo="+boardNo;
	}
	
	// 게시글 수정 폼
	@GetMapping("/community/board/modifyBoard")
	public String modifyBoard(@RequestParam(name="boardNo") int boardNo,
				Model model) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		Map<String,Object> m = boardService.getBoardOne(boardNo);
		
		model.addAttribute("m", m);
		
		return "/community/board/modifyBoard";
	}
	
	// 게시글 수정 
	@PostMapping("/community/board/modifyBoard")
	public String modifyBoard(BoardDTO boardDTO,
				@RequestParam(name="boardNo") int boardNo) {
		
		boardService.modifyBoard(boardDTO, boardNo);
		
		return "redirect:/community/board/boardOne?boardNo="+boardNo;
		
	}
	
	// 게시글 삭제 
	@PostMapping("/community/board/deleteBoard")
	@ResponseBody
	public boolean deleteBoard(@RequestParam(name="boardNo") int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		
		return boardService.deleteBoard(boardNo);
	}
	// 댓글 삭제 
	@PostMapping("/community/board/deleteComment")
	@ResponseBody
	public String deleteComment(@RequestParam(name="commentNo") int commentNo){
		log.debug(TeamColor.YELLOW + "commentNo =>" + commentNo);
		
		boardService.deleteComment(commentNo);
		
		return "success";
		
	}
	
	// 게시글 비번 체크 
	@PostMapping("/community/board/boardPwCheck")
	@ResponseBody
	public boolean boardPwCheck(@RequestParam(name="boardNo") int boardNo,
				String boardPw) {
		log.debug(TeamColor.YELLOW + "boardNo => "+ boardNo);
	
		
		return boardService.boardPwCheck(boardNo, boardPw);
	}
	// 댓글 비번 체크 
	@PostMapping("/community/board/commentPwCheck")
	@ResponseBody
	public boolean commentPwCheck(@RequestParam(name="commentNo") int commentNo,
				String commentPw) {
		
		return boardService.commentPwCheck(commentNo, commentPw);
	}
}
