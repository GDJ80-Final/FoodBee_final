package com.gd.foodbee.service;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.foodbee.dto.EmailDTO;
import com.gd.foodbee.dto.EmpDTO;
import com.gd.foodbee.dto.EmpSearchDTO;
import com.gd.foodbee.dto.LoginDTO;
import com.gd.foodbee.dto.ProfileDTO;
import com.gd.foodbee.dto.SignupDTO;
import com.gd.foodbee.mapper.EmpMapper;
import com.gd.foodbee.mapper.ProfileMapper;
import com.gd.foodbee.util.FileFormatter;
import com.gd.foodbee.util.SendEmail;
import com.gd.foodbee.util.TeamColor;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class EmpServiceImpl implements EmpService{
	
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private ProfileMapper profileMapper;
	
	@Autowired
	private SendEmail sendEmail;
	
	// 로그인
	// 파라미터 : LoginDTO
	// 반환 값 : EmptDTO
	// 사용 클래스 : LoginController.login
	@Override
	public EmpDTO login(LoginDTO loginDTO) {
		
		return empMapper.selectEmpByNoAndPw(loginDTO);
	}

	// 임시 비밀번호로 변경
	// 파라미터 : int empNo, String empPw
	// 반환 값 : void
	// 사용 클래스 : LoginController.getPw
	@Override
	public void modifyEmpPw(int empNo, String empPw) {
		int row = empMapper.updateEmpPw(empNo, empPw);
		if(row == 0) {
			throw new RuntimeException();
		}
	}
	
	//사원 인트라넷 등록 (가입) 
	//파라미터 : SignupDTO signupDTO,HttpServletRequest request
	//반환값 : void
	//사용클래스 : EmpController.signup
	@Override
	public void updateEmpSignup(SignupDTO signupDTO,
				HttpServletRequest request) {
			
			
		EmpDTO empDTO = EmpDTO.builder()
				.empNo(signupDTO.getEmpNo())
				.contact(signupDTO.getContact())
				.postNo(signupDTO.getPostNo())
				.address(signupDTO.getAddress() +" "+ signupDTO.getAddressDetail())
				.empPw(signupDTO.getEmpPw())
				.build();
		//emp 테이블 사원정보 업데이트 
		int row = empMapper.updateEmpSignup(empDTO);
		if(row == 0) {
			throw new RuntimeException();
		}
		
		MultipartFile mf = signupDTO.getProfileImg();
		log.debug(TeamColor.YELLOW + "multipartfile mf => " + mf.toString());
		
		//파일명 년월일시부초 형태로 변환 -> 파일명 중복 안되게 하기 위해서 
		String originalFile = FileFormatter.fileFormatter(mf);
		
		ProfileDTO profileDTO = ProfileDTO.builder()
					.empNo(signupDTO.getEmpNo())
					.originalFile(originalFile)
					.saveFile(mf.getOriginalFilename())
					.type(mf.getContentType())
					.build();
		//프로필 사진 등록 
		int row2 = profileMapper.insertProfileImg(profileDTO);
		
		// 파일 저장
		//Controller 에서 넘겨받은 HttpServletRequest 객체 받아서 RealPath 구해서 파일 저장하기 
		
		String path = request.getServletContext().getRealPath("/WEB-INF/upload/profile_img/");
		log.debug(TeamColor.YELLOW +"path =>"+ path);
		
		File emptyFile = new File(path+originalFile);
			try {
				mf.transferTo(emptyFile);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			} 
		if(row2 == 0) {
			throw new RuntimeException();
		}	
		
	}
	@Override
	public int selectEmpNoDuplicate(int empNo) {
		log.debug(TeamColor.YELLOW + "empNo => "+ empNo);
		int result = 0;
		//가입페이지접근은 result 가 0일때만 가능
		if(empMapper.selectEmpNoDuplicate(empNo) != null) {
			result = 1;
		}
		log.debug(TeamColor.YELLOW + "result => "+ result);
		return result;
	}
	@Override
	public int createEmpNo() {
      
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		log.debug(TeamColor.RED + "currenYear =>" + currentYear);
    	int empNoMax = empMapper.selectEmpNoMax();
    	log.debug(TeamColor.RED + "empNoMax =>" + empNoMax);
    	int empNo = 0;
      
    	if(empNoMax / 10000 ==  currentYear) {
    		empNo = empNoMax + 1;
    	} else {
    		empNo = currentYear * 10000 + 1;
    	}
      
    	log.debug(TeamColor.RED + "empNo =>" + empNo);
      
      return empNo;
      
	}
	
	@Override
	public void addEmp(EmpDTO empDTO, EmailDTO emailDTO) {
		
		int row = empMapper.insertEmp(empDTO);
      
		if(row != 1) {
			throw new RuntimeException();
		}
		
		sendEmail.sendEmail(emailDTO);
  
	}
	
	// 인증번호 생성
	// 파라미터 : int empNo, EmailDTO emailDTO
	// 반환 값 : int
	// 사용 클래스 : EmpController.sendAuthEmail
	@Override
	public int createAuth(int empNo, String empEmail) {
		
		
		EmpDTO empDTO = empMapper.selectEmpByNoAndEmail(empNo, empEmail);
		
		
		if(empDTO != null) {
			
			Random random = new Random();
			int authNum = random.nextInt(9000) + 1000;
			
			return authNum;
			
			
		}
		// empDTO가 없으면 사원번호나 이메일이 틀리다는 것이므로 틀렸다는 표시로 0을 넘김.
		return 0;
	}
	
	// 사원목록
	@Override
	public List<EmpSearchDTO> getEmpList(EmpSearchDTO empSearchDTO) {
		
		return empMapper.selectEmpList(empSearchDTO);
	}

	// 사원번호로 이메일 찾기
	@Override
	public String getEmpEmailByEmpNo(int empNo) {
		
		return empMapper.selectEmpEmailByEmpNo(empNo);
	}

	@Override
	public Map<String, Object> getEmpPersnal(int empNo) {
		
		return empMapper.selectEmpPersnal(empNo);
	}

	@Override
	public Map<String, Object> getEmpHr(int empNo) {
		
		return empMapper.selectEmpHr(empNo);
	}

	@Override
	public void modifyEmpHr(EmpDTO empDTO) {
		int row = empMapper.updateEmpHr(empDTO);
		
		if(row != 1) {
			throw new RuntimeException();
		}
	}
	
}
