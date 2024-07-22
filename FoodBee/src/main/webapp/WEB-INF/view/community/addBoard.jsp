<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
</head>
<body>
	<div class="container">
        <h2>익명게시판 작성</h2>
        <form method="post" action="${pageContext.request.contextPath}/community/addBoard">
            <table>
                <tr>
                    <td>제목:</td>
                    <td><input type="text" name="title" class="input-full"></td>
                </tr>
                <tr>
                    <td>카테고리:</td>
                    <td>
                        <select name="boardCategory" class="input-full">
                            <option value="잡담">잡담</option>
                            <option value="회사이야기">회사이야기</option>
                            <option value="질문">질문</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호:</td>
                    <td><input type="password" name="boardPw" class="input-full" required></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea name="content" placeholder="내용을 입력하세요..."></textarea>
                    </td>
                </tr>
                <tr class="button-row">
                    <td colspan="2">
                        <button type="submit">작성</button>
                        <button type="reset">취소</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>