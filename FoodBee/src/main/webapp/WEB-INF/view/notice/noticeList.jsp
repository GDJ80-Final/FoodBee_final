<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<h1>공지사항</h1>
<button id="list" data-url="${pageContext.request.contextPath}/notice/allNoticeList" data-type="list">전체</button>
<button id="emp" data-url="${pageContext.request.contextPath}/notice/allEmpList" data-type="emp">전사원</button>
<button id="dpt" data-url="${pageContext.request.contextPath}/notice/allDptList" data-type="dpt">부서별</button>

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
    <tbody id="noticeTableBody">
    </tbody>
</table>

<div id="paginationControls">
    <!-- 페이지네이션 링크가 여기에 동적으로 추가됩니다 -->
</div>
 <c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
   	<a href="addNotice">공지사항 작성</a>
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    let currentType = 'list'; // 초기 상태는 'list'
    let currentPage = ${currentPage}; // 서버에서 전달받은 현재 페이지
    let dptNo = "${dptNo}";

    // 페이지 로드 시 초기 데이터(전체 리스트) 보이기 
    //id가 noticeTableBody인 div 숨기기
    fetchPageData(); //아래쪽의 fetchPageData에서 바로 실행해서 따로 안만들어도 된다!

    // 버튼 클릭 이벤트
    $("button").click(function() {
        currentType = $(this).data('type');
        let url = $(this).data('url');
        fetchPageData(url, currentPage, dptNo);
    });

   //function updatePagination에서 a버튼을 클릭했을때 정상적으로 작동해야한다
   //탭 분기를 한 곳에서 a태그가 실행될 것이라고 생각했던 것이 잘못이었다...
    $(document).on('click', '#paginationControls a', function(e) {
        e.preventDefault();
        let page = $(this).data('page');
        if (page) {
            currentPage = page;
            fetchPageData();
        }
    });

    // 데이터 페칭 함수
    function fetchPageData() {
        let url = $("button[data-type='" + currentType + "']").data('url');
        $.ajax({
            url: url,
            type: "GET",
            data: {
                currentPage: currentPage,
                dptNo: dptNo
            },
            success: function(json) {
                if (json) {
                    let dataKey = currentType === 'emp' ? 'allEmpList' : currentType === 'dpt' ? 'allDptList' : 'list';
                    updateTable(json[dataKey]);
                    updatePagination(json.currentPage, json.lastPage || json.empLastPage || json.dptLastPage);
                } else {
                    alert("데이터를 가져올 수 없습니다.");
                }
            },
            error: function() {
                alert("데이터를 가져올 수 없습니다.");
            }
        });
    }

    //여기는 테이블 업데이트(기존에 짜놓은 코드 활용해서 가져왔음)
    function updateTable(json) {
        let tableBody = $("#noticeTableBody");
        tableBody.empty();

        $.each(json, function(index, item) {
            let date = new Date(item.createDatetime);
            let formattedDate = date.toISOString().split('T')[0]; // yyyy-MM-dd 포맷으로 변환

            let newRow = $("<tr>" +
                "<td>" + item.noticeNo + "</td>" +
                "<td>" + item.type + "</td>" +
                "<td><a href='" + "${pageContext.request.contextPath}/notice/noticeOne?noticeNo=" + item.noticeNo + "'>" + item.title + "</a></td>" +
                "<td>" + item.name + "</td>" +
                "<td>" + formattedDate + "</td>" +
                "</tr>");
            tableBody.append(newRow);
        });
    }

	//여기서 페이지 업데이트
    function updatePagination(currentPage, lastPage) {
        let paginationControls = $("#paginationControls");
        paginationControls.empty();

        let paginationHtml = '<a href="#" data-page="1">First</a> ';
        for (let i = 1; i <= lastPage; i++) {
            paginationHtml += '<a href="#" data-page="' + i + '">' + i + '</a> ';
        }
        paginationHtml += '<a href="#" data-page="' + lastPage + '">Last</a>';

        paginationControls.html(paginationHtml);
    }
});
</script>
</body>
</html>