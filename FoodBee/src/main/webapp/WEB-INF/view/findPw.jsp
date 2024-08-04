<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FindPw</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
     .items-align-center {
         display: flex;
         flex-direction: column;
         align-items: center;
         justify-content: center;
         text-align: center;
         
     }
     html, body {
	    height: 100%;
	    margin: 0;
	}
	
	.login-form-bg {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    min-height: 100vh;
	}
</style>
</head>
<body class="h-100">
    <!--*******************
        Preloader start
    ********************-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************-->

	 <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-2">
                           		<div class="items-align-center mt-5"> 
                              		<h4>비밀번호 찾기</h4>
                            	</div>
	                             <form method="post" id="findPwForm" class="mt-3 mb-5 login-input" action="${pageContext.request.contextPath}/findPw">
									<div class="form-group">
										<input type="number" id="empNo" name="empNo" class="form-control" placeholder="사원번호" required>
										<span id="noMsg" class="msg"></span>
									</div>
									<div class="form-group">
										<input type="email" id="empEmail" name="empEmail" class="form-control" placeholder="이메일" required>
										<span id="emailMsg" class="msg"></span>
									</div>
									<div>  
									<span id="formMsg" class="msg"></span>
									</div>
									<div><button type="button" id="authBtn" class="btn btn-primary">인증번호 발송</button></div>
								</form>
								<div id="authCheckContainer" >
								
								</div>
								<p class="mt-5 login-form__footer"><a href="${pageContext.request.contextPath}/login" class="text-primary">로그인 페이지로 이동</a></p>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

	
	
    <!--**********************************
        Scripts
    ***********************************-->
    <script src="plugins/common/common.min.js"></script>
    <script src="js/custom.min.js"></script>
    <script src="js/settings.js"></script>
    <script src="js/gleek.js"></script>
    <script src="js/styleSwitcher.js"></script>
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
						                        '<div class="form-group">' +
						                        '<input type="number" id="authNum" name="authNum" class="form-control" required>' +
						                        '<span id="authMsg" class="msg"></span>' +
						                        '</div>' +
						                        '<div><button type="button" id="pwBtn" class="btn btn-primary">임시 비밀번호 발급</button></div>' +
						                        '</form>';
	                        $('#authCheckContainer').html(authCheckForm).show();
	                        
	                        $('#pwBtn').click(function(){
	                			$.ajax({
	                				async : false,
	                				url : '${pageContext.request.contextPath}/getPw',
	                				method : 'post', 
	                				data: {
	                                	authNum: $('#authNum').val(),
	                                	empNo: $('#empNo').val(),
	                                	empEmail: $('#empEmail').val()
	                                },
	                				success : function(json) {
	                					if(json === 'success'){
	                						alert('이메일이 발송되었습니다.');
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
</body>
</html>	