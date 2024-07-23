package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	//사내익명게시판 새 게시글 쓰기
	//파라미터 : BoardDTO
	//반환값 : int
	//사용클래스 : BoardService.
	int insertBoard(BoardDTO boardDTO);
	
	//게시글 리스트 + 검색 
	List<Map<String,Object>> selectBoardList(int beginRow, int rowPerPage, String category,String keyword);
	
	//게시글 상세보기 
	Map<String,Object> selectBoardOne(int boardNo);
	
}
