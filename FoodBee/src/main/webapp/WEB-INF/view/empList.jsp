<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>사원목록</h1>
	
	<form>
		<div>
			본사/지사
			<select id="office">
				<option value="">---본사/지사 선택---</option>
			</select>
			부서
			<select id="dept">
				<option value="">---부서 선택---</option>
			</select>
			팀
			<select id="team">
				<option value="">---팀 선택---</option>
			</select>
			직급 
			<select id="rankName" name="rankName">
				<option value="">---직급 선택---
				<option value="사원">사원
				<option value="대리">대리
				<option value="팀장">팀장
				<option value="부서장">부서장
				<option value="지서장">지사장
				<option value="CEO">CEO
			</select>
			회원가입 
			<select id="signupYN" name="signupYN">
				<option value="">---회원가입 유무---
				<option value="Y">Y
				<option value="N">N
			</select>
		</div>
		<div>
			사원 번호
			<input type="number" id="empNo" name="empNo">
			
			<button id="searchBtn" type="button">검색</button>
		</div>
	</form>
	
	<table border="1" id="empList">
		<tr>
			<th>본사/지사</th>
			<th>부서</th>
			<th>팀</th>
			<th>직급</th>
			<th>사원번호</th>
			<th>사원명</th>
			<th>내선번호</th>
			<th>가입일</th>
			<th>회원가입 유무</th>
		</tr>
	</table>
	
	<script>
		$(document).ready(function() {
			$.ajax({
				url:'${pageContext.request.contextPath}/officeList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#office').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			
			$.ajax({
				url:'${pageContext.request.contextPath}/deptList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#dept').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			
			$.ajax({
				url:'${pageContext.request.contextPath}/teamList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#team').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			
			$.ajax({
				url:'${pageContext.request.contextPath}/searchEmp',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						
						$('#empList').append('<tr>' +
							'<td>' + item.officeName +'</td>' + 
							'<td>' + item.deptName +'</td>' + 
							'<td>' + item.teamName +'</td>' + 
							'<td>' + item.rankName +'</td>' + 
							'<td>' + item.empNo +'</td>' + 
							'<td>' + item.empName +'</td>' + 
							'<td>' + item.extNo +'</td>' + 
							'<td>' + item.startDate +'</td>' + 
							'<td>' + item.signupYN +
							(item.signupYN == 'N' ? '<button type="button" class="sendEmail" value= "'+ item.empNo +'">이메일 재발송</button>' : '') +
							'</td>' + 
							'<td><button type="button" class="resetPw" value="' + item.empNo + '">비밀번호 초기화</button></td>' +
							'</tr>');
					});
				}
			});
			
			$('#searchBtn').click(function(){
				$.ajax({
					url:'${pageContext.request.contextPath}/searchEmp',
					method:'get',
					data:{
						officeName: $('#office').val(),
						deptName: $('#dept').val(),
						teamName: $('#team').val(),
						rankName: $('#rankName').val(),
						signupYN: $('#signupYN').val(),
						empNo: $('#empNo').val()
					},
					success:function(json){
						console.log(json);
						$('#empList').empty();
						$('#empList').append('<tr>' +
								'<th>본사/지사</th>' +
								'<th>부서</th>' +
								'<th>팀</th>' +
								'<th>직급</th>' +
								'<th>사원번호</th>' +
								'<th>사원명</th>' +
								'<th>내선번호</th>' +
								'<th>가입일</th>' +
								'<th>회원가입 유무</th>' +
								'</tr>');
						json.forEach(function(item){
							console.log(item);
							
							$('#empList').append('<tr>' +
								'<td>' + item.officeName +'</td>' + 
								'<td>' + item.deptName +'</td>' + 
								'<td>' + item.teamName +'</td>' + 
								'<td>' + item.rankName +'</td>' + 
								'<td>' + item.empNo +'</td>' + 
								'<td>' + item.empName +'</td>' + 
								'<td>' + item.extNo +'</td>' + 
								'<td>' + item.startDate +'</td>' + 
								'<td>' + item.signupYN +
								(item.signupYN == 'N' ? '<button type="button" class="sendEmail" value= "'+ item.empNo +'">이메일 재발송</button>' : '') +
								'</td>' + 
								'<td><button type="button" class="resetPw" value="' + item.empNo + '">비밀번호 초기화</button></td>' +
								'</tr>');
							
						});
					}
				});
			});
			
			$('#empList').on('click', '.resetPw', function(){
			    let empNo = $(this).val();
			    console.log(empNo);
			    $.ajax({
			        url: '${pageContext.request.contextPath}/resetPw',
			        method: 'post',
			        data: { empNo: empNo },
			        success: function(json){
			            alert('비밀번호가 초기화되었습니다. 임시 비밀번호는 ' + json + '입니다');
			        }
			    });
			});
			
			$('#empList').on('click', '.sendEmail', function(){
			    let empNo = $(this).val();
			    console.log(empNo);
			    $.ajax({
			        url: '${pageContext.request.contextPath}/resendEmail',
			        method: 'post',
			        data: { empNo: empNo },
			        success: function(json){
			            alert('회원가입 링크가 발송되었습니다. 이메일 : ' + json);
			        }
			    });
			});
		});
	</script>
</body>
</html>