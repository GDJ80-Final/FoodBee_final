package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpDTO {
	
	private int empNo;
	private String empName;
	private String extNo;
	private String empEmail;
	private String startDate;
	private String contact;
	private String address;
	private String postNo;
	private String empPw;
	private int errorCnt;
	private String pwUpdateDate;
	private String signupYN;
	private String signupDate;
	private String empState;
	private String endDate;
	private String rankName;
	private String dptNo;
}
