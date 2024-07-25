package com.gd.foodbee.service;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import com.gd.foodbee.util.FilePath;
import com.gd.foodbee.util.TeamColor;

import jakarta.servlet.ServletContext;
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
	private MsgRecipientMapper msgRecipientMapper;
	
	
	
	
	// 새 쪽지 작성
	// 파라미터 : MsgRequestDTO msgRequestDTO,HttpServeltReqeust request, int empNo
	// 반환 값 : int
	// 사용 클래스 : MsgController.addMsg
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
		
		//파일 저장 경로 설정
		String path = FilePath.getFilePath() + "msg_file/";
		log.debug(TeamColor.YELLOW +"path =>"+ path);
		
		//쪽지 insert 
		int msgRow = msgMapper.insertMsg(msgDTO);
		if(msgRow != 1) {
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
				if(msgFileRow != 1) {
					throw new RuntimeException();
				}
				//파일 경로에 저장
				FilePath.saveFile(path, originalFile, mf);
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
				int msgRecipientRow = msgRecipientMapper.insertMsgRecipient(msgRecipientDTO);
				if(msgRecipientRow == 0) {
					throw new RuntimeException();
				}
				recipientOrder++;
			}
		}
		
		
	}
	// 받은 쪽지함 
	// 파라미터 : int currentPage, int empNo, String readYN 
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스  : MsgController.receivedMsg
	@Override
	public List<Map<String, Object>> getReceivedMsgList(int currentPage, int empNo,String readYN) {
		int rowPerPage = 15;
        int beginRow = (currentPage -1) * rowPerPage;
        log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgMapper.selectReceivedMsgList(empNo, beginRow, rowPerPage,readYN);
	}
	// 보낸 쪽지함
	// 파라미터 : int currentPage, int empNo, String readYN 
	// 반환 값 : List<Map<String,Object>>
	// 사용 클래스 : MsgConrtoller.sentMsgBox
	@Override
	public List<Map<String, Object>> getSentMsgList(int currentPage, int empNo, String readYN) {
		int rowPerPage = 15;
		int beginRow = (currentPage - 1) * rowPerPage;
		log.debug(TeamColor.YELLOW + "empNo" + empNo);
		
		return msgMapper.selectSentMsgList(empNo, beginRow, rowPerPage, readYN);
	}
	// 쪽지 휴지통 이동
	// 파라미터 : int msgNo
	// 반환 값 : X
	// 사용 클래스 : MsgController.toTrash
	@Override
	public void toTrash(int [] msgNos) {
		
		for(int msgNo : msgNos) {
			int row = msgMapper.updateMsgToTrash(msgNo);
			if(row != 1) {
				throw new RuntimeException();
			}
		}
		
		
	}
	
	// 쪽지 휴지통으로 보내기 >>수신자
	// 파라미터 : int [] msgNos, int empNo
	// 반환 값 :X
	// 사용 클래스 : MsgController.toTrashRecipient
	@Override
	public void toTrashRecipient(int[] msgNos, int empNo) {
		for(int msgNo : msgNos) {
			log.debug(TeamColor.YELLOW + "msgNo" + msgNo);
			int row = msgRecipientMapper.updateMsgToTrash(msgNo, empNo);
			if(row != 1) {
				throw new RuntimeException();
			}
		}
		
	}
	// 휴지통 리스트
	// 파라미터 : int empNo
	// 반환 값: List<Map<STring,Object>>
	// 사용 클래스 : MsgController.trashMsgBox
	@Override
	public List<Map<String, Object>> getTrashList(int empNo) {
		log.debug(TeamColor.YELLOW + "empNo =>" +empNo);
		
		return msgMapper.selectTrashMsgList(empNo);
	}
		
	
	// 휴지통 -> 쪽지함 이동 
	// 파라미터 : int[] msgNos, int empNo, String result
	// 반환 값 :X
	// 사용 클래스 : MsgController.toMsgBox
	@Override
	public void updatetoMsgBox(int[] msgNos,int empNo,String [] results) {
		// 입력된 배열의 길이가 일치하는지 확인
	    if (msgNos.length != results.length) {
	        throw new RuntimeException("msgNos와 results 배열의 길이가 일치하지 않습니다.");
	    }
	    for (int i = 0; i < msgNos.length; i++) {
	        int msgNo = msgNos[i];
	        String result = results[i];

	        if (result.equals("true")) {
	            // 발신자가 일치하므로 보낸 편지함으로 이동
	            log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
	            int row = msgMapper.updateMsgToMsgBox(msgNo);
	            if (row != 1) {
	                throw new RuntimeException("메시지 이동 실패: msgNo=" + msgNo);
	            }
	        } else if (result.equals("false")) {
	            // 발신자가 일치하지 않으므로 받은 편지함으로 이동
	            log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
	            int row2 = msgRecipientMapper.updatetoMsgBoxRecipient(msgNo, empNo);
	            if (row2 != 1) {
	                throw new RuntimeException("받은 편지함 이동 실패: msgNo=" + msgNo);
	            }
	        }
		
		}
			
	}
	
	// 쪽지 상세보기 
	// 파라미터 : int msgNo
	// 반환 값 : Map<String,Object>
	// 사용 클래스 : MsgController.msgOne
	@Override
	public Map<String, Object> getMsgOne(int msgNo) {
		log.debug(TeamColor.YELLOW + "msgNo => "+ msgNo);
		
		return msgMapper.selectMsgOne(msgNo);
	}
	// 쪽지 삭제 
	// 파라미터 : int[] msgNos, int empNo, String[] results
	// 반환 값 : X
	// 사용 클래스 : MsgController.deleteMsg
	@Override
	public void deleteMsg(int[] msgNos, int empNo, String[] results) {
		log.debug(TeamColor.YELLOW + "msgNos[0] =>" + msgNos[0]);
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo);
		log.debug(TeamColor.YELLOW + "result[0] =>" + results[0]);
		// 입력된 배열의 길이가 일치하는지 확인
	    if (msgNos.length != results.length) {
	        throw new RuntimeException("msgNos와 results 배열의 길이가 일치하지 않습니다.");
	    }
	    //발신자 일치 시 msg >> msg_state값을 업데이트
	    //불일치 시 msg_recipient >> recipient_msg_state 값을 업데이트
	    for (int i = 0; i < msgNos.length; i++) {
	        int msgNo = msgNos[i];
	        String result = results[i];

	        if (result.equals("true")) {
	            // 발신자가 일치하므로 msg 테이블을 업데이트 
	            log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
	            int row = msgMapper.updateMsgDelete(msgNo);
	            if (row != 1) {
	                throw new RuntimeException("메시지 삭제 실패: msgNo=" + msgNo);
	            }
	        } else if (result.equals("false")) {
	            // 발신자가 일치하지 않으므로 msg_recipient 테이블을 업데이트 
	            log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
	            int row2 = msgRecipientMapper.updateMsgDelete(msgNo, empNo);
	            if (row2 != 1) {
	                throw new RuntimeException("받은 편지함 이동 실패: msgNo=" + msgNo);
	            }
	        }
		
		}
		
	}

	// 쪽지 읽음 여부 업데이트
	// 파라미터 : int msgNo, int empNo
	// 반환 값 : X
	// 사용 클래스 : MsgController.updateReadState
	@Override
	public void updateReadState(int msgNo, int empNo) {
		log.debug(TeamColor.YELLOW + "msgNo =>" + msgNo);
		log.debug(TeamColor.YELLOW + "empNo =>" + empNo);
		
		int row = msgRecipientMapper.updateReadYN(msgNo, empNo);
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}
}
