package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DraftDocDetailDTO {
	private int draftDocOrder;
	private int draftDocNo;
	private String startDate;
	private String endDate;
	private String typeName;
	private int amount;
	private String description;
	private String text;
}
