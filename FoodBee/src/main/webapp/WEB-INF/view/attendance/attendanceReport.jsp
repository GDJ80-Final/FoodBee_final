<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태보고</title>
</head>
<body>
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
	
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<div class="content-body">
	<h1>근태보고</h1>
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
		<c:if test="${attendanceDTO.date ne null}">
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceModify?date=${attendanceDTO.date}'">수정</button>
			<button type="submit">확정</button>
		</c:if>	
	</form>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>

</body>
</html>