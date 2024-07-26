package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.BoardCommentDTO;
import com.gd.foodbee.dto.BoardDTO;
import com.gd.foodbee.mapper.BoardCommentMapper;
import com.gd.foodbee.mapper.BoardMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private BoardCommentMapper boardCommentMapper;
	
	private static final int ROW_PER_PAGE = 10;
	
	private static final int ROW_PER_PAGE_COMMENT = 5;
	
	// 새 글 작성
	// 파라미터 : BoardDTO boardDTO
	// 반환 값 : X
	// 사용 클래스 : BoardController.addBoard
	@Override
	public void addBoard(BoardDTO boardRequestDTO) {
		BoardDTO boardDTO = BoardDTO.builder()
					.boardCategory(boardRequestDTO.getBoardCategory())
					.title(boardRequestDTO.getTitle())
					.content(boardRequestDTO.getContent())
					.boardPw(boardRequestDTO.getBoardPw())
					.build();
		log.debug(TeamColor.YELLOW + "boardDTO =>" + boardDTO.toString());
		//insert
		int row = boardMapper.insertBoard(boardDTO);
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}
	// 글 리스트
	// 파라미터 : int currentPage,String category,String keyword
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : BoardController.boardList
	@Override
	public List<Map<String, Object>> getBoardList(int currentPage,String category, String keyword) {
		
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
		
		return boardMapper.selectBoardList(beginRow, ROW_PER_PAGE, category,keyword);
	}
	// 게시판 lastPage 구하기
	// 파라미터 : String category, String keyword
	// 반환 값 : int
	// 사용 클래스 : BoardController.boardList
	@Override
	public int getLastPageBoard(String category, String keyword) {
		
		int boardCount = boardMapper.selectBoardCnt(category, keyword);
		
		int lastPage = (int) Math.ceil((double) boardCount / ROW_PER_PAGE);
		
		return lastPage;
	}
	
	// 글 상세보기 
	// 파라미터 : int boardNo
	// 반환 값 : Map<String,Object>
	// 사용 클래스 : BoardController.boardOne
	@Override
	public Map<String, Object> getBoardOne(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		return boardMapper.selectBoardOne(boardNo);
	}
	// 댓글 리스트 
	// 파라미터 : int boardNo
	// 반환 값 : List<Map<String, Object>>
	// 사용 클래스 : BoardController.commentList
	@Override
	public List<Map<String, Object>> getCommentList(int currentPage, int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		int beginRow = (currentPage - 1) * ROW_PER_PAGE_COMMENT;
		
		return boardCommentMapper.selectCommentList(boardNo, beginRow, ROW_PER_PAGE_COMMENT);
	}
	
	// 댓글리스트 lastPage 구하기
	// 파라미터 : int boardNo
	// 반환 값 : int
	// 사용 클래스 : BoardController.commentList
	@Override
	public int getLastPageComment(int boardNo) {
		
		int commentCount = boardCommentMapper.selectCommentCnt(boardNo);
		
		int lastPage = (int) Math.ceil((double) commentCount / ROW_PER_PAGE_COMMENT);
		
		return lastPage;
	}
	
	// 좋아요 수 업데이트 
	// 파라미터 : int boardNo
	// 반환 값 : X
	// 사용 클래스 : BoardController.updateLikeCnt
	@Override
	public void updateLikeCnt(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		int row = boardMapper.updateLikeCnt(boardNo);
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}
	
	// 조회수 업데이트  
	// 파라미터 : int boardNo
	// 반환 값 :X
	// 사용 클래스 : BoardController.updateViewCnt
	@Override
	public void updateViewCnt(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		int row = boardMapper.updateViewCnt(boardNo);
		if(row != 1) {
			throw new RuntimeException();
		}
	}
	
	// 댓글 추가
	// 파라미터 : int boardNo
	// 반환 값 : X
	// 사용 클래스 : BoardController.addComment
	@Override
	public void addComment(BoardCommentDTO boardCommentRequestDTO,int boardNo) {
		BoardCommentDTO boardCommentDTO = BoardCommentDTO.builder()
					.boardNo(boardNo)
					.content(boardCommentRequestDTO.getContent())
					.commentPw(boardCommentRequestDTO.getCommentPw())
					.build();
		log.debug(TeamColor.YELLOW + "boardCommentDTO =>"+boardCommentDTO.toString());
		int row = boardCommentMapper.insertComment(boardCommentDTO);
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}
}
