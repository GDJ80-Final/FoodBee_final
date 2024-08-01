<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	<div class="content-body">
	<div class="container">
		    <form id="form" method="post" action="${pageContext.request.contextPath}/approval/modifyDraft" enctype="multipart/form-data">
		    	<input type="hidden" name="draftDocNo" value="${dayOffOne.draftDocNo}">
		        <!-- 공통 영역 -->
				<jsp:include page="./forms/commonForm.jsp"></jsp:include>
		       
		        <!-- 공통 영역 끝 -->
		        
		        <!-- 양식 영역 시작 -->
				<div class="form-section">
					<div class="form-group">
						<label for="category">유형:</label>
						<input type="radio" id="categoryYear" name="typeName" value="연차"> 연차          
						<input type="radio" id="categoryHalf" name="typeName" value="반차" style="margin-left: 20px;"> 반차
				    </div>
				    <div class="form-group">
				        <label for="remaining">잔여 휴가:</label>
				        
				        <label for="period" style="margin-left: 400px;">기간:</label>
				        <input type="date" id="period" name="startDate" value="${dayOffDetailOne.startDate}"> ~
				        <input type="date" id="period" name="endDate" value="${dayOffDetailOne.endDate}">
				    </div>
				    <div class="form-group">
				        <label for=emergency>비상연락:</label>
				        <input type="text" id="emergency" name="text" value="${dayOffDetailOne.text}">
				    </div>
				    <div class="form-group">
				    	<input type="hidden" name="tmpNo" value="2">
				        <label for="title">제목:</label>
				        <input type="text" id="title" name="title" value="${dayOffOne.title}">
				    </div>
				    <div class="form-group">
				        <label for="content">내용:</label>
				        <textarea id="content" name="content" placeholder="휴가 사유을 작성하세요.">${dayOffOne.content}</textarea>
				    </div>
				    <div class="file-upload">
		                <label for="attachment">첨부파일:</label>
		                <div id="fileInputsContainer">
					        <div class="file-input-group" id="fileGroup1">
					                <input type="file" id="attachment-1" name="docFiles">
					        </div>
					   </div>
        			   <button type="button" class="add-file-button" id="addFileButton">+ 파일 추가</button>
		                
		            </div>
				</div>
			    <!-- 양식 영역 끝 -->
		        <div class="form-actions">
		            <button type="reset" class="cancel-btn">취소</button>
		            <button type="button" id="submitBtn" class="submit-btn">제출</button>
		        </div>
			</form>	
			<!-- 폼 종료 -->
	    </div>
	</div>
</div>
 		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	    
	    
	    
		<!-- 모달 -->
		<jsp:include page="./forms/empModal.jsp"></jsp:include>
		
		
<script>
	$(document).ready(function(){
		let typeName = '${dayOffDetailOne.typeName}';
	    
	    // Radio button check logic
	    if (typeName === '연차') {
	        $('#categoryYear').prop('checked', true);
	    } else if (typeName === '반차') {
	        $('#categoryHalf').prop('checked', true);
	    }
	    
	    let drafter = '${dayOffOne.drafterEmpNo}';  
	    let drafterName = '${dayOffOne.drafterEmpName}';  
	    let midApprover = '${dayOffOne.midApproverNo}';
	    let midApproverName = '${dayOffOne.midApproverName}';
	    let finalApproverName = '${dayOffOne.finalApproverName}';
	    let finalApprover = '${dayOffOne.finalApproverNo}';
	    let referrerField = '${dayOffReferrer.referrerName}';
	    //수신자가 없는경우
	    if(referrerField === null || referrerField === '') {
	    	referrerField = "수신자 없음";
	    }
	    let name = '${dayOffOne.drafterEmpName}';  
	    let dptNo = '${dayOffOne.dptNo}';  
	
	    $("#drafterEmpNo").val(drafter);
	    $("#drafterEmpNoField").val(drafterName+"("+drafter+")");
	    $("#midApproverNo").val(midApprover);
	    $("#midApproverNoField").val(midApproverName+"("+midApprover+")");
	    $("#finalApproverNo").val(finalApprover);
	    $("#finalApproverNoField").val(finalApproverName+"("+finalApprover+")");
	    $("#referrerField").val(referrerField);
	    $("#name").val(drafterName);
	    $("#department").val(dptNo);
	    $("#midApproverBtn").hide();
	    $("#finalApproverBtn").hide();
	    
    	//사원 결재사인
	    let drafterSign = '${dayOffOne.drafterSign}';
	    let midApproverSign = '${dayOffOne.midApproverSign}';
	    let finalApproverSign = '${dayOffOne.finalApproverSign}';
	    let midApprovalState = '${dayOffOne.midApprovalState}';
	    let finalApprovalState = '${dayOffOne.finalApprovalState}';
	    
	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${dayOffOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign && midApprovalState == 1) {
	        $("#midApproverSign").html(`<img src="${dayOffOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간 결재자 서명전");
	    }
	
	    if (finalApproverSign && finalApprovalState == 1) {
	        $("#finalApproverSign").html(`<img src="${dayOffOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종 결재자 서명전");
	    }
	    
	 // 취소 버튼 클릭시 상세보기로 이동
        $('#cancle').click(function() {
        	window.location.href = "${pageContext.request.contextPath}/approval/modifyDayOffForm?draftDocNo=${dayOffOne.draftDocNo}";
        })
		
		$('#submitBtn').click(function(e) {
	        let drafterNo = $('#drafterEmpNo').val();
	        console.log(drafterNo)
	        $.ajax({
	            url: '${pageContext.request.contextPath}/approval/getSign',
	            method: 'get',
	            data: {
	            	approverNo : drafterNo
	            },
	            success: function(json) {
	            	console.log('sign 있음');
	            	$('#form').submit();
	            },
	            error: function(xhr, status, error) {
	            	e.preventDefault();
	                alert("결재사인을 등록을 해주세요");
	                window.location.href = '${pageContext.request.contextPath}/myPage';
	            }
	        });
	    });
		
		/* 파일 여러 개 추가  */
		let fileOrder = 1;
        // 파일 추가 버튼 클릭 시
        $('#addFileButton').click(function() {
            fileOrder++;
            let newFileInput = 
                '<div class="file-input-group" id="fileGroup${fileOrder}">'+
                '<input type="file" id="attachment-${fileOrder}" name="docFiles">'+
                 '<button type="button" class="remove-file-button" data-file-id="fileGroup${fileOrder}">삭제</button>'+
                '</div>';
            $('#fileInputsContainer').append(newFileInput);
        });

        // 파일 입력 필드 삭제 버튼 클릭 시
        $(document).on('click', '.remove-file-button', function() {
        	console.log('test');
        	let fileGroupId = $(this).data('file-id');
            $('#' + fileGroupId).remove();
        });

	});
</script>
</body>

</html>