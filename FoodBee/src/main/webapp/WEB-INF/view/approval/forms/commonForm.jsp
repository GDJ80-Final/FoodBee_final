<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <div class="common-section">
        <table>
            <tr>
                <th colspan="2">기안서</th>
                <th>기안자</th>
                <th>중간결재자</th>
                <th>최종결재자</th>
            </tr>
            <tr>
                <td colspan="2">결재자</td>
                                  
                <td>
                <input type="hidden" name="drafterEmpNo" id="drafterEmpNo" value="" >
                <input type="text" name="drafterEmpNoField" id="drafterEmpNoField" value="" readonly>
                </td>
                <td id="midApprover">
                <input type="hidden" name="midApproverNo" id="midApproverNo" value="" >
                <input type="text" name="midApproverNoField" id="midApproverNoField" value="" readonly>
                <button type="button" id="midApproverBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색
                </button>
                <div class="error" id="midApproverError"></div>
                </td>
                <td id="finalApprover">
                 <input type="hidden" name="finalApproverNo" id="finalApproverNo" value="">
                 <input type="text" name="finalApproverNoField" id="finalApproverNoField" value="" readonly>
                <button type="button"  id="finalApproverBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색
                </button>
                <div class="error" id="finalApproverError"></div>
                </td>
            </tr>
            <tr class="sign">
                <td colspan="2">결재</td>
                                  
                <td id="drafterSign"></td>
                <td id="midApproverSign"></td>
                <td id="finalApproverSign"></td>
            </tr>
            <tr>
                <td>수신참조자</td>
                <td colspan="4">
                
                <input type="text" id="referrerField" style="width:80%;" name="referrerEmpName" readonly>
                <input type="hidden" name="referrerEmpNo" id="referrerEmpNo" readonly>
                <button type="button"  id="referrer" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button>
                <button type="button"  id="reset" class="btn btn-secondary">초기화</button>
                </td>
            </tr>
        </table>
        <div class="form-section">
            <div class="form-group">
                <label for="name">성명:</label>
                <input type="text" id="name" readonly>
                <label for="department" style="margin-left: 10px;">부서:</label>
                <input type="text" id="department" readonly>
            </div>
         </div>
    </div>
   
	
 <script>
	$(document).ready(function(){
		/* 블러시 공백 검사 */
	            // drafterEmpNoField 블러 이벤트
            $('#drafterEmpNoField').blur(function() {
                let value = $(this).val().trim();
                if (value === '') {
                    $('#drafterError').text('기안자를 선택해 주세요.');
                } else {
                    $('#drafterError').text('');
                }
            });

            // midApproverNoField 블러 이벤트
            $('#midApproverNoField').blur(function() {
                let value = $(this).val().trim();
                if (value === '') {
                    $('#midApproverError').text('중간결재자를 선택해 주세요.');
                } else {
                    $('#midApproverError').text('');
                }
            });

            // finalApproverNoField 블러 이벤트
            $('#finalApproverNoField').blur(function() {
                let value = $(this).val().trim();
                if (value === '') {
                    $('#finalApproverError').text('최종결재자를 선택해 주세요.');
                } else {
                    $('#finalApproverError').text('');
                }
            });

            

            // 제출 버튼 클릭 시 전체 유효성 검사
            $('#submitBtn').click(function(e) {
                e.preventDefault();

                let isValid = true;

                // drafterEmpNoField 유효성 검사
                let drafterValue = $('#drafterEmpNoField').val().trim();
                if (drafterValue === '') {
                    $('#drafterError').text('기안자를 선택해 주세요.');
                    isValid = false;
                } else {
                    $('#drafterError').text('');
                }

                // midApproverNoField 유효성 검사
                let midApproverValue = $('#midApproverNoField').val().trim();
                if (midApproverValue === '') {
                    $('#midApproverError').text('중간결재자를 선택해 주세요.');
                    isValid = false;
                } else {
                    $('#midApproverError').text('');
                }

                // finalApproverNoField 유효성 검사
                let finalApproverValue = $('#finalApproverNoField').val().trim();
                if (finalApproverValue === '') {
                    $('#finalApproverError').text('최종결재자를 선택해 주세요.');
                    isValid = false;
                } else {
                    $('#finalApproverError').text('');
                }

            });
            
            $('#returnBox').click(function() {
            	window.location.href = "${pageContext.request.contextPath}/approval/draftBox";
            });
			
            // 초기화 버튼 클릭 시 수신자 필드 초기화
            $('#reset').click(function() {
                $('#referrerField').val('');
                $('#referrerEmpNo').val('');
            });
		
<!-- 사원선택 -->

		let currentPage = 1;
		let lastPage = 1;
	
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
						'<td><button type="button" id="selectEmp" class="selectEmp btn btn-primary" value="' + item.empNo + '" data-name="' + item.empName + '">선택</button></td>' +
						'</tr>');
				}
			
			// 중간결재자 / 최종결재자 분기 
			let action = '';
			$('#midApproverBtn').click(function(){
				action = 'mid';
			});
			$('#finalApproverBtn').click(function(){
				action = 'final';
			});
			$('#referrer').click(function(){
				action = 'referrer';
			});
			
			
			
			//모달에서 사원 선택 
			$(document).on('click', '#selectEmp', function() {
				let empNo = $(this).val();
			    let empName = $(this).data('name');
			    let selectedEmp = empName + '(' + empNo + ')';
			    // 중간결재자, 최종결재자,수신참조자 중복 검사 -> 같은 사원번호는 들어가면 안됨 .
			    
                let midApproverNo = $('#midApproverNo').val();
                let finalApproverNo = $('#finalApproverNo').val();
                let referrerNo = $('#referrerEmpNo').val();
                
                
                console.log(midApproverNo);
				console.log(empNo);
				console.log(empName);
			    // 선택한 사원의 정보를 필요한 곳에 출력
			    console.log(action);
			    
			    
			    if(action === 'mid'){
			    	if (empNo === finalApproverNo) {
			            alert('중간결재자는 최종결재자와 동일할 수 없습니다.');
			        } else if (referrerNo.split(',').includes(empNo)) {
			            alert('중간결재자는 수신참조자와 동일할 수 없습니다.');
			        } else {
			            $('#midApproverNo').val(empNo);
			            $('#midApproverNoField').val(selectedEmp);
			        }
			 
			    }else if(action === 'final'){
			    	if (empNo === midApproverNo) {
			            alert('최종결재자는 중간결재자와 동일할 수 없습니다.');
			        } else if (referrerNo.split(',').includes(empNo)) {
			            alert('최종결재자는 수신참조자와 동일할 수 없습니다.');
			        } else {
			            $('#finalApproverNo').val(empNo);
			            $('#finalApproverNoField').val(selectedEmp);
			        }
			    }else if(action === 'referrer'){
			 
			       
				    let referrerField = $('#referrerField');
				    let referrerFieldVal = referrerField.val();
				    let referrer = $('#referrerEmpNo');
				    let referrerVal = referrer.val();
				    let newReferrerFieldVal;
				    let newReferrerVal;
				    let empNosArray = [];

				    console.log(empNo);
				    
			        // 중복 검사
			        if (empNo === midApproverNo || empNo === finalApproverNo) {
			            alert('수신참조자는 중간결재자나 최종결재자와 동일할 수 없습니다.');
			            return;
			        }

				    // 현재 recipient 필드 값 가져오기 및 배열로 변환
				    if (referrerVal) {
				        empNosArray = referrerVal.split(','); // 사원 번호 배열로 변환
				        console.log('empNosArray => ' + empNosArray);

				        // 중복된 사번이 있으면
				        if (empNosArray.includes(empNo)) {
				            alert('이미 추가된 사원입니다.');
				            return;
				        } else {
				        	newReferrerVal = referrerVal + ',' + empNo; // 중복이 아니면 추가
				        }
				    } else {
				    	newReferrerVal = empNo; // 처음 추가할 때
				    }

				    // 사원 이름(empName(empNo))을 recipientField에 추가
				    if (referrerFieldVal) {
				    	newReferrerFieldVal = referrerFieldVal + ', ' + empName + '(' + empNo + ')'; // 기존 값에 추가
				    } else {
				    	newReferrerFieldVal = empName + '(' + empNo + ')'; // 처음 추가할 때
				    }

				    // 필드 값 업데이트
				    referrerField.val(newReferrerFieldVal);
				    referrer.val(newReferrerVal);

				   
			    };
			    // 모달 닫기
			    $('#staticBackdrop').modal('hide');
		    });
			
			 function checkDuplicatesEmpNo() {
	                // 값 받아오기
	                let drafterNo = $('#drafterEmpNo').val();
	                let midApproverNo = $('#midApproverNo').val();
	                let finalApproverNo = $('#finalApproverNo').val();
	                let referrerNo = $('#referrerEmpNo').val();
	                console.log(drafterNo);
	                console.log(midApproverNo);

	                // 이전 에러 메세지가 있다면 초기화 
	                $('.error').text('');

	                // 중복값이 있다면 검사
	                if (midApproverNo === drafterNo) {
	                    alert('중간결재자는 기안자와 동일할 수 없습니다.');
	             }
	                if (finalApproverNo === drafterNo) {
	                	alert('최종결재자는 기안자와 동일할 수 없습니다.');
	                }
	                if (finalApproverNo === midApproverNo) {
	                	alert('최종결재자는 중간결재자와 동일할 수 없습니다.');
	                }
	                if (referrerNo === drafterNo || referrerNo === midApproverNo || referrerNo === finalApproverNo) {
	                    $('#referrerField').siblings('.error').text('수신참조자는 기안자, 중간결재자, 최종결재자와 동일할 수 없습니다.');
	                }
	            }

	        // 중간결재자, 최종결재자,수신참조자 중복 값 안들어가게 분기
	       $('#drafterEmpNo, #midApproverNo, #finalApproverNo, #referrerEmpNo').on('input', checkDuplicatesEmpNo);

			
			
			
			
		});
    
    
    
    </script>