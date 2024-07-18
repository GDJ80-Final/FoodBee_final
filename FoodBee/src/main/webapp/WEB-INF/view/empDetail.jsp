<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사원 조회</title>
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
        <form>
            <div class="mb-4">
                <h5>사원조회</h5>
                <div>
					<button type="button" id="empInfo">개인/인사 정보</button>
					<button type="button" id="dayOffHistory">휴가 내역</button>
				</div>
            </div>
			<div id="content">
	           
            </div>
        </form>
    </div>

	<script>
		$(document).ready(function() {
			$.ajax({
				url:'${pageContext.request.contextPath}/getEmpHr',
				method:'get',
				data: {empNo : ${empNo}},
				success:function(json){
					console.log(json);
					$('#content').append(
						    '<div class="row">' +
						        '<div class="col-md-4">' +
						            '<div class="profile-img mb-3">' +
						                '프로필사진' +
						            '</div>' +
						        '</div>' +
						        '<div class="col-md-8">' +
						            '<h5>인사</h5>' +
						            '<div class="row g-3">' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">이름</label>' +
						                    '<input type="text" class="form-control" value="' + json.empName + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">사원번호</label>' +
						                    '<input type="text" class="form-control" value="' + json.empNo + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">상태</label>' +
						                    '<input type="text" class="form-control" value="' + json.empState + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">본사/지사</label>' +
						                    '<input type="text" class="form-control" value="' + json.officeName + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">부서</label>' +
						                    '<input type="text" class="form-control" value="' + json.deptName + '" readonly>' +
						                '</div>' +
						                
						                '<div class="col-md-6">' +
						                    '<label class="form-label">팀</label>' +
						                    '<input type="text" class="form-control" value="' + json.teamName + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">직급</label>' +
						                    '<input type="text" class="form-control" value="' + json.rankName + '" readonly>' +
						                '</div>' +
						                '<div class="col-md-6">' +
						                    '<label class="form-label">입사 일자</label>' +
						                    '<input type="text" class="form-control" value="' + json.startDate + '" readonly>' +
						                '</div>' +
						            '</div>' +
						        '</div>' +
						    '</div>'
						);
					
					$.ajax({
						url:'${pageContext.request.contextPath}/getEmpPersnal',
						method:'get',
						data: {empNo : ${empNo}},
						success:function(json){
							console.log(json);
							$('#content').append(
								    '<div class="mt-4">' +
								        '<h5>개인</h5>' +
								        '<div class="row g-3">' +
								            '<div class="col-md-4">' +
								                '<label class="form-label">개인 이메일</label>' +
								                '<input type="email" class="form-control" value="' + json.empEmail + '" readonly>' +
								            '</div>' +
								            '<div class="col-md-4">' +
								                '<label class="form-label">휴대폰 번호</label>' +
								                '<input type="tel" class="form-control" value="' + json.contact + '" readonly> ' +
								            '</div>' +
								            '<div class="col-md-4">' +
			                                    '<label class="form-label">주소</label>' +
			                                    '<textarea class="form-control" rows="3" readonly>' + json.address + '</textarea> ' +
		                                	'</div>' +
								        '</div>' +
								    '</div>' +
								    '<div class="text-center mt-4">' +
								        '<a href="${pageContext.request.contextPath}/modifyEmpHr?empNo=' + json.empNo +'" class="btn btn-danger">수정</a>' +
								    '</div>'
								);
						}
					});
				}
			});
			
			$("#empInfo").click(function(){
				$.ajax({
					url:'${pageContext.request.contextPath}/getEmpHr',
					method:'get',
					data: {empNo : ${empNo}},
					success:function(json){
						console.log(json);
						
						$('#content').empty();
						
						$('#content').append(
							    '<div class="row">' +
							        '<div class="col-md-4">' +
							            '<div class="profile-img mb-3">' +
							                '프로필사진' +
							            '</div>' +
							        '</div>' +
							        '<div class="col-md-8">' +
							            '<h5>인사</h5>' +
							            '<div class="row g-3">' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">이름</label>' +
							                    '<input type="text" class="form-control" value="' + json.empName + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">사원번호</label>' +
							                    '<input type="text" class="form-control" value="' + json.empNo + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">상태</label>' +
							                    '<input type="text" class="form-control" value="' + json.empState + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">본사/지사</label>' +
							                    '<input type="text" class="form-control" value="' + json.officeName + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">부서</label>' +
							                    '<input type="text" class="form-control" value="' + json.deptName + '" readonly>' +
							                '</div>' +
							                
							                '<div class="col-md-6">' +
							                    '<label class="form-label">팀</label>' +
							                    '<input type="text" class="form-control" value="' + json.teamName + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">직급</label>' +
							                    '<input type="text" class="form-control" value="' + json.startDate + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-6">' +
							                    '<label class="form-label">입사 일자</label>' +
							                    '<input type="text" class="form-control" value="' + json.startDate + '" readonly>' +
							                '</div>' +
							            '</div>' +
							        '</div>' +
							    '</div>'
							);
						
						$.ajax({
							url:'${pageContext.request.contextPath}/getEmpPersnal',
							method:'get',
							data: {empNo : ${empNo}},
							success:function(json){
								console.log(json);
								
								$('#content').append(
									    '<div class="mt-4">' +
									        '<h5>개인</h5>' +
									        '<div class="row g-3">' +
									            '<div class="col-md-4">' +
									                '<label class="form-label">개인 이메일</label>' +
									                '<input type="email" class="form-control" value="' + json.empEmail + '" readonly>' +
									            '</div>' +
									            '<div class="col-md-4">' +
									                '<label class="form-label">휴대폰 번호</label>' +
									                '<input type="tel" class="form-control" value="' + json.contact + '" readonly>' +
									            '</div>' +
									            '<div class="col-md-4">' +
				                                    '<label class="form-label">주소</label>' +
				                                    '<textarea class="form-control" rows="3" readonly>' + json.address + '</textarea> ' +
			                                	'</div>' +
									        '</div>' +
									    '</div>' +
									    '<div class="text-center mt-4">' +
									    '<a href="${pageContext.request.contextPath}/modifyEmpHr?emNo=' + json.empNo +'" class="btn btn-danger">수정</a>' + +
									    '</div>'
									);
							}
						});
					}
				});
			});
			
			$("#dayOffHistory").click(function(){
				$("#content").empty();
			});
			
			
		});
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>