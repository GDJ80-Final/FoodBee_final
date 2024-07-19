package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmpSearchDTO {

	private String officeName;
	private String deptName;
	private String teamName;
	private String rankName;
	private String signupYN;
	private Integer empNo;
	private String empName;
	private String empEmail;
	private String extNo;
	private String startDate;
	
}
