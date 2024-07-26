package com.gd.foodbee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.BoardCommentDTO;

@Mapper
public interface BoardCommentMapper {
	
	// 글 댓글 리스트 출력
	// 파라미터 : int boardNo
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : BoardService.getCommentList
	List<Map<String,Object>> selectCommentList(int boardNo,int beginRow, int rowPerPage);
	
	// 댓글 전체 갯수 구하기
	// 파라미터 : int boardNo
	// 반환 값 : int
	// 사용 클래스 : BoardService.getLastPageComment
	int selectCommentCnt(int boardNo);
	
	// 댓글 작성
	// 파라미터 : BoardCommentDTO boardCommentRequestDTO
	// 반환 값 : int
	// 사용 클래스 : BoardService.addComment
	int insertComment(BoardCommentDTO boardCommentDTO);
	
	// 댓글 삭제
	// 파라미터 : int commentNo
	// 반환 값 : int
	// 사용 클래스 : BoardService.deleteComment
	int deleteComment(int commentNo);
	
	// 댓글 삭제 시 비번 체크 
	// 파라미터 : int commentNo, STring commentPw
	// 반환 값 : int
	// 사용 클래스 : BoarrdService.commentPwCheck
	int selectPwCheck(int commentNo, String commentPw);
	
	
}
