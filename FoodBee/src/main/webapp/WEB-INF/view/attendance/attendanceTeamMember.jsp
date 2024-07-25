<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 근태 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	/* 테이블 및 버튼에 대한 사용자 정의 스타일 */
	table { width: 100%; border-collapse: collapse; }
	th, td { padding: 8px; text-align: left; border: 1px solid #ddd; }
	th { background-color: #f4f4f4; }
	.pagination { margin: 10px 0; }
	.pagination a { margin: 0 5px; text-decoration: none; color: #007bff; }
	.active { font-weight: bold; }
</style>
</head>
<body>
    <h1>팀원 근태 조회</h1>

    <!-- 필터링 버튼 -->
    <button onclick="loadAllAttendanceData(1)">전체</button>
    <button onclick="loadAttendanceDataByStatus('0', 1)">미승인</button>
    <button onclick="loadAttendanceDataByStatus('1', 1)">승인</button>
    <br>
	<!-- 사원명 검색 입력 필드 -->
    <input type="text" id="search" placeholder="사원명으로 검색">
    <button onclick="performSearch()">검색</button>
    
    <!-- 데이터를 표시할 테이블 -->
    <table id="attendanceTable">
        <thead>
            <tr>
                <th>사원 번호</th>
                <th>사원 이름</th>
                <th>해당 일자</th>
                <th>출근 시간</th>
                <th>퇴근 시간</th>
                <th>출근 수정</th>
                <th>퇴근 수정</th>
                <th>승인 상태</th>
                <th>수정 여부</th>
                <th>수정 사유</th>
                <th>확정 일시</th>
            </tr>
        </thead>
        <tbody>
            <!-- 데이터는 동적으로 삽입 -->
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination" id="pagination">
        <!-- 페이지네이션 링크는 동적으로 삽입 -->
    </div>

<script>
let currentPage = 1; // 현재 페이지
let currentStatus = 'all';  // 현재 상태: 'all', '0', 또는 '1'

// 전체 근태 데이터를 로드하는 함수
function loadAllAttendanceData(page) {
    currentPage = page;
    currentStatus = 'all';
    $.ajax({
        url: '${pageContext.request.contextPath}/attendance/getAttendanceTeamMemberAll',
        type: 'GET',
        data: {
            empNo: ${empNo},
            dptNo: '${dptNo}',
            currentPage: page,
            search: $('#search').val() || ''  // 검색어
        },
        success: function(response) {
            // 응답 데이터는 JSON 형식이어야 함
            const data = response; // response가 JSON 형태로 전달되므로 data에 저장
            updateTable(data.allList);
            updatePagination(data.currentPage, data.allLastPage);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("오류:", textStatus, errorThrown);
        }
    });
}

// 상태에 따라 근태 데이터를 로드하는 함수
function loadAttendanceDataByStatus(status, page) {
    currentPage = page;
    currentStatus = status;
    $.ajax({
        url: '${pageContext.request.contextPath}/attendance/getAttendanceTeamMemberByStatus',
        type: 'GET',
        data: {
            empNo: ${empNo},
            dptNo: '${dptNo}',
            currentPage: page,
            search: $('#search').val() || '',  // 검색어
            approvalState: status
        },
        success: function(response) {
            // 응답 데이터는 JSON 형식이어야 함
            const data = response; // response가 JSON 형태로 전달되므로 data에 저장
            updateTable(data.list);
            updatePagination(data.currentPage, data.allLastPage);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("오류:", textStatus, errorThrown);
        }
    });
}

// 입력된 검색어로 검색을 수행하는 함수
function performSearch() {
    if (currentStatus === 'all') {
        loadAllAttendanceData(1);
    } else {
        loadAttendanceDataByStatus(currentStatus, 1);
    }
}

// 테이블을 업데이트하는 함수
function updateTable(data) {
    let tableBody = $('#attendanceTable tbody');
    tableBody.empty();
    data.forEach(function(item) {
        let row = $('<tr>');
        row.append($('<td>').text(item.empNo));
        row.append($('<td>').text(item.empName));
        row.append($('<td>').text(item.date));
        row.append($('<td>').text(item.startTime));
        row.append($('<td>').text(item.endTime));
        row.append($('<td>').text(item.updateStartTime));
        row.append($('<td>').text(item.updateEndTime));
        row.append($('<td>').text(item.approvalState));
        row.append($('<td>').text(item.updateStatus));
        row.append($('<td>').text(item.updateReason));
        row.append($('<td>').text(item.finalTime));
        tableBody.append(row);
    });
}

// 페이지네이션을 업데이트하는 함수
function updatePagination(currentPage, lastPage) {
    let pagination = $('#pagination');
    pagination.empty();
    for (let i = 1; i <= lastPage; i++) {
        let pageLink = $('<a>').text(i).attr('href', 'javascript:void(0)').click(function() {
            if (currentStatus === 'all') {
                loadAllAttendanceData(i);
            } else {
                loadAttendanceDataByStatus(currentStatus, i);
            }
        });
        if (i === currentPage) {
            pageLink.addClass('active');
        }
        pagination.append(pageLink);
    }
}

// 페이지 로드 시 전체 데이터 로드
$(document).ready(function() {
    loadAllAttendanceData(1);
});
</script>
</body>
</html>