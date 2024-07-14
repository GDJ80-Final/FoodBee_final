<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	세션값
	<div>empNo : ${emp.empNo}</div>
	<div>empName : ${emp.empName}</div>
	<div>dptNo : ${emp.dptNo}</div>
	<div>rankName : ${emp.rankName}</div>
	<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
	
</body>
</html>