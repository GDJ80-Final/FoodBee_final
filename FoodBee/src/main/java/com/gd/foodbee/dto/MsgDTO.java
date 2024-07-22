package com.gd.foodbee.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MsgDTO {
	
	private int msgNo;
	private int senderEmpNo;
	private String title;
	private String content;
	private String createDatetime;
	private String msgState;
}
