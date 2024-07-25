package com.gd.foodbee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class InBoxStateDTO {
	private int zeroState;
	private int oneState;
	private int twoState;
	private int nineState;
	
	public int totalCount() {
        return zeroState + oneState + twoState + nineState;
    }
}
