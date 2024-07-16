package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GroupDTO {
	
	private String dptNo;
	
	private String dptName;
	
	private String superiorDptNo;
	
	private String dptStartYear;
	
	private String dptEndYear;
	
	private String authorityCode;
	
}
