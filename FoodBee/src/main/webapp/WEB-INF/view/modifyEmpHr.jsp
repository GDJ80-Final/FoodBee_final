<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 800px;
            margin: 30px auto;
        }
        .profile-img {
            width: 200px;
            height: 200px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container form-container">
        <form method="post" id="modifyForm" action="${pageContext.request.contextPath}/modifyEmpHr">
            <div class="mb-4">
                <h5>사원수정</h5>
                <div>
				</div>
            </div>
			<div id="content">
	           <div class="row">
                    <div class="col-md-4">
                        <div class="profile-img mb-3">
                            프로필사진
                        </div>
                    </div>
                    <div class="col-md-8">
                        <h5>인사</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">이름</label>
                                <input type="text" class="form-control" value="${empHr.empName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">사원번호</label>
                                <input type="text" name="empNo" class="form-control" value="${empHr.empNo}" readonly>
                            </div>
                            <div class="col-md-6">
								 <label class="form-label">상태</label>
								<select id="empState" name="empState" class="form-select">
									<option value="0">가발령
									<option value="1">재직
									<option value="2">휴직
									<option value="9">퇴직
								</select> 
								<span id="stateMsg" class="msg"></span>
							</div> 
                            <div class="col-md-6">
                                <label class="form-label">본사/지사</label>
								<select id="office" class="form-select">
									<option value="">---본사/지사 선택---</option>
								</select>
								<span id="officeMsg" class="msg"></span>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">부서</label>
                                <select id="dept" class="form-select">
									<option value="">---부서 선택---</option>
								</select>
								<span id="deptMsg" class="msg"></span>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">팀</label>
                                <select id="team" name="dptNo" class="form-select">
									<option value="">---팀 선택---</option>
								</select>
								<span id="teamMsg" class="msg"></span>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">직급</label>
                                <select id="rankName" name="rankName" class="form-select">
									<option value="">---직급 선택---
									<option value="사원">사원
									<option value="대리">대리
									<option value="팀장">팀장
									<option value="부서장">부서장
									<option value="지사장">지사장
									<option value="CEO">CEO
								</select>
								<span id="rankMsg" class="msg"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-4">
                	<button type="button" id="modifyBtn" class="btn btn-danger">수정</button>
               	</div>
            </div>
        </form>
    </div>
    
    <script>
	    $(document).ready(function() {
	    	

	    	
			$('#empState').change(function() {
	
		        // 만약 empState가 "가발령"이 아니면 본사/지사, 부서, 팀을 활성화
		        if ($('#empState').val() != '0') {
		            $('#office, #dept, #team').prop('disabled', false);  // 활성화
		            $('#officeMsg, #deptMsg, #teamMsg').text('선택하지않을시 원래 부서로 자동 선택됩니다.'); 
		            $('#deptMsg, #teamMsg').text('')// 메시지 초기화
		        } else {
		        	// "가발령"일시 비활성화
		            $('#office, #dept, #team').prop('disabled', true);
		            $('#team').val('')
		            $('#team').empty();
		            $('#team').append('<option value="">---팀 선택---</option>');
		            $('#dept').val('');
		            $('#dept').empty();
		            $('#dept').append('<option value="">---부서 선택---</option>');
		            $('#office').val('');
		            
		        }
		    });
			
	
		    // 초기 상태 설정
		    if ($('#empState').val() === '0') {
		        $('#office, #dept, #team').prop('disabled', true);
		    }
			$('#createNoBtn').click(function(){
				$.ajax({
					url : '${pageContext.request.contextPath}/createEmpNo',
					method : 'get', 
					success : function(json) {
						console.log(json);
						$(empNo).val(json);
					}
				});
			});
			
			$.ajax({
				url:'${pageContext.request.contextPath}/officeList',
				method:'get',
				success:function(json){
					console.log(json);
					json.forEach(function(item){
						console.log(item);
						$('#office').append('<option value="' + item.dptNo + '">' + item.dptName + '</option>');
					});			
				}
			});
			
			$('#office').change(function(){
				if($('#office').val() == '') {
					$('#team').val('');
		            $('#team').empty();
		            $('#team').append('<option value="">---팀 선택---</option>');
		            $('#dept').val('');
		            $('#dept').empty();
		            $('#dept').append('<option value="">---부서 선택---</option>');
					return;
				}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/deptList',
					method:'post',
					data:{'dptNo' : $('#office').val()},
					success:function(json) {
						console.log(json);
						
						$('#dept').empty();
						
						$('#dept').append('<option value="">---부서 선택---</option>');
						json.forEach(function(item){ 
							$('#dept').append('<option value="' + item.dptNo + '">' + item.dptName + '</option>');
						});
					}
				});
			});
			
			$('#dept').change(function(){
				if($('#dept').val() == '') {
					$('#team').val('');
		            $('#team').empty();
		            $('#team').append('<option value="">---부서 선택---</option>');
					return;
				}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/teamList',
					method:'post',
					data:{'dptNo' : $('#dept').val()},
					success:function(json) {
						console.log(json);
						
						$('#team').empty();
						
						$('#team').append('<option value="">---팀 선택---</option>');
						json.forEach(function(item){ 
							$('#team').append('<option value="' + item.dptNo + '">' + item.dptName + '</option>');
						});
					}
				});
			});
			
			$.ajax({
	    		url:'${pageContext.request.contextPath}/getEmpHr',
	    		method: 'get',
				data: {empNo : ${empHr.empNo}},
				success:function(json){
					console.log(json);
					$('#empState').val(json.empStateCode).trigger('change');
					$('#rankName').val(json.rankName);
					
				}
			});
			
			$('#modifyBtn').click(function(){
				if($('#empState').val() !== '0' && $('#office').val() !== ''){
					if($('#dept').val() == '') {
						$('#deptMsg').text('부서를 선택해주세요 ');
						$('#deptMsg').focus();
						return;
					} else {
						$('#deptMsg').text('');
					}
					
					if($('#team').val() == '') {
						$('#teamMsg').text('팀을 선택해주세요 ');
						$('#teamMsg').focus();
						return;
					} else {
						$('#teamMsg').text('');
					}
				}
				
				if($('#rankName').val() == '') {
					$('#rankMsg').text('직급을 선택해주세요 ');
					$('#rankMsg').focus();
					return;
				} else {
					$('#rankMsg').text('');
				}
				
				$('#modifyForm').submit();
			});
			
	    });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>