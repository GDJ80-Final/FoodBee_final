<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.file-container {
    margin-bottom: 10px;
}
</style>
</head>
<body>
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
                            <input type="file" name="files" multiple="multiple"><br>
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
<script>
function addFileInput() {
    var fileContainer = document.getElementById('file-container');
    var newFileInput = document.createElement('input');
    newFileInput.type = 'file';
    newFileInput.name = 'files';
    newFileInput.multiple = 'multiple';
    fileContainer.appendChild(newFileInput);
}
</script>
</body>
</html>