package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class InBoxDTO {
	private int draftDocNo;
	private int tmpNo;
	private String empName;
	private String tmpName;
	private String title;
	private String docApproverStateNo;
	private String createDatetime;
	
}
