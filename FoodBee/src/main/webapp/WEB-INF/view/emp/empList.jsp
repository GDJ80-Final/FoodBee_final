<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>

    .form-control-sm{
    	border:1px solid grey;
    }
</style>
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
		                 <li class="breadcrumb-item active"><a href="javascript:void(0)">사원 조회</a></li>
		             </ol>
		         </div>
		   	</div>
		  	 <div class="container-fluid">
	               <div class="row">
	                    <div class="col-lg-12">
	                        <div class="card">
	                            <div class="card-body">
									<form>
										<div class="form-row align-items-center mt-3">
								        	<div class="col-auto my-1">
												<select id="office" class="custom-select mr-sm-2">
													<option value="">---본사/지사 선택---</option>
												</select>
									        </div>
								        	<div class="col-auto my-1">
											<select id="dept" class="custom-select mr-sm-2">
												<option value="">---부서 선택---</option>
											</select>
									        </div>
								        	<div class="col-auto my-1">
											<select id="team" class="custom-select mr-sm-2">
												<option value="">---팀 선택---</option>
											</select>
									        </div>
								        	<div class="col-auto my-1">
											<select id="rankName" name="rankName" class="custom-select mr-sm-2">
												<option value="">---직급 선택---</option>
												<option value="사원">사원</option>
												<option value="대리">대리</option>
												<option value="팀장">팀장</option>
												<option value="부서장">부서장</option>
												<option value="지서장">지사장</option>
												<option value="CEO">CEO</option>
											</select>
									        </div>
								        	<div class="col-auto my-1">
											<select id="signupYN" name="signupYN" class="custom-select mr-sm-2">
												<option value="">---회원가입 유무---</option>
												<option value="Y">Y</option>
												<option value="N">N</option>
											</select>
									        </div>
										  	<div class="col-auto my-1">
										    	<input type="number" id="empNo" name="empNo" class="form-control-sm" placeholder="사원번호를 입력하세요 ">
										  	</div>
										  	<div class="col-auto my-1">
										    	<button id="searchBtn" type="button" class="btn btn-primary">검색</button>
										  	</div>   	
								        </div>    
										  
									</form>
									
									<div id="table-body"class="table-responsive mt-3">
										<table id="empList" class="table header-border">
											<tr>
												<th>본사/지사</th>
												<th>부서</th>
												<th>팀</th>
												<th>직급</th>
												<th>사원번호</th>
												<th>사원명</th>
												<th>내선번호</th>
												<th>가입일</th>
												<th>회원가입 유무</th>
											</tr>
										</table>
									
									<!-- panel & page -->
									<div class="bootstrap-pagination mt-3" id="page">
								         <nav>
								             <ul class="pagination justify-content-center">
								                 <li class="page-item"><button type="button" id="first" class="page-link">처음</button>
								                 </li>
								                 <li class="page-item"><button type="button" class="page-link" id="pre">이전</button>
								                 </li>
								                 <li class="page-item active"><div class="page-link" id="currentPage"></div>
								                 </li>
								                 <li class="page-item"><button type="button" class="page-link" id="next">다음</button>
								                 </li>
								                 <li class="page-item"><button type="button" class="page-link" id="last">마지막</button>
								                 </li>
								             </ul>
								         </nav>
								     </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<script>
		let currentPage = 1;
		let lastPage = 1;

		// 팀 권한 코드
		let teamAuthCode;
	
		$(document).ready(function() {
			loadEmpList(1);
			
			
			// 본사/지사 데이터
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
			
			// 부서 데이터
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
			
			// 팀 데이터
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
			
			// 팀 권한 코드 구하기
			$.ajax({
				url: '${pageContext.request.contextPath}/auth/getTeamAuth',
				method:'get',
				data:{dptNo : '${emp.dptNo}'},
				success:function(json){
					console.log(json);
					teamAuthCode = json;
				}
			})
			
			
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
			
			
			// 임시 비밀번호 발급, 이메일 발송
			$('#empList').on('click', '.resetPw', function(){
				const emp = JSON.parse(this.value);
			    console.log(emp);
			    $.ajax({
			        url: '${pageContext.request.contextPath}/emp/resetPw',
			        method: 'post',
			        data: {
			        	empNo: emp.empNo,
			        	empEmail: 	emp.empEmail
		        	},
			        success: function(json){
			            alert('비밀번호가 초기화되었습니다. 이메일로 임시 비밀번호를 발송했습니다');
			        },
		        	error: function(jqXHR, textStatus, errorThrown) {
		                if(jqXHR.status === 403) {
		                    alert('권한이 없습니다.');
		                }
		        	}
			    });
			});
			
			// 회원가입 이메일 재발송
			$('#empList').on('click', '.sendEmail', function(){
			    let empNo = $(this).val();
			    console.log(empNo);
			    $.ajax({
			        url: '${pageContext.request.contextPath}/emp/resendEmail',
			        method: 'post',
			        data: { empNo: empNo },
			        success: function(json){
			            alert('회원가입 링크가 발송되었습니다. 이메일 : ' + json);
			        },
			        error: function(jqXHR, textStatus, errorThrown) {
		                if(jqXHR.status === 403) {
		                    alert('권한이 없습니다.');
		                }
		        	}
			    });
			});
			
			//페이징 버튼 활성화
	        function updateBtnState() {
	            console.log("update");
	            $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
	            $('#next').closest('li').toggleClass('disabled', currentPage === lastPage);
	            $('#first').closest('li').toggleClass('disabled', currentPage === 1);
	            $('#last').closest('li').toggleClass('disabled', currentPage === lastPage);
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
						signupYN: $('#signupYN').val(),
						empNo: $('#empNo').val(),
						currentPage: page
					},
					success:function(json){
						console.log(json);
						lastPage = json.lastPage;
						console.log('curreptPage : ' + currentPage);
						$('#currentPage').text(currentPage);
						$('#empList').empty();
						$('#empList').append('<tr>' +
								'<th>본사/지사</th>' +
								'<th>부서</th>' +
								'<th>팀</th>' +
								'<th>직급</th>' +
								'<th>사원번호</th>' +
								'<th>사원명</th>' +
								'<th>내선번호</th>' +
								'<th>가입일</th>' +
								'<th>회원가입 유무</th>' +
								'</tr>');

						if(json.empList.length != 0){
							json.empList.forEach(function(item){
								console.log(item);
								
								empList(item);
								
								
							});
						} else {
							$('#empList').append('<tr>'+
                            '<td colspan="10" style="text-align:center;">조회된 사원이 없습니다.</td>'+
                            '</tr>')
						}
						
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
						'<td><a href= "${pageContext.request.contextPath}/emp/empDetail?empNo=' + item.empNo +  '">' + item.empName +'</a></td>' + 
						'<td>' + item.extNo +'</td>' + 
						'<td>' + item.startDate +'</td>' + 
						'<td>' + item.signupYN +
						(teamAuthCode == 'G-1' ? (item.signupYN == 'N' ? '&nbsp&nbsp&nbsp<button type="button" class="sendEmail btn ms-3 mb-1 btn-info" value= "'+ item.empNo +'">이메일 재발송</button>' : '') : '') +
						'</td>' + 
						(teamAuthCode == 'G-1' ? '<td><button type="button" class="resetPw btn mb-1 btn-danger" value=\'{"empNo": "' + item.empNo + '", "empEmail": "' + item.empEmail + '"}\'>비밀번호 초기화</button></td>' : '') +
						'</tr>');
			}
			
			
		});
	</script>
</body>
</html>