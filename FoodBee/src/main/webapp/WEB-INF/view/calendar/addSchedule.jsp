<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 일정추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	#main-wrapper .content-body{
			margin-left: 270px;
			margin-top:20px;
	}
	table {
        width: 100%; 
    }
	th, td {
        border: 1px solid #ddd; /* 테두리 */
        padding: 10px; /* 셀 내부 여백 추가 */
        vertical-align: top; /* 셀 내용 상단 정렬 */
    }
    
    th {
        background-color: #f4f4f4; 
    }
    
	 #back{
    	width: 100px;
    	margin-bottom: 10px;
    }
    
    #btnSubmit {
		width:100px;
	}
	
	#oneBtn {
    display: flex; 
    justify-content: center; 
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
                 <li class="breadcrumb-item"><a href="javascript:void(0)">일정</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">캘린더</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">일정추가</a></li>
             </ol>
         </div>
   	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		 <!-- 여기부터 내용 -->
						<a href="schedule" class="btn btn-primary btn-block" id="back">돌아가기</a>
						<form method="post" action="addScheduleAction" onsubmit="return validateForm()">
							<table>
								<tr>
									<th>작성자</th>
									<td>
										<c:out value="${empName}"></c:out>
									</td>
								</tr>
								<tr>
									<th>
										<label for="startDate">시작일시</label>
									</th>
									<td>
										<input type="datetime-local" name="startDatetime" id="startDate" class="form-control input-default" >
									</td>
								</tr>
								<tr>
									<th>
										<label for="endDate">종료일시</label>
									</th>
									<td>
										<input type="datetime-local" name="endDatetime" id="endDate" class="form-control input-default" >
									</td>
								</tr>
								<tr>
									<th>유형</th>
									<td>
										<select name="type" class="form-control form-control-sm">
											<option value="개인">개인</option>
											<c:if test="${rankName != '사원'}">
												<option value="팀">팀</option>					
											</c:if>
										</select>
									</td>
								</tr>
								<tr>
									<th>
										<label for="title">제목</label>
									</th>
									<td>
										<input type="text" name="title" id="title" class="form-control input-default">
									</td>
								</tr>
								<tr>
									<th>
										<label for="content">메모</label>
									</th>
									<td>
										<textarea rows="3" cols="30" name="content" id="content" class="form-control h-150px"></textarea>
									</td>
								</tr>
							</table>
							<input type="hidden" name="empNo" value='<c:out value="${empNo}"></c:out>'>
							<div id="oneBtn">							
								<button type="submit" class="btn btn-info btn-block mt-3" id="btnSubmit">추가</button>
							</div>
						</form>
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
	//제목, 내용이 공백이 되지 않도록 공백검사!
	function validateForm() {
	    var title = document.getElementById('title').value.trim();
	    var content = document.getElementById('content').value.trim();
	    var startDate = document.getElementById('startDate').value.trim();
	    var endDate = document.getElementById('endDate').value.trim();
	    
	    if (startDate === "") {
	        alert("시작일시를 정해주세요");
	        return false;
	    }
	
	    if (endDate === "") {
	        alert("종료일시를 정해주세요");
	        return false;
	    }
	    
	    if (new Date(startDate) > new Date(endDate)) {
	        alert("종료일시는 시작일시 이후로 부탁드려요");
	        return false;
	    }
	
	    if (title === "") {
	        alert("제목을 입력해주세요");
	        return false;
	    }
	
	    if (content === "") {
	        alert("내용을 입력해주세요");
	        return false;
	    }
	  
	    return true;
	}
</script>
</body>
</html>