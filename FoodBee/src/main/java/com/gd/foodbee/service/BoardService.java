package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;

public interface BoardService {
	
	// 새글작성
	void addBoard(BoardDTO boardDTO);
	
	// 글 리스트
	List<Map<String,Object>> getBoardList(int currentPage,String category,String keyword);
	
	// 게시판 lastPage 구하기
	int getLastPageBoard(String category,String keyword);
	
	//글 상세보기 
	Map<String,Object> getBoardOne(int boardNo);
	
	// 댓글 리스트
	List<Map<String,Object>> getCommentList(int currentPage, int boardNo);
	
	// 댓글 lastPage 구하기
	int getLastPageComment(int boardNo);
	
	// 조회수 카운팅
	void updateViewCnt(int boardNo);
	
	// 좋아요 수 카운팅
	void updateLikeCnt(int boardNo);
	
	// 댓글 작성
	void addComment(BoardCommentDTO boardCommentDTO,int boardNo);
	
	// 글 수정
	void modifyBoard(BoardDTO boardDTO, int boardNo);
	
	// 글 삭제 
	boolean deleteBoard(int boardNo);
	
	// 댓글 삭제 
	boolean deleteComment(int commentNo);
	
	// 글 수정 삭제 시 비번 체크 
	boolean boardPwCheck(int boardNo, String boardPw);
	
	// 댓글 삭제 시 비번 체크 
	boolean commentPwCheck(int commentNo, String boardPw);
	
	// 최근 1주내의 top 5 인기글 뽑기
	List<Map<String,Object>> getMostLikedBoard();
	
	// 관리자 게시글 강제 삭제
	void deleteBoardByAdmin(int boardNo,int empNo,String deleteReason);
	
	// 관리자 댓글 강제 삭제 
	void deleteCommentByAdmin(int commentNo,int empNo, String deleteReason);
}
