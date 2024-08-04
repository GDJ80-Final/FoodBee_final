<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>팀원 근태 조회</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .page-link:disabled {
            color: lightgray; /* 비활성화된 버튼의 글씨색을 회색으로 변경 */
            border-color: #dee2e6; /* 테두리 색상도 변경 */
            cursor: not-allowed; /* 커서를 변경하여 클릭 불가를 표시 */
        }
    </style>
</head>
<body>
<div id="main-wrapper">
    <jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
    
    <div class="content-body">
        <div class="row page-titles mx-0">
            <div class="col p-md-0">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">근태 관리</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0)">팀내 근태 조회</a></li>
                </ol>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="default-tab">
                                <div id="categoryButtons">
                                    <ul class="nav nav-tabs mb-3" role="tablist">
                                        <li class="nav-item">
										    <button class="nav-link active" data-status="all" onclick="loadAllAttendanceData(1); setActiveButton(this)">전체</button>
										</li>
										<li class="nav-item">
										    <button class="nav-link" data-status="1" onclick="loadAttendanceDataByStatus('1', 1); setActiveButton(this)">미승인</button>
										</li>
										<li class="nav-item">
										    <button class="nav-link" data-status="2" onclick="loadAttendanceDataByStatus('2', 1); setActiveButton(this)">승인</button>
										</li>
										<li class="nav-item">
										    <button class="nav-link" data-status="9" onclick="loadAttendanceDataByStatus('9', 1); setActiveButton(this)">반려</button>
										</li>
                                    </ul>
                                </div>
                            </div>

                            <!-- 사원명 검색 입력 필드 -->
                            <input type="text" id="search" placeholder="사원명으로 검색">
                            <button class="btn btn-secondary btn-sm" style="color: white;" onclick="performSearch()">검색</button>
                            
                            <!-- 데이터를 표시할 테이블 -->
                            <table class="table header-border" id="attendanceTable">
                                <thead>
                                    <tr>
                                        <th>사원 번호</th>
                                        <th>사원 이름</th>
                                        <th>해당 일자</th>
                                        <th>출근 시간</th>
                                        <th>퇴근 시간</th>
                                        <th>승인 상태</th>
                                        <th>수정 여부</th>
                                        <th>확정 일시</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- 데이터는 동적으로 삽입 -->
                                </tbody>
                            </table>
                            
                            <!-- 페이지네이션 -->
                            <div class="pagination justify-content-center" id="pagination">
                                <!-- 페이지네이션 링크는 동적으로 삽입 -->
                            </div>
                            
                            <!-- 반려 사유 입력 모달 구조 -->
                            <div class="modal fade" id="rejectionReasonModal" tabindex="-1" role="dialog" aria-labelledby="rejectionReasonModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="rejectionReasonModalLabel">반려 사유 입력</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <textarea id="rejectionReason" placeholder="반려 사유를 입력하세요." rows="3" class="form-control"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                            <button type="button" class="btn btn-primary" id="submitRejection">확인</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 수정 사유 확인 모달 -->
                            <div class="modal fade" id="updateReasonModal" tabindex="-1" role="dialog" aria-labelledby="updateReasonModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="updateReasonModalLabel">수정 사유</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p id="updateReasonText"></p> <!-- 수정 사유 내용 -->
                                            <br><br><br><hr>         
                                            <p id="updateStartTime"></p> <!-- 출근 시간 내용 -->
                                            <p id="updateEndTime"></p> <!-- 퇴근 시간 내용 -->
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                    </div>      
                </div>          
            </div>          
        </div>              
    </div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>

<script>
let currentPage = 1; // 현재 페이지
let currentStatus = 'all'; // 현재 상태: 'all', '1', '2', '9'

// 전체 근태 데이터를 로드하는 함수
function loadAllAttendanceData(page) {
    currentPage = page;
    $.ajax({
        url: '${pageContext.request.contextPath}/attendance/getAttendanceTeamMemberAll',
        type: 'GET',
        data: {
            empNo: ${empNo},
            dptNo: '${dptNo}',
            currentPage: page,
            search: $('#search').val() || '' // 검색어
        },
        success: function(response) {
            const data = response; 
            updateTable(data.allList);
            updatePagination(data.allCurrentPage, data.allLastPage, data.allList.length); // 데이터 길이 전달
        },
        error: function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 403) {
                alert('권한이 없습니다.');
            } else {
                console.error("오류:", textStatus, errorThrown);
            }
        }
    });
}

//상태에 따라 근태 데이터를 로드하는 함수
function loadAttendanceDataByStatus(status, page) {
    currentStatus = status; // 현재 상태 업데이트
    currentPage = page;
    $.ajax({
        url: '${pageContext.request.contextPath}/attendance/getAttendanceTeamMemberByStatus',
        type: 'GET',
        data: {
            empNo: ${empNo},
            dptNo: '${dptNo}',
            currentPage: page,
            search: $('#search').val() || '', // 검색어
            approvalState: status
        },
        success: function(json) {
            const data = json;
            updateTable(data.list);
            updatePagination(data.currentPage, data.lastPage, data.list.length); // 데이터 길이 전달
        },
        error: function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 403) {
                alert('권한이 없습니다.');
            } else {
                console.error("오류:", textStatus, errorThrown);
            }
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
    if (data.length === 0) {
        let row = $('<tr>');
        let cell = $('<td>').attr('colspan', '9').html('<h3>조회된 이력이 없습니다.</h3>');
        row.append(cell);
        tableBody.append(row);
    } else {
        data.forEach(function(item) {
            let row = $('<tr>');
            row.append($('<td>').text(item.empNo));
            row.append($('<td>').text(item.empName));
            row.append($('<td>').text(item.date));
            row.append($('<td>').text(item.updateStartTime));
            row.append($('<td>').text(item.updateEndTime));
            row.append($('<td>').text(item.approvalState));
            
            // 수정 여부 열 처리
            if (item.updateStatus === 'x') {
                row.append($('<td>').text('x')); // 수정 여부가 'x'일 경우
            } else {
                let updateStatusButton = $('<button>')
                    .text('사유 확인')
                    .addClass('btn btn-info btn-sm')
                    .click(function() {
                        $('#updateReasonText').text(item.updateReason); // 수정 사유를 모달에 표시
                        $('#updateStartTime').text('수정 전 출근: ' + item.startTime); // 출근 시간 추가
                        $('#updateEndTime').text('수정 전 퇴근: ' + item.endTime); // 퇴근 시간 추가
                        $('#updateReasonModal').modal('show'); // 모달 열기
                    });
                row.append($('<td>').append(updateStatusButton)); // 사유 확인 버튼 추가
            }

            // 반려 버튼 추가
            let rejectButton = $('<button>')
                .text('반려')
                .addClass('btn btn-danger btn-sm')
                .click(function() {
                    // 반려 사유 입력 모달 열기
                    $('#rejectionReasonModal').modal('show'); // 모달 열기
                    // 모달 확인 버튼 클릭 시 AJAX 호출
                    $('#submitRejection').off('click').on('click', function() {
                        let reason = $('#rejectionReason').val(); // 반려 사유 입력 값
                        $.ajax({
                            url: '${pageContext.request.contextPath}/attendance/attendanceRejection',
                            type: 'POST',
                            data: { 
                                date: item.date, 
                                empNo: item.empNo, 
                                approvalReason: reason 
                            },
                            success: function(response) {
                                alert('반려되었습니다.'); // 성공 메시지
                                loadAllAttendanceData(currentPage); // 데이터 새로 고침
                                $('#rejectionReasonModal').modal('hide'); // 모달 닫기
                                $('#rejectionReason').val(''); // 입력 값 초기화
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                if (jqXHR.status === 403) {
                                    alert('권한이 없습니다.');
                                } else {
                                    console.error("오류:", textStatus, errorThrown);
                                    alert('반려 중 오류가 발생했습니다.');
                                }
                            }
                        });
                    });
                });
                
            // 승인 버튼 추가
            let acceptButton = $('<button>')
                .text('승인')
                .addClass('btn btn-success btn-sm')
                .click(function() {        
                    $.ajax({
                        url: '${pageContext.request.contextPath}/attendance/attendanceAccept',
                        type: 'POST',
                        data: { 
                            date: item.date, 
                            empNo: item.empNo 
                        },
                        success: function(response) {
                            alert('승인되었습니다.'); 
                            loadAllAttendanceData(currentPage); // 데이터 새로 고침
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            if (jqXHR.status === 403) {
                                alert('권한이 없습니다.');
                            } else {
                                console.error("오류:", textStatus, errorThrown);
                                alert('승인 중 오류가 발생했습니다.'); 
                            }
                        }
                    });
                });
            
            row.append($('<td>').text(item.finalTime));
            row.append($('<td>').append(rejectButton).append('&nbsp;').append('&nbsp;').append(acceptButton)); // 버튼 추가
            tableBody.append(row);
        });
    }
}

// 페이지네이션을 업데이트하는 함수
function updatePagination(currentPage, lastPage, dataLength) {
    let pagination = $('#pagination');
    pagination.empty();

    // '처음' 버튼
    let firstButton = $('<li class="page-item">').append(
        $('<button type="button" class="page-link">').text('처음')
            .prop('disabled', currentPage === 1)
            .click(function() {
                changePage(1);
            })
    );

    // '이전' 버튼
    let prevButton = $('<li class="page-item">').append(
        $('<button type="button" class="page-link">').text('이전')
            .prop('disabled', currentPage === 1)
            .click(function() {
                changePage(currentPage - 1);
            })
    );

    // 현재 페이지 표시
    let currentPageItem = $('<li class="page-item active">').append(
        $('<div class="page-link">').text(currentPage)
    );

    // '다음' 버튼
    let nextButton = $('<li class="page-item">').append(
        $('<button type="button" class="page-link">').text('다음')
            .prop('disabled', (currentPage === lastPage || dataLength === 0))
            .click(function() {
                changePage(currentPage + 1);
            })
    );

    // '마지막' 버튼
    let lastButton = $('<li class="page-item">').append(
        $('<button type="button" class="page-link">').text('마지막')
            .prop('disabled', (currentPage === lastPage || dataLength === 0))
            .click(function() {
                changePage(lastPage);
            })
    );

    // 페이지네이션 추가
    pagination.append(firstButton)
              .append(prevButton)
              .append(currentPageItem)
              .append(nextButton)
              .append(lastButton);
}

// 페이지 변경 함수
function changePage(page) {
    // 현재 상태에 따라 데이터 로드
    if (currentStatus === 'all') {
        loadAllAttendanceData(page); // 전체 데이터 로드
    } else {
        loadAttendanceDataByStatus(currentStatus, page); // 상태에 따른 데이터 로드
    }
}

// 활성화된 버튼의 클래스를 업데이트하는 함수
function setActiveButton(button) {
    $('.nav-link').removeClass('active');
    $(button).addClass('active');
}


// 버튼 클릭 시 현재 상태를 업데이트하고 페이지를 로드
function onTabClick(status, button) {
    currentStatus = status; // 상태 업데이트
    changePage(1); // 페이지를 1로 초기화
    setActiveButton(button); // 클릭된 버튼에 active 클래스를 추가
}

// 각 탭에 대한 클릭 핸들러를 설정
$('.nav-link').click(function() {
    const status = $(this).data('status'); // 각 버튼에 data-status 속성 추가
    onTabClick(status, this); // 현재 버튼을 인자로 추가
});

// 페이지 로드 시 전체 데이터 로드
$(document).ready(function() {
    loadAllAttendanceData(1);
});
</script>
</body>
</html>