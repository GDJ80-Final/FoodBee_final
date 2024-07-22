package com.gd.foodbee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.foodbee.dto.BoardDTO;
import com.gd.foodbee.mapper.BoardMapper;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardMapper boardMapper;
	
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
	public List<Map<String, Object>> getBoardList() {
		// TODO Auto-generated method stub
		return null;
	}

}
