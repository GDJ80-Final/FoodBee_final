<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>익명게시판 새 글 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
        .error{
        	margin-top:5px;
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
	  		
	  		<div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">커뮤니티</a></li>
                        <li class="breadcrumb-item"><a href="javascript:void(0)">익명게시판</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">글 작성</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->
            
            <div class="container-fluid">
               <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <!-- 내용 시작 -->
                                <div class="basic-form">
						            <h3>게시판 글 작성</h3>
						           	<hr>
							        <form method="post" action="${pageContext.request.contextPath}/community/board/addBoard">
							            <div class="form-group">
		                                    <div class="form-row align-items-left">
		                                      
		                                      <div class="col-auto my-1">
							               		  <select name="boardCategory" id="boardCategory" class="custom-select mr-sm-2">
								                       <option value="잡담">잡담</option>
								                       <option value="회사이야기">회사이야기</option>
								                       <option value="질문">질문</option>
								                  </select>
							                  </div>
							                  <div id="categoryError" class="error"></div>
							                </div>
		                                  </div>
							              <div class="form-group">
							              	
		                                      <input type="text" name="title" id="title" placeholder="제목 입력" class="form-control">
		                                      <div id="titleError" class="error"></div>
		                                    
		                                  </div>
		                               
		                                 <div class="form-group">
		                                      
		                                      <input type="password" id="boardPw" name="boardPw" placeholder="비밀번호 입력" class="form-control" required>
		                                      <div id="passwordError" class="error"></div>
		                                 </div>
		                                 <div class="form-group">
		                                      
		                                      <textarea class="form-control h-150px" rows="6" id="content" name="content" placeholder="내용을 입력하세요..."></textarea>
		                                      <div id="contentError" class="error"></div>
		                                 </div>
		                                 <div class="text-right m-t-15">
	                                        <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10 send-btn" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 작성</button>
	                                        <button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 cancel-btn" type="button" id="cancelBtn"><i class="ti-close m-r-5 f-s-12"></i> 취소</button>
	                                     </div>
		                                  
							           
							        </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>
	 	 	
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
 	<!-- end -->
 	
         
        <!--**********************************
            Content body end
        ***********************************-->
        
 	






<%-- 





<!-- 템플릿 적용 전 -->
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
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include> --%>
<script>
	$(document).ready(function(){
	    $('#cancelBtn').click(function(){
	    	$('.error').text('');
	        window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
	    });
	    // 비밀번호 유효성 검사 함수
	    function validatePassword(password) {
	        // 비밀번호 정규식: 대소문자, 숫자, 특수문자를 포함하여 8-16자
	        const passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
	        return passwordRegex.test(password);
	    }
	    
	    
	   
	    // 제목 공백검사 
	    $('#title').blur(function() {
	        let title = $(this).val().trim();
	        if (title.length > 300) {
	            $('#error').text('제목은 300자를 초과할 수 없습니다.');
	        } else {
	        	$('#error').text('');
	        }
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