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
   
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 10px;
        }
        .input-full {
            width: 100%;
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
						            <h3>게시판 글 수정</h3>
						           	<hr>
							        <form id="modifyBoardForm" method="post" action="${pageContext.request.contextPath}/community/board/addBoard">
							            <div class="form-group">
		                                    <div class="form-row align-items-left">
		                                      <input type="hidden" id="boardNo" value="${m.boardNo}">
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
		                                      <input type="text" name="title" id="title" placeholder="제목 입력" value="${m.title}" class="form-control">
		                                      <div id="titleError" class="error"></div>
		                                  </div>
		                                  <div class="form-group">
		                                      <textarea class="form-control h-150px" rows="6" id="content" name="content" placeholder="내용을 입력하세요...">${m.content}</textarea>
		                                      <div id="contentError" class="error"></div>
		                                 </div>
		                                 <div class="text-right m-t-15">
	                                        <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10 send-btn" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 수정</button>
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
        
<%-- <div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	<div class="content-body">
		<div class="container">
	        <h2>익명게시판 수정</h2>
	        <form method="post" action="${pageContext.request.contextPath}/community/board/modifyBoard?boardNo=${m.boardNo}">
	            <table>
	                <tr>
	                    <td>제목:</td>
	                    <td><input type="hidden" id="boardNo" value="${m.boardNo}">
	                    <td><input type="text" name="title" id="title" class="input-full" value="${m.title}">
	                    	<div id="error" class="error"></div>
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
	                    </td>
	                </tr>
	                <tr>
	                    <td colspan="2">
	                        <textarea name="content" >${m.content}</textarea>
	                    </td>
	                </tr>
	                <tr class="button-row">
	                    <td colspan="2">
	                        <button type="submit">수정</button>
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
	let boardNo = $('#boardNo').val();
	$(document).ready(function(){
	    $('#cancelBtn').click(function(){
	        window.location.href = '${pageContext.request.contextPath}/community/board/boardOne?boardNo='+boardNo;
	    });
	    
	   
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

	    
	    // 선택된 카테고리 selected
	    let currentCategory = '${m.boardCategory}';
	    
	    $('#boardCategory option').each(function() {
            if ($(this).val() === currentCategory) {
                $(this).prop('selected', true);
            }
        });
	    
	})
</script>
</body>
</html>