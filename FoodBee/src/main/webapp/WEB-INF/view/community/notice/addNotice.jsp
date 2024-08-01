<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
</style>
</head>
<body>
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
<h1>공지사항 작성</h1>
    <div id="notice">
        <form method="post" action="addNoticeAction" enctype="multipart/form-data">
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
                        <input type="text" name="title">
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
                                <button type="button" onclick="removeFileInput(this)">제거</button>
                                <!-- this는 file-container 전체 -->
                            </div>
                        </div>
                        <button type="button" onclick="addFileInput()">파일 추가</button>
                    </td>
                </tr>
                 <tr>
                    <th>내용</th>
                    <td>
                    	<textarea rows="8" cols="50" name="content"></textarea>
                    </td>
                </tr>
            </table>
     		<input type="hidden" name="dptNo" value="${dptNo}">
     		<input type="hidden" name="writerEmpNo" value="${empNo}">
            <button type="submit">공지사항 등록</button>
        </form>
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
	
	function removeFileInput(button) {
	    var fileInputWrapper = button.parentNode;
	    fileInputWrapper.parentNode.removeChild(fileInputWrapper);
	}
</script>
</body>
</html>