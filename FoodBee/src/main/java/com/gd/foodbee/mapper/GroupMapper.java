package com.gd.foodbee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.foodbee.dto.GroupDTO;

@Mapper
public interface GroupMapper {
	
	// 본사/지사 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 클래스 : GroupService.getOfficeList
	List<GroupDTO> selectOfficeList();
	
	// 본사/지사에 포함된 부서 리스트
	// 파라미터 : String dptNo
	// 반환 값 : List<GroupDTO>
	// 사용 클래스 : GroupService.getDeptListByOffice
	List<GroupDTO> selectDeptListByOffice(String dptNo);
	
	// 부서에 포함된 팀 리스트
	// 파라미터 : String dptNo
	// 반환 값 : List<GroupDTO>
	// 사용 클래스 : GroupService.getTeamListByDept
	List<GroupDTO> selectTeamListByDept(String dptNo);
	
	// 부서 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 클래스 : GroupService.getDeptList
	List<GroupDTO> selectDeptList();
	
	// 팀 리스트
	// 파라미터 : X
	// 반환 값 : List<GroupDTO>
	// 사용 클래스 : GroupService.getTeamList
	List<GroupDTO> selectTeamList();
	
	// 부서번호로 부서명 구하기
	// 파라미터 : String dptNo
	// 반환 값 : String 
	// 사용 클래스 : GroupService.getDptName
	String selectDptName(String dptNo);
	
	// 부서번호로 권한 코드 구하기
	// 파라미터 : String dptNo
	// 반환 값 : String
	// 사용 클래스 : 
	String selectAuthorityCodeByDptNo(String dptNo);

}
