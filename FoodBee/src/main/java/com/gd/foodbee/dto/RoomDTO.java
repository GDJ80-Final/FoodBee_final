package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomDTO {
	private int roomNo;
	private String roomName;
	private String roomPlace;
	private int roomMax;
	private String info;
	private String useYN;
	private String createDate;
	private String updateDate;
	private String caution;
	private String originalFile;
	private String saveFile;
}
