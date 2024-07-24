package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;

public interface BoardService {
	//새글작성
	//파라미터 : boardDTO
	//반환값 :X
	//사용클래스 : BoardController.addBoard
	public void addBoard(BoardDTO boardDTO);
	
	//글 리스트
	//파라미터 : int currentPage,String category,String keyword)
	//반환값 : List
	//사용클래스 : BoardController.boardList
	public List<Map<String,Object>> getBoardList(int currentPage,String category,String keyword);
	
	//글 상세보기 
	//파라미터 : int boardNo
	//반환값 : Map<String,Object>
	//사용클래스 : BoardController.boardOne
	public Map<String,Object> getBoardOne(int boardNo);
	
	//댓글 리스트
	public List<Map<String,Object>> getCommentList(int boardNo);
	
	//조회수 카운팅
	public void updateViewCnt(int boardNo);
	//좋아요 수 카운팅
	public void updateLikeCnt(int boardNo);
	
	//댓글 작성
	public void addComment(BoardCommentDTO boardCommentDTO,int boardNo);
}
