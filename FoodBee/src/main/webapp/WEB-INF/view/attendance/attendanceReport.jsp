<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태보고</title>
</head>
<body>
<div id="main-wrapper">
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
	
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	<div class="content-body">
	<div class="container">
		<h1>근태보고</h1>
		<form method="post" action="${pageContext.request.contextPath}/attendance/attendanceFinalTime">
			<input type="hidden" name="date" value="${attendanceDTO.date}">
			<table border="1">
			<c:choose>
			    <c:when test="${empty attendanceDTO.date and empty attendanceDTO.updateStartTime and empty attendanceDTO.updateEndTime}">
			        <tr>
			            <td colspan="2" style="text-align:center;">등록된 근무가 없습니다.</td>
			        </tr>
			    </c:when>
			    
			    <c:otherwise>
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
			            <td>
			                <c:choose>
			                    <c:when test="${not empty map.rankName and not empty map.empName}">
			                        ${map.rankName} ${map.empName}
			                    </c:when>
			                    <c:otherwise>
			                        없음
			                    </c:otherwise>
			                </c:choose>
			            </td>
			        </tr>
			    </c:otherwise>
			</c:choose>
			</table>
			<c:if test="${attendanceDTO.date ne null and attendanceDTO.approvalState == 0}">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceModify?date=${attendanceDTO.date}'">수정</button>
				<button type="submit" onclick="showAlert();">확정</button>
			</c:if>	
		</form>
	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>

<script>
	// 알림을 띄우는 함수
	function showAlert() {
	    alert("확정되었습니다.");
	}
</script>
</body>
</html>