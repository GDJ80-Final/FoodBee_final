<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
        
        canvas {
            border: 1px solid black;
        }
    </style>
</head>
<body>
    <div class="container form-container">
        <form>
            <div class="mb-4">
                <h3>마이페이지</h3>
                <div>
					<button type="button" id="empInfo">개인/인사 정보</button>
					<button type="button" id="changePw">비밀번호 변경</button>
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
    
    <!-- 프로필 사진 변경 모달 -->
    <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title naver-green" id="profileModalLabel">프로필 사진 업데이트</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <img id="profileImage" src="" alt="프로필 사진" class="img-fluid rounded mb-3" style="max-width: 200px; max-height: 200px;">
                    <div class="d-grid gap-2">
                        <button id="changeImageBtn" class="btn btn-outline-naver">이미지 변경</button>
                        <input type="file" id="fileInput" accept=".jpg,.png" style="display: none;">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button id="updateProfileBtn" class="btn btn-naver" style="display:none;">프로필 수정</button>
                </div>
            </div>
        </div>
    </div>
    
    <!--  전자 서명 모달 -->
    <div class="modal fade" id="signModal" tabindex="-1" aria-labelledby="signModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="signModalLabel">전자 서명</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="existingSignContainer">
                        <h6>기존 서명:</h6>
                        <img id="existingSign" src="" alt="기존 서명" style="display: none;">
                    </div>
                    <h6>새 서명:</h6>
                    <canvas id="signCanvas" width="400" height="200"></canvas>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button id="clearBtn" type="button" class="btn btn-warning">지우기</button>
                    <button id="saveBtn" type="button" class="btn btn-primary">저장</button>
                </div>
            </div>
        </div>
    </div>

	<script>
		//휴가 내역 페이징
		let currentPage = 1;
		let lastPage = 1;
		
		//휴가 내역 현재년도
		const currentYear = new Date().getFullYear();
		$(document).ready(function() {
			
			// 프로필 사진
		 	let originalSrc;
			//새 사진이 선택됐는지 여부
	        let newImageSelected = false;
	        
			$('#year').hide();
			const empNo = '${emp.empNo}';
			let approvalSign;
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/getEmpHr',
				method:'get',
				data: {empNo : empNo},
				success:function(json){
					console.log(json);
					
					console.log(json.originalFile);
					
					empInfo(json);
				}
			});
			
			// 개인/인사정보 탭 클릭시
			$("#empInfo").click(function(){
				$('#year').hide();
				$('#yearSelect').empty();
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/getEmpHr',
					method:'get',
					data: {empNo : empNo},
					success:function(json){
						console.log(json);
						$('#content').empty();
						
						$("#title").text('개인/인사 정보');
						
						empInfo(json);
					}
				});
			});
			
			// 비밀번호 변경
			$("#changePw").click(function(){
				$('#year').hide();
				$('#yearSelect').empty();
				
				$("#content").empty();
				
				$("#title").text('비밀번호 변경');
				
				$('#content').append(
					'<form method="post" action="${pageContext.request.contextPath}/myPage/modifyEmpPwMyPage">' +
					    '<div">' +
					        '<div class="mb-3">' +
					            '<label for="oldPw" class="form-label">현재 비밀번호</label>' +
					            '<input type="password" name="oldPw" id="oldPw" class="form-control">' +
					            '<div id="oldPwError" class="error-message text-danger">${empPwErrorMsg}</div>' +
					        '</div>' +
					        '<div class="mb-3">' +
					            '<label for="newPw" class="form-label">새 비밀번호</label>' +
					            '<input type="password" name="newPw" id="newPw" class="form-control">' +
					            '<div id="newPwError" class="error-message text-danger">${empPwErrorMsg}</div>' +
					        '</div>' +
					        '<div class="mb-3">' +
					            '<label for="confirmedNewPw" class="form-label">새 비밀번호 확인</label>' +
					            '<input type="password" name="confirmedEmpPw" id="confirmedNewPw" class="form-control">' +
					            '<div id="confirmedNewPwError" class="error-message text-danger"></div>' +
					        '</div>' +
					        '<div">' +
					            '<button type="button" id="modifyPwBtn" class="btn btn-primary">변경</button>' +
					        '</div>' +
					    '</div>' +
					'</form>'
				);
			});
			
			// 휴가내역 탭 클릭시
			$("#dayOffHistory").click(function(){
				$("#title").text('휴가 내역');
				$('#year').show();
				yearSelect();
				dayOffHistoryList(1);

			});
			
			// 휴가내역 년도 바뀔시
			$('#yearSelect').change(function(){
				dayOffHistoryList(1);
			});
			
			// 프로필 사진 변경 버튼 누를시
			$('#changeImageBtn').on('click', function() {
                $('#fileInput').click();
            });
			
			// 프로필 사진에 파일이 들어왔을때
			$('#fileInput').on('change', function(e) {
	                let file = e.target.files[0];
	                if (file) {
	                    let reader = new FileReader();
	                    reader.onload = function(e) {
	                        $('#profileImage').attr('src', e.target.result);
	                        newImageSelected = true;
	                        $('#updateProfileBtn').show();
	                    }
	                    reader.readAsDataURL(file);
	                }
	            });
			 
			// 모달이 꺼졌을때
			 $('#profileModal').on('hidden.bs.modal', function () {
	                $('#profileImage').attr('src', originalSrc);
	                $('#updateProfileBtn').hide();
	                $('#fileInput').val('');
	                newImageSelected = false;
	         });
			 
			// 프로필 사진 수정 버튼 클릭시
			 $('#updateProfileBtn').on('click', function() {
				 
	                if (newImageSelected) {
	                    let formData = new FormData();
	                    formData.append('file', $('#fileInput')[0].files[0]);
	                    formData.append('empNo', empNo);

	                    $.ajax({
	                        url: '${pageContext.request.contextPath}/myPage/modifyProfileImg',
	                        type: 'POST',
	                        data: formData,
	                        processData: false,
	                        contentType: false,
	                        success: function(json) {
	                            alert('프로필 사진이 성공적으로 업데이트되었습니다.');
	                            originalSrc = json;
	                            $('#profileImage').attr('src', '${pageContext.request.contextPath}/upload/profile_img/' +originalSrc);
	                            newImageSelected = false;
	                            $('#updateProfileBtn').hide();
	                            $('#profileModal').modal('hide');
	                        },
	                        error: function() {
	                            alert('프로필 사진 업데이트에 실패했습니다.');
	                        }
	                    });
	                }
	            });
			
			// 페이징 버튼
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
			
			// 전자 서명
			const $canvas = $('#signCanvas');
            const ctx = $canvas[0].getContext('2d');
            let isDrawing = false;
            
            $canvas.on({
                'mousedown touchstart': startDrawing,
                'mousemove touchmove': draw,
                'mouseup mouseout touchend': stopDrawing
            });

            $('#saveBtn').click(saveSign);
            $('#clearBtn').click(clearCanvas);

            $('#signModal').on('show.bs.modal', function () {
                loadExistingSign();
            });

            function startDrawing(e) {
                isDrawing = true;
                draw(e);
            }

            function draw(e) {
                if (!isDrawing) return;

                e.preventDefault();
                const offset = $canvas.offset();
                const x = (e.type === 'touchmove') ? e.touches[0].pageX - offset.left : e.pageX - offset.left;
                const y = (e.type === 'touchmove') ? e.touches[0].pageY - offset.top : e.pageY - offset.top;

                ctx.lineWidth = 2;
                ctx.lineCap = 'round';
                ctx.strokeStyle = 'black';

                ctx.lineTo(x, y);
                ctx.stroke();
                ctx.beginPath();
                ctx.moveTo(x, y);
            }

            function stopDrawing() {
                isDrawing = false;
                ctx.beginPath();
            }

            function validateSignature(canvas) {
                const ctx = canvas.getContext('2d');
                const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
                const data = imageData.data;
                let pixelCount = 0;
                let minX = canvas.width, minY = canvas.height, maxX = 0, maxY = 0;

                // 픽셀 수 및 서명 영역 계산
                for (let i = 0; i < data.length; i += 4) {
                    if (data[i] < 255 || data[i + 1] < 255 || data[i + 2] < 255) {
                        pixelCount++;
                        const x = (i / 4) % canvas.width;
                        const y = Math.floor((i / 4) / canvas.width);
                        minX = Math.min(minX, x);
                        minY = Math.min(minY, y);
                        maxX = Math.max(maxX, x);
                        maxY = Math.max(maxY, y);
                    }
                }

                const signatureWidth = maxX - minX;
                const signatureHeight = maxY - minY;
                const signatureArea = signatureWidth * signatureHeight;
                const canvasArea = canvas.width * canvas.height;

                // 검증 조건
                const minPixelCount = 1000; // 최소 픽셀 수
                const minAreaRatio = 0.05; // 최소 영역 비율 (5%)

                if (pixelCount < minPixelCount) {
                    return { valid: false, message: "서명이 너무 짧거나 단순합니다." };
                }

                if ((signatureArea / canvasArea) < minAreaRatio) {
                    return { valid: false, message: "서명이 너무 작습니다." };
                }

                return { valid: true, message: "유효한 서명입니다." };
            }

            function saveSign() {
                const result = validateSignature($canvas[0]);
                if (!result.valid) {
                    alert(result.message);
                    return;
                }

                const dataURL = $canvas[0].toDataURL('image/png');
                
                // 서버에 서명 저장
                $.ajax({
                    url: '${pageContext.request.contextPath}/myPage/saveApprovalSign',
                    method: 'POST',
                    data: { 
                    		empNo: empNo,
                    		url: dataURL 
                	},
                    success: function(json) {
                        alert('서명이 성공적으로 저장되었습니다.');
                        $('#existingSign').attr('src', dataURL).show();
                        approvalSign = json;
                        clearCanvas();
                    },
                    error: function(xhr, status, error) {
                        alert('서명 저장에 실패했습니다: ' + error);
                    }
                });
            }

            function clearCanvas() {
                ctx.clearRect(0, 0, $canvas[0].width, $canvas[0].height);
                ctx.beginPath();
            }

            function loadExistingSign() {
                if (approvalSign) {
                    $('#existingSign').attr('src', approvalSign).show();
                } else {
                    $('#existingSign').hide();
                }
            }
			
			// 휴가 내역 틀
			function dayOffHistoryList(page){
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/getDayOffHistoryList',
					method:'post',
					data: {
						empNo: empNo,
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
			
			
			//휴가 내역 리스트
			function dayOffHistory(item){
				$('#dayOffList').append('<tr>' +
						'<td>' + item.empNo + '</td>' +
						'<td>' + item.startDate + ' ~ ' + item.endDate +'</td>' +
						'<td>' + item.typeName + '</td>' +
						'<td>' + item.content + '</td>' +
						'</tr>')
				
			};
			
			// 휴가 내역 년도 셀렉트 생성
			function yearSelect() {
			    let startYear = 0;
			    $.ajax({
			        url: '${pageContext.request.contextPath}/emp/getEmpHr',
			        method: 'get',
			        data: { empNo: empNo },
			        async: false,
			        success: function(json) {
			            console.log(json.startDate.substring(0, 4));
			            startYear = parseInt(json.startDate.substring(0, 4));
			            console.log(startYear);
			            
			            const currentYear = new Date().getFullYear();
			            
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
			
			// 비밀번호 변경
			$("#content").on("click", "#modifyPwBtn", function() {
				validateOldPw();
				validateNewPw();
	       		validateConfirmedNewPw();
       			
	       		if ($('.error-message').text() == "") {
		       		$.ajax({
						url:'${pageContext.request.contextPath}/myPage/modifyEmpPw',
						method:'post',
						data: {
							empNo : empNo,
							oldPw : $('#oldPw').val(),
							newPw : $('#newPw').val()
						},
						success:function(json){
							window.location.href = "${pageContext.request.contextPath}/myPage";
						},
						error: function(xhr, status, error) {
					        alert("비밀번호를 확인해주세요");
					    }
	       			});
	       		}
			});
			
			//주소검색 버튼 클릭 시 다음주소api 팝업 호출
	        $(document).on('click', '#selectAddr', function() {
	               new daum.Postcode({
	                   oncomplete: function(data) {
	                       // 각 주소의 노출 규칙에 따라 주소를 조합
	                       
	                       let addr; // 주소 변수
	                       // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴 
	                       if (data.userSelectedType === 'R') { 
	                    	   // 사용자가 도로명 주소를 선택했을 경우
	                           addr = data.roadAddress;
	                       } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                           addr = data.jibunAddress;
	                       }

	                       // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                       $('#postNo').val(data.zonecode);
	                       $('#address').val(addr);
	                       // 커서를 상세주소 필드로 이동한다.
	                       $('#addressDetail').focus();
	                   }
	               }).open();
	        });
			
			//비밀번호 공백검사 
			function validateOldPw() {
				const empPw = $('#oldPw').val().trim();
			    if (empPw === "") {
			        $('#oldPwError').text("현재 비밀번호를 입력해주세요.");
			    }else{
			 	   $('#oldPwError').text("");
			    }
			}
			
			function validateNewPw() {
			    const empPw = $('#newPw').val().trim();
			    //비번 정규식 - 대소문자, 특수문자 포함 8-16자 
			    const passwordPattern = 
			 	   /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
			    //.trim() 입력값 양쪽 공백 제거 
			    if (empPw === "") {
			        $('#newPwError').text("새 비밀번호를 입력해주세요.");
			    } else if (!passwordPattern.test(empPw)) {
			        $('#newPwError').text("비밀번호는 8자 이상 16자 이하의 대소문자, 숫자 및 특수문자를 포함해야 합니다.");
			    }else{
			 	   $('#newPwError').text("");
			    }
			}
			
			function validateConfirmedNewPw() {
			    const empPw = $('#newPw').val().trim();
			    const confirmedEmpPw = $('#confirmedNewPw').val().trim();
			    if (confirmedEmpPw === "") {
			        $('#confirmedNewPwError').text("비밀번호 확인을 입력해주세요.");
			    } else if (empPw !== confirmedEmpPw) {
			        $('#confirmedNewPwError').text("비밀번호가 일치하지 않습니다.");
			    } else {
			        $('#confirmedNewPwError').text("");
			    }
			}
           	
			// 사원정보 가져오기
			function empInfo(json){
				endDate = json.endDate;
				console.log(json.approvalSignFile);
				approvalSign = json.approvalSignFile;
				$('#profileImage').attr('src', '${pageContext.request.contextPath}/upload/profile_img/' +json.originalFile);
				originalSrc = $('#profileImage').attr('src');
				console.log(json.originalFile);
				if(endDate == null){
					endDate = '';
				}
				
				// 인사정보
				$('#content').append(
					    '<div class="row">' +
					        '<div class="col-md-4">' +
					            '<div class="profile-img mb-3">' +
					                '<img id="profileImg" src="${pageContext.request.contextPath}/upload/profile_img/' + json.originalFile +'" alt="프로필 사진" class="img-fluid rounded mb-3">' +
					            '</div>' +
					            '<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal">' +
					                '프로필 사진 업데이트' +
					            '</button>' +
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
					                '<div class="col-md-6">' +
						                '<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signModal">' +
							                '전자 서명 수정' +
							            '</button>' +
					                '</div>' +
					            '</div>' +
					        '</div>' +
					    '</div>'
					);
				
				// 개인정보
				$.ajax({
					url:'${pageContext.request.contextPath}/emp/getEmpPersnal',
					method:'get',
					data: {empNo : empNo},
					success:function(json){
						console.log(json);
						const addressArr = json.address.split("|");
						const address = addressArr[0];
						const addressDetail = addressArr[1];
						console.log(addressDetail)
						$('#content').append(
								'<div class="mt-4">' +
								    '<h5>개인</h5>' +
								    '<form id="EmpPersnalForm">' +
								        '<div class="row g-3">' +
								            '<div class="col-md-6">' +
								                '<label class="form-label">개인 이메일</label>' +
								                '<input type="email" class="form-control" id="empEmail" name="empEmail" value="' + json.empEmail + '">' +
								                '<div id="empEmailError" class="error-message"></div>' +
							                '</div>' +
								            '<div class="col-md-6">' +
								                '<label class="form-label">휴대폰 번호</label>' +
								                '<input type="tel" class="form-control" id="contact" name="contact" value="' + json.contact + '">' +
								                '<div id="contactError" class="error-message"></div>' +
							                '</div>' +
								        '</div>' +
								        '<div class="mt-3">' +
								            '<div class="row mb-3">' +
								                '<div class="col-md-9">' +
								                    '<label for="postNo" class="form-label">우편번호</label>' +
								                    '<input type="number" class="form-control" id="postNo" name="postNo" id="postNo" placeholder="우편번호" readonly value="' + json.postNo + '">' +
								                    '<div id="postNoError" class="error-message"></div>' +
								                '</div>' +
								                '<div class="col-md-3 d-flex align-items-end">' +
								                    '<button type="button" id="selectAddr" class="btn btn-secondary">주소검색</button>' +
								                '</div>' +
								            '</div>' +
								            '<div class="mb-3">' +
								                '<label for="address" class="form-label">주소</label>' +
								                '<input type="text" class="form-control" name="address" id="address" placeholder="주소" readonly value="' + address + '">' +
								                '<div id="addressError" class="error-message"></div>' +
								            '</div>' +
								            '<div class="mb-3">' +
								                '<label for="addressDetail" class="form-label">상세주소</label>' +
								                '<input type="text" class="form-control" name="addressDetail" id="addressDetail" placeholder="상세주소를 입력해주세요" value="' + addressDetail + '">' +
								                '<div id="addressDetailError" class="error-message"></div>' +
								            '</div>' +
								        '</div>' +
								        '<button type="submit" id="modifyBtn" class="btn btn-danger">수정</button>' +
								    '</form>' +
								'</div>'
							);
					}
				});
			}
			
			$(document).on('click', '#modifyBtn', function(e) {
			    e.preventDefault();
			    
			    validateEmail()
			    validateContact();
			    validatePostNo()
			    validateAddress()
			    validateAddrDetail()
			    
			    let formData = $('#EmpPersnalForm').serialize();
			    formData += '&empNo=' + empNo;
			    if ($('.error-message').text() == "") {
			        $.ajax({
			            url: '${pageContext.request.contextPath}/myPage/modifyEmpPersnal',
			            type: 'POST',
			            data: formData,
			            success: function(json) {
			                    alert('개인정보가 수정되었습니다.');
			            },
			            error: function(xhr, status, error) {
			                alert('개인정보 수정에 실패했습니다');
			            }
			        });
			    }
		    });
			
			//유효성 검사
			function validateEmail() {
			    const email = $('#empEmail').val().trim();
			    // 이메일 정규식 확인
			    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			    
			    if (email === "") {
			        $('#empEmailError').text("이메일을 입력해주세요.");
			    } else if (!emailPattern.test(email)) {
			        $('#empEmailError').text("이메일 형식이 올바르지 않습니다.");
			    } else {
			        $('#empEmailError').text("");
			    }
			}
			function validateContact() {
	            const contact = $('#contact').val().trim();
	            //전화번호 정규식 확인 
	            const contactPattern = /^\d{3}-\d{4}-\d{4}$/;
	            if (contact === "") {
	                $('#contactError').text("연락처를 입력해주세요.");
	            } else if (!contactPattern.test(contact)) {
	                $('#contactError').text("연락처 형식이 올바르지 않습니다.");
	            } else {
	                $('#contactError').text("");
	            }
           	}
			function validatePostNo() {
			    const postNo = $('#postNo').val().trim();
			    if (postNo === "") {
			        $('#postNoError').text("우편번호를 입력해주세요.");
			    } else {
			        $('#postNoError').text("");
			    }
			}

			function validateAddress() {
			    const address = $('#address').val().trim();
			    if (address === "") {
			        $('#addressError').text("주소를 입력해주세요.");
			    } else {
			        $('#addressError').text("");
			    }
			}
           	function validateAddrDetail() {
	            const addressDetail = $('#addressDetail').val().trim();
	            
	            if (addressDetail === "") {
	                $('#addressDetailError').text("상세주소를 입력해주세요.");
	            } else {
	                $('#addressDetailError').text("");
	            }
           	}
		});
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>