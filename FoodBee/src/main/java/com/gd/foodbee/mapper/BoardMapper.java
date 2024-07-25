package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	
	// 사내익명게시판 새 게시글 쓰기
	// 파라미터 : BoardDTO boardDTO
	// 반환 값 : int
	// 사용 클래스 : BoardService.addBoard
	int insertBoard(BoardDTO boardDTO);
	
	// 게시글 리스트 + 검색 
	// 파라미터 :int beginRow, int rowPerPage, String category,String keyword
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : BoardService.getBoardList
	List<Map<String,Object>> selectBoardList(int beginRow, int rowPerPage, String category,String keyword);
	
	// 게시글 상세보기
	// 파라미터 : int boardNo
	// 반환 값 : Map<String,Object>>
	// 사용 클래스 : BoardService.getBoardOne
	Map<String,Object> selectBoardOne(int boardNo);
	
	// 조회수 카운팅
	// 파라미터 : int boardNo
	// 반환값 : int
	// 사용 클래스 : BoardService.updateViewCnt
	int updateViewCnt(int boardNo);
	
	// 좋아요 수 카운팅
	// 파라미터 : int boardNo
	// 반환 값 : int
	// 사용 클래스 : BoardService.updateLikeCnt
	int updateLikeCnt(int boardNo);
	
}
