<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가일정 상세보기</title>
</head>
<body>
<h1>휴가일정 상세보기</h1>
<a href="scheduleList">돌아가기</a>
<table border="1">
    <tr>
        <th>휴가자</th>
        <td>
            <input type="text" value="${dayOffOne.empName}" readonly="readonly">
        </td>
    </tr>
    <tr>
        <th>시작일시</th>
        <td>
             <input type="datetime-local" name="startDate" value="${dayOffOne.formattedStartDate}" readonly="readonly">
        </td>
    </tr>
    <tr>
        <th>종료일시</th>
        <td>
            <input type="datetime-local" name="endDate" value="${dayOffOne.formattedEndDate}" readonly="readonly">
        </td>
    </tr>
    <tr>
        <th>유형</th>
        <td>
            <input type="text" value="${dayOffOne.typeName}" readonly="readonly">
        </td>
    </tr>
    <tr>
        <th>사용년도</th>
        <td>
            <input type="text" value="${dayOffOne.useYear}" readonly="readonly">
        </td>
    </tr>
    <tr>
        <th>비상연락처</th>
        <td>
            <input type="text" value="${dayOffOne.emergencyContact}" readonly="readonly">
        </td>
    </tr>
    <tr>
      <th>취소유무</th>
      <td>
          <input type="text" value="<c:out value="${dayOffOne.cancleYN}"/>" readonly="readonly">
      </td>
  	</tr>
	<c:if test="${dayOffOne.cancleYN == 'Y'}">
      <tr>
          <th>취소 이유</th>
          <td>
              <input type="text" value="<c:out value="${dayOffOne.cancleReason}"/>" readonly="readonly">
          </td>
      </tr>
  	</c:if>
  	<tr>
        <th>사유/목적</th>
        <td>
        	<textarea rows="4" cols="50" readonly="readonly" ><c:out value="${dayOffOne.content}"/></textarea>
        </td>
    </tr>
</table>
</body>
</html>