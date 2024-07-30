<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
<h1>회의실 예약</h1>
<a href="scheduleList">돌아가기</a>
		<table border="1">
			<tr>
				<th>예약자</th>
				<td>
					<input type="text" value="<c:out value="${roomRsvOne.empName}"></c:out>"readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>시작일정</th>
				<td>
					<input type="datetime-local" name="startDatetime" value="<c:out value="${roomRsvOne.startTime}"></c:out>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>종료일정</th>
				<td>
					<input type="datetime-local" name="endDatetime" value="<c:out value="${roomRsvOne.endTime}"></c:out>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<c:if test="${roomRsvOne.type == 'team'}">
						팀 회의
					</c:if>
					<c:if test="${roomRsvOne.type == 'personal'}">
						개인 회의
					</c:if>
				</td>
			</tr>
			<tr>
				<th>예약상태</th>
				<td>
					<c:if test="${roomRsvOne.rsvState == 1}">
						예약 완료
					</c:if>
					<c:if test="${roomRsvOne.rsvState == 0}">
						예약 취소됨
					</c:if>
				</td>
			</tr>
			<tr>
				<th>회의실</th>
				<td>
					<input type="text" value="<c:out value="${roomRsvOne.roomName}"></c:out>" readonly="readonly">
					<br>
					<input type="text" value="<c:out value="${roomRsvOne.roomPlace}"></c:out>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>인원</th>
				<td>
					<input type="text" value="<c:out value="${roomRsvOne.users}명"></c:out>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<c:out value="${roomRsvOne.meetingTitle}"></c:out>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>목적</th>
				<td>
					<textarea rows="3" cols="30" name="content" readonly="readonly"><c:out value="${roomRsvOne.meetingReason}"></c:out></textarea>
				</td>
			</tr>
		</table>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
</body>
</html>