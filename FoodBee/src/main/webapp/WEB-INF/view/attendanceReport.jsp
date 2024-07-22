<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>전일 근태보고</h1>
<form method="post" action="${pageContext.request.contextPath}/">
<table border="1">
	<tr>
		<td>확인일자</td>
		<td>${attendanceDTO.date}</td>
	</tr>
	<tr>
		<td>출근 시간</td>
		<td>${attendanceDTO.startTime}</td>
	</tr>
	<tr>
		<td>퇴근 시간</td>
		<td>${attendanceDTO.endTime}</td>
	</tr>
	<tr>
		<td>승인자</td>
		<td>${map.rankName} ${map.empName}</td>
	</tr>

</table>
	<a href="${pageContext.request.contextPath}/">수정</a>
	<button type="submit">확정</button>
</form>
</body>
</html>