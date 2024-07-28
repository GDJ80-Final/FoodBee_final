<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 900px;
           
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
        }
        .tabs {
            display: flex;
            background-color: #f1f1f1;
            margin:10px;
           
            
        }
        .tabs div {
            padding: 10px 20px;
            cursor: pointer;
            flex: 1;
            text-align: center;
            color : black;
        }
        .tabs div.active {
            background-color: #fff;
            border-bottom: 2px solid #000;
        }
        .form-actions {
            display: flex;
            justify-content: center;
            margin: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin: 0 10px;
        }
        .form-actions .cancel-btn {
            background-color: #444;
            color: #fff;
        }
        .form-actions .submit-btn {
            background-color: #e74c3c;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container">
	    <div class="tabs">
	        <div class="active">기본기안서</div>
	        <div>매출보고</div>
	        <div>지출결의</div>
	        <div>출장신청</div>
	        <div>휴가신청</div>
	    </div>
	    <form>
	        <!-- 공통 영역 포함 -->
	        <jsp:include page="./forms/commonForm.jsp"></jsp:include>
	        <!-- 공통 영역 끝 -->
	        
	        <!-- 양식 영역 시작 -->
	        <jsp:include page="./forms/basicForm.jsp"></jsp:include>
	        <!-- 양식 영역 끝 -->
	        <div class="form-actions">
	            <button class="cancel-btn">취소</button>
	            <button class="submit-btn">제출</button>
	        </div>
		</form>
    </div>
</body>
</html>