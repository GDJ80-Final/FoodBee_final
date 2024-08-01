<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출장상세보기</title>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
	<div class="content-body">
	<h1>출장일정</h1>
		<div>
		<a href="scheduleList">돌아가기</a>
		    <table border="1">
		        <tr>
		            <th>출장자</th>
		            <td>
		                <input type="text" value="<c:out value="${tripHistoryOne.empName}"/>" readonly="readonly">
		            </td>
		        </tr>
		        <tr>
		            <th>출발일</th>
		            <td>
		                <input type="datetime-local" name="startDatetime" value="<c:out value="${tripHistoryOne.formattedStartDate}"/>" readonly="readonly">
		            </td>
		        </tr>
		        <tr>
		            <th>도착일</th>
		            <td>
		                <input type="datetime-local" name="endDatetime" value="<c:out value="${tripHistoryOne.formattedEndDate}"/>" readonly="readonly">
		            </td>
		        </tr>
		        <tr>
		            <th>출장지</th>
		            <td>
		                <input type="text" value="<c:out value="${tripHistoryOne.businessTripDestination}"/>" readonly="readonly">
		            </td>
		        </tr>
		        <tr>
		            <th>비상연락처</th>
		            <td>
		                <input type="text" value="<c:out value="${tripHistoryOne.emergencyContact}"/>" readonly="readonly">
		            </td>
		        </tr>
		        <tr>
		            <th>취소유무</th>
		            <td>
			            <c:if test="${tripHistoryOne.cancleYN == 'N'}">
				      		<input type="text" readonly="readonly" value="취소X">
				      	</c:if>
				      	<c:if test="${tripHistoryOne.cancleYN == 'Y'}">
				      		<input type="text" readonly="readonly" value="취소O">
				      	</c:if>
		            </td>
		        </tr>
		        <c:if test="${tripHistoryOne.cancleYN == 'Y'}">
		            <tr>
		                <th>취소 이유</th>
		                <td>
		                    <input type="text" value="<c:out value="${tripHistoryOne.cancleReason}"/>" readonly="readonly">
		                </td>
		            </tr>
		        </c:if>
		        <tr>
		            <th>목적/사유</th>
		            <td>
		                <textarea rows="4" cols="50" readonly="readonly"><c:out value="${tripHistoryOne.content}"/></textarea>
		            </td>
		        </tr>
		    </table>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
</body>
</html>