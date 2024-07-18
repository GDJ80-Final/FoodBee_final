package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MsgRecipientDTO {
	private int msgNo;
	private int recipientOrder;
	private int recipientEmpNo;
	private String readYN;
	private String readDateTime;
}
