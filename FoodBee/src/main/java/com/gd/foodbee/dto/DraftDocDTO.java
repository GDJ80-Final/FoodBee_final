package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DraftDocDTO {
	private int draftDocNo;
	private int drafterEmpNo;
	private String createDatetime;
	private String title;
	private String content;
	private int midApproverNo;
	private String midApprovalState;
	private String midApprovalDatetime;
	private int finalApproverNo;
	private String finalApprovalState;
	private String finalApprovalDatetime;
	private String midApproverReason;
	private String finalApproverReason;
	private String docApproverState;
	private int tmpNo;
}
