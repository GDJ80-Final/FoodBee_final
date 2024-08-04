<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
		                 <li class="breadcrumb-item"><a href="javascript:void(0)">사원</a></li>
		                 <li class="breadcrumb-item active"><a href="javascript:void(0)">사원 초대</a></li>
		             </ol>
		         </div>
		   	</div>
		  
		  	<div class="container-fluid">
               <div class="row">
               		<div class="col-lg"></div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                            	<div class="row mt-3">
                            		<div class="col"></div>
                            		<div class="col-9">
		                            	<div class="form-validation">
											<form method="post" id="addEmpForm" class="form-valide"  action="${pageContext.request.contextPath}/addEmp">
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="empNo">사원번호 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<input type="number" class="form-control" id="empNo" name="empNo"  readonly>
														<button type="button" class="btn btn-primary mt-3" id="createNoBtn">사원번호 생성</button>
														<div id="noMsg" class="msg">${empNoErrorMsg}</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="empName">사원명 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
		                                       	    	<input type="text" class="form-control"  id="empName" name="empName" required>
														<span id="nameMsg" class="msg">${empNameErrorMsg}</span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="empState">상태 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<select id="empState"  class="form-control" name="empState">
															<option value="">---상태 선택---
															<option value="0">가발령
															<option value="1">재직
														</select> 
														<span id="stateMsg" class="msg">${empStateErrorMsg}</span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="office">본사/지사 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<select id="office" class="form-control">
															<option value="">---본사/지사 선택---</option>
														</select>
														<span id="officeMsg" class="msg"></span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="dept">부서 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<select id="dept" class="form-control">
															<option value="">---부서 선택---</option>
														</select>
														<span id="deptMsg" class="msg"></span>
													</div>
												</div>
												<div  class="form-group row">
													<label class="col-lg-4 col-form-label" for="team">팀 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<select id="team" name="dptNo" class="form-control">
															<option value="">---팀 선택---</option>
														</select>
														<span id="teamMsg" class="msg"></span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="rankName">직급 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<select id="rankName" name="rankName" class="form-control">
															<option value="">---직급 선택---
															<option value="사원">사원
															<option value="대리">대리
															<option value="팀장">팀장
															<option value="부서장">부서장
															<option value="지서장">지사장
															<option value="CEO">CEO
														</select>
														<span id="rankMsg" class="msg">${rankNameErrorMsg}</span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="startDate">입사일 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<input type="date" id="startDate" name="startDate" class="form-control" required>
														<span id="dateMsg" class="msg">${startDateErrorMsg}</span>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-lg-4 col-form-label" for="empEmail">이메일 <span class="text-danger">*</span>
		                                       	    </label>
		                                       	    <div class="col-lg-6">
														<input type="email" id="empEmail" name="empEmail" class="form-control" required>
														<span id="emailMsg" class="msg">${empEmailErrorMsg}</span>
													</div>
												</div>
												<div class="form-group row">
													<div class="col-lg-8 ml-auto">
														<button type="button" class="btn btn-primary float-right" id="addBtn">등록 및 초대</button>
													</div>
												</div>
											</form>
										</div>
									</div>
									<div class="col"></div>								
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg"></div>
				</div>
			</div>
		</div>
	</div>
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
 	
	<script>
	$(document).ready(function() {
		$('#empState').change(function() {

	        // 만약 empState가 "재직"이면 본사/지사, 부서, 팀을 활성화
	        if ($('#empState').val() == '1') {
	            $('#office, #dept, #team').prop('disabled', false);  // 활성화
	            $('#officeMsg, #deptMsg, #teamMsg').text('');  // 메시지 초기화
	        } else {
	        	// "재직"이 아닐시 비활성화
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
	    if ($('#empState').val() !== '1') {
	        $('#office, #dept, #team').prop('disabled', true);
	    }
		$('#createNoBtn').click(function(){
			$.ajax({
				url : '${pageContext.request.contextPath}/emp/createEmpNo',
				method : 'get', 
				success : function(json) {
					console.log(json);
					$(empNo).val(json);
				}
			});
		});
		
		$.ajax({
			url:'${pageContext.request.contextPath}/emp/officeList',
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
				url:'${pageContext.request.contextPath}/emp/deptList',
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
				url:'${pageContext.request.contextPath}/emp/teamList',
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
		
		$('#addBtn').click(function(){
			if($('#empNo').val().length != 8) {
				$('#noMsg').text('사원번호를 생성해주세요');
				$('#empNo').focus();
				return;
			} else {
				$('#noMsg').text('');
			}
			
			
			if($('#empName').val() == '') {
				$('#stateMsg').text('상태를 선택해주세요 ');
				$('#stateMsg').focus();
				return;
			} else {
				$('#stateMsg').text('');
			}
			if($('#empState').val() == '') {
				$('#stateMsg').text('상태를 선택해주세요 ');
				$('#stateMsg').focus();
				return;
			} else {
				$('#stateMsg').text('');
			}
			
			if($('#empState').val() == '1'){
				if($('#office').val() == '') {
					$('#officeMsg').text('본사/지사를 선택해주세요 ');
					$('#officeMsg').focus();
					return;
				} else {
					$('#officeMsg').text('');
				}
				
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
			
			if($('#startDate').val() == '') {
				$('#dateMsg').text('입사일을 선택해주세요 ');
				$('#dateMsg').focus();
				return;
			} else {
				$('#dateMsg').text('');
			}
			
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			
			if($('#empEmail').val() == '') {
				$('#emailMsg').text('이메일을 입력해주세요 ');
				$('#emialMsg').focus();
				return;
			} else if (!emailRegex.test($('#empEmail').val())) {
                $('#emailMsg').text('유효하지 않은 이메일 형식입니다.');
                return;
			} else {
				$('#emailMsg').text('');
			}
			
			
			
			$('#addEmpForm').submit();
		});	
	});
	</script>
</body>
</html>