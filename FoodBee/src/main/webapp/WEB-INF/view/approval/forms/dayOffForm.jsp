<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>Insert title here</title>
    <style>
    	 body {
            font-family: Arial, sans-serif;
           
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
        .add-category, .remove-category {
        cursor: pointer;
        color: blue;
        text-decoration: underline;
        margin-left: 10px;
        text-decoration: none;
	    }
	    .remove-category {
	        color: red;
	    }
	    .category-row {
        margin-bottom: 10px;
	    }
	    .category-row div {
	        margin-bottom: 5px;
	    }
	    .category-row label {
	        margin-right: 10px;
	    }
	    .category-row textarea {
	        resize: none;
	    }
    </style>
</head>
<body>
<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	<div class="content-body">
	<div class="container">	
		<div class="tabs" id="tabs">
			<div class="tab" id="basicForm" data-form="basicForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/basicForm">
			    	기본기안서
			    </a>
	     	</div>
			<div class="tab" id="revenueForm" data-form="revenueForm">
				<a href="${pageContext.request.contextPath}/approval/forms/revenueForm">
			 		매출보고
				</a>
			</div>
			<div class="tab" id="chargeForm" data-form="chargeForm">
				<a href="${pageContext.request.contextPath}/approval/forms/chargeForm">
			 		지출결의
				</a>
			</div>
			<div class="tab" id="businessTripForm" data-form="businessTripForm">
				<a href="${pageContext.request.contextPath}/approval/forms/businessTripForm">
					출장신청
				</a>
			</div>
			<div class="tab" id="dayOffForm" data-form="dayOffForm">
				<a href="${pageContext.request.contextPath}/approval/forms/dayOffForm">
					휴가신청
				</a>
			</div>
		</div>
		<form method="post" action="${pageContext.request.contextPath}/approval/addDraft" id="form" enctype="multipart/form-data">
			<!-- 공통 영역 포함 -->
			<jsp:include page="./commonForm.jsp"></jsp:include>
			<!-- 공통 영역 끝 -->
			
			<!-- 양식 영역 시작 -->
			<div class="form-section">
				<div class="form-group">
					<label for="category">유형:</label>
					<input type="radio" id="category" name="typeName" value="연차"> 연차          
					<input type="radio" id="category" name="typeName" value="반차" style="margin-left: 20px;"> 반차
			    </div>
			    <div class="form-group">
			        <label for="remaining">잔여 휴가:</label>
			        <input type="text" id="dayOff" name="dayoff" readonly="readonly">
			        
			        <label style="margin-left: 400px;">기간:</label>
			        <input type="date" id="startDate" name="startDate"> ~
			        <input type="date" id="endDate" name="endDate">
			    </div>
			    <div class="form-group">
			        <label for=emergency>비상연락:</label>
			        <input type="text" id="emergency" name="text">
			    </div>
			    <div class="form-group">
			    	<input type="hidden" name="tmpNo" value="2">
			        <label for="title">제목:</label>
			        <input type="text" id="title" name="title">
			    </div>
			    <div class="form-group">
			        <label for="content">내용:</label>
			        <textarea id="content" name="content" placeholder="휴가 사유을 작성하세요."></textarea>
			    </div>
			    <div class="file-upload">
                <label for="attachment">첨부파일:</label>
	                <div id="fileInputsContainer">
				        <div class="file-input-group" id="fileGroup1">
				        	<input type="file" id="attachment-1" name="docFiles">
				        </div>
				    </div>
	      			<button type="button" class="add-file-button" id="addFileButton">+ 파일 추가</button>		                
		               
		     	</div>
			</div>
		    <!-- 양식 영역 끝 -->
			<div class="form-actions">
				<button type="button" id="returnBox" class="cancel-btn">취소</button>
	            <button type="button" id="submitBtn" class="submit-btn">제출</button>
			</div>
		</form>
	</div>
	</div>
</div>
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<!-- 모달 -->
<jsp:include page="./empModal.jsp"></jsp:include>     
<script>
$(document).ready(function() {
	let empNo; // 직원 번호를 저장할 변수 선언

    // 호출되면 페이지에 담을 emp 정보 불러오기 
    $.ajax({
        url: '${pageContext.request.contextPath}/approval/forms/commonForm',
        method: 'get',
        success: function(json) {
            empNo = json.empNo; // 직원 번호를 변수에 저장
            $('#drafterEmpNo').val(empNo);
            console.log(empNo); // 직원 번호 확인
            $('#drafterEmpNoField').val(json.empName + '(' + empNo + ')');
            console.log($('#drafterEmpNoField').val());
            $('#name').val(json.empName);
            $('#department').val(json.dptName);

            // 잔여휴가 불러오기 호출
            getRemainingDayOff(empNo); // empNo를 인자로 전달
        },
        error: function() {
            alert('기본정보 불러오는데 실패했습니다.');
        }
    });

    // 잔여 휴가 불러오기 함수
    function getRemainingDayOff(empNo) {
        const year = new Date().getFullYear(); // 현재 연도

        $.ajax({
            url: '${pageContext.request.contextPath}/emp/getRemainingDayOff',
            method: 'POST',
            data: {
                empNo: empNo,
                year: year
            },
            success: function(json) {
                console.log('휴가 있음:', json);
                $('#dayOff').val(json); // 응답으로 받은 값을 #dayOff input 요소에 설정
            },
            error: function(xhr, status, error) {
                console.error('오류 발생:', error);
                alert('휴가 정보를 불러오는 데 실패했습니다.');
            }
        });
    }
	
 	// 기간 설정 기능 추가
    $('#startDate').on('change', function() {
        const startDate = $(this).val(); // startDate 값
        const remainingDays = parseFloat($('#dayOff').val()); // 잔여휴가 값
        const start = new Date(startDate);

        // 엔드데이트의 최대값 설정
        if (startDate) {
            const maxEndDate = new Date(start);
            maxEndDate.setDate(start.getDate() + remainingDays - 1); 
            $('#endDate').attr('max', maxEndDate.toISOString().split('T')[0]); // max 속성 설정
        } else {
            $('#endDate').attr('max', ''); // startDate 비어있으면 max 속성 제거
        }
    });
    
	$('#submitBtn').click(function(e) {
        let drafterNo = $('#drafterEmpNo').val();
        console.log(drafterNo)
        
        // 폼 필드 유효성 검사
        let typeName = $("input[name='typeName']:checked").val();
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let emergency = $('#emergency').val();
        let title = $('#title').val();
        let content = $('#content').val();
        
        if (!typeName) {
            alert("유형을 선택해주세요.");
            return false;
        }
        if (!startDate) {
            alert("시작 날짜를 입력해주세요.");
            return false;
        }
        if (!endDate) {
            alert("종료 날짜를 입력해주세요.");
            return false;
        }
        if (!emergency) {
            alert("비상연락처를 입력해주세요.");
            return false;
        }
        if (!title) {
            alert("제목을 입력해주세요.");
            return false;
        }
        if (!content) {
            alert("내용을 입력해주세요.");
            return false;
        }
        
        $.ajax({
            url: '${pageContext.request.contextPath}/approval/getSign',
            method: 'get',
            data: {
            	approverNo : drafterNo
            },
            success: function(json) {
            	console.log('sign 있음');
            	$('#form').submit();
            },
            error: function(xhr, status, error) {
            	e.preventDefault();
                alert("결재사인을 등록을 해주세요");
                window.location.href = '${pageContext.request.contextPath}/myPage';
            }
        });
    });
	
	/* 파일 여러 개 추가  */
	let fileOrder = 1;
    // 파일 추가 버튼 클릭 시
    $('#addFileButton').click(function() {
        fileOrder++;
        let newFileInput = 
            '<div class="file-input-group" id="fileGroup${fileOrder}">'+
            '<input type="file" id="attachment-${fileOrder}" name="docFiles">'+
             '<button type="button" class="remove-file-button" data-file-id="fileGroup${fileOrder}">삭제</button>'+
            '</div>';
        $('#fileInputsContainer').append(newFileInput);
    });

    // 파일 입력 필드 삭제 버튼 클릭 시
    $(document).on('click', '.remove-file-button', function() {
    	console.log('test');
    	let fileGroupId = $(this).data('file-id');
        $('#' + fileGroupId).remove();
    });
   
});

</script>
</body>
</html>

