<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	    <div class="tabs" id="tabs">
	        <div class="tab" id="basicForm" data-form="basicForm">기본기안서</div>
	        <div class="tab" id="revenueForm" data-form="revenueForm">매출보고</div>
	        <div class="tab" id="chargeForm" data-form="chargeForm">지출결의</div>
	        <div class="tab" id="businessTripForm" data-form="businessTripForm">출장신청</div>
	        <div class="tab" id="dayOffForm" data-form="dayOffForm">휴가신청</div>
	    </div>
	    <form>
	        <!-- 공통 영역 포함 -->
	        <jsp:include page="./forms/commonForm.jsp"></jsp:include>
	        <!-- 공통 영역 끝 -->
	        
	        <!-- 양식 영역 시작 -->
	        <!-- 
	        	<jsp:include page="./forms/basicForm.jsp"></jsp:include>
	        	<jsp:include page="./forms/revenueForm.jsp"></jsp:include>
	        	<jsp:include page="./forms/dayOffForm.jsp"></jsp:include>
	        	<jsp:include page="./forms/businessTripForm.jsp"></jsp:include>
	        	<jsp:include page="./forms/basicForm.jsp"></jsp:include>
	      		
	        -->
	        <div id="formContent" class="form-content">
                <jsp:include page="./forms/basicForm.jsp"></jsp:include>
            </div>
           	
           
	        	
	        	
	        <!-- 양식 영역 끝 -->
	        <div class="form-actions">
	            <button class="cancel-btn">취소</button>
	            <button class="submit-btn">제출</button>
	        </div>
		</form>
    </div>
<script>
	$(document).ready(function(){
	    // 컨텍스트 경로를 JavaScript 변수로 설정
	    let contextPath = "${pageContext.request.contextPath}";
		console.log(contextPath);
		
	    $(".tab").click(function(){
	        // 모든 탭에서 'active' 클래스 제거
	        $(".tab").removeClass("active");
	        // 클릭한 탭에 'active' 클래스 추가
	        $(this).addClass("active");
	        
	        // data-form 속성에서 폼 파일명 가져오기
	        let formName = $(this).data("form");
	        console.log(formName);
	        
	        // formContent div를 비우고 새로운 내용 로드
	        $("#formContent").load(contextPath + "/approval/forms/revenueForm.jsp);
	    });
	});
</script>
</body>
</html>