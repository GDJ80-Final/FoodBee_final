<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<body>
<h1>공지사항 상세보기</h1>
<div>
    <c:choose>
        <c:when test="${not empty one}">
            <table>
                <tr>
                    <th>제목</th> 
                    <td>${one[0].title}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${one[0].empName}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${one[0].createDatetime}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <c:forEach items="${one}" var="one">
                            <a href="${pageContext.request.contextPath}/download?file=${one.originalFile}" download="${one.originalFile}">
                                ${one.saveFile}
                            </a>
                            <br>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea rows="7" cols="50">${one[0].content}</textarea> 
                    </td>
                </tr>
            </table>
            
            <a href="noticeList">돌아가기</a>
            <c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
			    <form action="deleteNotice" method="post">
	                <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
	                <button type="submit">삭제</button>
            	</form>
			</c:if>
            <!-- 수정 버튼 추가 -->
            <c:if test="${one[0].empName == empName}">
                <form action="modifyNotice" method="get">
                    <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
                    <button type="submit">수정하기</button>
                </form>
            </c:if>
        </c:when>
    </c:choose>
</div>
</body>
</html>