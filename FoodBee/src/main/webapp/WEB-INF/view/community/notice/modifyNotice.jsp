<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<style>
	.add-file-button {
		margin-top: 10px;
		padding: 10px 20px;
		border: none;
		border-radius: 5px;
		background-color: #333;
		color: #fff;
		cursor: pointer;
	}
	.add-file-button:hover {
		background-color: #555;
	}
	#btnSubmit {
		width:100px;
	}
</style>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
    <h1>공지사항 수정</h1>

    <form action="modifyNoticeAction" method="post" enctype="multipart/form-data">
       <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
        <table>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${one[0].title}" class="form-control bg-transparent flex-grow-1 me-2"></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><input type="text" name="empName" value="${one[0].empName}" class="form-control bg-transparent flex-grow-1 me-2" readonly></td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td>
                    <select name="type">
                        <c:choose>
                            <c:when test="${one[0].type == '전사원'}">
                                <option value="전사원" selected>전사원</option>
                                <option value="부서">부서</option>
                            </c:when>
                            <c:when test="${one[0].type == '부서'}">
                                <option value="전사원">전사원</option>
                                <option value="부서" selected>부서</option>
                            </c:when>
                            <c:otherwise>
                                <option value="전사원">전사원</option>
                                <option value="부서">부서</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea rows="7" cols="50" name="content" class="textarea_editor form-control bg-light">${one[0].content}</textarea></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    삭제
                    <br>
                    <div id="Xfile">                	
                        <c:forEach items="${one}" var="file">
                            <input type="hidden" value="${one[0].noticeNo}"> 
                           	<span>
                           		${file.originalFile}
                           	</span>
                            <c:if test="${file.originalFile != null}">
                            	<button class="deleteFile" data-file="${file.saveFile}">X</button>
                            </c:if>
                            <br>
                        </c:forEach>
                    </div>
                    <input type="hidden" id="deleteFiles" name="deleteFiles">
                    <br>
			          <h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5>
			          <button type="button" class="add-file-button mb-3" id="addFileButton">+ 파일 추가</button>	               
                    <div class="form-group" id="fileInputsContainer">
					     <div class="file-input-group" id="fileGroup1">
					          <input type="file" name="files" multiple="multiple">
					     </div>   
                   </div>
                </td>
            </tr>
        </table>
        <button type="submit" class="btn btn-primary btn-block" id="btnSubmit">수정</button>
    </form>
    <a href="noticeOne?noticeNo=${one[0].noticeNo}">돌아가기</a>
</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>    
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
     $(document).ready(function() {
    	 let deleteFiles = []; //삭제된 파일을 담아서 저장

    	// 파일 삭제 버튼 클릭 시
         $(".deleteFile").click(function(e) {
             e.preventDefault();
             let filename = $(this).data("file");
             deleteFiles.push(filename);
             $(this).parent().remove(); // 해당 파일만 제거
             $("#deleteFiles").val(deleteFiles.join(",")); // 삭제된 파일 정보 업데이트
         });
     });
     
    let fileOrder = 1;
 	// 파일 추가 버튼 클릭 시
    $('#addFileButton').click(function() {
        fileOrder++;
        let newFileInput = 
            '<div class="file-input-group d-flex align-items-center mt-3" id="fileGroup${fileOrder}">'+
            '<input type="file" id="attachment-${fileOrder}" name="files">'+
             '<button type="button" class="btn btn-danger remove-file-button mt-2 ms-3" data-file-id="fileGroup${fileOrder}">삭제</button>'+
            '</div>';
        $('#fileInputsContainer').append(newFileInput);
    });

    // 파일 입력 필드 삭제 버튼 클릭 시
    $(document).on('click', '.remove-file-button', function() {
    	console.log('test');
    	let fileGroupId = $(this).data('file-id');
        $('#' + fileGroupId).remove();
    }); 
</script>
</body>
</html>