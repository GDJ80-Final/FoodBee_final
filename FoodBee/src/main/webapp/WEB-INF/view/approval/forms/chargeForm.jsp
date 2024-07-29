<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
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
    </style>
</head>

        <div class="form-section">
        	<div class="form-group">
                <label for="yearSelect"></label>
				<select id="yearSelect"></select>
				<label for="monthSelect">월 선택:</label>
				<select id="monthSelect"></select>
            </div>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title">
            </div>
            <div class="form-group">
                <label for="content">내역:</label>
                <div id="categoryContainer">
			        <div class="category-row" style="display: flex; align-items: center;">
			            
			            <label for="expenditure">적요:</label>						
			            <input type="text" class="expenditureInput" placeholder="지출내용" style="margin-right: 20px;">
			            
			            <label for="charge">금액:</label>
			            <input type="text" class="chargeInput" placeholder="금액 입력">원
			            
			            <label for="note" style="margin-left: 20px;">비고:</label>
			            <textarea style="width: 400px; margin-top: 20px;" placeholder="상세내용"></textarea>
			            
			            <span class="add-category">+</span>
			            <span class="remove-category">-</span>
			            
			        </div>
			    </div>
            </div>
            <div class="file-upload">
                <label for="attachment">첨부파일:</label>
                <input type="text" id="attachment" name="attachment">
                <button>찾기</button>
            </div>
        </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	            	<div id="categoryContainer">
				        <div class="category-row" style="display: flex; align-items: center;">
				            
				            <label for="expenditure">적요:</label>						
				            <input type="text" class="expenditureInput" placeholder="지출내용" style="margin-right: 20px;">
				            
				            <label for="charge">금액:</label>
				            <input type="text" class="chargeInput" placeholder="금액 입력">원
				            
				            <label for="note" style="margin-left: 20px;">비고:</label>
				            <textarea style="width: 400px;" placeholder="상세내용"></textarea>
				            
				            <span class="add-category">+</span>
				            <span class="remove-category">-</span>
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
	                alert("삭제 할 수 없습니다.");
	            }
	        });
		      
	    });
	    </script>

