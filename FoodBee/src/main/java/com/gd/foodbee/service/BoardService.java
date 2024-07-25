package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;

public interface BoardService {
	
	//새글작성
	void addBoard(BoardDTO boardDTO);
	
	//글 리스트
	List<Map<String,Object>> getBoardList(int currentPage,String category,String keyword);
	
	//글 상세보기 
	Map<String,Object> getBoardOne(int boardNo);
	
	//댓글 리스트
	List<Map<String,Object>> getCommentList(int boardNo);
	
	//조회수 카운팅
	void updateViewCnt(int boardNo);
	
	//좋아요 수 카운팅
	void updateLikeCnt(int boardNo);
	
	//댓글 작성
	void addComment(BoardCommentDTO boardCommentDTO,int boardNo);
}
