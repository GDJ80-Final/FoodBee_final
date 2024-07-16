<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인트라넷 사원 등록</title>
<style>
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
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <form method="post" action="${pageContext.request.contextPath}/signup" id="signupForm" enctype="multipart/form-data">
        <div class="form-title">사원 등록</div>
        <div>
            <label for="empNo">사원번호</label>
            <c:choose>
		        <c:when test="${empty empNo}">
		        <!-- 포워딩 시에 signupDTO에서 값 그대로 넣어주기  -->
		            <input type="number" value="${signupDTO.empNo}" name="empNo" id="empNo" readonly>
		        </c:when>
		        <c:otherwise>
		            <input type="number" value="${empNo}" name="empNo" id="empNo" readonly>
        		</c:otherwise>
    		</c:choose>
            <span>${empNoErrorMsg}</span>
        </div>
        <div>
            <label for="empPw">비밀번호</label>
            <input type="password" name="empPw" id="empPw" value="${signupDTO.empPw}">
            <!--포워딩되어서 올 경우 form value에 입력값 담아주기 + model에 담긴 에러메세지 출력  -->
            <div id="empPwError" class="error-message">${empPwErrorMsg}</div>
        </div>
        <div>
            <label for="confirmedEmpPw">비밀번호 확인</label>
            <input type="password" name="confirmedEmpPw" id="confirmedEmpPw">
            <div id="confirmedEmpPwError" class="error-message"></div>
        </div>
        <div>
            <label for="contact">연락처</label>
            <input type="text" name="contact" id="contact" placeholder="000-0000-0000" value="${signupDTO.contact}">
            <div id="contactError" class="error-message">${contactErrorMsg}</div>
        </div>
        <div>
            <label>주소</label>
            <button type="button" id="selectAddr">주소검색</button>
        </div>
        <div>
            <label for="postNo">우편번호</label>
            <input type="number" name="postNo" id="postNo" placeholder="우편번호" readonly value="${signupDTO.postNo}">
            <div id="postNoError" class="error-message">${postNoErrorMsg}</div>
        </div>
        <div>
            <label for="address">주소</label>
            <input type="text" name="address" id="address" placeholder="주소" readonly value="${signupDTO.address}">
            <div id="addressError" class="error-message">${addressErrorMsg}</div>
        </div>
        <div>
            <label for="addressDetail">상세주소</label>
            <input type="text" name="addressDetail" id="addressDetail" placeholder="상세주소를 입력해주세요" value="${signupDTO.addressDetail}">
            <div id="addressDetailError" class="error-message">${addressDetailErrorMsg}</div>
        </div>
        <div>
            <label for="profileImg">프로필 사진</label>
            <input type="file" name="profileImg" id="profileImg" required>
            
        </div>
        <div>
            <button type="submit">등록</button>
        </div>
    </form>
</body>
<script>
       $(document).ready(function() {
    	   
    	   //사원번호 중복 검사 
    	   //model에 담았던 result 값
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

          
           //커서이동시마다 유효성 검사 
           $('#empPw').blur(validateEmpPw);
           $('#confirmedEmpPw').blur(validateConfirmedEmpPw);
           $('#contact').blur(validateContact);
           $('#addressDetail').blur(validateAddrDetail);
           
           //폼 제출 시 모든 필드 유효성 검사 
           $('#signupForm').submit(function(event) {
               validateEmpPw();
               validateConfirmedEmpPw();
               validateContact();
               

               if ($('.error-message').text() !== "") {
                   event.preventDefault();
               }
           });
       });
 </script>
</html>