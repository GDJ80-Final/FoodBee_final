package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import com.gd.foodbee.dto.BoardDTO;

public interface BoardService {
	//새글작성
	void addBoard(BoardDTO boardDTO);
	
	//글 리스트
	List<Map<String,Object>> getBoardList();
}
