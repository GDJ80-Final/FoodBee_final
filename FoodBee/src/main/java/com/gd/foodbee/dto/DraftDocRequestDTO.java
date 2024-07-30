package com.gd.foodbee.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DraftDocRequestDTO {
	
	private int drafterEmpNo;
	private String title;
	private String content;
	private int midApproverNo;
	private int finalApproverNo;
	private int tmpNo;
	
	private String startDate;
	private String endDate;
	private String [] typeName;
	private int [] amount;
	private String [] description;
	private String text;
	
	private MultipartFile[] docFiles;

	private int[] referrerEmpNo;
}
