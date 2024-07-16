<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<h1>내 예약 목록</h1>
<a href="${pageContext.request.contextPath}/roomRsvList">전체 예약</a>
<a href="${pageContext.request.contextPath}/myRoomRsvList">내 예약</a>
<table border="1">
    <tr> 
        <th>회의실</th>
        <th>예약 날짜</th>
        <th>예약시간</th>
        <th>예약자</th>
        <th>&nbsp;</th>
    </tr>    
    <c:forEach var="rsv" items="${rsvListByEmpNo}">   
        <tr>
            <td>${rsv.roomName}</td>
            <td>${rsv.rsvDate}</td>
            <td>${rsv.startTime} ~ ${rsv.endTime}</td>
            <td>${rsv.empName}</td>
            <td>
            	<form method="post" action="${pageContext.request.contextPath}/cancleRoomRsv"> 
            	<input type="hidden" name="empNo" value="${rsv.empNo}">
				<input type="hidden" name="rsvDate" value="${rsv.rsvDate}">
				<input type="hidden" name="startTime" value="${rsv.startTime}">            	           
            	<button id="cancel-link" type="submit">취소</button>
            	</form> 
            </td>
        </tr>  
    </c:forEach>   
</table>
<div>
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/myRoomRsvList?currentPage=${currentPage - 1}">이전</a>
    </c:if>
    <span>페이지 ${currentPage} / ${lastPage}</span>
    <c:if test="${currentPage < lastPage}">
        <a href="${pageContext.request.contextPath}/myRoomRsvList?currentPage=${currentPage + 1}">다음</a>
    </c:if>
</div>
<script>
$(document).ready(function() {
    let today = new Date(); // 오늘 날짜 객체를 가져옴

    // 각 예약 항목을 순회하며 날짜를 비교하고 취소 링크를 숨김
    $('table tr').each(function() {
        let rsvDateStr = $(this).find('td:eq(1)').text(); // 두 번째 td 요소의 텍스트(예약 날짜)를 가져옴
        let rsvDate = new Date(rsvDateStr); // 예약 날짜를 Date 객체로 변환

        if (rsvDate <= today) {
            $(this).find('#cancel-link').hide(); // 예약 날짜가 오늘 이전인 경우 취소 링크를 숨김
        }
    });
});
</script>
</body>
</html>