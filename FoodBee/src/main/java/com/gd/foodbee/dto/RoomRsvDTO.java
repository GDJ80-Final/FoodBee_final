package com.gd.foodbee.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomRsvDTO {
	private int rsvNo;
	private int roomNo;
	private int empNo;
	private String empName;
	private String roomName;
	private String rsvDate;
	private String startTime;
	private String endTime;
	private String type;
	private String rsvState;

}
