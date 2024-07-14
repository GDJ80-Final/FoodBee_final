<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice</title>
<style>
    .content-div {
        display: none;
    }
</style>
<script>
    function show(divId) {
        var divs = ['allList', 'allEmpList', 'deptList']; // 모든 div ID 목록
        for (var i = 0; i < divs.length; i++) {
            document.getElementById(divs[i]).style.display = 'none';
        }
        document.getElementById(divId).style.display = 'block';
    }
    // 페이지가 로드될 때 기본적으로 allList를 표시
    window.onload = function() {
        show('allList');
    }
</script>
</head>
<body>
<h1>공지사항</h1>
    <button onclick="show('allList')">전체</button>
    <button onclick="show('allEmpList')">전사원</button>
    <button onclick="show('deptList')">부서별</button>
    
    <div id="allList" class="content-div">
        <table border="1">
            <tr>
                <th>번호</th>
                <th>유형</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일자</th>
            </tr>
            <c:forEach var="all" items="${list}">
                <tr>
                    <td>${all.noticeNo}</td>
                    <td>${all.type}</td>
                    <td>
                    	<a href="${pageContext.request.contextPath}/noticeOne?noticeNo=${all.noticeNo}">
                    		${all.title}
                    	</a>
                    </td>
                    <td>${all.name}</td>
                    <td>${all.createDatetime}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    
    <div id="allEmpList" class="content-div">
        <table border="1">
            <tr>
                <th>번호</th>
                <th>유형</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일자</th>
            </tr>
            <c:forEach var="emp" items="${allEmpList}">
                <tr>
                    <td>${emp.noticeNo}</td>
                    <td>${emp.type}</td>
                    <td>
                    	<a href="${pageContext.request.contextPath}/noticeOne?noticeNo=${emp.noticeNo}">
                    		${emp.title}
                    	</a>
                    </td>
                    <td>${emp.name}</td>
                    <td>${emp.createDatetime}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    
    <div id="deptList" class="content-div">
        <table border="1">
            <tr>
                <th>번호</th>
                <th>유형</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일자</th>
            </tr>
            <c:forEach var="dpt" items="${allDptList}">
                <tr>
                    <td>${dpt.noticeNo}</td>
                    <td>${dpt.type}</td>
                    <td>
                    	<a href="${pageContext.request.contextPath}/noticeOne?noticeNo=${dpt.noticeNo}">
                    		${dpt.title}
                    	</a>
                    </td>
                    <td>${dpt.name}</td>
                    <td>${dpt.createDatetime}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <a href="addNotice">공지사항 작성</a>
</body>
</html>