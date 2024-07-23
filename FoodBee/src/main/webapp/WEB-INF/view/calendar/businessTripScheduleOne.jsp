<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출장상세보기</title>
</head>
<body>
<h1>출장상세보기</h1>
<div>
<a href="schedule">돌아가기</a>
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
                <input type="text" value="<c:out value="${tripHistoryOne.cancleYN}"/>" readonly="readonly">
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
    </table>
</div>
</body>
</html>