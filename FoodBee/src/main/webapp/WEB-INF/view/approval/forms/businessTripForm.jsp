<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    	 body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
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

        .form-section {
            padding: 20px;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            width: 80px;
            
        }
        .form-group input, .form-group textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .form-group input:first-child {
            margin-right: 10px;
        }
        .form-group textarea {
            height: 100px;
            resize: none;
        }
        .file-upload {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .file-upload label {
            width: 80px;
            margin-right: 10px;
        }
        .file-upload input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .file-upload button {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 8px 10px;
            cursor: pointer;
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
        a {
        	text-decoration-line: none;
        
        }
        .common-section table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .common-section th, .common-section td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            height : 60px;
        }
        .common-section .search-btn {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .form-section {
            padding: 20px;
        }
         .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            width: 80px;
            margin-right: 10px;
        }
        .form-group input[type="text"], .form-group textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .form-group input[type="text"]:first-child {
            margin-right: 20px;
        }
        .form-group textarea {
            height: 100px;
            resize: none;
        }
        .sign td {
       		height : 130px;
        
        }
</style>
</head>
<body>

	<div class="container">
	    <div class="tabs" id="tabs">
		        <div class="tab" id="basicForm" data-form="basicForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/basicForm">
		        기본기안서
		        </a></div>
		        <div class="tab" id="revenueForm" data-form="revenueForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/revenueForm">
		        매출보고
		        </a></div>
		        <div class="tab" id="chargeForm" data-form="chargeForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/chargeForm">
		        지출결의
		        </a></div>
		        <div class="tab" id="businessTripForm" data-form="businessTripForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/businessTripForm">
		        출장신청
		        </a></div>
		        <div class="tab" id="dayOffForm" data-form="dayOffForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/dayOffForm">
		        휴가신청
		        </a></div>
		    </div>
	    <form method="post" action="${pageContext.request.contextPath}/approval/addDraft" enctype="multipart/form-data">
	        <!-- 공통 영역 포함 -->
	        <jsp:include page="./commonForm.jsp"></jsp:include>
	        <!-- 공통 영역 끝 -->
	        
	        <!-- 양식 영역 시작 -->
			<div class="form-section">        
	        	<div class="form-group">
	        		<input type="hidden" name="tmpNo" value="3">
	                <label for=place>출장지:</label>
	                <input type="text" id="place" name="typeName">
	                
	                <label for="period" style="margin-left: 200px;">기간:</label>
	                <input type="date" id="period" name="startDate"> ~
	                <input type="date" id="period" name="endDate">
	            </div>
	            <div class="form-group">
	                <label for=emergency>비상연락:</label>
	                <input type="text" id="emergency" name="text">
	            </div>
	            <div class="form-group">
	                <label for="title">제목:</label>
	                <input type="text" id="title" name="title">
	            </div>
	            <div class="form-group">
	                <label for="content">내용:</label>
	                <textarea id="content" name="content" placeholder="출장 목적을 작성하세요."></textarea>
	            </div>            
	            <div class="file-upload">
	                <label for="docFiles">첨부파일:</label>
	                <input type="file" id="docFiles" name="docFiles" multiple>
	                <button>찾기</button>
	            </div>
          </div>	
	        <!-- 양식 영역 끝 -->
	        <div class="form-actions">
	            <button class="cancel-btn">취소</button>
	            <button type="submit" class="submit-btn">제출</button>
	        </div>
		</form>
    </div>
    
  <!-- 모달 -->
	<jsp:include page="./empModal.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		// 호출되면 페이지에 담을 emp 정보 불러오기 
		$.ajax({
            url: '${pageContext.request.contextPath}/approval/forms/commonForm',
            method: 'get',
            success: function(json) {
                $('#drafterEmpNo').val(json.empNo);
                console.log($('#drafterEmpNo').val());
                $('#drafterEmpNoField').val(json.empName + '('+json.empNo+')');
				console.log($('#drafterEmpNoField').val());
                $('#name').val(json.empName);
                $('#department').val(json.dptName)
            },
            error: function() {
                alert('기본정보 불러오는데 실패했습니다 .');
            }
        });
		
	   

		});
</script>
</body>
</html>


