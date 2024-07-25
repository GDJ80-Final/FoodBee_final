<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>수신함</h1>
<div>
    <table border="1">
        <tr>
            <th>결재대기</th>
            <th>승인중</th>
            <th>승인완료</th>
            <th>반려</th>
        </tr>
        <tr>
            <td><c:out value="${stateBox.zeroState == null ? 0 : stateBox.zeroState}"></c:out>건</td>
            <td><c:out value="${stateBox.oneState == null ? 0 : stateBox.oneState}"></c:out>건</td>
            <td><c:out value="${stateBox.twoState == null ? 0 : stateBox.twoState}"></c:out>건</td>
            <td><c:out value="${stateBox.nineState == null ? 0 : stateBox.nineState}"></c:out>건</td>
        </tr>
    </table>
</div>
<button>전체</button>
<div>
    <table border="1">
        <tr>
            <th>양식유형</th>
            <th>기안자</th>
            <th>제목</th>
            <th>결재상태</th>
            <th>기안일시</th>
        </tr>
        <!-- c:forEach를 사용하여 referrerList의 항목을 반복 출력 -->
        <c:forEach var="item" items="${referrerList}">
            <tr>
                <td><c:out value="${item.tmpName}"></c:out></td>
                <td><c:out value="${item.empName}"></c:out></td>
                <td><a href="">
                		<c:out value="${item.title}"></c:out>
                	</a>
                </td>
                <td><c:out value="${item.docApproverStateNo}"></c:out></td>
                <td><c:out value="${item.createDatetime}"></c:out></td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
