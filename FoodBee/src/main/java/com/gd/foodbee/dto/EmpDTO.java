package com.gd.foodbee.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpDTO {
	
	@NotNull(message= "필수 입력 값입니다.")
	@Positive(message= "유효하지 않은 사원번호입니다.")
	private int empNo;
	
	@NotBlank(message= "필수 입력 값입니다.")
	private String empName;
	
	private String extNo;
	
	@NotBlank(message= "필수 입력 값입니다.")
	@Email(message = "유효하지 않은 이메일 형식입니다.")
	private String empEmail;
	
	@NotBlank(message= "필수 입력 값입니다.")
	private String startDate;
	
	private String contact;
	
	private String address;
	
	private String postNo;
	
	private String empPw;
	
	private int errorCnt;
	
	private String pwUpdateDate;
	
	private String signupYN;
	
	private String signupDate;
	
	@NotBlank(message= "필수 입력 값입니다.")
	private String empState;
	
	private String endDate;
	
	@NotBlank(message= "필수 입력 값입니다.")
	private String rankName;
		
	private String dptNo;
}
