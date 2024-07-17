package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class ScheduleDTO {
	private int scheduleNo;
	private int empNo;
	private String title;
	private String content;
	private String type;
	private String startDatetime;
	private String endDatetime;
}
