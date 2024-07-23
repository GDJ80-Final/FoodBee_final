<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 목록</title>
</head>
<body>
<h1>전체</h1>
<a href="${pageContext.request.contextPath}/room/roomRsvList">전체 예약</a>
<a href="${pageContext.request.contextPath}/room/myRoomRsvList">내 예약</a>
<form id="dateForm" method="get" action="${pageContext.request.contextPath}/room/roomRsvList">
    <input type="date" id="dateInput" name="date" value="${rsvDate}">
</form>
<table border="1">
    <tr>   
        <th>회의실</th>
        <th>예약 날짜</th>
        <th>예약시간</th>
        <th>예약자</th>
    </tr>
    <c:forEach var="rsv" items="${rsvListByDate}">
        <tr>
            <td>${rsv.roomName}</td>
            <td>${rsv.rsvDate}</td>
            <td>${rsv.startTime} ~ ${rsv.endTime}</td>
            <td>${rsv.empName}</td>
        </tr>
    </c:forEach>
</table>
<div>
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=${currentPage - 1}">이전</a>
    </c:if>
    <span>페이지 ${currentPage} / ${lastPage}</span>
    <c:if test="${currentPage < lastPage}">
        <a href="${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=${currentPage + 1}">다음</a>
    </c:if>
</div>
<script>
    // 페이지가 로드될 때 실행될 함수
    window.onload = function() {
        let today = new Date();
        let year = today.getFullYear();
        let month = ('0' + (today.getMonth() + 1)).slice(-2);
        let day = ('0' + today.getDate()).slice(-2);
        let dateString = year + '-' + month + '-' + day;
        document.getElementById('dateInput').value = dateString; // 기본값 설정
    }

    // 날짜 입력 변경 시 폼 제출
    document.getElementById('dateInput').addEventListener('change', function() {
        document.getElementById('dateForm').submit();
    });
</script>
</body>
</html>