<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-100" lang="en">
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Login</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"> -->
<link href="css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                            <div class="card-body pt-5">
                                <a class="text-center" href="#"> <h4>FOODBEE<br><br>사원 로그인 </h4></a>
        
                                <form class="mt-5 mb-5 login-input" method="post" id="signinForm" action="${pageContext.request.contextPath}/login">
                                    <div class="form-group">
                                        <input type="number" id="empNo" name="empNo" class="form-control" placeholder="사원번호" value="<%= request.getAttribute("empNo") %>" required>
                                        <span id="noMsg" class="nomsg"></span>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" id="empPw" name="empPw" class="form-control" placeholder="비밀번호" required>
                                        <span id="pwMsg" class="msg"></span>
                                    </div>
                                    <input type="checkbox" name="saveId" value="O"> &nbsp;&nbsp;아이디 저장
                                    <br><br>
                                    <button class="btn login-form__btn submit w-100" id="btn">Sign In</button>
                                </form>
                                <p class="mt-5 login-form__footer"><a href="/foodbee/findPw" class="text-primary">비밀번호 찾기</a></p>
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
</body>
<script>
		$(document).ready(function() {
			$('#btn').click(function(){
				if($('#empNo').val().length == 0) {
					$('#noMsg').text('사원번호를 입력해주세요');
					$('#empNo').focus();
					return;
				} else {
					$('#noMsg').text('');
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