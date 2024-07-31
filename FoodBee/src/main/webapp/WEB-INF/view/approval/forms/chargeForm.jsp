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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		            <label for="yearSelect"></label>
					<select id="yearSelect"></select>
					<label for="monthSelect">월 선택:</label>
					<select id="monthSelect"></select>						       	        
					<input type="hidden" id="description" name="description">
		        </div>	            
		        <div class="form-group">
		        	<input type="hidden" name="tmpNo" value="5">
		            <label for="title">제목:</label>
		            <input type="text" id="title" name="title">
		        </div>
		        <div class="form-group">
		            <label for="categoryContainer">내역:</label>
		            <div id="categoryContainer"><hr>
					    <div class="category-row" style="display: flex; flex-direction: column;">
					        <div style="display: flex; align-items: center; margin-bottom: 10px;">
					            <label for="typeName">적요:</label>
					            <input type="text" placeholder="지출내용" style="margin-right: 20px;" name="typeName">
					            
					            <label for="amount">금액:</label>
					            <input type="text" placeholder="금액 입력" name="amount">원
					        </div>
					        <div style="display: flex; align-items: center;">
					            <label for="description" style="margin-right: 10px;">비고:</label>
					            <textarea style="width: 400px;" placeholder="상세내용" name="text"></textarea>
					            
					            <span class="add-category" style="margin-left: 10px;">+</span>
					            <span class="remove-category" style="margin-left: 5px;">-</span>
					        </div>
					        <hr>
					    </div>
					</div>
		        </div>
		        <div class="file-upload">
		            <label for="attachment">첨부파일:</label>
		            <input type="file" id="attachment" name="docFiles" multiple>
				</div>
			</div>	
			<!-- 양식 영역 끝 -->
			
		    <div class="form-actions">
		        <button type="reset" class="cancel-btn">취소</button>
		        <button type="submit" id="submitBtn" class="submit-btn">제출</button>
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
	
	// 현재 날짜를 가져와 셀렉트 박스에 년도와 월 추가
	const currentDate = new Date();
	const currentYear = currentDate.getFullYear(); // 현재 년도
	const currentMonth = currentDate.getMonth() + 1; // 현재 월 (0부터 시작하므로 +1)
	
	const yearSelect = $('#yearSelect');
	const monthSelect = $('#monthSelect');
	// 현재 년도만 추가
	yearSelect.append(new Option(currentYear + '년', currentYear));
	// 초기 데이터 호출 (현재 년도와 월 기준 금월 데이터)
	let initialYear = currentMonth === 1 ? currentYear - 1 : currentYear;
	let initialMonth = currentMonth === 1 ? 12 : currentMonth;
	yearSelect.val(initialYear);
	monthSelect.val(initialMonth);
	
	// 월 선택 옵션 설정 함수
    function updateMonthSelect(selectedYear) {
        monthSelect.empty();
        const maxMonth = selectedYear == currentYear ? currentMonth : 12; // 현재 년도인 경우 현재 월은 제외
        for (let month = 1; month <= maxMonth; month++) {
            const monthValue = month < 10 ? '0' + month : month;
            monthSelect.append(new Option(monthValue + '월', monthValue));
        }
    }

    // 초기 월 설정
    updateMonthSelect(initialYear);
    monthSelect.val(initialMonth < 10 ? '0' + initialMonth : initialMonth);
    
	// 카테고리 추가 기능
	$(document).on('click', '.add-category', function() {
	    const newRow = `	            		    	
	    	<div class="category-row" style="display: flex; flex-direction: column;">
		        <div style="display: flex; align-items: center; margin-bottom: 10px;">
		            <label for="typeName">적요:</label>
		            <input type="text" placeholder="지출내용" style="margin-right: 20px;" name="typeName">
		            
		            <label for="amount">금액:</label>
		            <input type="text" placeholder="금액 입력" name="amount">원
		        </div>
		        <div style="display: flex; align-items: center;">
		            <label for="description" style="margin-right: 10px;">비고:</label>
		            <textarea style="width: 400px;" placeholder="상세내용" name="text"></textarea>
		            
		            <span class="add-category" style="margin-left: 10px;">+</span>
		            <span class="remove-category" style="margin-left: 5px;">-</span>
		        </div>
		        <hr>
		    </div>`;
	    $('#categoryContainer').append(newRow);
	});
	
	// 카테고리 삭제 기능
	$(document).on('click', '.remove-category', function() {
	    // 카테고리 수가 1개 이상일 경우에만 삭제
	    if ($('#categoryContainer .category-row').length > 1) {
	        $(this).closest('.category-row').remove();
	    } else {
	        alert("삭제 할 수 없습니다.");
	    }
	});
	
	// 폼 제출 시 년도와 월을 합쳐서 description 필드에 설정
	$('#form').on('submit', function(e) {
	    const year = yearSelect.val();
	    const month = monthSelect.val();
	    const description = year + '-' + month;
	    $('#description').val(description);
	});
	
	$('#submitBtn').click(function(e) {
        let drafterNo = $('#drafterEmpNo').val();
        console.log(drafterNo)
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
   
	
});
</script>
</body>
</html>
