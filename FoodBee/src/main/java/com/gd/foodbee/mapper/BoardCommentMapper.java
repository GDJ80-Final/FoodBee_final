package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.BoardCommentDTO;

@Mapper
public interface BoardCommentMapper {
	//글 댓글 리스트 출력
	//파라미터 : int boardNo
	//반환값 : List<Map<String,Object>>
	//사용클래스 : BoardService.getCommentList
	List<Map<String,Object>> selectCommentList(int boardNo);
	
	//댓글 작성
	//파라미터 : BoardCommentDTO boardCommentRequestDTO
	//반환값 : int
	//사용클래스 : BoardService.addComment
	int insertComment(BoardCommentDTO boardCommentDTO);
}
