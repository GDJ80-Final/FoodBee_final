package com.gd.foodbee.service;

import java.util.Objects;

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
	// 파라미터 : DraftDocRequestDTO draftDocRequestDTO
	// 반환 값 : X
	// 사용 클래스 : ApprovalController.addDraft
	@Override
	public void addDraftDoc(DraftDocRequestDTO draftDocRequestDTO) {
		
		log.debug(TeamColor.YELLOW + "draftDocRequestDTO =>" + draftDocRequestDTO.toString());
		// draft_doc insert
		DraftDocDTO draftDocDTO = DraftDocDTO.builder()
					.drafterEmpNo(draftDocRequestDTO.getDrafterEmpNo())
					.title(draftDocRequestDTO.getTitle())
					.content(Objects.isNull(draftDocRequestDTO.getContent()) ? null : draftDocRequestDTO.getContent())
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
		// typeNames 값이 들어오지 않았다면 -> 기본기안서 
		String [] typeNames = null;
		int [] amounts = null;
		String [] texts = null;
		if(Objects.isNull(draftDocRequestDTO.getTypeName()) || draftDocRequestDTO.getTypeName().length == 0) {
			log.debug("typeNames => null");
		}else {
			typeNames = draftDocRequestDTO.getTypeName();
		}
		if(Objects.isNull(draftDocRequestDTO.getAmount()) || draftDocRequestDTO.getAmount().length == 0) {
			log.debug(TeamColor.YELLOW + "amounts => null");
		}else {
			amounts = draftDocRequestDTO.getAmount();
		}
		if(Objects.isNull(draftDocRequestDTO.getText()) || draftDocRequestDTO.getText().length == 0) {
			log.debug("typeNames => null");
		}else {
			texts = draftDocRequestDTO.getText();
		}
		
		if (Objects.isNull(typeNames)) {
		    log.debug(TeamColor.YELLOW + "기본기안서 작성");
			
		}else {
			int draftDocOrder = 1;
		    log.debug(TeamColor.YELLOW + "typeName =>" + typeNames[0]);
			for(int i = 0;i < typeNames.length;i++) {
				DraftDocDetailDTO draftDocDetailDTO = DraftDocDetailDTO.builder()
					.draftDocOrder(draftDocOrder)
					.draftDocNo(draftDocDTO.getDraftDocNo())
					.startDate(Objects.isNull(draftDocRequestDTO.getStartDate()) ? null : draftDocRequestDTO.getStartDate())
					.endDate(Objects.isNull(draftDocRequestDTO.getEndDate()) ? null : draftDocRequestDTO.getEndDate())
					.typeName(typeNames[i])
					.amount(Objects.isNull(draftDocRequestDTO.getAmount()) ? 0 :amounts[i])
					.description(Objects.isNull(draftDocRequestDTO.getDescription()) ? null : draftDocRequestDTO.getDescription())
					.text(Objects.isNull(draftDocRequestDTO.getText()) ? null : texts[i])
					.build();
				log.debug(TeamColor.YELLOW + "draftDocDetailDTO => " + draftDocDetailDTO);
				// insert into draft_doc_detail 
				int detailRow = draftDocDetailMapper.insertDraftDocDetail(draftDocDetailDTO);
				if(detailRow != 1) {
					throw new RuntimeException();
				}
				draftDocOrder++;
			}
		}
		
		// insert draft_doc_file 
		String path = filePath.getFilePath() + "draft_file/";
		log.debug(TeamColor.YELLOW + "path => " + path);
		MultipartFile[] mfs = null;
		if(Objects.isNull(draftDocRequestDTO.getDocFiles())) {
			log.debug(TeamColor.YELLOW + "첨부파일 존재하지 않음");
		}else {
			mfs = draftDocRequestDTO.getDocFiles();
			if(!mfs[0].isEmpty()) {
				for(MultipartFile mf:mfs) {
					String originalFile = fileFormatter.fileFormatter(mf);
					DraftDocFileDTO draftDocFileDTO = DraftDocFileDTO.builder()
								.draftDocNo(draftDocDTO.getDraftDocNo())
								.originalFile(originalFile)
								.saveFile(mf.getOriginalFilename())
								.type(mf.getContentType())
								.build();
					log.debug(TeamColor.YELLOW + "DocFileDTO =>" + draftDocFileDTO.toString());
					int fileRow = draftDocFileMapper.insertDraftDocFile(draftDocFileDTO);
					if(fileRow != 1) {
						throw new RuntimeException();
					}
					//파일 경로에 저장
					filePath.saveFile(path, originalFile, mf);
				}
		}
			
			
		// insert draft_referrer
		int [] referrers = null;
		if(Objects.isNull(draftDocRequestDTO.getReferrerEmpNo()) || draftDocRequestDTO.getReferrerEmpNo().length == 0) {
			log.debug(TeamColor.YELLOW + "수신 참조자가 없습니다");
		}else {
			referrers = draftDocRequestDTO.getReferrerEmpNo();
			log.debug(TeamColor.YELLOW + "referre[0] =>" + referrers[0]);
			for(int referrer:referrers) {
				DocReferrerDTO docReferrerDTO = DocReferrerDTO.builder()
							.draftDocNo(draftDocDTO.getDraftDocNo())
							.referrerEmpNo(referrer)
							.build();
				log.debug(TeamColor.YELLOW + "docReferrerDTO =>" +docReferrerDTO );
				int referrerRow = draftDocReferrerMapper.insertDraftDocReferrer(docReferrerDTO);
				if(referrerRow != 1) {
					throw new RuntimeException();
					}
				}
			}
			
		}
	}
	
	@Override
	public void modifyDraftDoc(DraftDocRequestDTO draftDocRequestDTO, int draftDocNo) {
		log.debug(TeamColor.RED + "draftDocRequestDTO =>" + draftDocRequestDTO.toString());
		// draft_doc update
		DraftDocDTO draftDocDTO = DraftDocDTO.builder()
					.draftDocNo(draftDocNo)
					.drafterEmpNo(draftDocRequestDTO.getDrafterEmpNo())
					.title(draftDocRequestDTO.getTitle())
					.content(Objects.isNull(draftDocRequestDTO.getContent()) ? null : draftDocRequestDTO.getContent())
					.midApproverNo(draftDocRequestDTO.getMidApproverNo())
					.finalApproverNo(draftDocRequestDTO.getFinalApproverNo())
					.tmpNo(draftDocRequestDTO.getTmpNo())
					.build();
		int row = draftDocMapper.updateDraftDoc(draftDocDTO);
		if(row != 1) {
			throw new RuntimeException();
		}
		
		// draft_doc_detail update
		
		// typeName length 만큼 반복문 돌리기 
		// typeNames 값이 들어오지 않았다면 -> 기본기안서 
		String [] typeNames = null;
		int [] amounts = null;
		String [] texts = null;
		if(Objects.isNull(draftDocRequestDTO.getTypeName()) || draftDocRequestDTO.getTypeName().length == 0) {
			log.debug("typeNames => null");
		}else {
			typeNames = draftDocRequestDTO.getTypeName();
		}
		if(Objects.isNull(draftDocRequestDTO.getAmount()) || draftDocRequestDTO.getAmount().length == 0) {
			log.debug(TeamColor.YELLOW + "amounts => null");
		}else {
			amounts = draftDocRequestDTO.getAmount();
		}
		if(Objects.isNull(draftDocRequestDTO.getText()) || draftDocRequestDTO.getText().length == 0) {
			log.debug("typeNames => null");
		}else {
			texts = draftDocRequestDTO.getText();
		}
		
		if (Objects.isNull(typeNames)) {
		    log.debug(TeamColor.RED + "기본기안서 작성");
			
		}else {
			int deleteRow = draftDocDetailMapper.deleteDraftDocDetail(draftDocNo);
			int draftDocOrder = 1;
		    log.debug(TeamColor.RED + "typeName =>" + typeNames[0]);
			for(int i = 0;i < typeNames.length;i++) {
				DraftDocDetailDTO draftDocDetailDTO = DraftDocDetailDTO.builder()
					.draftDocOrder(draftDocOrder)
					.draftDocNo(draftDocDTO.getDraftDocNo())
					.startDate(Objects.isNull(draftDocRequestDTO.getStartDate()) ? null : draftDocRequestDTO.getStartDate())
					.endDate(Objects.isNull(draftDocRequestDTO.getEndDate()) ? null : draftDocRequestDTO.getEndDate())
					.typeName(typeNames[i])
					.amount(Objects.isNull(draftDocRequestDTO.getAmount()) ? 0 :amounts[i])
					.description(Objects.isNull(draftDocRequestDTO.getDescription()) ? null : draftDocRequestDTO.getDescription())
					.text(Objects.isNull(draftDocRequestDTO.getText()) ? null : texts[i])
					.build();
				log.debug(TeamColor.RED + "draftDocDetailDTO => " + draftDocDetailDTO);
				// insert into draft_doc_detail 
				int detailRow = draftDocDetailMapper.insertDraftDocDetail(draftDocDetailDTO);
				if(detailRow != 1) {
					throw new RuntimeException();
				}
				draftDocOrder++;
			}
		}
		
		// update draft_doc_file 
//		String path = filePath.getFilePath() + "draft_file/";
//		log.debug(TeamColor.RED + "path => " + path);
//		MultipartFile[] mfs = null;
//		if(Objects.isNull(draftDocRequestDTO.getDocFiles())) {
//			log.debug(TeamColor.RED + "첨부파일 존재하지 않음");
//		}else {
//			mfs = draftDocRequestDTO.getDocFiles();
//			if(!mfs[0].isEmpty()) {
//				for(MultipartFile mf:mfs) {
//					String originalFile = fileFormatter.fileFormatter(mf);
//					DraftDocFileDTO draftDocFileDTO = DraftDocFileDTO.builder()
//								.draftDocNo(draftDocDTO.getDraftDocNo())
//								.originalFile(originalFile)
//								.saveFile(mf.getOriginalFilename())
//								.type(mf.getContentType())
//								.build();
//					log.debug(TeamColor.RED + "DocFileDTO =>" + draftDocFileDTO.toString());
//					int fileRow = draftDocFileMapper.insertDraftDocFile(draftDocFileDTO);
//					if(fileRow != 1) {
//						throw new RuntimeException();
//					}
					//파일 경로에 저장
//					filePath.saveFile(path, originalFile, mf);
//				}
//			}
//		}
//			
			
		// update draft_referrer
		int [] referrers = null;
		draftDocReferrerMapper.deleteDraftDocReferrer(draftDocNo);
		if(Objects.isNull(draftDocRequestDTO.getReferrerEmpNo()) || draftDocRequestDTO.getReferrerEmpNo().length == 0) {
			log.debug(TeamColor.RED + "수신 참조자가 없습니다");
		}else {
			referrers = draftDocRequestDTO.getReferrerEmpNo();
			log.debug(TeamColor.RED + "referre[0] =>" + referrers[0]);
			for(int referrer:referrers) {
				DocReferrerDTO docReferrerDTO = DocReferrerDTO.builder()
							.draftDocNo(draftDocDTO.getDraftDocNo())
							.referrerEmpNo(referrer)
							.build();
				log.debug(TeamColor.RED + "docReferrerDTO =>" +docReferrerDTO );
				int referrerRow = draftDocReferrerMapper.insertDraftDocReferrer(docReferrerDTO);
				if(referrerRow != 1) {
					throw new RuntimeException();
				}
			}
		}
	}
}
