package com.gd.foodbee.service;

import java.io.File;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
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
	
	private static final int ROW_PER_PAGE = 2;
	
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
				.address(signupDTO.getAddress() +" | "+ signupDTO.getAddressDetail())
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
	
	// 사원번호 생성
	// 파라미터 : int empNo
	// 반환 값 : int
	// 사용 클래스 : 
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
	
	// 사원번호 생성
	// 파라미터 : X
	// 반환 값 : int
	// 사용 클래스 : EmpController.createEmpNo
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
	
	
	// 사원 등록
	// 파라미터 : EmpDTO empDTO, EmailDTO emailDTO
	// 반환 값 : X
	// 사용 클래스 : EmpController.addEmp
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
	// 파라미터 : EmpSearchDTO empSearchDTO, int currentPage
	// 반환 값 : List<EmpSearchDTO>
	// 사용 클래스 : EmpController.getEmpList
	@Override
	public List<EmpSearchDTO> getEmpList(EmpSearchDTO empSearchDTO, int currentPage,int empNo) {
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
		return empMapper.selectEmpList(empSearchDTO, beginRow, ROW_PER_PAGE,empNo);
	}

	// 사원번호로 이메일 찾기
	// 파라미터 : int empNo
	// 반환 값 : String
	// 사용 클래스 : EmpController.resendEmail
	@Override
	public String getEmpEmailByEmpNo(int empNo) {
		
		return empMapper.selectEmpEmailByEmpNo(empNo);
	}

	// 사원 상세보기(개인 정보)
	// 파라미터 : int empNo
	// 반환 값 : Map<String, Object>
	// 사용 클래스 : EmpController.getEmpPersnal
	@Override
	public Map<String, Object> getEmpPersnal(int empNo) {
		
		return empMapper.selectEmpPersnal(empNo);
	}

	// 사원 상세보기(인사 정보)
	// 파라미터 : int empNo
	// 반환 값 : Map<String, Object>
	// 사용 클래스 : EmpController.getEmpHr
	@Override
	public Map<String, Object> getEmpHr(int empNo) {
		
		return empMapper.selectEmpHr(empNo);
	}

	// 사원 인사 정보 수정
	// 파라미터 : EmpDTO empDTO
	// 반환 값 : X
	// 사용 클래스 :  EmpController.modifyEmpHr
	@Override
	public void modifyEmpHr(EmpDTO empDTO) {
		int row = empMapper.updateEmpHr(empDTO);
		
		if(row != 1) {
			throw new RuntimeException();
		}
	}

	// 사원 목록 마지막 페이지 구하기
	// 파라미터 : EmpSearchDTO empSearchDTO
	// 반환 값 : int
	// 사용 클래스 : EmpController.searhEmpList
	@Override
	public int getLastPage(EmpSearchDTO empSearchDTO) {
		
		int empCount = empMapper.selectEmpCount(empSearchDTO);
		log.debug(TeamColor.RED + "empCount =>" + empCount);
		
		int lastPage = 0;
		if(empCount % ROW_PER_PAGE == 0) {
			lastPage = empCount / ROW_PER_PAGE;
		} else {
			lastPage = empCount / ROW_PER_PAGE + 1;
		}
		return lastPage;
	}

	// 마이페이지 사원 비밀번호 수정
	// 파라미터 : int empNo, String oldPw, String newPw
	// 반환 값 : X
	// 사용 클래스 : EmpController.modifyEmpPwMyPage
	@Override
	public void modifyEmpPwMyPage(int empNo, String oldPw, String newPw) {
		
		int row = empMapper.updateEmpPwMyPage(empNo, oldPw, newPw);
		
		if(row != 1) {
			throw new RuntimeException();
		}
		
	}

	// 사원 년도별 휴가 개수 구하기
	// 파라미터 : int empNo, String targetYearStr
	// 반환 값 : double
	// 사용 클래스 : DayOffHistoryController.getdayOffHistoryList
	@Override
	public double getDayOff(int empNo, String targetYearStr) {
		
		Map<String, Object> map = empMapper.selectEmpHr(empNo);
		
		if(map == null) {
			throw new RuntimeException();
		}
		
		LocalDate startDate = LocalDate.parse((map.get("startDate")).toString());
		LocalDate targetDate = LocalDate.of(Integer.parseInt(targetYearStr), 1, 1);
		
		//회계년도 시작일
		LocalDate fiscalYearStart = LocalDate.of(targetDate.getYear(), 1, 1);
		
		//회계년도 종료일
		LocalDate fiscalYearEnd = LocalDate.of(targetDate.getYear(), 12, 31);
        
        //입사일의 1년후
        LocalDate oneYearAfterStart = startDate.plusYears(1);
        
        long daysWorkedBeforeTargetYear = ChronoUnit.DAYS.between(startDate, fiscalYearStart);
        long daysInTargetYear = ChronoUnit.DAYS.between(fiscalYearStart, fiscalYearEnd) + 1;

        if (daysWorkedBeforeTargetYear < 365) {
            // 1년 미만 근무자
        	LocalDate leaveStartDate;
        	if (startDate.isBefore(fiscalYearStart)) {
        	    leaveStartDate = fiscalYearStart;
        	} else {
        	    leaveStartDate = startDate;
        	}

        	LocalDate oneYearDate = startDate.plusYears(1);

        	LocalDate leaveEndDate;
        	if (oneYearDate.isBefore(fiscalYearEnd)) {
        	    leaveEndDate = oneYearDate;
        	} else {
        	    leaveEndDate = fiscalYearEnd;
        	}
            
            long monthsWorked = ChronoUnit.MONTHS.between(leaveStartDate, leaveEndDate);
            double dayOffCnt = Math.min(monthsWorked, 11);

            if (oneYearDate.isBefore(fiscalYearEnd)) {
                // 1년 되는 시점이 해당 연도 내에 있는 경우
                long daysAfterOneYear = ChronoUnit.DAYS.between(oneYearDate, fiscalYearEnd) + 1;
                dayOffCnt += 15 * (daysAfterOneYear / (double)daysInTargetYear);
            }

            return Math.round(dayOffCnt * 2.0) / 2.0;
        } else {
            // 1년 이상 근무자
            int yearsWorked = (int) (ChronoUnit.DAYS.between(startDate, fiscalYearStart) / 365);
            int baseDayOff = 15;
            int additionalLeave = Math.min(yearsWorked / 2, 10);
            return Math.round((baseDayOff + additionalLeave) * 2.0) / 2.0;
        }
	}

	// 마이페이지 사원 개인정보 수정
	// 파라미터 : Map map
	// 반환 값 : X
	// 사용 클래스 : EmpController.modifyEmpPersnalMyPage
	@Override
	public void modifyEmpPersnalMyPage(Map map) {
		
		EmpDTO empDTO = EmpDTO.builder()
				.empNo((int)map.get("empNo"))
				.contact((String)map.get("contact"))
				.postNo((String)map.get("postNo"))
				.address(map.get("address") +" | "+ map.get("addressDetail"))
				.empEmail((String) map.get("empEmail"))
				.build();
		
		int row = empMapper.updateEmpPersnalMyPage(empDTO);
		if(row == 0) {
			throw new RuntimeException();
		}
		
	}
	
}
