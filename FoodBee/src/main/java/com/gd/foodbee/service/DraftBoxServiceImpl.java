package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.foodbee.mapper.DraftBoxMapper;

@Service
public class DraftBoxServiceImpl implements DraftBoxService {
	@Autowired DraftBoxMapper draftBoxMapper;
	
}
