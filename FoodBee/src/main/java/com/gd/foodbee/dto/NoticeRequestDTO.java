package com.gd.foodbee.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeRequestDTO {
	private int writerEmpNo;
	private int noticeNo;
	private String dptNo;
	private String title;
	private String content;
	private String createDatetime;
	private String updateDatetime;
	private String type;
	private String saveFile;
	private String originalFile;
	private MultipartFile[] files;
	
}
