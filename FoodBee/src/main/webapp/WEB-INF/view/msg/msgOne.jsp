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
		
			<c:set var="originalFiles" value="${fn:split(m.originalFiles, ',')}" />
			<c:set var="saveFiles" value="${fn:split(m.saveFiles, ',')}" />
			<tr>
				<td>첨부파일</td>
				<td>
				<c:forEach var="file" items="${originalFiles}" varStatus="status">
					 <a href="${pageContext.request.contextPath}/msg/download?file=${file}" download="${file}">
					  ${saveFiles[status.index]}
					 </a>

	                 <br>
	            </c:forEach>
	            </td>
			</tr>
				
	</table>
<script>
	$(document).ready(function(){
		let empName = '${empName}';
		let receivers = '${m.receivers}';
		let currentState = '${m.readYN}';
		console.log(empName);
		console.log(receivers);
		if(receivers.includes(empName) && currentState === 'N' ){
			$.ajax({
				url:'${pageContext.request.contextPath}/msg/updateReadYN',
				method:'post',
				data : {
					msgNo : '${m.msgNo}'
				},
				success:function(json){
					console.log('읽음상태 업데이트 완료');
				}
		})
		
		}else{
			console.log('업데이트 되지 않음');
		}
		
	})


</script>
</body>
</html>