<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 취소 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<h1>예약 취소 목록</h1>
<a href="${pageContext.request.contextPath}/room/roomRsvList">전체 예약</a>
<a href="${pageContext.request.contextPath}/room/myRoomRsvList">내 예약</a>
<table class="table table-bordered">
    <thead>
        <tr> 
            <th>회의실</th>
            <th>예약일</th>
            <th>예약시간</th>                
            <th>제목</th>
            <th>유형</th>
            <th>인원</th>
            <th>부서</th>
            <th>예약자</th>     
            <th>상태</th>
        </tr>    
    </thead>
    <tbody>
        <c:forEach var="m" items="${list}">   
            <tr>
                <td>${m.roomName}</td>
                <td>${m.rsvDate}</td>
                <td>${m.startTime} ~ ${m.endTime}</td>                                                            
                <td>${m.meetingTitle}</td>
                <td>${m.type}</td>
                <td>${m.users}</td>
                <td>${m.dptNo}</td>
                <td>${m.rankName} ${m.empName}</td>
                <td>${m.rsvState}</td>
            </tr>
            <c:if test="${empty list}">
            	<td colspan="9">
			    	<h3>취소 된 예약이 없습니다.</h3>
			    </td>
			</c:if>
        </c:forEach>        	
    </tbody>
</table>
<div>
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/room/cancleRsvList?currentPage=${currentPage - 1}">이전</a>
    </c:if>
    <span>페이지 ${currentPage} / ${lastPage}</span>
    <c:if test="${currentPage < lastPage}">
        <a href="${pageContext.request.contextPath}/room/cancleRsvList?currentPage=${currentPage + 1}">다음</a>
    </c:if>
</div>
</body>
</html>