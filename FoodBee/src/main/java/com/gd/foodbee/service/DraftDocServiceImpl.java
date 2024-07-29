package com.gd.foodbee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.DocReferrerDTO;
import com.gd.foodbee.dto.DraftDocDTO;
import com.gd.foodbee.dto.DraftDocDetailDTO;
import com.gd.foodbee.dto.DraftDocFileDTO;
import com.gd.foodbee.dto.DraftDocRequestDTO;
import com.gd.foodbee.mapper.DraftDocDetailMapper;
import com.gd.foodbee.mapper.DraftDocFileMapper;
import com.gd.foodbee.mapper.DraftDocMapper;
import com.gd.foodbee.mapper.DraftDocReferrerMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class DraftDocServiceImpl implements DraftDocService{
	
	@Autowired
	private DraftDocMapper draftDocMapper;
	
	@Autowired
	private DraftDocDetailMapper draftDocDetailMapper;
	
	@Autowired
	private DraftDocReferrerMapper draftDocReferrerMapper;
	
	@Autowired
	private DraftDocFileMapper draftDocFileMapper;
	
	@Autowired
	private FileFormatter fileFormatter;
	
	@Autowired
	private FilePath filePath;
	
	// 새기안서 추가
	// 파라미터 : 
	@Override
	public void addDraftDoc(DraftDocRequestDTO draftDocRequestDTO) {
		
		log.debug(TeamColor.YELLOW + "draftDocRequestDTO =>" + draftDocRequestDTO.toString());
		// draft_doc insert
		DraftDocDTO draftDocDTO = DraftDocDTO.builder()
					.drafterEmpNo(draftDocRequestDTO.getDrafterEmpNo())
					.title(draftDocRequestDTO.getTitle())
					.content(draftDocRequestDTO.getContent() == null ? null : draftDocRequestDTO.getContent())
					.midApproverNo(draftDocRequestDTO.getMidApproverNo())
					.finalApproverNo(draftDocRequestDTO.getFinalApproverNo())
					.tmpNo(draftDocRequestDTO.getTmpNo())
					.build();
		int row = draftDocMapper.insertDraftDoc(draftDocDTO);
		if(row != 1) {
			throw new RuntimeException();
		}
		
		// draft_doc_detail insert
		
		// typeName length 만큼 반복문 돌리기 
		// typeNames [0] => empty 이면 기본기안서 이므로 for문 X
		String [] typeNames = null;
		if(draftDocRequestDTO.getTypeName().length != 0) {
			typeNames = draftDocRequestDTO.getTypeName();
		}else {
			typeNames = null;
		}
		int [] amounts = draftDocRequestDTO.getAmount();
		String [] descriptions = draftDocRequestDTO.getDescription();
		log.debug(TeamColor.YELLOW + "typeName =>" + typeNames[0]);
		if (typeNames != null && typeNames.length > 0 && typeNames[0] != null && !typeNames[0].isEmpty()) {
		    int draftDocOrder = 1;
			
			for(int i = 0;i < typeNames.length;i++) {
				DraftDocDetailDTO draftDocDetailDTO = DraftDocDetailDTO.builder()
					.draftDocOrder(draftDocOrder)
					.draftDocNo(draftDocDTO.getDraftDocNo())
					.startDate(draftDocRequestDTO.getStartDate() == null ? null : draftDocRequestDTO.getStartDate())
					.endDate(draftDocRequestDTO.getEndDate() == null ? null : draftDocRequestDTO.getEndDate())
					.typeName(typeNames[i] == null ? null : typeNames[i])
					.amount(amounts[i] == 0 ? null :amounts[i])
					.description(descriptions[i] ==  null ? null : descriptions[i])
					.text(draftDocRequestDTO.getText() == null ? null : draftDocRequestDTO.getText())
					.build();
				log.debug(TeamColor.YELLOW + "draftDocDetailDTO => " + draftDocDetailDTO);
				// insert into draft_doc_detail 
				int detailRow = draftDocDetailMapper.insertDraftDocDetail(draftDocDetailDTO);
				if(detailRow != 1) {
					throw new RuntimeException();
				}
				draftDocOrder++;
			}
			
		}else {
			log.debug(TeamColor.YELLOW + "기본기안서 작성");
		}
		
		// insert draft_doc_file 
		MultipartFile[] mfs = draftDocRequestDTO.getDocFiles();
		String path = filePath.getFilePath() + "draft_file/";
		log.debug(TeamColor.YELLOW + "path => " + path);
		// 첨부파일이 들어왔을 경우 
		log.debug(TeamColor.YELLOW + "mfs isEmpty =>" + mfs[0].isEmpty());
		if(!mfs[0].isEmpty()) {
			for(MultipartFile mf:mfs) {
				String originalFile = fileFormatter.fileFormatter(mf);
				DraftDocFileDTO draftDocFileDTO = DraftDocFileDTO.builder()
							.draftDocNo(draftDocDTO.getDraftDocNo())
							.originalFile(originalFile)
							.saveFile(mf.getOriginalFilename())
							.type(mf.getContentType())
							.build();
				log.debug(TeamColor.YELLOW + "MsgFileDTO =>" + draftDocFileDTO.toString());
				int fileRow = draftDocFileMapper.insertDraftDocFile(draftDocFileDTO);
				if(fileRow != 1) {
					throw new RuntimeException();
				}
				//파일 경로에 저장
				filePath.saveFile(path, originalFile, mf);
			}
		}else {
			log.debug(TeamColor.YELLOW + "첨부파일이 없습니다.");
		}
			
		// insert draft_referrer
		int [] referrers = draftDocRequestDTO.getReferrerEmpNo();
		log.debug(TeamColor.YELLOW + "referre[0] =>" + referrers[0]);
		if(referrers.length != 0) {
			for(int referrer:referrers) {
				DocReferrerDTO docReferrerDTO = DocReferrerDTO.builder()
							.docDraftNo(draftDocDTO.getDraftDocNo())
							.referrerEmpNo(referrer)
							.build();
				log.debug(TeamColor.YELLOW + "docReferrerDTO =>" +docReferrerDTO );
				int referrerRow = draftDocReferrerMapper.insertDraftDocReferrer(docReferrerDTO);
				if(referrerRow != 1) {
					throw new RuntimeException();
				}
			}
		}else {
			log.debug(TeamColor.YELLOW + "수신참조자가 없습니다. ");
		}
		
	}
}
