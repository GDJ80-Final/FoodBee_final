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
            width: 100%;
            height: auto;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #back{
    	width: 100px;
    	margin-bottom: 10px;
    	}
    </style>
</head>
<body>
	<div id="main-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>
		
		<jsp:include page="../sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
		  <div class="content-body">
		  		<div class="row page-titles mx-0">
			         <div class="col p-md-0">
			             <ol class="breadcrumb">
			                 <li class="breadcrumb-item"><a href="javascript:void(0)">사원</a></li>
			                 <li class="breadcrumb-item active"><a href="javascript:void(0)">사원 조회</a></li>
			                 <li class="breadcrumb-item active"><a href="javascript:void(0)">사원 상세보기</a></li>
			             </ol>
			         </div>
			   	</div>
		    	<div class="container-fluid">
	               <div class="row">
	                    <div class="col-lg-12">
	                        <div class="card">
	                            <div class="card-body">
	                            	<ul class="nav nav-tabs mb-3">
			                            <li class="nav-item"><a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false" id="empInfo">개인/인사 정보</a>
			                            </li>
			                            <li class="nav-item"><a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false" id="dayOffHistory">휴가 내역</a>
			                            </li>
			                        </ul>
			                        <a href="${pageContext.request.contextPath}/emp/empList" class="btn btn-primary btn-block" id="back">돌아가기</a>
	                            	<div class="row">
	                            		<div class="col"></div>
	                            		<div class="col-8">
									        <form>
									        	<div id="year" class="mt-5">
									        		<select id="yearSelect" class="form-select"></select>
									        	</div>
												<div id="content" class="mt-3">
										           
									            </div>
									        </form>
								        </div>
								        <div class="col"></div>
							        </div>
						        </div>
					        </div>
				        </div>
			        </div>
		    </div>
		 </div>
	</div>
 		<jsp:include page="../footer.jsp"></jsp:include>
	<script>
		let currentPage = 1;
		let lastPage = 1;
	
		const currentYear = new Date().getFullYear();
		
		// 팀 권한 코드
		let teamAuthCode;
		
		$(document).ready(function() {
			
			
			$('#year').hide();
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/getEmpHr',
				method:'get',
				data: {empNo : ${empNo}},
				success:function(json){
					console.log(json);
					empInfo(json);
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
			
			$('#empInfo').click(function(){
				$('#year').hide();
				$('#yearSelect').empty();
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/getEmpHr',
					method:'get',
					data: {empNo : ${empNo}},
					success:function(json){
						console.log(json);
						$('#content').empty();
						
						
						empInfo(json);
					}
				});
			});
			
			$('#dayOffHistory').click(function(){
				$('#year').show();
				yearSelect();
				dayOffHistoryList(1);
				
				
			});
			
			$('#yearSelect').change(function(){
				dayOffHistoryList(1);
			});
			
			//페이징 버튼 활성화
	        function updateBtnState() {
	            console.log("update");
	            $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
	            $('#next').closest('li').toggleClass('disabled', currentPage === lastPage);
	            $('#first').closest('li').toggleClass('disabled', currentPage === 1);
	            $('#last').closest('li').toggleClass('disabled', currentPage === lastPage);
	        }
			
			$(document).on('click', '#page button', function() {
		        const buttonId = $(this).attr('id');

		        
		        switch(buttonId) {
		            case 'first':
		                if (currentPage > 1) {
		                    currentPage = 1; 
		    				dayOffHistoryList(currentPage);
		                }
		                break;
		            case 'pre':
		                if (currentPage > 1) {
		                    currentPage = currentPage - 1;
		    				dayOffHistoryList(currentPage);
		                }
		                break;
		            case 'next':
		                if (currentPage < lastPage) {
		                    currentPage = currentPage + 1;
		                    dayOffHistoryList(currentPage);
		                }
		                break;
		            case 'last':
		                if (currentPage < lastPage) {
		                    currentPage = lastPage;
		                    dayOffHistoryList(currentPage);
		                }
		                break;
		        }
		    });
			
			
			function yearSelect() {
			    let startYear = 0;
			    $.ajax({
			    	
			        url: '${pageContext.request.contextPath}/emp/getEmpHr',
			        method: 'get',
			        data: { empNo: ${empNo} },
			        async: false,
			        success: function(json) {
			            console.log(json.startDate.substring(0, 4));
			            startYear = parseInt(json.startDate.substring(0, 4));
			            console.log(startYear);
			            
			            for (let year = startYear; year <= currentYear; year++) {
			            	$('#yearSelect').append($('<option>', {
			                    value: year,
			                    text: year
			                }));
			            }
			            
			            $('#yearSelect').val(currentYear);
			        }
			    });
			}

			function dayOffHistoryList(page){
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/getDayOffHistoryList',
					method:'post',
					data: {
						empNo: ${empNo},
						year: $('#yearSelect').val(),
						currentPage: page
					},
					success:function(json){
						console.log(json.lastPage);
						lastPage = json.lastPage;
						if(lastPage == 0){
							lastPage = 1;
						}
						
						$("#content").empty();
						
						$('#content').append('<div class="mt-4">' +
							    '<div class="row g-3">' +
							        '<div class="col-12 custom-border">' +
							            '<div class="row">' +
							                '<div class="col-md-4 mb-2">' +
							                    '<label class="form-label fw-bold">총연차</label>' +
							                    '<input type="text" class="form-control bg-light" id="totalDayOff" value="'+ json.dayOff + '" readonly>' +
							                '</div>' +
							                '<div class="col-md-4 mb-2">' +
							                    '<label class="form-label fw-bold">사용연차</label>' +
							                    '<input type="text" class="form-control bg-light" id="usedDayOff" value="'+ json.cnt + '"readonly>' +
							                '</div>' +
							                '<div class="col-md-4 mb-2">' +
							                    '<label class="form-label fw-bold">남은 연차</label>' +
							                    '<input type="text" class="form-control bg-light" id="remainingDayOff" value="'+ (json.dayOff - json.cnt) + '" readonly>' +
							                '</div>' +
							            '</div>' +
							        '</div>' +
							        '<div class="col-12">' +
							            '<div id="table-body" class="table-responsive">' +
							                '<table class="table header-border">' +
							                    '<thead>' +
							                        '<tr>' +
							                            '<th>사원번호</th>' +
							                            '<th>휴가일자</th>' +
							                            '<th>유형</th>' +
							                            '<th>상세</th>' +
							                        '</tr>' +
							                    '</thead>' +
							                    '<tbody id="dayOffList">' +
							                    
							                    '</tbody>' +
							                '</table>' +
						                '</div>' +
					                '</div>' +
									'<div class="bootstrap-pagination mt-3" id="page">' +
								        '<nav>' +
								             '<ul class="pagination justify-content-center">' +
								                '<li class="page-item"><button type="button" id="first" class="page-link">처음</button>' +
								                 '</li>' +
								                 '<li class="page-item"><button type="button" class="page-link" id="pre">이전</button>' +
								                 '</li>' +
								                 '<li class="page-item active"><div class="page-link" id="currentPage"></div>' +
								                 '</li>' +
								                 '<li class="page-item"><button type="button" class="page-link" id="next">다음</button>' +
								                 '</li>' +
								                 '<li class="page-item"><button type="button" class="page-link" id="last">마지막</button>' +
								                 '</li>' +
								             '</ul>' +
								         '</nav>' +
								     '</div>' +
					            '</div>' +
					        '</div>');
						
							
						
						if(json.list.length != 0){
							json.list.forEach(function(item){
								dayOffHistory(item);
			                });
							
						} else {
							$('#dayOffList').append('<tr>'+
                            '<td colspan="4" style="text-align:center;">사용한 휴가가 없습니다.</td>'+
                            '</tr>')
						}
						
						$('#currentPage').text(currentPage);
						
						updateBtnState();
					}
				
				});
			};
			
			function dayOffHistory(item){
				$('#dayOffList').append('<tr>' +
						'<td>' + item.empNo + '</td>' +
						'<td>' + item.startDate + ' ~ ' + item.endDate +'</td>' +
						'<td>' + item.typeName + '</td>' +
						'<td>' + item.content + '</td>' +
						'</tr>')
				
			};
			
			function empInfo(json){
				endDate = json.endDate;
				console.log(json.extNo);
				if(endDate == null){
					endDate = '';
				}
				
				$('#content').append(
					    '<div class="row">' +
					        '<div class="col-md-4">' +
					            '<div class="profile-img mt-5 mb-3">' +
					                '<img id="profileImg" src="${pageContext.request.contextPath}/upload/profile_img/' + json.originalFile +'" alt="프로필 사진" class="img-fluid rounded mb-3">' +
					            '</div>' +
					        '</div>' +
					        '<div class="col-md-8">' +
					            '<h4 class="fw-bold">인사</h4>' +
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
					                '<div class="col-md-6">' +
					                	(json.empState == '퇴직' ?
					                	    '<label class="form-label">퇴사 일자</label>' +
					                	    '<input type="text" class="form-control" value="' + endDate + '" readonly>'
					                		: ''
				                		) +
					                '</div>' +
						                '<div class="col-md-6">' +
					                    '<label class="form-label">내선 번호</label>' +
					                    '<input type="text" class="form-control" value="' + json.extNo + '" readonly>' +
					                '</div>' +
					            '</div>' +
					        '</div>' +
					    '</div>'
					);
				
				// 인사팀만 보이게
				if(teamAuthCode == 'G-1'){
					$.ajax({
						url:'${pageContext.request.contextPath}/emp/getEmpPersnal',
						method:'get',
						data: {empNo : ${empNo}},
						success:function(json){
							console.log(json);
							const addressArr = json.address.split("|");
							const address = addressArr[0];
							const addressDetail = addressArr[1];
							$('#content').append(
									'<div class="row">' +
									    '<div class="col-4 mt-4"></div>' +
									    '<div class="col-8 mt-4">' +
									        '<h5 class="fw-bold">개인</h5>' +
									        '<div class="row g-3">' +
										        '<div class="col-md-6">' +
										            '<label class="form-label">개인 이메일</label>' +
										            '<input type="email" class="form-control" id="empEmail" name="empEmail" value="' + json.empEmail + '" readonly>' +
										        '</div>' +
										        '<div class="col-md-6">' +
										            '<label class="form-label">휴대폰 번호</label>' +
										            '<input type="tel" class="form-control" id="contact" name="contact" value="' + json.contact + '" readonly>' +
										        '</div>' +
										    '</div>' +
										    '<div class="mt-3">' +
										        '<div class="row mb-3">' +
										            '<div class="col-md-6">' +
										                '<label for="postNo" class="form-label">우편번호</label>' +
										                '<input type="number" class="form-control" id="postNo" name="postNo" placeholder="우편번호" readonly value="' + json.postNo + '">' +
										            '</div>' +
										        '</div>' +
										        '<div class="mb-3">' +
										            '<label for="address" class="form-label">주소</label>' +
										            '<input type="text" class="form-control" name="address" id="address" placeholder="주소" readonly value="' + address + '">' +
										        '</div>' +
										        '<div class="mb-3">' +
										            '<label for="addressDetail" class="form-label">상세주소</label>' +
										            '<input type="text" class="form-control" name="addressDetail" id="addressDetail" placeholder="상세주소" readonly value="' + addressDetail + '">' +
										        '</div>' +
										    '</div>' +
									    '</div>' +
								    '<div>' +
								    '<div class="text-center mt-4">' +
								        '<a href="${pageContext.request.contextPath}/emp/modifyEmpHr?empNo=' + json.empNo +'" class="btn btn-danger">수정</a>' +
								    '</div>'
							    
								);
						}
					});
				}
			}
			
		});
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>