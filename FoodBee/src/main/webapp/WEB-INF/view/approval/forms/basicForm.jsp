<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .file-upload {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .file-upload label {
            width: 80px;
            margin-right: 10px;
        }
        .file-upload input[type="text"] {
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
		    
		    <form id="draftForm" method="post" action="${pageContext.request.contextPath}/approval/addDraft" enctype="multipart/form-data">
		        <!-- 공통 영역 포함 -->
		        <jsp:include page="./commonForm.jsp"></jsp:include>
		        <!-- 공통 영역 끝 -->
		        
		        <!-- 양식 영역 시작 -->
				 <div class="form-section">
		            <div class="form-group">
		                <label for="title">제목:</label>
		                <input type="text" id="title" name="title">
		            </div>
		            <div class="form-group">
		                <label for="content">내용:</label>
		                <textarea id="content" name="content"></textarea>
		            </div>
		            <div class="file-upload">
		                <label for="attachment">첨부파일:</label>
		                <input type="file" id="attachment" name="docFiles" multiple>
		               
		            </div>
		        </div>	
		        <!-- 양식 영역 끝 -->
		        <div class="form-actions">
		            <button type="reset" class="cancel-btn">취소</button>
		            <button  type="button" id="submitBtn" class="submit-btn">제출</button>
		        </div>
			</form>
			
	    </div>

<script>
	$(document).ready(function(){
		// 호출되면 페이지에 담을 emp 정보 불러오기 
		$.ajax({
            url: '${pageContext.request.contextPath}/approval/forms/commonForm',
            method: 'get',
            success: function(json) {
                $('#drafterEmpNo').val(json.empNo);
                $('#drafter').text(json.empName + '(' + json.empNo + ')');
                $('#name').val(json.empName);
                $('#department').val(json.dptName)
            },
            error: function() {
                alert('기본정보 불러오는데 실패했습니다 .');
            }
        });
		
	    $(".tab").click(function(){
	        // 모든 탭에서 'active' 클래스 제거
	        $(".tab").removeClass("active");
	        // 클릭한 탭에 'active' 클래스 추가
	        $(this).addClass("active");
	
	        // data-form 속성에서 폼 파일명 가져오기
	        let formName = $(this).data("form");
	        console.log(formName);
	    });
	 	// 제출 버튼 클릭 시 폼 제출
        $('#submitBtn').click(function() {
            $('#draftForm').submit();
        });
	});
</script>
</body>

</html>