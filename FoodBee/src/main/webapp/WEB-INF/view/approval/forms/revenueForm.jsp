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
<title>FoodBee : 매출보고서</title>
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
        .add-file-button {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #333;
            color: #fff;
            cursor: pointer;
        }
        .add-file-button:hover {
            background-color: #555;
        }
    	#fileInputsContainer {
	        display: flex;
	        flex-direction: column; 
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
        background-color: blue;
        color: white;
        text-decoration: underline;
        margin-left: 10px;
        text-decoration: none;
	    }
	    .remove-category {
	        background-color: red;
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
	    select {
		    height: 35px; 
		    padding: 5px; 
		}
    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	<div class="content-body">
	
		<div class="row page-titles mx-0">
            <div class="col p-md-0">
            	<ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0)">기안 작성</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0)">매출 보고</a></li>
                </ol>
            </div>
        </div>
        <!-- row -->
	
		<div class="container-fluid">
        	<div class="row">
        		<div class="col-lg-12">
	                <div class="card">
	                    <div class="card-body ps-5 pe-5">
                        	<!-- 내용 시작 -->
                        	
							<!-- Nav tabs -->
                            <div class="default-tab">
	                        	<ul class="nav nav-tabs mb-3" role="tablist">
                                	<li class="nav-item">
                                    	<a class="nav-link" id="basicForm" href="${pageContext.request.contextPath}/approval/forms/basicForm">
                                    	기본기안서</a>
                                    </li>
                                    <li class="nav-item">
                                    	<a class="nav-link active" id="revenueForm" href="${pageContext.request.contextPath}/approval/forms/revenueForm">
                                    	매출보고서</a>
                                    </li>
                                    <li class="nav-item">
                                    	<a class="nav-link" id="chargeForm" href="${pageContext.request.contextPath}/approval/forms/chargeForm">
                                    	지출결의서</a>
                                    </li>
                                    <li class="nav-item">
                                    	<a class="nav-link" id="businessTripForm" href="${pageContext.request.contextPath}/approval/forms/businessTripForm">
                                    	출장신청서</a>
                                    </li>
                                    <li class="nav-item">
                                    	<a class="nav-link" id="dayOffForm" href="${pageContext.request.contextPath}/approval/forms/dayOffForm">
                                    	휴가신청서</a>
                                    </li>
	                            </ul>
                            </div>
                            
                            <!-- 입력 폼 시작 -->
							<form method="post" action="${pageContext.request.contextPath}/approval/addDraft" id="form" enctype="multipart/form-data">
							    <!-- 공통 영역 포함 -->
							    <jsp:include page="./commonForm.jsp"></jsp:include>
							    <!-- 공통 영역 끝 -->
							    
							    <!-- 양식 영역 시작 -->
						        <div class="form-section">
						            <div class="form-group">
						                <label for="yearSelect">매출년월 </label>
										<select id="yearSelect"></select>
										<select id="monthSelect" style="margin-left: 30px;"></select>
										<input type="hidden" id="description" name="description">
						            </div>
						            <div class="form-group">
						            	<input type="hidden" name="tmpNo" value="1">
						                <label for="title">제목 </label>
						                <input type="text" id="title" name="title">
						            </div>
						            
						            <div class="form-group">
									    <label for="categoryContainer">내역 </label>
									    <div id="categoryContainer"><hr>
									        <div class="category-row" style="display: flex; align-items: center;">
									            <label for="categorySelect">카테고리 </label>
									            <select class="categorySelect" name="typeName" id="category">
									                <option value="category0">---선택---</option>
									                <option value="간편식">간편식</option>
									                <option value="쌀/곡물">쌀/곡물</option>
									                <option value="육/수산">육/수산</option>
									                <option value="음료/주류">음료/주류</option>
									                <option value="청과">청과</option>
									            </select>
									            
									            <label for="revenue"style="margin-left: 100px;">매출액 </label>
									            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount" id="amount"> 원
									            <button type="button" class="btn btn-primary add-category" style="margin-left: 50px;"> 추가</button>
									        </div><hr>
									    </div>
									</div>
						            <div>
										<h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5>
										<button type="button" class="add-file-button mb-3" id="addFileButton"> + 파일 추가</button>
			                            <div id="fileInputsContainer">
											<div class="file-input-group" id="fileGroup1">
												<input type="file" id="attachment-1" name="docFiles">
											</div> 
			                        	</div>
		                        	</div>      
						        </div> 
						        <!-- 양식 영역 끝 -->
						         
								<div class="text-center">
						            <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 작성하기</button>
								</div>
							</form>
						</div>	
					</div>		
				</div>			
			</div>							      
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
            $('#department').val(json.dptName);
            
            let drafterNo = $('#drafterEmpNo').val();
        	
        	$.ajax({
                url: '${pageContext.request.contextPath}/approval/getSign',
                method: 'get',
                data: {
                    approverNo: drafterNo
                },
                success: function(json) {
                    console.log('sign 있음');
                },
                error: function(xhr, status, error) {
                    alert("결재사인을 등록을 해주세요");
                    window.location.href = '${pageContext.request.contextPath}/myPage';
                }
            });
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

	// 초기 데이터 호출 (현재 년도와 월 기준 전월 데이터)
	let initialYear = currentMonth === 1 ? currentYear - 1 : currentYear;
	let initialMonth = currentMonth === 1 ? 12 : currentMonth - 1;
	yearSelect.val(initialYear);

	// 월 선택 옵션 설정 함수
	function updateMonthSelect(selectedYear) {
	    monthSelect.empty();
	    monthSelect.append(new Option('---선택---', '')); // 기본값 추가
	    const maxMonth = selectedYear == currentYear ? currentMonth - 1 : 12; // 현재 년도인 경우 현재 월은 제외
	    for (let month = 1; month <= maxMonth; month++) {
	        const monthValue = month < 10 ? '0' + month : month;
	        monthSelect.append(new Option(monthValue + '월', monthValue));
	    }
	}

	// 초기 월 설정
	updateMonthSelect(initialYear);
	monthSelect.val(''); // 기본값으로 '---선택---'을 선택
    
    // 카테고리 추가 기능
    $(document).on('click', '.add-category', function() {
        const newRow = `        	
        	<div class="category-row" style="display: flex; align-items: center;">
	            <label for="categorySelect">카테고리:</label>
	            <select class="categorySelect" name="typeName" id="category">
	                <option value="category0">---선택---</option>
	                <option value="간편식">간편식</option>
	                <option value="쌀/곡물">쌀/곡물</option>
	                <option value="육/수산">육/수산</option>
	                <option value="음료/주류">음료/주류</option>
	                <option value="청과">청과</option>
	            </select>
	            
	            <label for="revenue" style="margin-left: 100px;">매출액:</label>
	            <input type="text" class="revenueInput" placeholder="매출액 입력" name="amount" id="amount">원	            
	            <button type="button" class="btn btn-danger remove-category" style="margin-left: 50px;">삭제</button>
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
	
 	// 연도와 월 선택 후 AJAX 호출
    $('#yearSelect, #monthSelect').change(function() {
        const year = $('#yearSelect').val();
        const month = $('#monthSelect').val();
        const referenceMonth = year + '-' + month; // YYYY-MM 형식
        const selectedCategory = $('#categorySelect').val(); // 선택된 카테고리 값 가져오기

        // AJAX 호출
        $.ajax({
            url: '${pageContext.request.contextPath}/revenue/getCategory',
            method: 'POST',
            data: {
                YearMonth: referenceMonth
            },
            success: function(response) {
            	console.log('getCategory Ajax:', response);
                // 카테고리를 선택한 후의 경고를 처리하기 위해 전역 변수 설정
                window.isCategoryChecked = response && response.length > 0;
            },
            error: function(xhr, status, error) {
                console.error("AJAX 호출 중 오류 발생:", error);
            }
        });
    });

 	// 카테고리 선택 시 경고
    $(document).on('change', '.categorySelect', function() {
        const selectedCategory = $(this).val();
        const year = $('#yearSelect').val();
        const month = $('#monthSelect').val();
        const referenceMonth = year + '-' + month; // YYYY-MM 형식

        // 월 셀렉트 박스의 값 확인
        if (month === '') { // 월이 선택되지 않은 경우
            alert("월을 선택해 주세요.");
            $(this).val('category0'); // 카테고리 초기화
            return; // 함수 종료
        }

     	// 카테고리를 선택했을 때만 경고
        if (selectedCategory !== 'category0') {
            $.ajax({
                url: '${pageContext.request.contextPath}/revenue/getCategory',
                method: 'POST',
                data: {
                    YearMonth: referenceMonth
                },
                success: function(response) {
                    console.log('받아온값:', response);

                    // 선택된 카테고리가 응답 데이터에 존재하는지 확인
                    let isCategoryExists = response.includes(selectedCategory);

                    if (isCategoryExists) {
                        alert("이미 데이터가 존재합니다.");
                        $(this).val('category0'); // 선택된 카테고리를 초기화
                    }
                }.bind(this), // bind를 사용하여 this를 바인딩
                error: function(xhr, status, error) {
                    console.error("getCategory AJAX 호출 중 오류 발생:", error);
                }
            });
        }
    });
 	
	$('#submitBtn').click(function(e) {
	    let drafterNo = $('#drafterEmpNo').val();
	    console.log(drafterNo);
	    
	    // 공백 검사
	    let errorMessage = '';	    	  
	    
	    // 제목 입력 검사
	    if ($('#title').val().trim() === '') {
	        errorMessage += '제목을 입력해 주세요.\n';
	    }
	    
	 	// 카테고리 입력 검사
	    let categorySelected = false;
	    $('.categorySelect').each(function() {
	        if ($(this).val() !== 'category0') { // 'category0'이 아닌 경우
	            categorySelected = true; // 유효한 카테고리가 선택됨
	        }
	    });

	    if (!categorySelected) {
	        errorMessage += '카테고리를 선택해 주세요.\n'; // 'category0'이 선택된 경우
	    }
	    
	    // 매출액 입력 검사
	    if ($('.revenueInput').filter(function() { return $(this).val().trim() !== ''; }).length === 0) {
	        errorMessage += '매출액을 입력해 주세요.\n';
	    }
	    
	    // 중간결재자 입력 검사
	    if ($('#midApproverNo').val().trim() === '' || $('#midApproverNo').val().trim() === null) {
	        errorMessage += '중간결재자를 선택해 주세요.\n';
	    }
	    
	    // 최종결재자 입력 검사
	    if ($('#finalApproverNo').val().trim() === '' || $('#finalApproverNo').val().trim() === null) {
	        errorMessage += '최종결재자를 선택해 주세요.\n';
	    }
	    
	    // 공백 검사 및 결재자 검사 후 AJAX 요청
	    if (errorMessage === '') {
	        $('#form').submit();
	    } else {
	        e.preventDefault();
	        alert(errorMessage);
	    }
	});
	
	/* 파일 여러 개 추가  */
	let fileOrder = 1;
	// 파일 추가 버튼 클릭 시
    $('#addFileButton').click(function() {
        fileOrder++;
        let newFileInput = 
            '<div class="file-input-group d-flex align-items-center mt-3" id="fileGroup${fileOrder}">'+
            '<input type="file" id="attachment-${fileOrder}" name="docFiles">'+
             '<button type="button" class="btn btn-danger remove-file-button mt-2 ms-3" data-file-id="fileGroup${fileOrder}">삭제</button>'+
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