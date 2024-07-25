<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>일정추가</h3>
<a href="schedule">돌아가기</a>
<body>
	<form method="post" action="addScheduleAction">
		<table border="1">
			<tr>
				<th>작성자</th>
				<td>
					<c:out value="${empName}"></c:out>
				</td>
			</tr>
			<tr>
				<th>시작일시</th>
				<td>
					<input type="datetime-local" name="startDatetime">
				</td>
			</tr>
			<tr>
				<th>종료일시</th>
				<td>
					<input type="datetime-local" name="endDatetime">
				</td>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<select name="type">
						<option value="개인">개인</option>
						<c:if test="${rankName != '사원'}">
							<option value="팀">팀</option>					
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>메모</th>
				<td>
					<textarea rows="3" cols="30" name="content"></textarea>
				</td>
			</tr>
		</table>
		<input type="hidden" name="empNo" value='<c:out value="${empNo}"></c:out>'>
		<button type="submit">추가</button>
	</form>
</body>
</body>
</html>