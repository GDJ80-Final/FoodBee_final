<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회의실 목록</title>
</head>
<body>
	<h1>회의실 목록</h1>
	<input type="date" id="dateInput">
	<a href="${pageContext.request.contextPath}/roomRsvList">예약 리스트</a>
	<table border="1">
		<tr>
			<td style="width:300px; height:50px;">회의실 명</td>
			<td style="width:25%; height:50px;">이미지</td>
			<td style="width:25%; height:50px;">위치</td>
			<td style="width:25%; height:50px;">수용인원</td>
		</tr>
	<c:forEach var="m" items="${list}">	
		<tr>
			<td style="height:200px;">
				<form action="${pageContext.request.contextPath}/roomOne" method="get">
					<input type="hidden" name="roomNo" value="${m.roomNo}">
					<input type="hidden" name="date" id="hiddenDateInput_${m.roomNo}">
					<a href="#" onclick="submitForm(this, ${m.roomNo}); return false;">${m.roomName}</a>
				</form>	
			</td>
			<td style="height:200px;"><a href="#" onclick="submitForm(this, ${m.roomNo}); return false;">
									  	<img src="/article/img/${m.roomName}" width="100px">
									  </a>
			</td>
			<td style="height:200px;">${m.roomPlace}</td>
			<td style="height:200px;">최대 ${m.roomMAX}명</td>
		</tr>
	</c:forEach>	
	</table>
<script>
	// 페이지가 로드되었을 때 실행될 함수
	window.onload = function() {
	    var today = new Date();
	    var year1 = today.getFullYear();
	    var month = ('0' + (today.getMonth() + 1)).slice(-2);
	    var day = ('0' + today.getDate()).slice(-2);
	    var dateString = year1 + '-' + month + '-' + day;
	    document.getElementById('dateInput').setAttribute('min', dateString);
	    dateInput.value = dateString; // 기본값 설정
	}

	function submitForm(link, roomNo) {
	    var form = link.closest('form');
	    var dateInput = document.getElementById('dateInput');
	    document.getElementById('hiddenDateInput_' + roomNo).value = dateInput.value; // 선택된 날짜 설정
	    form.submit(); // 폼 제출
	}
</script>
</body>
</html>