<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        
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
        .common-section .search-btn {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
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
        .form-group textarea {
            height: 100px;
            resize: none;
        }
        .sign td {
       		height : 130px;
        
        }
    </style>
</head>
    <div class="common-section">
        <table>
            <tr>
                <th colspan="2">기안서</th>
                <th>기안자</th>
                <th>중간결재자</th>
                <th>최종결재자</th>
            </tr>
            <tr>
                <td colspan="2">결재</td>
                                  
                <td id="drafter">기안자 이름(사번)</td>
                <td id="midApprover"><button type="button" id="midApprover" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button></td>
                <td id="finalApprover"><button type="button"  id="finalApprover" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button></td>
            </tr>
            <tr class="sign">
                <td colspan="2">결재</td>
                                  
                <td id="drafterSign">기안자 sign </td>
                <td id="midApproverSign">mid approver sign</td>
                <td id="finalApproverSign">final approver sign</td>
            </tr>
            <tr>
                <td>수신참조자</td>
                <td colspan="4" id="referrerField"><button type="button"  id="referrer" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button></td>
            </tr>
        </table>
        <div class="form-section">
            <div class="form-group">
                <label for="name">성명:</label>
                <input type="text" id="name" name="name">
                <label for="department" style="margin-left: 10px;">부서:</label>
                <input type="text" id="department" name="department">
            </div>
         </div>
    </div>
<!-- 모달 -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">사원검색</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
			  <form>
				<div>
					본사/지사
					<select id="office">
						<option value="">---본사/지사 선택---</option>
					</select>
					부서
					<select id="dept">
						<option value="">---부서 선택---</option>
					</select>
					팀
					<select id="team">
						<option value="">---팀 선택---</option>
					</select>
					직급 
					<select id="rankName" name="rankName">
						<option value="">---직급 선택---
						<option value="사원">사원
						<option value="대리">대리
						<option value="팀장">팀장
						<option value="부서장">부서장
						<option value="지서장">지사장
						<option value="CEO">CEO
					</select>
				</div>
				<div>
					사원 번호
					<input type="number" id="empNo" name="empNo">
					
					<button id="searchBtn" type="button">검색</button>
				</div>
			</form>
		    <table class="table" id="empList">
		        
		            <tr>
		                <th>본사/지사</th>
						<th>부서</th>
						<th>팀</th>
						<th>직급</th>
						<th>사원번호</th>
						<th>사원명</th>
		                <th>선택</th>
		            </tr>
		        
		   </table>
		   <div id="page">
		        <button type="button" id="first">First</button>
		        <button type="button" id="pre">◁</button>
		        <button type="button" id="next">▶</button>
		        <button type="button" id="last">Last</button>
		   </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
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
				getLastPage();
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
			
			// 중간결재자 / 최종결재자 분기 
			let action = '';
			$('#midApprover').click(function(){
				action = 'mid';
			});
			$('#finalApprover').click(function(){
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

			    // 선택한 사원의 정보를 필요한 곳에 출력
			    console.log(action);
			    if(action === 'mid'){
			    	 $('#midApprover').text(selectedEmp);
			    }else if(action === 'final'){
			    	 $('#finalApprover').text(selectedEmp);
			    }else if(action === 'referrer'){
			 
				    let referrerField = $('#referrerField');
				    let currentVal = referrerField.val();
				    let newVal;
				    let empNosArray = [];
				    
				    console.log(empNo);
				    
				    if (currentVal) {
				        empNosArray = currentVal.split(',').map(emp => emp.split('(')[1].split(')')[0]); 
				        // 사원번호 배열로 변환
				        console.log('empNosArray => ' + empNosArray);
				        
				        // 중복된 사번이 있으면
				        if (empNosArray.includes(empNo)) {
				            alert('이미 추가된 사원입니다.');
				            return;
				        } else {
				            newVal = currentVal + ',' + empName + '(' + empNo + ')'; // 중복이 아니면 추가
				        }
				        
				    } else {
				        newVal = empName + '(' + empNo + ')'; // 처음 추가할 때
				    }
				    
				    referrerField.text(newVal);
			    }
			    
			    
			    // 모달 닫기
			    $('#staticBackdrop').modal('hide');
				
		    });
			
		});
</script>