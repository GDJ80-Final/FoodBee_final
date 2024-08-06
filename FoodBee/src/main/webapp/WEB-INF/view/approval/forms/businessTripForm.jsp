<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 출장신청서 작성</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
        .sign td {
       		height : 130px;
        
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

    	.remove-file-button {
        margin-left: 10px;
    	}
	
	    .error{
        	margin-top:5px;
        	color:red;
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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">출장 신청</a></li>
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
	                                        	<a class="nav-link" id="chargeForm" href="${pageContext.request.contextPath}/approval/forms/chargeForm">
	                                        	지출결의서</a>
	                                        </li>
	                                        <li class="nav-item">
	                                        	<a class="nav-link active" id="businessTripForm" href="${pageContext.request.contextPath}/approval/forms/businessTripForm">
	                                        	출장신청서</a>
	                                        </li>
	                                        <li class="nav-item">
	                                        	<a class="nav-link" id="dayOffForm" href="${pageContext.request.contextPath}/approval/forms/dayOffForm">
	                                        	휴가신청서</a>
	                                        </li>
	                                </ul>
	                            </div>
						        <!-- 입력 폼 시작 -->
							    <form id="form" method="post" action="${pageContext.request.contextPath}/approval/addDraft" enctype="multipart/form-data">
							    
							        <!-- 공통 영역 포함 -->
							        <jsp:include page="./commonForm.jsp"></jsp:include>
							        <!-- 공통 영역 끝 -->
							        
							        <!-- 양식 영역 시작 -->
									<div class="form-section">        
							        	<div class="form-group">
							        		<input type="hidden" name="tmpNo" value="3">
							                <label for=place>출장지 </label>
							                <input type="text" id="place" class="form-control" name="typeName">
							                <div class="error" id="placeError"></div>
							            </div>
							            <div class="form-group">
							                
							                <label for="period">기간 </label>
							                <input type="date" name="startDate" class="form-control-sm" id="startDate"> ~
							                <input type="date" name="endDate" class="form-control-sm" id="endDate">
							                <div class="error" id="periodError"></div>
							                
							            </div>
							            <div class="form-group">
							                <label for=emergency>비상연락처 </label>
							                <input type="text" id="emergency" name="text" class="form-control" placeholder="000-000-000">
							                <div class="error" id="emergencyError"></div>
							            </div>
							            <div class="form-group">
							                <label for="title">제목 </label>
							                <input type="text" id="title" name="title" class="form-control">
							                <div class="error" id="titleError"></div>
							            </div>
							            <div class="form-group">
							                <label for="content">내용 </label>
							                <textarea id="content" name="content" class="textarea_editor bg-light" placeholder="출장 목적을 작성하세요."></textarea>
							                 <div class="error" id="contentError"></div>
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
							            <button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 float-right" type="button" id="returnBox"><i class="ti-close m-r-5 f-s-12"></i> 취소</button>
							            <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 제출</button>
							        </div>
							       
								</form>
					
								<!-- 입력 폼 종료 -->
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
                $('#emergencyError').text('비상연락처를 입력해 주세요.');
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
            
		    let errorMessage = '';
		
		    if ($('#place').val().trim() === '') {
		        errorMessage += '출장지를 입력해 주세요.\n';
		    }
		
		    let startDate = $('#startDate').val();
		    let endDate = $('#endDate').val();
		    if (startDate === '' || endDate === '') {
		        errorMessage += '기간을 입력해 주세요.\n';
		    } else if (new Date(startDate) > new Date(endDate)) {
		        errorMessage += '종료 날짜는 시작 날짜 이후여야 합니다.\n';
		    }
		
		    if ($('#emergency').val().trim() === '') {
		        errorMessage += '비상연락을 입력해 주세요.\n';
		    }
		
		    if ($('#title').val().trim() === '') {
		        errorMessage += '제목을 입력해 주세요.\n';
		    }
		
		    if ($('#content').val().trim() === '') {
		        errorMessage += '내용을 입력해 주세요.\n';
		    }
		    if ($('#midApproverNo').val().trim() === '') {
		        errorMessage += '중간결재자를 선택해 주세요.\n';
		    }
		    if ($('#finalApproverNo').val().trim() === '') {
		        errorMessage += '최종결재자를 선택해 주세요.\n';
		    }
		
		    // 공백 및 날짜 유효성 검사 후 AJAX 요청
		    if (errorMessage === '') {
		        $('#form').submit();
		    } else {
		    	e.preventDefault();
		        alert(errorMessage);
		    }

	   });
		
		
		
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


