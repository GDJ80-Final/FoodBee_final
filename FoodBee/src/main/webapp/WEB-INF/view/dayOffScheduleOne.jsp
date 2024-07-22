<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가일정 상세보기</title>
</head>
<body>
<h1>휴가일정 상세보기</h1>
<a href="schedule">돌아가기</a>
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
        <th>사용유형</th>
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
            <input type="text" value="${dayOffOne.emergencyContact}">
        </td>
    </tr>
</table>
</body>
</html>