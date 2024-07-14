package com.gd.foodbee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.NoticeFileDTO;

@Mapper
public interface NoticeFileMapper {
	//공지사항 파일 추가
	int insertNoticeFile(NoticeFileDTO noticeFileDTO);
}
