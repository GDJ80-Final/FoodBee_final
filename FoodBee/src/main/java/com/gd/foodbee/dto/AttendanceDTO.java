package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AttendanceDTO {
	private String date;
	private int empNo;
	private String startTime;
	private String endTime;
	private String updateStartTime;
	private String updateEndTime;
	private String updateReason;
	private String finalTime;
	private String approvalState;
	private String approvalDateTime;
	private String approvalReason;
	
}