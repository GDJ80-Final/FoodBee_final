package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DayOffDTO {
	private int dayOffNo;
	private int empNo;
	private String empName;
	private int draftDocNo;
	private String startDate;
	private String endDate;
	private String cancleYN;
	private String cancleReason;
	private String useYear;
	private String emergencyContact;
	private String typeName;
	private String content;
	
	 public String getFormattedStartDate() {
	        return startDate + "T00:00";
	    }

	    public String getFormattedEndDate() {
	        return endDate + "T00:00";
	    }
}
