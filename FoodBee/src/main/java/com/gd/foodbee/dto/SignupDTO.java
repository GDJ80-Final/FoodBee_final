package com.gd.foodbee.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class SignupDTO {
	//회원가입 폼에서 보낸 값 받기  + validation 유효성 검사 추가 
	
	@NotNull(message= "필수 입력 값입니다.")
	@Positive(message= "유효하지 않은 사원번호입니다.")
	private int empNo;
	
	@NotBlank(message ="필수 입력 값입니다.")
	@Pattern(regexp = "^\\d{3}-\\d{4}-\\d{4}$",
			message ="연락처 형식이 올바르지 않습니다.")
	private String contact;
	
	@NotBlank(message ="필수 입력 값입니다.")
	private String postNo;
	
	@NotBlank(message ="필수 입력 값입니다.")
	private String address;
	
	@NotBlank(message ="필수 입력 값입니다.")
	private String addressDetail;
	
	@NotBlank(message ="필수 입력 값입니다.")
	@Pattern(regexp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,16}$",
		message ="비밀번호는 8자 이상 16자 이하의 대소문자, 숫자 및 특수문자를 포함해야 합니다.")
	private String empPw;
	

	private MultipartFile profileImg;
	
	
	
}
