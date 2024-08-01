<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#main-wrapper .content-body{
			margin-left: 270px;
			margin-top:20px;
		}
	.file-container {
	    margin-bottom: 10px;
	}
	.file-input-wrapper {
	    display: flex;
	    align-items: center;
	    margin-bottom: 5px;
	}
	.file-input-wrapper input[type="file"] {
	    margin-right: 10px;
	}
	#addFile{
		margin-bottom: 5px;
	}
	td{
		padding: 8px;
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
<h1>공지사항 작성</h1>
    <div id="notice">
        <form method="post" action="addNoticeAction" enctype="multipart/form-data" onsubmit="return validateForm()">
            <table>
                <tr>
                    <th>작성자</th>
                    <td>
                        <input type="text" name="writerEmpName" value="${empName}">
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="title" id="title">
                    </td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td>
                        <select name="type">
                            <option value="전사원">전사원</option>
                            <option value="부서">부서</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                     <td>
                        <div id="file-container">
                            <div class="file-input-wrapper">
                                <input type="file" name="files" multiple="multiple">
                                <button type="button" onclick="removeFileInput(this)" class="btn btn-outline-secondary btn-sm">제거</button>
                                <!-- this는 file-container 전체 -->
                            </div>
                        </div>
                        <button type="button" onclick="addFileInput()" class="btn btn-secondary btn-sm" id="addFile">파일 추가</button>
                    </td>
                </tr>
                 <tr>
                    <th>내용</th>
                    <td>
                    	<textarea rows="8" cols="50" name="content" placeholder="공지사항을 작성해주세요" id="content"></textarea>
                    </td>
                </tr>
            </table>
     		<input type="hidden" name="dptNo" value="${dptNo}">
     		<input type="hidden" name="writerEmpNo" value="${empNo}">
            <button type="submit" class="btn btn-secondary btn-sm">공지사항 등록</button>
        </form>
    </div>
 </div>
 </div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
	function addFileInput() {
	    var fileContainer = document.getElementById('file-container');
	    var fileInputWrapper = document.createElement('div');
	    fileInputWrapper.className = 'file-input-wrapper';
	
	    var newFileInput = document.createElement('input');
	    newFileInput.type = 'file';
	    newFileInput.name = 'files';
	    newFileInput.multiple = 'multiple';
	
	    var removeButton = document.createElement('button');
	    removeButton.type = 'button';
	    removeButton.innerText = '제거';
	    removeButton.onclick = function() {
	        removeFileInput(removeButton);
	    };
	
	    fileInputWrapper.appendChild(newFileInput);
	    fileInputWrapper.appendChild(removeButton);
	    fileContainer.appendChild(fileInputWrapper);
	}
	//선택 파일 제거 
	function removeFileInput(button) {
	    var fileInputWrapper = button.parentNode;
	    fileInputWrapper.parentNode.removeChild(fileInputWrapper);
	}
	// 제목, 내용이 공백이 되지 않도록 공백검사!
	function validateForm() {
	    var title = document.getElementById('title').value.trim();
	    var content = document.getElementById('content').value.trim();

	    if (title === "") {
	        alert("제목을 입력하지 않았습니다.");
	        return false;
	    }

	    if (content === "") {
	        alert("내용을 입력하지 않았습니다.");
	        return false;
	    }

	    return true;
	}
</script>
</body>
</html>