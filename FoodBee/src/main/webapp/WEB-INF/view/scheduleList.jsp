<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule List</title>
</head>
<body>
<h1>일정 리스트</h1>
<button id="all">전체</button>
<button id="person">개인</button>
<button id="team">팀</button>
<div>
	 <table border="1">
        <thead>
            <tr>
                <th>유형</th>
                <th>제목</th>
                <th>시작시간</th>
                <th>종료시간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="schedule" items="${personalList}">
                <tr>
                    <td>${schedule.type}</td>
                    <td>${schedule.title}</td>
                    <td>${schedule.startDatetime}</td>
                    <td>${schedule.endDatetime}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>