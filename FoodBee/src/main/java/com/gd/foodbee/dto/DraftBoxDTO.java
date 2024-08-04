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
	private int draftDocNo;
	private int drafterEmpNo;
	private String tmpName;
	private String title;
	private String approvalStateNo;
	private String midApprovalDatetime;
	private String midApproverReason;
	private String finalApprovalDatetime;
	private String midApprovalState;
	private String finalApprovalState;
	private String finalApproverReason;
	private String createDatetime;
}
