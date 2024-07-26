package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class ApprovalBoxStateDTO {
	private int zeroState;
	private int oneState;
	private int twoState;
	private int nineState;
}
