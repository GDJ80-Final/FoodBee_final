<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 목록</title>
</head>
<body>
<div id="main-wrapper">
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
	
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	<div class="content-body">
	<div class="container">
		<h1>회의실 목록</h1>
		<input type="date" id="dateInput">
		<a href="${pageContext.request.contextPath}/room/roomRsvList">예약 리스트</a>
		
		<table border="1">
			<tr>
				<td style="width:300px; height:50px;">회의실 명</td>
				<td style="width:25%; height:50px;">이미지</td>
				<td style="width:25%; height:50px;">위치</td>
				<td style="width:25%; height:50px;">수용인원</td>
			</tr>
			<c:forEach var="m" items="${list}">	
				<tr>
					<td style="height:100%;">
						<form action="${pageContext.request.contextPath}/room/roomOne" method="get">
							<input type="hidden" name="roomNo" value="${m.roomNo}">
							<input type="hidden" name="date" id="hiddenDateInput_${m.roomNo}">
							
							<a href="#" onclick="submitForm(this, ${m.roomNo}); return false;">
								${m.roomName}
							</a>
						</form>	
					</td>
					<td style="height:100%;">
						<img src="${pageContext.request.contextPath}/upload/room_img/${m.originalFile}" width="300px">				
					</td>
					<td style="height:200px;">${m.roomPlace}</td>
					<td style="height:200px;">최대 ${m.roomMax}명</td>
				</tr>
			</c:forEach>	
		</table>
	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
// 페이지가 로드되었을 때 실행될 함수
window.onload = function() {
    let today = new Date();
    let year = today.getFullYear();
    let month = ('0' + (today.getMonth() + 1)).slice(-2);
    let day = ('0' + today.getDate()).slice(-2);
    let dateString = year + '-' + month + '-' + day;
    document.getElementById('dateInput').setAttribute('min', dateString);
    dateInput.value = dateString; // 기본값 설정
}

function submitForm(link, roomNo) {
	let form = link.closest('form');
	let dateInput = document.getElementById('dateInput');
    document.getElementById('hiddenDateInput_' + roomNo).value = dateInput.value; // 선택된 날짜 설정
    form.submit(); // 폼 제출
}
</script>
</body>
</html>