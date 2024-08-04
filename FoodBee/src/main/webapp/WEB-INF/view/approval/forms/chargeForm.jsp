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
					<li class="breadcrumb-item active"><a href="javascript:void(0)">지출 결의</a></li>
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
	                            	<a class="nav-link" id="revenueForm" href="${pageContext.request.contextPath}/approval/forms/revenueForm">
	                            	매출보고서</a>
	                            </li>
	                            <li class="nav-item">
	                            	<a class="nav-link active" id="chargeForm" href="${pageContext.request.contextPath}/approval/forms/chargeForm">
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
						    		<label for="monthSelect">지출년월 </label>    
									<select id="yearSelect"></select>
									<select id="monthSelect" style="margin-left: 30px;"></select>						       	        
									<input type="hidden" id="description" name="description">
						        </div>	            
						        <div class="form-group">
						        	<input type="hidden" name="tmpNo" value="5">
						            <label for="title">제목 </label>
						            <input type="text" id="title" name="title">
						        </div>
						        <div class="form-group">
						            <label for="categoryContainer">내역 </label>
						            <div id="categoryContainer"><hr>
									    <div class="category-row" style="display: flex; flex-direction: column;">
									        <div style="display: flex; align-items: center; margin-bottom: 10px;">
									            <label for="typeName">적요 </label>
									            <input type="text" id="typeName" placeholder="지출내용" name="typeName" style="width: 350px; max-width: 350px;">
									            
									            <label for="amount" style="margin-left: 30px;">금액 </label>
									            <input type="text" id="amount" placeholder="금액 입력" name="amount" style="width: 315px; max-width: 315px;"> &nbsp;원
									        </div>
									        <div style="display: flex; align-items: center;">
									            <label for="description" style="margin-right: 10px;">비고 </label>
									            <textarea style="width:785px;" id="text" placeholder="상세내용" name="text"></textarea>
									            
									            <button type="button" class="btn btn-primary add-category">추가</button>	
									        </div>
									        <hr>
									    </div>
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
							
						    <div class="text-center mt-3">
						    	<button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 float-left" type="button" id="returnBox"><i class="ti-close m-r-5 f-s-12"></i> 돌아가기</button>
						    	<button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 작성하기</button>
							</div>	
						</form>
						<!-- 폼 종료 -->
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
            
	            <label for="typeName">적요 </label>
	            <input type="text" id="typeName" placeholder="지출내용" name="typeName" style="width: 350px; max-width: 350px;">
	            
	            <label for="amount" style="margin-left: 30px;">금액 </label>
	            <input type="text" id="amount" placeholder="금액 입력" name="amount" style="width: 315px; max-width: 315px;">&nbsp;원
	            
	        </div>
	        <div style="display: flex; align-items: center;">
	        
	            <label for="description" style="margin-right: 10px;">비고 </label>
	            <textarea style="width:785px;" id="text" placeholder="상세내용" name="text"></textarea>
	            
	            <button type="button" class="btn btn-danger remove-category">삭제</button>
	            
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
 		// 공백 검사
		let errorMessage = '';
		
		if ($('#title').val().trim() === '') {
		        errorMessage += '제목을 입력해 주세요.\n';
		}
		if ($('#typeName').val().trim() === '') {
		        errorMessage += '적요를 입력해 주세요.\n';
		}
		if ($('#amount').val().trim() === '') {
	        errorMessage += '금액을 입력해 주세요.\n';
		}
		if ($('#text').val().trim() === '') {
	        errorMessage += '비고를 입력해 주세요.\n';
		}
		
		if ($('#midApproverNo').val().trim() === '') {
		        errorMessage += '중간결재자를 선택해 주세요.\n';
		}
		if ($('#finalApproverNo').val().trim() === '') {
		        errorMessage += '최종결재자를 선택해 주세요.\n';
		}
		
		// 공백 검사 및 결재자 검사 후 AJAX 요청
		if (errorMessage === '') {
			$('#form').submit();
		} else {
		    e.preventDefault();
		    alert(errorMessage);
		}
		
    /*     // 폼 필드 유효성 검사
        let title = $('#title').val();
        let typeName = $('#typeName').val();
        let amount = $('#amount').val();
        let text = $('#text').val();
        
        if (!title) {
            alert("제목을 입력 해주세요.");
            return false;
        }
        if (!typeName) {
            alert("적요를 입력해주세요.");
            return false;
        }
        if (!amount) {
            alert("금액을 입력해주세요.");
            return false;
        }
        if (!text) {
            alert("비고를 입력해주세요.");
            return false;
        }
        
        $('#form').submit(); */
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
