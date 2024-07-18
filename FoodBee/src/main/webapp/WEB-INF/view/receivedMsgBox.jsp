<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<button type="button" name="readYN" id="all">전체</button>
	<button type="button" name="readYN" id="Y">읽음</button>
	<button type="button" name="readYN" id="N">안 읽음</button>
	<table border="1">
		<thead>
			<tr>
				<td>선택</td>
				<td>쪽지번호</td>
				<td>보낸이</td>
				<td>제목</td>
				<td>보낸일시</td>
			</tr>
		</thead>
		<tbody id="msgTableBody">
		<c:forEach var="msg" items="${list}">
			<tr>
				<td><input type="checkbox"></td>
				<td>${msg.msgNo}</td>
				<td>${msg.empName}</td>
				<td>
				<a href="${pageContext.request.contextPath}/msgOne?msgNo=${msg.msgNo}">
				${msg.title}
				</a>
				</td>
				<td>${msg.createDateTime}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
    <c:if test="${currentPage > 1}">
        <a href="receivedMsgBox?currentPage=1">First</a>
        <a href="receivedMsgBox?currentPage=${currentPage - 1}">◁</a>
    </c:if>
    <c:if test="${currentPage < lastPage}">
        <a href="receivedMsgBox?currentPage=${currentPage + 1}">▶</a>
        <a href="receivedMsgBox?currentPage=${lastPage}">Last</a>
    </c:if>
</div>
<script>
   
</script>
</body>
</html>