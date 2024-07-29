package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.DraftDocDTO;

@Mapper
public interface DraftDocMapper {
	//기안서 작성 
	int insertDraftDoc(DraftDocDTO draftDocDTO);
	
}
