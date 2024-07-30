<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
    <style>
    	 body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            margin: 0;
        }
        .container {
            width: 900px;
           
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
        }
        .tabs {
            display: flex;
            background-color: #f1f1f1;
            margin:10px;
           
            
        }
        .tabs div {
            padding: 10px 20px;
            cursor: pointer;
            flex: 1;
            text-align: center;
            color : black;
        }
        .tabs div.active {
            background-color: #fff;
            border-bottom: 2px solid #000;
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
        .file-upload {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .file-upload label {
            width: 80px;
            margin-right: 10px;
        }
        .file-upload input[type="text"] {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .file-upload button {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 8px 10px;
            cursor: pointer;
        }
        .form-actions {
            display: flex;
            justify-content: center;
            margin: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin: 0 10px;
        }
        .form-actions .cancel-btn {
            background-color: #444;
            color: #fff;
        }
        .form-actions .submit-btn {
            background-color: #e74c3c;
            color: #fff;
        }
        a {
        	text-decoration-line: none;
        
        }
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
<body>

	<div class="container">
		    <div class="tabs" id="tabs">
		        <div class="tab" id="basicForm" data-form="basicForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/basicForm">
		        기본기안서
		        </a></div>
		        <div class="tab" id="revenueForm" data-form="revenueForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/revenueForm">
		        매출보고
		        </a></div>
		        <div class="tab" id="chargeForm" data-form="chargeForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/chargeForm">
		        지출결의
		        </a></div>
		        <div class="tab" id="businessTripForm" data-form="businessTripForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/businessTripForm">
		        출장신청
		        </a></div>
		        <div class="tab" id="dayOffForm" data-form="dayOffForm">
		        <a href="${pageContext.request.contextPath}/approval/forms/dayOffForm">
		        휴가신청
		        </a></div>
		    </div>
		    
		    <form method="post" action="${pageContext.request.contextPath}/approval/addDraft" enctype="multipart/form-data">
		        <!-- 공통 영역 -->
				<jsp:include page="./commonForm.jsp"></jsp:include>
		       
		        <!-- 공통 영역 끝 -->
		        
		        <!-- 양식 영역 시작 -->
				 <div class="form-section">
		            <div class="form-group">
		            	<input type="hidden" name="tmpNo" value="4">
		                <label for="title">제목:</label>
		                <input type="text" id="title" name="title">
		            </div>
		            <div class="form-group">
		                <label for="content">내용:</label>
		                <textarea id="content" name="content"></textarea>
		            </div>
		            <div class="file-upload">
		                <label for="attachment">첨부파일:</label>
		                <input type="file" id="attachment" name="docFiles" multiple>
		               
		            </div>
		        </div>	
		        <!-- 양식 영역 끝 -->
		        <div class="form-actions">
		            <button type="reset" class="cancel-btn">취소</button>
		            <button  type="submit" id="submitBtn" class="submit-btn">제출</button>
		        </div>
			</form>	
			<!-- 폼 종료 -->
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
	$(document).ready(function(){
		// 호출되면 페이지에 담을 emp 정보 불러오기 
		$.ajax({
            url: '${pageContext.request.contextPath}/approval/forms/commonForm',
            method: 'get',
            success: function(json) {
                $('#drafterEmpNo').val(json.empNo);
                console.log($('#drafterEmpNo').val());
                
                $('#name').val(json.empName);
                $('#department').val(json.dptName)
            },
            error: function() {
                alert('기본정보 불러오는데 실패했습니다 .');
            }
        });
		
	    $(".tab").click(function(){
	        // 모든 탭에서 'active' 클래스 제거
	        $(".tab").removeClass("active");
	        // 클릭한 탭에 'active' 클래스 추가
	        $(this).addClass("active");
	
	        // data-form 속성에서 폼 파일명 가져오기
	        let formName = $(this).data("form");
	        console.log(formName);
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
				console.log(empNo);
				console.log(empName);
			    // 선택한 사원의 정보를 필요한 곳에 출력
			    console.log(action);
			    if(action === 'mid'){
			    	 $('#midApproverNo').val(empNo);
			    	 
			    	 
			    	 console.log($('#midApproverNo').val());
			    }else if(action === 'final'){
			    	
			    	 $('#finalApproverNo').val(empNo);
			    }else if(action === 'referrer'){
			 
				    let referrerField = $('#referrerField');
				    let currentVal = referrerField.val();
				    let newVal;
				    let empNosArray = [];
				    
				    console.log(empNo);
				    
				    if (currentVal) {
				        empNosArray = currentVal.split(','); 
				        // 사원번호 배열로 변환
				        console.log('empNosArray => ' + empNosArray);
				        
				        // 중복된 사번이 있으면
				        if (empNosArray.includes(empNo)) {
				            alert('이미 추가된 사원입니다.');
				            return;
				        } else {
				            newVal = currentVal + ',' + empNo; // 중복이 아니면 추가
				        }
				        
				    } else {
				        newVal = empNo ; // 처음 추가할 때
				    }
				    
				    referrerField.val(newVal);
			    }
			    
			    
			    // 모달 닫기
			    $('#staticBackdrop').modal('hide');
				
		    });
			
		});
</script>
</body>

</html>