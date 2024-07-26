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
<script>
	$(document).ready(function(){
	    $('#resetButton').click(function(){
	        window.location.href = '${pageContext.request.contextPath}/community/board/boardOne?boardNo='+$('#boardNo');
	    });
	    
	    $('#title').blur(function() {
	        let title = $(this).val();
	        if (title.length > 300) {
	            $('#error').text('제목은 300자를 초과할 수 없습니다.');
	        } else {
	        	$('#error').text('');
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