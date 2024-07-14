<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<form method="post" id="findPwForm" action="${pageContext.request.contextPath}/findPw">
		<div>사원번호</div>
		<div>
			<input type="number" id="empNo" name="empNo" required>
			<span id="noMsg" class="msg"></span>
		</div>
		<div>이메일</div>
		<div>
			<input type="email" id="empEmail" name="empEmail" required>
			<span id="emailMsg" class="msg"></span>
		</div>
		<div>
		<span id="formMsg" class="msg"></span>
		</div>
		<div><button type="button" id="authBtn">인증번호 발송</button></div>
	</form>
	<div id="authCheckContainer" >
	
	</div>
	
</body>

<script>
	$(document).ready(function() {
		$('#authBtn').click(function(){
			if($('#empNo').val().length == 0) {
				$('#noMsg').text('사원번호를 입력해주세요');
				$('#empNo').focus();
				return;
			} else {
				$('#noMsg').text('');
			}
			
			if($('#empEmail').val().length == 0) {
				$('#emailMsg').text('이메일을 입력해주세요 ');
				$('#empEmail').focus();
				return;
			} else {
				$('#emailMsg').text('');
			}
			
			$.ajax({
				async : false,
				url : '${pageContext.request.contextPath}/sendEmail',
				method : 'post', 
				data: {
                	empNo: $('#empNo').val(),
                	empEmail: $('#empEmail').val()
                },
				success : function(json) {
					if(json == 'success'){
						$('#formMsg').text('');
						let authCheckForm = '<form method="post" id="authCheckForm" action="${pageContext.request.contextPath}/getPw" >' +
					                        '<div>인증번호</div>' +
					                        '<div>' +
					                        '<input type="number" id="authNum" name="authNum" required>' +
					                        '<span id="authMsg" class="msg"></span>' +
					                        '</div>' +
					                        '<div><button type="button" id="pwBtn">임시 비밀번호 발급</button></div>' +
					                        '</form>';
                        $('#authCheckContainer').html(authCheckForm).show();
                        
                        $('#pwBtn').click(function(){
                			$.ajax({
                				async : false,
                				url : '${pageContext.request.contextPath}/getPw',
                				method : 'post', 
                				data: {
                                	authNum: $('#authNum').val(),
                                	empNo: $('#empNo').val()
                                },
                				success : function(json) {
                					if(json != 'fail'){
                						alert("임시 비밀번호: " + json);
    			                        window.location.href = '${pageContext.request.contextPath}/login';
                						
                					} else {
                						$('#authMsg').text('인증번호가 틀렸습니다.');
                					}
                				}
                				
                			});
                			
                		
                		});
                		
                        
					} else {
						$('#formMsg').text('사원번호 또는 이메일이 잘못되었습니다. ');
					}
				}
				
			});
			
		
		});
			
	});
</script>
</html>	