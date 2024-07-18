package com.gd.foodbee.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class MsgRequestDTO {
	private int[] recipientEmpNos;
	private int senderEmpNo;
	private String title;
	private String content;
	private MultipartFile[] msgFiles;
	
}
