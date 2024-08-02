<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		    <form id="form" method="post" action="${pageContext.request.contextPath}/approval/modifyDraft" enctype="multipart/form-data">
		    	<input type="hidden" name="draftDocNo" value="${revenueOne.draftDocNo}">
		        <!-- 공통 영역 -->
				<jsp:include page="./forms/commonForm.jsp"></jsp:include>
		       
		        <!-- 공통 영역 끝 -->
		        
		        <!-- 양식 영역 시작 -->
		        <div class="form-section">
		            <div class="form-group">
		                <label for="yearSelect">발생 년월:</label>
						<select id="yearSelect"></select>
						<label for="monthSelect"></label>
						<select id="monthSelect"></select>
						<input type="hidden" id="description" name="description">
		            </div>
		            <div class="form-group">
		            	<input type="hidden" name="tmpNo" value="1">
		                <label for="title">제목:</label>
		                <input type="text" id="title" name="title" value="${revenueOne.title}">
		            </div>
		            
		            <div class="form-group">
					    <label for="categoryContainer">내역:</label>
					    <div id="categoryContainer"><hr>
					    	<c:forEach items="${revenueDetailOne}" var="detail">
						        <div class="category-row" style="display: flex; align-items: center;">
						            <label for="categorySelect">카테고리:</label>
						            <select class="categorySelect" id="categorySelect" name="typeName">
						                <option value="category0">==선택==</option>
						                <option value="간편식">간편식</option>
						                <option value="쌀/곡물">쌀/곡물</option>
						                <option value="육/수산">육/수산</option>
						                <option value="음료/주류">음료/주류</option>
						                <option value="청과">청과</option>
						            </select>
						            
						            <script>
						            	$("#categorySelect").val("${detail.typeName}")
						            </script>
						            
						            <label for="revenue">매출액:</label>
						            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount" value="${detail.amount}">원
						            <span class="add-category">+</span>
						            <span class="remove-category">-</span>
						        </div><hr>
					        </c:forEach>
					    </div>
					</div>
			        <div class="file-upload">
		                <label for="attachment">첨부파일:</label>
		                	<c:forEach items="${revenueFileOne}" var="file">	
	                        	<div>                         	
		                            <c:if test="${file.originalFile != null}">
		                            	<input type="hidden" name="existingFile" value="${file.originalFile}" readonly>
		                            	<input type="text" value="${file.saveFile}" readonly>
		                            	<button type="button" class="deleteFile">X</button>
		                            </c:if>
                             	</div>
                             	<c:if test="${file.originalFile == null}">
	                            	<input type="text" value="첨부파일이 없습니다" class="form-control bg-transparent flex-grow-1 me-2" readonly="readonly">
	                            </c:if>
	                            <br>
	                        </c:forEach>
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
		            <button type="reset" class="cancel-btn">취소</button>
		            <button type="button" id="submitBtn" class="submit-btn">제출</button>
		        </div>
			</form>	
			<!-- 폼 종료 -->
	    </div>
	</div>
</div>
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	    
	    
	    
		<!-- 모달 -->
		<jsp:include page="./forms/empModal.jsp"></jsp:include>
		
		
<script>
	$(document).ready(function(){
		
		let drafter = '${revenueOne.drafterEmpNo}';
	    console.log(drafter);
	    let drafterName = '${revenueOne.drafterEmpName}';  
	    console.log(drafterName);
	    let midApprover = '${revenueOne.midApproverNo}';
	    let midApproverName = '${revenueOne.midApproverName}';
	    let finalApproverName = '${revenueOne.finalApproverName}';
	    let finalApprover = '${revenueOne.finalApproverNo}';
	    let referrerField = '${revenueReferrer.referrerName}';
	    //수신자가 없는경우
	    if(referrerField === null || referrerField === '') {
	    	referrerField = "수신자 없음";
	    }
	    let name = '${revenueOne.drafterEmpName}';  
	    let dptName = '${revenueOne.dptName}';  
	
	    $("#drafterEmpNo").val(drafter);
	    $("#drafterEmpNoField").val(drafterName+"("+drafter+")");
	    $("#midApproverNo").val(midApprover);
	    $("#midApproverNoField").val(midApproverName+"("+midApprover+")");
	    $("#finalApproverNo").val(finalApprover);
	    $("#finalApproverNoField").val(finalApproverName+"("+finalApprover+")");
	    $("#referrerField").val(referrerField);
	    $("#name").val(drafterName);
	    $("#department").val(dptName);
	    $("#midApproverBtn").hide();
	    $("#finalApproverBtn").hide();
	    
	    
		//사원 결재사인
	    let drafterSign = '${revenueOne.drafterSign}';
	    let midApproverSign = '${revenueOne.midApproverSign}';
	    let finalApproverSign = '${revenueOne.finalApproverSign}';
	    let midApprovalState = '${revenueOne.midApprovalState}';
	    let finalApprovalState = '${revenueOne.finalApprovalState}';
	    
	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${revenueOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign && midApprovalState == 1) {
	        $("#midApproverSign").html(`<img src="${revenueOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간결재 서명전");
	    }
	
	    if (finalApproverSign && finalApprovalState == 1) {
	        $("#finalApproverSign").html(`<img src="${revenueOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종결재 서명전");
	    }
	    
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
	            const monthValue = month < 10 ? '0' + month : month;
	            monthSelect.append(new Option(monthValue + '월', monthValue));
	        }
	    }

	    // 초기 월 설정
	    updateMonthSelect(initialYear);
	    let yearAndMonth = '${revenueDetailOne[0].description}'.split('-');
	    let selectedMonth = yearAndMonth[1];
	    console.log(selectedMonth);
	    monthSelect.val(selectedMonth);
	    
	    // 카테고리 추가 기능
	    $(document).on('click', '.add-category', function() {
	        const newRow = `        	
	        	<div class="category-row" style="display: flex; align-items: center;">
		            <label for="categorySelect">카테고리:</label>
		            <select class="categorySelect" name="typeName">
		                <option value="category0">==선택==</option>
		                <option value="간편식">간편식</option>
		                <option value="쌀/곡물">쌀/곡물</option>
		                <option value="육/수산">육/수산</option>
		                <option value="음료/주류">음료/주류</option>
		                <option value="청과">청과</option>
		            </select>
		            
		            <label for="revenue">매출액:</label>
		            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount">원
		            <span class="add-category">+</span>
		            <span class="remove-category">-</span>
		        </div><hr>`;
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
	    
	 	// 폼 제출 시 년도와 월을 합쳐서 description 필드에 설정
	    $('#form').on('submit', function(e) {
	        const year = yearSelect.val();
	        const month = monthSelect.val();
	        const description = year + '-' + month;
	        $('#description').val(description);
	    });
	 	
	 	// 파일 삭제 버튼 클릭 시
        $(".deleteFile").click(function(e) {
            $(this).parent().remove(); // 해당 파일만 제거
        });
	 	
	 	// 취소 버튼 클릭시 상세보기로 이동
        $('#cancle').click(function() {
        	window.location.href = "${pageContext.request.contextPath}/approval/modifyRevenueForm?draftDocNo=${revenueOne.draftDocNo}";
        })
	 	
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