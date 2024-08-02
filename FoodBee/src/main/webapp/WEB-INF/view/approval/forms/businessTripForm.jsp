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
        
        .form-group input[type="text"], .form-group textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
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
		    <form id="form" method="post" action="${pageContext.request.contextPath}/approval/addDraft" enctype="multipart/form-data">
		        <!-- 공통 영역 포함 -->
		        <jsp:include page="./commonForm.jsp"></jsp:include>
		        <!-- 공통 영역 끝 -->
		        
		        <!-- 양식 영역 시작 -->
				<div class="form-section">        
		        	<div class="form-group">
		        		<input type="hidden" name="tmpNo" value="3">
		                <label for=place>출장지:</label>
		                <input type="text" id="place" name="typeName">
		                <div class="error" id="placeError"></div>
		            </div>
		            <div class="form-group">
		                
		                <label for="period">기간:</label>
		                <input type="date" name="startDate" id="startDate"> ~
		                <input type="date" name="endDate" id="endDate">
		                <div class="error" id="periodError"></div>
		                
		            </div>
		            <div class="form-group">
		                <label for=emergency>비상연락:</label>
		                <input type="text" id="emergency" name="text">
		                <div class="error" id="emergencyError"></div>
		            </div>
		            <div class="form-group">
		                <label for="title">제목:</label>
		                <input type="text" id="title" name="title">
		                <div class="error" id="titleError"></div>
		            </div>
		            <div class="form-group">
		                <label for="content">내용:</label>
		                <textarea id="content" name="content" placeholder="출장 목적을 작성하세요."></textarea>
		                 <div class="error" id="contentError"></div>
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
		
		
		// 오늘 이전의 날짜는 선택하지 못하게 막아주기
		let date = new Date();
		let year = date.getFullYear();
		console.log(year);
		// padStart => 자릿수 맞추기 위해 씀 
		let month = String(date.getMonth()+1).padStart(2,'0');
		console.log(month);
		let day = String(date.getDate()).padStart(2,'0');
		console.log(day);
		let today = year+ '-' + month + '-' + day;
		console.log(today);
		$('#startDate').attr('min',today);
		$('#endDate').attr('min',today);
		
		
		// 공백/유효성 검사
		$('#place').blur(function() {
            let value = $(this).val().trim();
            if (value === '') {
                $('#placeError').text('출장지를 입력해 주세요.');
            } else {
                $('#placeError').text('');
            }
        });
		
		$('#startDate, #endDate').blur(function() {
	        let startDate = $('#startDate').val();
	        let endDate = $('#endDate').val();
	        
	        
	        
	        // 날짜 필드가 비어 있는지 확인
	        if (startDate === '' || endDate === '') {
	            $('#periodError').text('기간을 입력해 주세요.');
	        } else {
	            // 날짜 비교 및 오류 메시지 설정
	            if (new Date(startDate) > new Date(endDate)) {
	                $('#periodError').text('종료 날짜는 시작 날짜 이후여야 합니다.');
	            } else {
	                $('#periodError').text('');
	            }
	        }
	    });

        $('#emergency').blur(function() {
            let value = $(this).val().trim();
            if (value === '') {
                $('#emergencyError').text('비상연락을 입력해 주세요.');
            } else {
                $('#emergencyError').text('');
            }
        });

        $('#title').blur(function() {
            let value = $(this).val().trim();
            if (value === '') {
                $('#titleError').text('제목을 입력해 주세요.');
            } else {
                $('#titleError').text('');
            }
        });

        $('#content').blur(function() {
            let value = $(this).val().trim();
            if (value === '') {
                $('#contentError').text('내용을 입력해 주세요.');
            } else {
                $('#contentError').text('');
            }
        });

		
		
		// 결재사인 유무 체크
		$('#submitBtn').click(function(e) {
            // 공백 및 날짜 유효성 검사
            let hasError = false;
            if ($('#place').val().trim() === '') {
                $('#placeError').text('출장지를 입력해 주세요.');
                hasError = true;
            } else {
                $('#placeError').text('');
            }

            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            if (startDate === '' || endDate === '') {
                $('#periodError').text('기간을 입력해 주세요.');
                hasError = true;
            } else if (new Date(startDate) > new Date(endDate)) {
                $('#periodError').text('종료 날짜는 시작 날짜 이후여야 합니다.');
                hasError = true;
            } else {
                $('#periodError').text('');
            }

            if ($('#emergency').val().trim() === '') {
                $('#emergencyError').text('비상연락을 입력해 주세요.');
                hasError = true;
            } else {
                $('#emergencyError').text('');
            }

            if ($('#title').val().trim() === '') {
                $('#titleError').text('제목을 입력해 주세요.');
                hasError = true;
            } else {
                $('#titleError').text('');
            }

            if ($('#content').val().trim() === '') {
                $('#contentError').text('내용을 입력해 주세요.');
                hasError = true;
            } else {
                $('#contentError').text('');
            }
            if (!hasError) {
	        $('#form').submit();
	      }
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


