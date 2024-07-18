package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class MsgFileDTO {
	private int msgFileNo;
	private int msgNo;
	private String originalFile;
	private String saveFile;
	private String type;
	private String createDateTime;
	private String updateDateTime;
}
