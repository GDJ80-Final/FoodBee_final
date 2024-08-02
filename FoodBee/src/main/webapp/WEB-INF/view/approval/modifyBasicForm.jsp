<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
	<div class="row page-titles mx-0">
         <div class="col p-md-0">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">기안함</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">기본기안서</a></li>
             </ol>
         </div>
   	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		<!-- 여기서부터 내용시작 -->
					    <form id="form" method="post" action="${pageContext.request.contextPath}/approval/modifyDraft" enctype="multipart/form-data">
					    	<input type="hidden" name="draftDocNo" value="${basicFormOne.draftDocNo}">
					        <!-- 공통 영역 -->
							<jsp:include page="./forms/commonForm.jsp"></jsp:include>
					       
					        <!-- 공통 영역 끝 -->
					        
					        <!-- 양식 영역 시작 -->
							 <div class="form-section">
					            <div class="form-group">
					            	<input type="hidden" name="tmpNo" value="4">
					                <label for="title">제목:</label>
					                <input type="text" id="title" name="title" value="${basicFormOne.title}">
					            </div>
					            <div class="form-group">
					                <label for="content">내용:</label>
					                <textarea id="content" name="content">${basicFormOne.content}</textarea>
					            </div>
					            <div class="file-upload">
					                <label for="attachment">첨부파일:</label>              	
				                        <c:forEach items="${basicFormFileOne}" var="file">	
				                        	<div>                         	
					                            <c:if test="${file.originalFile != null}">
					                            	<input type="hidden" name="existingFile" value="${file.originalFile}" readonly>
					                            	<input type="text" value="${file.saveFile}" readonly>
					                            	<button type="button" class="deleteFile">X</button>
					                            </c:if>
			                             	</div>
			                             	<c:if test="${file.originalFile == null}">
				                            	<input type="text" value="첨부파일이 없습니다" class="form-control bg-transparent flex-grow-1 me-2" readonly="readonly">
				                            </c:if>
				                            <br>
				                        </c:forEach>
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
					            <button type="button" id="cancle" class="cancle-btn">취소</button>
					            <button type="button" id="submitBtn" class="submit-btn">수정</button>
					        </div>
						</form>	
						<!-- 여기가 내용끝! --> 		
                    </div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<!-- 모달 -->
<jsp:include page="./forms/empModal.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		let drafter = '${basicFormOne.drafterEmpNo}';  
	    let drafterName = '${basicFormOne.drafterEmpName}';  
	    let midApprover = '${basicFormOne.midApproverNo}';
	    let midApproverName = '${basicFormOne.midApproverName}';
	    let finalApproverName = '${basicFormOne.finalApproverName}';
	    let finalApprover = '${basicFormOne.finalApproverNo}';
	    let referrerField = '${basicReferrerOne.referrerName}';
	    let referrerVal = referrerField.split('(').slice(1).map(x => parseInt(x));
	    $('#referrerEmpNo').val(referrerVal);
	    
	    let name = '${basicFormOne.drafterEmpName}';  
	    let dptName = '${basicFormOne.dptName}';  
	
	    $("#drafterEmpNo").val(drafter);
	    $("#drafterEmpNoField").val(drafterName+"("+drafter+")");
	    $("#midApproverNo").val(midApprover);
	    $("#midApproverNoField").val(midApproverName+"("+midApprover+")");
	    $("#finalApproverNo").val(finalApprover);
	    $("#finalApproverNoField").val(finalApproverName+"("+finalApprover+")");
	    $("#referrerField").val(referrerField);
	    $("#name").val(drafterName);
	    $("#department").val(dptName);
	    
	    let drafterSign = '${basicFormOne.drafterSign}';
	    let midApproverSign = '${basicFormOne.midApproverSign}';
	    let finalApproverSign = '${basicFormOne.finalApproverSign}';
	    let midApprovalState = '${basicFormOne.midApprovalState}';
	    let finalApprovalState = '${basicFormOne.finalApprovalState}';
		

	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${basicFormOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign && midApprovalState == 1) {
	        $("#midApproverSign").html(`<img src="${basicFormOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간 결재자 서명전");
	    }
	
	    if (finalApproverSign && finalApprovalState == 1) {
	        $("#finalApproverSign").html(`<img src="${basicFormOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종 결재자 서명전");
	    }
	    
	 	// 파일 삭제 버튼 클릭 시
        $(".deleteFile").click(function(e) {
            $(this).parent().remove(); // 해당 파일만 제거
        });
	    
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
  
        
        // 취소 버튼 클릭시 상세보기로 이동
        $('#cancle').click(function() {
        	window.location.href = "${pageContext.request.contextPath}/approval/modifyBasicForm?draftDocNo=${basicFormOne.draftDocNo}";
        })
        
        // 제출 버튼 클릭 시 전체 유효성 검사
        $('#submitBtn').click(function(e) {
            

            // 공백 검사
            let hasError = false;
            if ($('#title').val().trim() === '') {
                $('#titleError').text('제목을 입력해 주세요.');
                hasError = true;
            } else {
                $('#titleError').text('');
            }
            if ($('#content').val().trim() === '') {
                $('#contentError').text('내용을 입력해 주세요.');
                hasError = true;
            } else {
                $('#contentError').text('');
            }

            // 공백 검사 후 AJAX 요청
            if (!hasError) {
                let drafterNo = $('#drafterEmpNo').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/approval/getSign',
                    method: 'get',
                    data: {
                        approverNo: drafterNo
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
            }
        });
		/* 기안서 입력 공백 검사 */
		
		 // 입력 필드 블러 이벤트 리스너
        $('#title').blur(function() {
            let title = $(this).val().trim();
            if (title === '') {
                $('#titleError').text('제목을 입력해 주세요.');
            } else {
                $('#titleError').text('');
            }
        });

        $('#content').blur(function() {
            let content = $(this).val().trim();
            if (content === '') {
                $('#contentError').text('내용을 입력해 주세요.');
            } else {
                $('#contentError').text('');
            }
        });

	});
	
</script>
</body>

</html>