package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DraftBoxDTO {
	private int drafterDocNo;
	private int drafterEmpNo;
	private String tmpName;
	private String title;
	private String approvalStateNo;
	private String finalApprovalDatetime;
	private String createDatetime;
}
