<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인일정 수정</title>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
<h4>개인일정 수정</h4>
<form method="post" action="modifyScheduleAction">
    <table>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" value="<c:out value='${one.empName}' />" readonly="readonly">
            </td>
        </tr>
        <tr>
            <th>시작일시</th>
            <td>
                <input type="datetime-local" name="startDatetime" value="<c:out value='${one.startDatetime}' />">
            </td>
        </tr>
        <tr>
            <th>종료일시</th>
            <td>
                <input type="datetime-local" name="endDatetime" value="<c:out value='${one.endDatetime}' />">
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="title" value="<c:out value='${one.title}' />">
            </td>
        </tr>
        <tr>
            <th>메모</th>
            <td>
                <textarea name="content" rows="5" cols="50"><c:out value='${one.content}' /></textarea>
            </td>
        </tr>
    </table>
    <input type="hidden" name="empNo" value='<c:out value="${one.empNo}" />'>
    <input type="hidden" name="scheduleNo" value='<c:out value="${one.scheduleNo}" />'>
    <button type="submit">수정</button>
</form>
</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
</body>
</html>