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
    .custom-category-input {
        display: none;        
        border: 1px solid #ccc;
        height: 25px;
        margin-left: 0px;
    }
    a {
    	text-decoration-line: none;
    
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
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
	<form method="post" action="${pageContext.request.contextPath}/approval/addDraft">
	    <!-- 공통 영역 포함 -->
	    <jsp:include page="./commonForm.jsp"></jsp:include>
	    <!-- 공통 영역 끝 -->
        <div class="form-section">
            <div class="form-group">
                <label for="yearSelect"></label>
				<select id="yearSelect"></select>
				<label for="monthSelect">월 선택:</label>
				<select id="monthSelect"></select>
				<input type="hidden" id="description" name="description">
            </div>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title">
            </div>
            
            <div class="form-group">
			    <label for="categoryContainer">내역:</label>
			    <div id="categoryContainer">
			        <div class="category-row" style="display: flex; align-items: center;">
			            <label for="categorySelect">카테고리:</label>
			            <select class="categorySelect" name="typeName">
			                <option value="category0">==선택==</option>
			                <option value="category1">간편식</option>
			                <option value="category2">쌀/곡물</option>
			                <option value="category3">육/수산</option>
			                <option value="category4">음료/주류</option>
			                <option value="category5">청과</option>
			                <option value="custom">직접입력</option>
			            </select>
			            <input type="text" class="custom-category-input" name="typeName" placeholder="직접 입력">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			            <label for="revenue">매출액:</label>
			            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount">원
			            <span class="add-category">+</span>
			            <span class="remove-category">-</span>
			        </div>
			    </div>
			</div>
            <div class="file-upload">
                <label for="attachment">첨부파일:</label>
                <input type="text" id="attachment" name="docFiles">
                <button>찾기</button>
            </div>        
         </div> 
         <!-- form section 종료 -->
         <!-- 양식 영역 끝 -->
	     <div class="form-actions">
	          <button class="cancel-btn">취소</button>
	          <button class="submit-btn">제출</button>
	     </div>
	</form>
         
</div>
		
<script>
$(document).ready(function() {

    // 현재 날짜를 가져와 셀렉트 박스에 년도와 월 추가
	const currentDate = new Date();
    const currentYear = currentDate.getFullYear(); // 현재 년도
    const currentMonth = currentDate.getMonth() + 1; // 현재 월 (0부터 시작하므로 +1)

    const yearSelect = $('#yearSelect');
    const monthSelect = $('#monthSelect');
    // 현재 년도만 추가
    yearSelect.append(new Option(currentYear + '년', currentYear));
    // 초기 데이터 호출 (현재 년도와 월 기준 전월 데이터)
    let initialYear = currentMonth === 1 ? currentYear - 1 : currentYear;
    let initialMonth = currentMonth === 1 ? 12 : currentMonth - 1;
    yearSelect.val(initialYear);
    monthSelect.val(initialMonth);

    // 월 선택 옵션 설정 함수
    function updateMonthSelect(selectedYear) {
        monthSelect.empty();
        const maxMonth = selectedYear == currentYear ? currentMonth - 1 : 12; // 현재 년도인 경우 현재 월은 제외
        for (let month = 1; month <= maxMonth; month++) {
            monthSelect.append(new Option(month + '월', month));
        }
    }

    // 초기 월 설정
    updateMonthSelect(initialYear);
    monthSelect.val(initialMonth);		
    // 카테고리 추가 기능
    $(document).on('click', '.add-category', function() {
        const newRow = `
        	<div class="form-group">
			    <label for="categoryContainer">내역:</label>
			    <div id="categoryContainer">
			        <div class="category-row" style="display: flex; align-items: center;">
			            <label for="categorySelect">카테고리:</label>
			            <select class="categorySelect" name="typeName">
			                <option value="category0">==선택==</option>
			                <option value="category1">간편식</option>
			                <option value="category2">쌀/곡물</option>
			                <option value="category3">육/수산</option>
			                <option value="category4">음료/주류</option>
			                <option value="category5">청과</option>
			                <option value="custom">직접입력</option>
			            </select>
			            <input type="text" class="custom-category-input" name="typeName" placeholder="직접 입력">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			            <label for="revenue">매출액:</label>
			            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount">원
			            <span class="add-category">+</span>
			            <span class="remove-category">-</span>
			        </div>
			    </div>
			</div>`;
        $('#categoryContainer').append(newRow);
    });
    
    // 카테고리 삭제 기능
    $(document).on('click', '.remove-category', function() {
        // 카테고리 수가 1개 이상일 경우에만 삭제
        if ($('#categoryContainer .category-row').length > 1) {
            $(this).closest('.category-row').remove();
        } else {
            alert("최소 하나의 카테고리가 필요합니다.");
        }
    });

    // 직접입력 선택 시 인풋 텍스트 보이기
    $(document).on('change', '.categorySelect', function() {
        const selectedValue = $(this).val();
        const customInput = $(this).siblings('.custom-category-input');

        if (selectedValue === 'custom') {
            customInput.show();
            customInput.focus(); // 인풋 텍스트에 포커스
        } else {
            customInput.hide();
            customInput.val(''); // 이전 입력 값 초기화
        }
    });
    
 	// 폼 제출 시 년도와 월을 합쳐서 description 필드에 설정
    $('#myForm').on('submit', function(e) {
        const year = yearSelect.val();
        const month = monthSelect.val();
        const description = year + '-' + month;
        $('#description').val(description);
    });
});
</script>
</body>
</html>
