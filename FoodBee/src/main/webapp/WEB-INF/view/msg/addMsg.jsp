<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
	}

	.form-container {
	    width: 50%;
	    margin: 50px auto;
	    padding: 20px;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	td {
	    padding: 10px;
	    vertical-align: top;
	}
	
	label {
	    font-weight: bold;
	}
	
	input[type="text"],
	input[type="file"],
	textarea {
	    width: 100%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	textarea {
	    height: 200px;
	    resize: none;
	}
	
	.search-btn {
	    margin-left: 10px;
	    padding: 8px 12px;
	    background-color: #f0f0f0;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.search-btn:hover {
	    background-color: #e0e0e0;
	}
	
	.form-buttons {
	    display: flex;
	    justify-content: flex-end;
	}
	
	.cancel-btn,
	.send-btn {
	    padding: 10px 20px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	.cancel-btn {
	    background-color: #ccc;
	    margin-right: 10px;
	}
	
	.send-btn {
	    background-color: #4CAF50;
	    color: white;
	}
	
	.send-btn:hover {
	    background-color: #45a049;
	}
	
	.cancel-btn:hover {
	    background-color: #b0b0b0;
	}
	

</style>
</head>
<body>
	 <div class="form-container">
	 	<form method="post" action="${pageContext.request.contextPath}/msg/addMsg" id="addMsgForm" enctype="multipart/form-data">
	        <table>
	            <tr>
	                <td><label for="recipient">받는사람:</label></td>
	                <td>
	                    <input type="text" name="recipientEmpNos" id="recipient" readonly>
	                    <button type="button" class="btn btn-primary" id="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
  							검색 
						</button>
	                </td>
	            </tr>
	            <tr>
	                <td><label for="title">제목:</label></td>
	                <td><input type="text" name="title" id="title"></td>
	            </tr>
	            <tr>
	                <td><label for="msgFile">첨부파일:</label></td>
	                <td><input type="file" name="msgFiles" id="msgFile" multiple="multiple"></td>
	            </tr>
	            <tr>
	                <td colspan="2">
	                    <label for="message">쪽지쓰기:</label>
	                    <textarea id="message" name="content" placeholder="쪽지쓰기 textarea"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="2" class="form-buttons">
	                    <button class="cancel-btn">취소</button>
	                    <button class="send-btn">보내기</button>
	                </td>
	            </tr>
	        </table>
        </form>
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
						'<td><button type="button" id="selectEmp" value="'+ item.empNo + '">선택</button></td>' +
						'</tr>');
				}
			
			
			//모달에서 사원 선택 
			$(document).on('click', '#selectEmp', function() {
				
				let empNo = $(this).val();
			    let recipientField = $('#recipient');
			    let currentVal = recipientField.val();
			    let newVal;
			    let empNosArray = [];
			    
			    console.log(empNo);
			    
			    if(currentVal){
		
			    	empNosArray = currentVal.split(',');
			    	console.log('empNosArray => '+ empNosArray);
			    	//중복된 사번 이 없으면 -1반환 -> 수신자로 추가 가능
			    	if($.inArray(empNo,empNosArray) !== -1){
			    		alert('이미 추가된 사원입니다.');
			    		return;
			    		
			    	}else{
			    		newVal = currentVal + ','+empNo;
			    	}
			    	
			    }else{
			    	newVal = empNo;
			    }
			    
			    recipientField.val(newVal);
			    $('#staticBackdrop').modal('hide');
		    });
			
		});
	</script>
</body>
</html>