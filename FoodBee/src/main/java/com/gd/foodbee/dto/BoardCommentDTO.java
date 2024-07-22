package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardCommentDTO {
	private int commentNo;
	private int boardNo;
	private String content;
	private String createDatetime;
	private String commentPw;
}
