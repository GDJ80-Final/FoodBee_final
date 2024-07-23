<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>근태 조회</h1>
<table border="1">
	<tr>
		<td>사원번호</td>
		<td>해당일자</td>
		<td>출근시간</td>
		<td>퇴근시간</td>
		<td>승인자</td>
		<td>승인상태</td>
		<td>수정여부</td>
	</tr>
	<c:forEach var="m" items="${list}">
		<tr>
			<td>${m.empNo}</td>
			<td>${m.date}</td>
			<td>${m.updateStartTime}</td>
			<td>${m.updateEndTime}</td>
			<td>${map.rankName} ${map.empName}</td>
			<td>${m.approvalState}</td>
			<td></td>
		</tr>
	</c:forEach>
</table>
</body>
</html>