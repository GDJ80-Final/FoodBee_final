package com.gd.foodbee.service;

import java.io.File;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.MsgDTO;
import com.gd.foodbee.dto.MsgFileDTO;
import com.gd.foodbee.dto.MsgRecipientDTO;
import com.gd.foodbee.dto.MsgRequestDTO;
import com.gd.foodbee.mapper.MsgFileMapper;
import com.gd.foodbee.mapper.MsgMapper;
import com.gd.foodbee.mapper.MsgRecipientMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
@Transactional
public class MsgServiceImpl implements MsgService{
	
	
	@Autowired
	private MsgMapper msgMapper;
	
	@Autowired
	private MsgFileMapper msgFileMapper;
	
	@Autowired
	private MsgRecipientMapper msgRepicientMapper;
	
	
	//새 쪽지 작성
	//파라미터 : MsgRequestDTO
	//반환값 : int
	//사용클래스 : MsgController.addMsg
	@Override
	public void addMsg(MsgRequestDTO msgRequestDTO,
				HttpServletRequest request,
				int empNo) {
		//매개값 확인 
		log.debug(TeamColor.YELLOW + "MsgRequestDTO =>" + msgRequestDTO.toString());
		
		//msgDTO 빌드
		MsgDTO msgDTO = MsgDTO.builder()
				.senderEmpNo(empNo)
				.title(msgRequestDTO.getTitle())
				.content(msgRequestDTO.getContent())
				.build();
		log.debug(TeamColor.YELLOW + "MsgDTO =>" + msgDTO);
		
		MultipartFile [] mfs = msgRequestDTO.getMsgFiles();
		log.debug(TeamColor.YELLOW + "Multipartfiel mfs =>" + mfs.toString() );
		
		String path = request.getServletContext().getRealPath("/WEB-INF/upload/msg_file/");
		log.debug(TeamColor.YELLOW +"path =>"+ path);
		
		//쪽지 insert 
		int msgRow = msgMapper.insertMsg(msgDTO);
		if(msgRow == 0) {
			throw new RuntimeException();
			//실패 시 예외 처리
		}
		//첨부파일이 들어왔을 경우 
		log.debug(TeamColor.YELLOW + "mfs isEmpty =>" + mfs[0].isEmpty());
		if(!mfs[0].isEmpty()) {
			for(MultipartFile mf:mfs) {
				String originalFile = FileFormatter.fileFormatter(mf);
				MsgFileDTO msgFileDTO = MsgFileDTO.builder()
							.msgNo(msgDTO.getMsgNo())
							.originalFile(originalFile)
							.saveFile(mf.getOriginalFilename())
							.type(mf.getContentType())
							.build();
				log.debug(TeamColor.YELLOW + "MsgFileDTO =>" + msgFileDTO);
				int msgFileRow = msgFileMapper.insertMsgFile(msgFileDTO);
				if(msgFileRow == 0) {
					throw new RuntimeException();
				}
				File emptyFile = new File(path+originalFile);
				try {
					mf.transferTo(emptyFile);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				} 
			}
		}else {
			log.debug(TeamColor.YELLOW + "첨부파일이 없습니다.");
		}
		int [] msgRecipients = msgRequestDTO.getRecipientEmpNos();
		
		if(msgRecipients.length != 0) {
			//수신자 순번 
			int recipientOrder = 1;
			for(int msgRecipient: msgRecipients) {
				MsgRecipientDTO msgRecipientDTO = MsgRecipientDTO.builder()
							.msgNo(msgDTO.getMsgNo())
							.recipientOrder(recipientOrder)
							.recipientEmpNo(msgRecipient)
							.build();
				int msgRecipientRow = msgRepicientMapper.insertMsgRecipient(msgRecipientDTO);
				if(msgRecipientRow == 0) {
					throw new RuntimeException();
				}
				recipientOrder++;
			}
		}
		
		
	}
	//받은 쪽지함 
	//파라미터 : int currentPage, int empNo, String readYN 
	//반환값 : List<Map<String,Object>>
	//사용클래스  : MsgController.receivedMsg
	@Override
	public List<Map<String, Object>> getReceivedMsgList(int currentPage, int empNo,String readYN) {
		int rowPerPage = 15;
        int beginRow = (currentPage -1) * rowPerPage;
        log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgMapper.selectReceivedMsgList(empNo, beginRow, rowPerPage,readYN);
	}
	//보낸 쪽지함
	//파라미터 : int currentPage, int empNo, String readYN 
	//반환값 : List<Map<String,Object>>
	@Override
	public List<Map<String, Object>> getSentMsgList(int currentPage, int empNo, String readYN) {
		int rowPerPage = 15;
		int beginRow = (currentPage - 1) * rowPerPage;
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgMapper.selectSentMsgList(empNo, beginRow, rowPerPage, readYN);
	}
	//쪽지 휴지통 이동
	//파라미터 : int msgNo
	//반환값 : X
	//사용클래서 : MsgController.toTrash
	@Override
	public void toTrash(int [] msgNos) {
		
		for(int msgNo : msgNos) {
			int row = msgMapper.updateMsgToTrash(msgNo);
			if(row != 1) {
				throw new RuntimeException();
			}
		}
		
		
	}
	
	//쪽지 휴지통으로 보내기 >>수신자
	//파라미터 : int [] msgNos, int empNo
	//반환값 :X
	//사용클래스 : MsgController.toTrashRecipient
	@Override
	public void toTrashRecipient(int[] msgNos, int empNo) {
		for(int msgNo : msgNos) {
			log.debug(TeamColor.YELLOW + "msgNo" + msgNo);
			int row = msgRepicientMapper.updateMsgToTrash(msgNo, empNo);
			if(row != 1) {
				throw new RuntimeException();
			}
		}
		
	}
}
