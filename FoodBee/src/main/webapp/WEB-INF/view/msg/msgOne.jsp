<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<table>
			<tr>
				<td>쪽지번호</td>
				<td>${m.msgNo}</td>
			</tr>
			<tr>
				<td>보낸 이</td>
				<td>${m.sender}</td>
			</tr>
			<tr>
				<td>받는 이</td>
				<td>${m.receivers}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${m.title}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${m.content}</td>
			</tr>
		<!-- 파일 다운로드 -->
		
		<c:set var="saveFiles" value="${fn:split(m.saveFiles, ',')}" />
			<tr>
				<td>첨부파일</td>
				<td>
				<c:forEach var="file" items="${saveFiles}" varStatus="status">
					 <a href="${pageContext.request.contextPath}/download?file=${file}" download="${file}">
					  ${file}
					 </a>

	                 <br>
	            </c:forEach>
	            </td>
			</tr>
				
	</table>
</body>
</html>