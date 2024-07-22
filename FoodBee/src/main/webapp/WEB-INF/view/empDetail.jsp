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
                <h3>사원조회</h3>
                <div>
					<button type="button" id="empInfo">개인/인사 정보</button>
					<button type="button" id="dayOffHistory">휴가 내역</button>
				</div>
            </div>
            <div>
            	<h4 id="title">개인/인사 정보</h4>
        	</div>
        	<div id="year">
        		<select id="yearSelect" class="form-select"></select>
        	</div>
			<div id="content">
	           
            </div>
        </form>
    </div>

	<script>
		let currentPage = 1;
		let lastPage = 1;
	
		const currentYear = new Date().getFullYear();
		
		$(document).ready(function() {
			$('#year').hide();
			$.ajax({
				url:'${pageContext.request.contextPath}/getEmpHr',
				method:'get',
				data: {empNo : ${empNo}},
				success:function(json){
					console.log(json);
					empInfo(json);
				}
			});
			
			$('#empInfo').click(function(){
				$('#year').hide();
				$('#yearSelect').empty();
				$.ajax({
					url:'${pageContext.request.contextPath}/getEmpHr',
					method:'get',
					data: {empNo : ${empNo}},
					success:function(json){
						console.log(json);
						$('#content').empty();
						
						$("#title").text('개인/인사 정보');
						
						empInfo(json);
					}
				});
			});
			
			$('#dayOffHistory').click(function(){
				$('#title').text('휴가 내역');
				$('#year').show();
				yearSelect();
				dayOffHistoryList(1);
				
				
			});
			
			$('#yearSelect').change(function(){
				dayOffHistoryList(1);
			});
			
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
			    	
			        url: '${pageContext.request.contextPath}/getEmpHr',
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
					url:'${pageContext.request.contextPath}/getDayOffHistoryList',
					method:'post',
					data: {
						empNo: ${empNo},
						year: $('#yearSelect').val(),
						currentPage: page
					},
					success:function(json){
						console.log(json.lastPage);
						lastPage = json.lastPage;
						
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
							            '<h6 class="mb-3">연차 내역 조회</h6>' +
							            '<div class="table-responsive">' +
							                '<table class="table table-bordered">' +
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
					                '<div id="page">' +
					                	'<button type="button" id="first">First</button>' +
						                '<button type="button" id="pre">◁</button>' +
						                '<button type="button" id="next">▶</button>' +
						               '<button type="button" id="last">Last</button>' +
						        	'</div>' +
					            '</div>' +
					        '</div>');
							
						
						json.list.forEach(function(item){
							dayOffHistory(item);
		                });
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
				if(endDate == null){
					endDate = '';
				}
				
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
					                '<div class="col-md-6">' +
					                    '<label class="form-label">퇴사 일자</label>' +
					                    '<input type="text" class="form-control" value="' + endDate + '" readonly>' +
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
		                                    '<label class="form-label">우편번호</label>' +
		                                    '<input type="tel" class="form-control" value="' + json.postNo + '" readonly> ' +
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
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>