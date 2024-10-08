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
	
	// 글 수정 삭제 시 비번 체크 
	// 파라미터 : int boardNo, String boardPw
	// 반환 값 : int 
	// 사용 클래스 :BoardService.boardPwCheck
	int selectPwCheck(int boardNo, String boardPw);
	
	// 사내익명게시판 게시글 수정
	// 파라미터 : BoardDTO boardDTO
	// 반환 값 : int
	// 사용 클래스 : BoardService.modifyBoard
	int updateBoard(BoardDTO boardDTO);
	
	// 사내익명게시판 게시글 삭제 
	// 파라미터 : int boardNo,
	// 반환 값 : int
	// 사용 클래스 : BoardService.deleteBoard
	int deleteBoard(int boardNo);
	
	// 게시글 리스트 + 검색 
	// 파라미터 :int beginRow, int rowPerPage, String category,String keyword
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : BoardService.getBoardList
	List<Map<String,Object>> selectBoardList(int beginRow, int rowPerPage, String category,String keyword);
	
	// 게시글 페이징 전체 갯수 구하기 
	// 파라미터 : String category, String keyword
	// 반환 값 : int
	// 사용 클래스 : BoardService.getBoardList
	int selectBoardCnt(String category,String keyword);
	
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
	
	// 인기글 top 5 리스트 출력
	// 파라미터 : X
	// 반환 값 : List<Map<STring,Obejct>>
	// 사용 클래스 : BoardService.getMostLikedBoard
	List<Map<String,Object>> selectMostLikedBoard();
	
	// 관리자(운영팀) 으로 들어올 시 게시글 강제삭제  -> 업데이트 
	// 파라미터 : int boardNo, int empNo,String deleteReason
	// 반환 값 : int
	// 사용 클래스 : BoardService.deleteBoardByAdmin
	int updateBoardByAdmin(int boardNo,int empNo,String deleteReason);
	
}
