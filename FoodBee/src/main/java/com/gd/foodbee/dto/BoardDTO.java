package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardDTO {
	private int boardNo;
	private String title;
	private String boardCategory;
	private String createDatetime;
	private String updateDatetime;
	private int view;
	private String content;
	private String boardPw;
	private int likeCnt;
}
