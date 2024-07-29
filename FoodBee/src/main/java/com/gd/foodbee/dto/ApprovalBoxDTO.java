package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class ApprovalBoxDTO {
	private int draftDocNo;
	private String tmpName;
	private String empName;
	private String title;
	private String approverStateNo;
	private int midApproverNo;
	private String midApprovalState;
	private String midApprovalDatetime;
	private int finalApproverNo;
	private String finalApprovalState;
	private String finalApprovalDatetime;
	private String createDatetime;
}
