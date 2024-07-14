<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<form method="post" id="signinForm" action="${pageContext.request.contextPath}/login">
		<div>사원번호</div>
		<div>
			<input type="number" id="empNo" name="empNo" value="<%= request.getAttribute("empNo") %>" required>
			<span id="noMsg" class="nomsg"></span>
		</div>
		<div>비밀번호</div>
		<div>
			<input type="password" id="empPw" name="empPw" required>
			<span id="pwMsg" class="msg"></span>
		</div>
		<input type="checkbox" name="saveId" value="O"> 아이디 저장
		<div><a href="/foodbee/findPw">비밀번호 찾기</a></div>
		<div><button type="button" id="btn">Login</button></div>
	</form>
</body>
<script>
	$(document).ready(function() {
		$('#btn').click(function(){
			if($('#empNo').val().length == 0) {
				$('#noMsg').text('사원번호를 입력해주세요');
				$('#empNo').focus();
				return;
			} else {
				$('#empNoMsg').text('');
			}
			
			if($('#empPw').val().length == 0) {
				$('#pwMsg').text('비밀번호를 입력해주세요 ');
				$('#empPw').focus();
				return;
			} else {
				$('#pwMsg').text('');
			}
			
			$('#signinForm').submit();
		});	
	});
</script>
</html>