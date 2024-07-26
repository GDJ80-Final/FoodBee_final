<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 조회</title>
</head>
<body>
<h1>근태 조회</h1>
<form method="get" action="${pageContext.request.contextPath}/attendance/attendancePersonal">
    <label for="startDate">기간 선택</label>
    <input type="date" id="startDate" name="startDate" value="${param.startDate}">
    <label for="endDate"> - </label>
    <input type="date" id="endDate" name="endDate" value="${param.endDate}">
    <button type="submit">조회</button>
</form>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal'">전체</button>
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
			<td>&nbsp;&nbsp;&nbsp;${m.updateStartTime}<br>등록:${m.startTime}</td>
			<td>&nbsp;&nbsp;&nbsp;${m.updateEndTime}<br>등록:${m.endTime}</td>
			<td>${map.rankName} ${map.empName}</td>
			
			<c:if test="${m.approvalState eq '승인' || m.approvalState eq '미승인'}">
			    <td>${m.approvalState}</td>
			</c:if>
			<c:if test="${m.approvalState eq '반려'}">
			    <td><a href="${pageContext.request.contextPath}/attendance/attendanceReport?date=${m.date}">${m.approvalState}</a></td>
			</c:if>
			
			<td>${m.updateStatus}</td>
		</tr>
	</c:forEach>
</table>
<div>
    <c:if test="${param.startDate == null || param.endDate == null}">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage - 1}">이전</a>
        </c:if>
        <span>페이지 ${currentPage} / ${lastPage}</span>
        <c:if test="${currentPage < lastPage}">
            <a href="${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage + 1}">다음</a>
        </c:if>
    </c:if>
</div>
</body>
</html>