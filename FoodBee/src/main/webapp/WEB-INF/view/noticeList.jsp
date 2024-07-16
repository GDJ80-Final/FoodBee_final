<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
    .content-div {
        display: none;
    }
</style>
</head>
<body>
<h1>공지사항</h1>
<button id="list">전체</button>
<button id="emp">전사원</button>
<button id="dpt">부서별</button>

<table border="1">
    <thead>
        <tr>
            <th>번호</th>
            <th>유형</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일자</th>
        </tr>
    </thead>
    <tbody id="first"><!-- 페이지 처음 들어가면 보이는 list -->
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
    </tbody>
    <tbody id="noticeTableBody" style="display:none;">
    </tbody>
</table>
<div id="first">
    <c:if test="${currentPage > 1}">
        <a href="noticeList?currentPage=1">First</a>
        <a href="noticeList?currentPage=${currentPage - 1}">◁</a>
    </c:if>
    <c:if test="${currentPage < lastPage}">
        <a href="noticeList?currentPage=${currentPage + 1}">▶</a>
        <a href="noticeList?currentPage=${lastPage}">Last</a>
    </c:if>
</div>

 <div id="page"></div>

<c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
    <a href="addNotice">공지사항 작성</a>
</c:if>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 페이지 로드 시 초기 데이터 보이기 & id가 noticeTableBody인 div숨기기
        $("#first").show();
        $("#noticeTableBody").hide();

        $("#list").click(function() {
            $.ajax({
                url: "${pageContext.request.contextPath}/allNoticeList", // mapping에서 가져옴
                type: "GET",
                data: {
                    currentPage: 1,
                    rowPerPage: 10,
                    dptNo: "${dptNo}"
                },
                success: function(json) {
                    updateTable(json.list);
                    updatePage(json.lastPage);
                },
                error: function() {
                    alert("전체 공지사항 가져올 수 없음.");
                }
            });
        });

        $("#emp").click(function() {
            $.ajax({
                url: "${pageContext.request.contextPath}/allEmpList", // mapping에서 가져옴
                type: "GET",
                data: {
                    currentPage: 1,
                    rowPerPage: 10
                },
                success: function(json) {//callBack함수 json으로 고정!
                    updateTable(json.allEmpList);
                	updatePage(json.empLastPage);
                },
                error: function() {
                    alert("전사원 공지사항 가져올 수 없음.");
                }
            });
        });

        $("#dpt").click(function() {
            let dptNo = "${dptNo}";

            $.ajax({
                url: "${pageContext.request.contextPath}/allDptList",
                type: "GET",
                data: {
                    currentPage: 1,
                    rowPerPage: 10,
                    dptNo: "${dptNo}"
                },
                success: function(json) {
                    updateTable(json.allDptList);
                    updatePage(json.dptLastPage);
                },
                error: function() {
                    alert("부서별 공지사항 가져올 수 없음");
                }
            });
        });

        function updateTable(json) {
            let tableBody = $("#noticeTableBody");
            tableBody.empty();

            $.each(json, function(index, item) { //여기서의 index는 for문의 i같은 개념이라고 생각하면된다.item은 실제값
                let date = new Date(item.createDatetime);
                let formattedDate = date.toISOString().split('T')[0]; // yyyy-MM-dd 포맷으로 변환

                let newRow = $("<tr>" +
                    "<td>" + item.noticeNo + "</td>" +
                    "<td>" + item.type + "</td>" +
                    "<td><a href='" + "${pageContext.request.contextPath}/noticeOne?noticeNo=" + item.noticeNo + "'>" + item.title + "</a></td>" +
                    "<td>" + item.name + "</td>" +
                    "<td>" + formattedDate + "</td>" +
                    "</tr>");
                tableBody.append(newRow);
            });

            // 테이블 표시 및 숨김 처리
            $("#first").hide();
            tableBody.show();
        }
        
        function updatePage(lastPage, currentPage) {
            let pagination = $("#page");
            pagination.empty();

        }

    });
</script>
</body>
</html>