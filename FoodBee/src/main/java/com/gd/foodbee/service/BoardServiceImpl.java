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
	BoardMapper boardMapper;
	
	@Autowired
	BoardCommentMapper boardCommentMapper;
	
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

	@Override
	public List<Map<String, Object>> getBoardList(int currentPage,String category, String keyword) {
		int rowPerPage = 10;
		int beginRow = (currentPage - 1) * rowPerPage;
		
		return boardMapper.selectBoardList(beginRow, rowPerPage, category,keyword);
	}
	@Override
	public Map<String, Object> getBoardOne(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		return boardMapper.selectBoardOne(boardNo);
	}
	
	@Override
	public List<Map<String, Object>> getCommentList(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		
		return boardCommentMapper.selectCommentList(boardNo);
	}
	@Override
	public void updateLikeCnt(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		int row = boardMapper.updateLikeCnt(boardNo);
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}
	
	@Override
	public void updateViewCnt(int boardNo) {
		log.debug(TeamColor.YELLOW + "boardNo =>" + boardNo);
		int row = boardMapper.updateViewCnt(boardNo);
		if(row != 1) {
			throw new RuntimeException();
		}
	}
	
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
