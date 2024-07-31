<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>익명게시판 새 글 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 10px;
        }
        .input-full {
            width: 80%;
            padding: 8px;
            box-sizing: border-box;
        }
        textarea {
            width: 100%;
            height: 300px;
            padding: 8px;
            box-sizing: border-box;
        }
        .button-row {
            text-align: center;
            margin-top: 20px;
        }
        .button-row button {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            background-color: #333;
            color: #fff;
            cursor: pointer;
        }
        .button-row button:hover {
            background-color: #555;
        }
        
        .error{
        	color:red;
        }
</style>
</head>
<body>
<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	  <div class="content-body">
		<div class="container">
	        <h2>익명게시판 작성</h2>
	        <form method="post" action="${pageContext.request.contextPath}/community/board/addBoard">
	            <table>
	                <tr>
	                    <td>제목:</td>
	                    <td><input type="text" name="title" id="title" class="input-full">
	                    	<div id="titleError" class="error"></div>
	                    </td>
	                </tr>
	                <tr>
	                    <td>카테고리:</td>
	                    <td>
	                        <select name="boardCategory" id="boardCategory" class="input-full">
	                            <option value="잡담">잡담</option>
	                            <option value="회사이야기">회사이야기</option>
	                            <option value="질문">질문</option>
	                        </select>
	                        <div id="categoryError" class="error"></div>
	                    </td>
	                </tr>
	                <tr>
	                    <td>비밀번호:</td>
	                    <td><input type="password" id="boardPw" name="boardPw" class="input-full" required>
	                    <div id="passwordError" class="error"></div>
	                    </td>
	                </tr>
	                <tr>
	                    <td colspan="2">
	                        <textarea id="content" name="content" placeholder="내용을 입력하세요..."></textarea>
	                        <div id="contentError" class="error"></div>
	                    </td>
	                </tr>
	                <tr class="button-row">
	                    <td colspan="2">
	                        <button type="submit" id="submitBtn">작성</button>
	                        <button type="reset" id="resetButton">취소</button>
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>
</div>
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
	$(document).ready(function(){
	    $('#resetButton').click(function(){
	    	$('.error').text('');
	        window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
	    });
	    // 비밀번호 유효성 검사 함수
	    function validatePassword(password) {
	        // 비밀번호 정규식: 대소문자, 숫자, 특수문자를 포함하여 8-16자
	        const passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
	        return passwordRegex.test(password);
	    }
	    
	    $('#title').blur(function() {
	        let title = $(this).val();
	        if (title.length > 300) {
	            $('#error').text('제목은 300자를 초과할 수 없습니다.');
	        } else {
	        	$('#error').text('');
	        }
	    });
	    // 제목 공백검사 
	    $('#title').blur(function() {
	        let title = $(this).val().trim();
	        if (title === '') {
	            $('#titleError').text('제목을 입력해 주세요.');
	        } else {
	            $('#titleError').text('');
	        }
	    });

	    // 카테고리 공백검사
	    $('#boardCategory').blur(function() {
	        let boardCategory = $(this).val().trim();
	        if (boardCategory === '') {
	            $('#categoryError').text('카테고리를 선택해 주세요.');
	        } else {
	            $('#categoryError').text('');
	        }
	    });

	    // 비밀번호 유효성검사
	    $('#boardPw').blur(function() {
	        let boardPw = $(this).val().trim();
	        if (!validatePassword(boardPw)) {
	            $('#passwordError').text('비밀번호는 대소문자, 숫자, 특수문자를 포함하여 8-16자 사이여야 합니다.');
	        } else {
	            $('#passwordError').text('');
	        }
	    });

	    // 내용 필드 공백검사
	    $('#content').blur(function() {
	        let content = $(this).val().trim();
	        if (content === '') {
	            $('#contentError').text('내용을 입력해 주세요.');
	        } else {
	            $('#contentError').text('');
	        }
	    });

	    // 제출 버튼 클릭 시 전체 유효성 검사
	    $('#submitBtn').click(function(e) {
	        // 기본 폼 제출 방지
	        e.preventDefault();

	        // 모든 입력 필드 블러 이벤트 트리거
	        $('#title').blur();
	        $('#boardCategory').blur();
	        $('#boardPw').blur();
	        $('#content').blur();

	        // 유효성 검사 확인
	        if ($('.error:contains("입력해 주세요"), .error:contains("선택해 주세요"), .error:contains("비밀번호는 대소문자, 숫자, 특수문자를 포함하여 8-16자 사이여야 합니다.")').length === 0) {
	            $('#addBoardForm').submit();
	        }
	    });

	})
</script>
</body>
</html>