<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전일 근태보고 수정</title>
</head>
<body>
<h1>전일 근태보고 수정</h1>
<form method="post" action="${pageContext.request.contextPath}/attendance/attendanceModifyAction">
	<table border="1">
		<tr>
			<td>확인일자</td>
			<td>${attendanceDTO.date}</td>
		</tr>
		<tr>
			<td>출근 시간</td>
			<td>${attendanceDTO.updateStartTime}</td>
			<td><input type="datetime" name="updateStartTime" value="${attendanceDTO.updateStartTime}"></td>
		</tr>
		<tr>
			<td>퇴근 시간</td>
			<td>${attendanceDTO.updateEndTime}</td>
			<td><input type="datetime" name="updateEndTime" value="${attendanceDTO.updateEndTime}"></td>
		</tr>
		<tr>
			<td>승인자</td>
			<td>${map.rankName} ${map.empName}</td>
		</tr>
		<tr>
			<td>사유</td>
			<td><textarea name="updateReason"></textarea></td>
		</tr>
	</table>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceReport'">돌아가기</button>
	<button type="submit">수정 완료</button>
</form>
</body>
</html>