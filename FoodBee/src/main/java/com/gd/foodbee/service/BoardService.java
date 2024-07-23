package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.BoardDTO;

public interface BoardService {
	//새글작성
	//파라미터 : boardDTO
	//반환값 :X
	//사용클래스 : BoardController.addBoard
	public void addBoard(BoardDTO boardDTO);
	
	//글 리스트
	//파라미터 : 
	//반환값 : List
	//사용클래스 : BoardController.boardList
	public List<Map<String,Object>> getBoardList(int currentPage,String category,String keyword);
}
