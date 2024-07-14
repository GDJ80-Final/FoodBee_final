package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class NoticeDTO {
	private int noticeNo;
	private int writerEmpNo;
	private String dptNo;
	private String title;
	private String content;
	private String createDatetime;
	private String updateDatetime;
	private String type;

}
