<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#main-wrapper .content-body{
			margin-left: 270px;
			margin-top:20px;
	}
	td{
	padding: 8px;
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
<h2>일정추가</h2>
<a href="schedule" class="btn btn-secondary btn-sm">돌아가기</a>
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
					<input type="datetime-local" name="startDatetime" id="startDate">
				</td>
			</tr>
			<tr>
				<th>
					<label for="endDate">종료일시</label>
				</th>
				<td>
					<input type="datetime-local" name="endDatetime" id="endDate">
				</td>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<select name="type">
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
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>
					<label for="content">메모</label>
				</th>
				<td>
					<textarea rows="3" cols="30" name="content" id="content"></textarea>
				</td>
			</tr>
		</table>
		<input type="hidden" name="empNo" value='<c:out value="${empNo}"></c:out>'>
		<button type="submit" class="btn btn-secondary btn-sm">추가</button>
	</form>
</div>
</div>
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