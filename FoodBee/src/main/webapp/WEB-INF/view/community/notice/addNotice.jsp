<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
        width: 100%; 
    }
	th, td {
        border: 1px solid #ddd; /* 테두리 */
        padding: 10px; /* 셀 내부 여백 추가 */
        vertical-align: top; /* 셀 내용 상단 정렬 */
    }
    
    th {
        background-color: #f4f4f4; /* 헤더 셀 배경색 추가 */
    }
       .file-input-wrapper {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    .add-file-button {
		margin-top: 10px;
		padding: 10px 20px;
		border: none;
		border-radius: 5px;
		background-color: #333;
		color: #fff;
		cursor: pointer;
	}
	.add-file-button:hover {
		background-color: #555;
	} 
	#oneBtn {
	    display: flex; 
	    justify-content: center; 
	}
	#btnSubmit {
		width:150px;
	}
	#back{
    	width: 100px;
    	margin-bottom: 10px;
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
                 <li class="breadcrumb-item"><a href="javascript:void(0)">커뮤니티</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항 추가</a></li>
             </ol>
         </div>
   	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 			<!-- 여기부터 내용 -->
			 			<a href="noticeList" class="btn btn-primary btn-block" id="back">돌아가기</a>
					    <div id="notice">
					        <form method="post" action="addNoticeAction" enctype="multipart/form-data" onsubmit="return validateForm()">
					            <table>
					                <tr>
					                    <th>작성자</th>
					                    <td>
					                        <input type="text" name="writerEmpName" value="${empName}" class="form-control bg-transparent flex-grow-1 me-2" readonly="readonly">
					                    </td>
					                </tr>
					                <tr>
					                    <th>제목</th>
					                    <td>
					                        <input type="text" name="title" id="title" class="form-control bg-transparent flex-grow-1 me-2">
					                    </td>
					                </tr>
					                <tr>
					                    <th>카테고리</th>
					                    <td>
					                        <select name="type" class="form-control form-control-sm">
					                            <option value="전사원">전사원</option>
					                            <option value="부서">부서</option>
					                        </select>
					                    </td>
					                </tr>
					                <tr>
					                    <th>첨부파일</th>
					                     <td>
					                     	<h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5>
					                        <div id="file-container">
					                            <div class="file-input-wrapper">
					                                <input type="file" name="files" multiple="multiple">
					                                <button type="button" onclick="removeFileInput(this)" class="btn btn-danger" id="deleteBtn">제거</button>
					                                <!-- this는 file-container 전체 -->
					                            </div>
					                        </div>
					                        <button type="button" onclick="addFileInput()" class="add-file-button" id="addFile">파일 추가</button>
					                    </td>
					                </tr>
					                 <tr>
					                    <th>내용</th>
					                    <td>
					                    	<textarea rows="8" cols="50" name="content" placeholder="공지사항을 작성해주세요" id="content"></textarea>
					                    </td>
					                </tr>
					            </table>
					     		<input type="hidden" name="dptNo" value="${dptNo}">
					     		<input type="hidden" name="writerEmpNo" value="${empNo}">
					     		<div id="oneBtn"> 					     		
					            	<button type="submit" class="btn btn-info btn-block mt-3" id="btnSubmit">공지사항 등록</button>
					     		</div>
					        </form>
					    </div>
					<!-- 내용끝 -->
					</div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include> 
<script>
	function addFileInput() {
	    var fileContainer = document.getElementById('file-container');
	    var fileInputWrapper = document.createElement('div');
	    fileInputWrapper.className = 'file-input-wrapper';
	
	    var newFileInput = document.createElement('input');
	    newFileInput.type = 'file';
	    newFileInput.name = 'files';
	    newFileInput.multiple = 'multiple';
	
	    var removeButton = document.createElement('button');
	    removeButton.type = 'button';
	    removeButton.innerText = '제거';
	    removeButton.className = 'btn btn-danger'; // Bootstrap 버튼 스타일
	    removeButton.onclick = function() {
	        removeFileInput(removeButton);
	    };
	
	    fileInputWrapper.appendChild(newFileInput);
	    fileInputWrapper.appendChild(removeButton);
	    fileContainer.appendChild(fileInputWrapper);
	}
	//선택 파일 제거 
	function removeFileInput(button) {
	    var fileInputWrapper = button.parentNode;
	    fileInputWrapper.parentNode.removeChild(fileInputWrapper);
	}
	// 제목, 내용이 공백이 되지 않도록 공백검사!
	function validateForm() {
	    var title = document.getElementById('title').value.trim();
	    var content = document.getElementById('content').value.trim();

	    if (title === "") {
	        alert("제목을 입력하지 않았습니다.");
	        return false;
	    }

	    if (content === "") {
	        alert("내용을 입력하지 않았습니다.");
	        return false;
	    }

	    return true;
	}
</script>
</body>
</html>