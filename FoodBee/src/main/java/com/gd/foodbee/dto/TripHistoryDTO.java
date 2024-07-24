package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class TripHistoryDTO {
	private int businessTripNo;
	private int empNo;
	private String empName;
	private String businessTripDestination;
	private String startDate;
	private String endDate;
	private String cancleYN;
	private String cancleReason;
	private String emergencyContact;
	private int draftDocNo;
	private String content;
	
	public String getFormattedStartDate() {
        return startDate + "T00:00";
    }

    public String getFormattedEndDate() {
        return endDate + "T00:00";
    }
	
}
