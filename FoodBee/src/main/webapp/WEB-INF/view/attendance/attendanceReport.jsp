<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전일 근태보고</title>
</head>
<body>
<h1>전일 근태보고</h1>
<form method="post" action="${pageContext.request.contextPath}/attendance/attendanceFinalTime">
	<input type="hidden" name="date" value="${attendanceDTO.date}">
	<table border="1">
		<tr>
			<td>확인일자</td>
			<td>${attendanceDTO.date}</td>
		</tr>
		<tr>
			<td>출근 시간</td>
			<td>${attendanceDTO.updateStartTime}</td>
		</tr>
		<tr>
			<td>퇴근 시간</td>
			<td>${attendanceDTO.updateEndTime}</td>
		</tr>
		<tr>
			<td>승인자</td>
			<td>${map.rankName} ${map.empName}</td>
		</tr>	
	</table>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceModify'">수정</button>
	<button type="submit">확정</button>
</form>
</body>
</html>