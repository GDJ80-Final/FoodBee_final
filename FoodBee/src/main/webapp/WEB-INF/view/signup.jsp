<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>FoodBee:인트라넷 사원 등록</title>

<!-- Custom Stylesheet -->
<link href="css/style.css" rel="stylesheet">

<!-- <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    form {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
    }
    form div {
        margin-bottom: 15px;
    }
    form div label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    form div input[type="text"],
    form div input[type="password"],
    form div input[type="number"],
    form div input[type="file"],
    form div input[type="button"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    form div button[type="submit"] {
        background-color: #28a745;
        color: #fff;
        border: none;
        padding: 10px;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }
    form div button[type="submit"]:hover {
        background-color: #218838;
    }
    .error-message {
        color: red;
        font-size: 0.9em;
        margin-top: 5px;
    }
    .form-title {
        font-size: 1.5em;
        margin-bottom: 20px;
        text-align: center;
    }
</style> -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
                        <div class="card login-form mb-5 mt-5">
                            <div class="card-body pt-2">
                            <!-- 가입폼 시작 -->
                            <div style="text-align:center;">
                              <a class="mb-5" href="${pageContext.request.contextPath}/login">
                            	<img src="${pageContext.request.contextPath}/upload/img/logo.png" width="260" height="200">
                             </a>
                             <h4>인트라넷 사원 등록</h4>
                            </div>
                            <hr>
                            <br>
                                <div class="form-validation">
                             
                                	
                                	<form class="form-valide" method="post" action="${pageContext.request.contextPath}/signup" id="signupForm" enctype="multipart/form-data">
                                        <div class="form-group row">
                                        	    <label class="col-lg-4 col-form-label" for="empNo">사원번호 <span class="text-danger">*</span>
                                        	    </label>
                                        	    <div class="col-lg-6">
										            <c:choose>
												        <c:when test="${empty empNo}">
												        <!-- 포워딩 시에 signupDTO에서 값 그대로 넣어주기  -->
												            <input type="number" class="form-control" value="${signupDTO.empNo}" name="empNo" id="empNo" readonly>
												        </c:when>
												        <c:otherwise>
												            <input type="number"  class="form-control" value="${empNo}" name="empNo" id="empNo" readonly>
										        		</c:otherwise>
										    		</c:choose>
									    		</div>
									            <span>${empNoErrorMsg}</span> 
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="empPw">비밀번호 <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                    	        <input type="password" class="form-control" name="empPw" id="empPw" value="${signupDTO.empPw}">
                                    	         <div id="empPwError" class="error-message">${empPwErrorMsg}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="confirmedEmpPw">비밀번호 확인 <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="password" class="form-control" name="confirmedEmpPw" id="confirmedEmpPw">
                                                <div id="confirmedEmpPwError" class="error-message"></div>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="contact">연락처 <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="text" class="form-control" name="contact" id="contact" placeholder="000-0000-0000" value="${signupDTO.contact}">
                                                <div id="contactError" class="error-message">${contactErrorMsg}</div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group row">
									        <label class="col-lg-4 col-form-label">주소 
									        </label>
									        <div class="col-lg-3">
									        <button type="button" class="btn btn-primary" id="selectAddr">주소검색</button>
        									</div>
                                        </div>
                                        <div class="form-group row">

									        <label class="col-lg-4 col-form-label" for="postNo">우편번호 <span class="text-danger">*</span>
									        </label>
									        <div class="col-lg-6">
									           <input type="number" class="form-control" name="postNo" id="postNo" placeholder="우편번호" readonly value="${signupDTO.postNo}">
									           <div id="postNoError" class="error-message">${postNoErrorMsg}</div>
									        </div>
        									
                                        </div>

                                        <div class="form-group row">
                                               
								            <label class="col-lg-4 col-form-label" for="address">주소 <span class="text-danger">*</span>
								            </label>
								            <div class="col-lg-6">
								            <input type="text" name="address" id="address" class="form-control" placeholder="주소" readonly value="${signupDTO.address}">
								            <div id="addressError" class="error-message">${addressErrorMsg}</div>
											</div>

                                        </div>
                                        
                                        <div class="form-group row">
								            <label class="col-lg-4 col-form-label" for="addressDetail">상세주소 <span class="text-danger">*</span>
								            </label>
								            <div class="col-lg-8">
								            	<input type="text" name="addressDetail" class="form-control" id="addressDetail" placeholder="상세주소를 입력해주세요" value="${signupDTO.addressDetail}">
								            <div id="addressDetailError" class="error-message">${addressDetailErrorMsg}</div>
       										</div>
                                        </div>
                                        <div class="form-group row">
								            <label class="col-lg-4 col-form-label" for="profileImg">프로필 사진 <span class="text-danger">*</span>
								            </label>
								            <div class="col-lg-8">
								            	<input type="file" name="profileImg" id="profileImg" class="form-control" required>
       										</div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-lg-8 ml-auto">
                                            	<button type="submit" class="btn btn-primary float-right">등록</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #/ container -->
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
    	   
    	   //사원번호 중복 검사 
    	   // model에 담았던 result 값
    	   //1 => 가입불가, 바로 로그인으로 이동
    	   //0 => 가입 가능 
    	   let result = '<%=request.getAttribute("result")%>';
           
           if (result == 1) {
               // 접근 불가한 경우 
        	   alert("잘못 된 접근입니다.이미 가입된 사번이거나 정상등록 되지 않은 사번입니다.");
               window.location.href = '${pageContext.request.contextPath}/login'; // 로그인 페이지 URL로 변경
           } 
   
    	   //주소검색 버튼 클릭 시 다음주소api 팝업 호출
           $('#selectAddr').click(function() {
               new daum.Postcode({
                   oncomplete: function(data) {
                       // 각 주소의 노출 규칙에 따라 주소를 조합
                       
                       let addr; // 주소 변수
                       // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴 
                       if (data.userSelectedType === 'R') { 
                    	   // 사용자가 도로명 주소를 선택했을 경우
                           addr = data.roadAddress;
                       } else { // 사용자가 지번 주소를 선택했을 경우(J)
                           addr = data.jibunAddress;
                       }

                       // 우편번호와 주소 정보를 해당 필드에 넣는다.
                       $('#postNo').val(data.zonecode);
                       $('#address').val(addr);
                       // 커서를 상세주소 필드로 이동한다.
                       $('#addressDetail').focus();
                   }
               }).open();
           });
    	   //비밀번호 공백검사 
           function validateEmpPw() {
               const empPw = $('#empPw').val().trim();
               //비번 정규식 - 대소문자, 특수문자 포함 8-16자 
               const passwordPattern = 
            	   /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
               //.trim() 입력값 양쪽 공백 제거 
               if (empPw === "") {
                   $('#empPwError').text("비밀번호를 입력해주세요.");
               } else if (!passwordPattern.test(empPw)) {
                   $('#empPwError').text("비밀번호는 8자 이상 16자 이하의 대소문자, 숫자 및 특수문자를 포함해야 합니다.");
               }else{
            	   $('#empPwError').text("");
               }
           }

           function validateConfirmedEmpPw() {
               const empPw = $('#empPw').val().trim();
               const confirmedEmpPw = $('#confirmedEmpPw').val().trim();
               if (confirmedEmpPw === "") {
                   $('#confirmedEmpPwError').text("비밀번호 확인을 입력해주세요.");
               } else if (empPw !== confirmedEmpPw) {
                   $('#confirmedEmpPwError').text("비밀번호가 일치하지 않습니다.");
               } else {
                   $('#confirmedEmpPwError').text("");
               }
           }
           function validateContact() {
               const contact = $('#contact').val().trim();
               //전화번호 정규식 확인 
               const contactPattern = /^\d{3}-\d{4}-\d{4}$/;
               if (contact === "") {
                   $('#contactError').text("연락처를 입력해주세요.");
               } else if (!contactPattern.test(contact)) {
                   $('#contactError').text("연락처 형식이 올바르지 않습니다.");
               } else {
                   $('#contactError').text("");
               }
           }
           function validateAddrDetail() {
               const addressDetail = $('#addressDetail').val().trim();
               
               if (addressDetail === "") {
                   $('#addressDetailError').text("상세주소를 입력해주세요.");
               } else {
                   $('#addressDetailError').text("");
               }
           }
           function validateAddr(){
        	   
        	   const address = $('#address').val().trim();
        	   if(address === ""){
        		   $('#addressError').text("주소를 확인해주세요.")
        	   }else{
        		   $('#addressError').text("");
        	   }
           }
           

          
           // 커서이동시마다 유효성 검사 
           $('#empPw').blur(validateEmpPw);
           $('#confirmedEmpPw').blur(validateConfirmedEmpPw);
           $('#contact').blur(validateContact);
           $('#addressDetail').blur(validateAddrDetail);
           $('#address').blur(validateAddr);
           
           
           // 폼 제출 시 모든 필드 유효성 검사 
           $('#signupForm').submit(function(e) {
        	   
               $('#empPw').blur(validateEmpPw);
               $('#confirmedEmpPw').blur(validateConfirmedEmpPw);
               $('#contact').blur(validateContact);
               $('#addressDetail').blur(validateAddrDetail);
               $('#address').blur(validateAddr);
              
               
               if ($('.error-message').text() !== "") {
                   e.preventDefault();
                   alert('모든 항목을 입력해주세요.')
               }else{
            	   $('#signupForm').submit();
               }
           });
       });
 </script>
 </body>
</html>