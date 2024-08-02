<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>

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
      

</style>
</head>
<body>
	<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	  
	  
	  
	  
	  
	  <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">쪽지함</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">새 쪽지 쓰기</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="email-left-box"><div class="btn btn-primary btn-block">새 쪽지 쓰기</div>
                                    <!-- <div class="mail-list mt-4"><a href="email-inbox.html" class="list-group-item border-0 text-primary p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>Inbox</b> <span class="badge badge-primary badge-sm float-right m-t-5">198</span> </a>
                                        <a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-paper-plane font-18 align-middle mr-2"></i>Sent</a>  <a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-star-o font-18 align-middle mr-2"></i>Important <span class="badge badge-danger badge-sm float-right m-t-5">47</span> </a>
                                        <a href="#" class="list-group-item border-0 p-r-0"><i class="mdi mdi-file-document-box font-18 align-middle mr-2"></i>Draft</a><a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>Trash</a>
                                    </div>
                                    -->
                                </div>
                                <div class="email-right-box">
                                    <div class="toolbar" role="toolbar">
                                        
                                    </div>
	                                    <form method="post" action="${pageContext.request.contextPath}/msg/addMsg" id="addMsgForm" enctype="multipart/form-data">
	                                    <div class="compose-content mt-5">
	                                       
	                                            <div class="form-group">
	                                            	
				                                    <div class="d-flex">
												        <input type="text" class="form-control bg-transparent flex-grow-1 me-2" name="recipientField" id="recipientField" placeholder="받는 이" readonly>
												        <button type="button" class="btn btn-info" id="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button>
												    </div>
	                                                <input type="hidden" name="recipientEmpNos" id="recipient" readonly>
	             
	                                                <div id="recipientError" class="error"></div>
	                                                
	                                            </div>
	                                            <div class="form-group">
	                                            	
	                                                <input type="text" name="title" id="title" class="form-control bg-transparent" placeholder=" 제목">
	                                                <div id="titleError" class="error"></div>
	                                            </div>
	                                            <div class="form-group">
	                                                <textarea class="textarea_editor form-control bg-light" id="message" name="content" rows="15" placeholder=" 쪽지 내용을 입력하세요 ..."></textarea>
	                                                 <div id="messageError" class="error"></div>
	                                            </div>
	                                       
	                                        <h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5><button type="button" class="add-file-button mb-3" id="addFileButton">+ 파일 추가</button>	
	                                        
	                                            <div class="form-group" id="fileInputsContainer">
												     <div class="file-input-group" id="fileGroup1">
												          <input type="file" id="attachment-1" name="msgFiles">
												     </div>   
	                                            </div>
	                                        
	                                    </div>
	                                    <div class="text-right m-t-15">
	                                        <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10 send-btn" type="button" id="submitBtn"><i class="fa fa-paper-plane m-r-5"></i> 보내기</button>
	                                        <button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 cancel-btn" type="button" id="cancelBtn"><i class="ti-close m-r-5 f-s-12"></i>취소</button>
	                                    </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #/ container -->
        </div>
       </div>
        <!--**********************************
            Content body end
        ***********************************-->
	  
	  <jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	  
	  

 		
    <!-- 모달 -->
	<jsp:include page="/WEB-INF/view/approval/forms/empModal.jsp"></jsp:include>
	
	<!-- 모달 종료 -->
	
	<script>
		let currentPage = 1;
		let lastPage = 1;
	
		$(document).ready(function() {
			loadEmpList(1);
			
			//본사지사 데이터 
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/officeList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#office').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			//부서데이터 
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/deptList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#dept').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			//팀 리스트 데이터 
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/teamList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#team').append('<option value="' + item.dptName + '">' + item.dptName + '</option>');
					});			
				}
			});
			
			$('#searchBtn').click(function(){
				currentPage = 1
				loadEmpList(currentPage);
			});
			
			$('#pre').click(function() {
				if (currentPage > 1) {
					currentPage = currentPage - 1;
					loadEmpList(currentPage);
				}
			});

			$('#next').click(function() {
				if (currentPage < lastPage) {
					currentPage = currentPage + 1;
					loadEmpList(currentPage);
				}
			});
			
			$('#first').click(function() {
				if (currentPage > 1) {
					currentPage = 1;
					loadEmpList(currentPage);
				}
			});

			$('#last').click(function() {
				if (currentPage < lastPage) {
					currentPage = lastPage
					loadEmpList(currentPage);
				}
			});
			
			// 버튼 활성화
			function updateBtnState() {
				console.log("update");
		        $('#pre').prop('disabled', currentPage === 1);
		        $('#next').prop('disabled', currentPage === lastPage);
		        $('#first').prop('disabled', currentPage === 1);
		        $('#last').prop('disabled', currentPage === lastPage);
		    }
			
			// 사원 목록 출력
			function loadEmpList(page){
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/searchEmp',
					method:'get',
					data:{
						officeName: $('#office').val(),
						deptName: $('#dept').val(),
						teamName: $('#team').val(),
						rankName: $('#rankName').val(),
						empNo: $('#empNo').val(),
						currentPage: page
					},
					success:function(json){
						console.log(json);
						lastPage = json.lastPage;
						console.log('curreptPage : ' + currentPage);
						$('#empList').empty();
						$('#empList').append('<tr>' +
								'<th>본사/지사</th>' +
								'<th>부서</th>' +
								'<th>팀</th>' +
								'<th>직급</th>' +
								'<th>사원번호</th>' +
								'<th>사원명</th>' +
								'</tr>');
						json.empList.forEach(function(item){
							console.log(item);
							
							empList(item);
							
							
						});
						
						updateBtnState();
					}
				});
			}
			
			// 사원 목록 데이터 가져오기
			function empList(item){
				
				 let officeInfo = '';

			    if (item.officeName !== null) {
			        officeInfo += '<td>' + item.officeName + '</td>';
			        officeInfo += '<td>' + item.deptName + '</td>';
			        officeInfo += '<td>' + item.teamName + '</td>';
			    } else {
			        officeInfo += '<td colspan="3">가발령</td>';
			    }
				
				$('#empList').append('<tr>' +
						officeInfo + 
						'<td>' + item.rankName +'</td>' + 
						'<td>' + item.empNo +'</td>' + 
						'<td>' + item.empName +'</td>' + 
						'<td><button type="button" id="selectEmp" class="selectEmp" value="' + item.empNo + '" data-name="' + item.empName + '">선택</button></td>' +
						'</tr>');
				}
			
			
			//모달에서 사원 선택 
			$(document).on('click', '#selectEmp', function() {
				
			    let empNo = $(this).val();
			    let empName = $(this).data('name');
			    let recipientField = $('#recipientField');
			    let recipientFieldVal = recipientField.val();
			    let recipient = $('#recipient');
			    let recipientVal = recipient.val();
			    let newRecipientFieldVal;
			    let newRecipientVal;
			    let empNosArray = [];

			    console.log(empNo);

			    // 현재 recipient 필드 값 가져오기 및 배열로 변환
			    if (recipientVal) {
			        empNosArray = recipientVal.split(','); // 사원 번호 배열로 변환
			        console.log('empNosArray => ' + empNosArray);

			        // 중복된 사번이 있으면
			        if (empNosArray.includes(empNo)) {
			            alert('이미 추가된 사원입니다.');
			            return;
			        } else {
			            newRecipientVal = recipientVal + ',' + empNo; // 중복이 아니면 추가
			        }
			    } else {
			        newRecipientVal = empNo; // 처음 추가할 때
			    }

			    // 사원 이름(empName(empNo))을 recipientField에 추가
			    if (recipientFieldVal) {
			        newRecipientFieldVal = recipientFieldVal + ', ' + empName + '(' + empNo + ')'; // 기존 값에 추가
			    } else {
			        newRecipientFieldVal = empName + '(' + empNo + ')'; // 처음 추가할 때
			    }

			    // 필드 값 업데이트
			    recipientField.val(newRecipientFieldVal);
			    recipient.val(newRecipientVal);

			    // 모달 닫기
			    $('#staticBackdrop').modal('hide');
		    });
			
			let fileOrder = 1;
	        // 파일 추가 버튼 클릭 시
	        $('#addFileButton').click(function() {
	            fileOrder++;
	            let newFileInput = 
	                '<div class="file-input-group d-flex align-items-center mt-3" id="fileGroup${fileOrder}">'+
	                '<input type="file" id="attachment-${fileOrder}" name="msgFiles">'+
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
			
			/* 공백 검사, 유효성 검사 */
			
		    // 입력 필드 블러 이벤트 리스너
		    
		    $('#recipient').blur(function() {
		        let recipient = $(this).val().trim();
		        if (recipient === '') {
		            $('#recipientError').text('받는사람을 입력해 주세요.');
		        } else {
		            $('#recipientError').text('');
		        }
		    });

		    $('#title').blur(function() {
		        let title = $(this).val().trim();
		        if (title === '') {
		            $('#titleError').text('제목을 입력해 주세요.');
		        } else {
		            $('#titleError').text('');
		        }
		    });

		    $('#message').blur(function() {
		        let message = $(this).val().trim();
		        if (message === '') {
		            $('#messageError').text('쪽지 내용을 입력해 주세요.');
		        } else {
		            $('#messageError').text('');
		        }
		    });

		    // 제출 버튼 클릭 시 전체 유효성 검사
		    
		    $('#submitBtn').click(function(e) {
		        // 기본 폼 제출 방지
		        e.preventDefault();

		        // 모든 입력 필드 블러 이벤트 트리거
		        $('#recipient').blur();
		        $('#title').blur();
		        $('#message').blur();

		        // 유효성 검사 확인
		        if ($('.error:contains("입력해 주세요")').length === 0) {
		            $('#addMsgForm').submit();
		        }
		    });

		    // 취소 버튼 클릭 시 폼 초기화 및 에러 메시지 초기화
		    
		    $('#cancelBtn').click(function() {
		        $('#addMsgForm')[0].reset();
		        $('.error').text(''); 
		        window.location.href = '${pageContext.request.contextPath}/msg/receivedMsgBox';
		        // 모든 에러 메시지 초기화
		    });
		});
	</script>
</body>
</html>