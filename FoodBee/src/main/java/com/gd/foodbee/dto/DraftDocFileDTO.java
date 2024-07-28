package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DraftDocFileDTO {
	private int draftDocFileNo;
	private String originalFile;
	private String saveFile;
	private String type;
	private String createDatetime;
	private String updateDatetime;
	private int draftDocNo;
	
}
