<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 예약 목록</title>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    .page-link:disabled {
        color: lightgray; /* 비활성화된 버튼의 글씨색을 회색으로 변경 */
        border-color: #dee2e6; /* 테두리 색상도 변경 */
        cursor: not-allowed; /* 커서를 변경하여 클릭 불가를 표시 */
    }
	b {
        color: blue; /* 파란색으로 설정 */
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
                <li class="breadcrumb-item"><a href="javascript:void(0)">예약</a></li>
                <li class="breadcrumb-item"><a href="javascript:void(0)">예약 조회</a></li>
                <li class="breadcrumb-item active"><a href="javascript:void(0)">전체 예약</a></li>
            </ol>
        </div>
   	</div>
	
		<div class="container-fluid">
        	<div class="row">
				<div class="col-lg-12">
   					<div class="card">
   					<div class="card-body">
   						<!-- 여기서부터 내용시작 -->
						<!-- Nav tabs -->
					    <div class="default-tab">
						    <div id="categoryButtons">
						    <ul class="nav nav-tabs mb-3" role="tablist">
								<li class="nav-item">
									<a href="${pageContext.request.contextPath}/room/roomRsvList" class="nav-link active">날짜별 예약</a>
								</li>
								<li class="nav-item">
									<a href="${pageContext.request.contextPath}/room/myRoomRsvList" class="nav-link">내 예약</a>
								</li>				
								<c:if test="${rankName eq '팀장'}">
									<li class="nav-item">
										<a href="${pageContext.request.contextPath}/room/cancleRsvList" class="nav-link">예약 취소</a>
									</li>
								</c:if>
							</ul>
							</div>
						</div>		
						<form id="dateForm" method="get" action="${pageContext.request.contextPath}/room/roomRsvList">
						    <input type="date" id="dateInput" name="date" value="${rsvDate}">
						</form>
						
						<table class="table header-border">
						    <thead>
						        <tr>   
						            <th>예약 날짜</th>
						            <th>예약시간</th>
						            <th>제목</th>
						            <th>예약자</th>
						            <th>&nbsp;</th>
						        </tr>
						    </thead>
						    <tbody>
						        <c:forEach var="rsv" items="${rsvListByDate}">
						            <tr>
						                <td>${rsv.rsvDate}</td>
						                <td>${rsv.startTime} ~ ${rsv.endTime}</td>
						                <td>
						                    <a href="#" class="info-link" data-reason="${rsv.meetingReason}" data-users="${rsv.users}" data-name="${rsv.roomName}">
						                        <b>${rsv.meetingTitle}</b>
						                    </a>
						                </td>
						                <td>${rsv.empName}</td>
						                <td>&nbsp;</td>
						            </tr>
							       
						        </c:forEach>
								<c:if test="${empty rsvListByDate}">
								    <tr>
								    	<td colspan="5">
								    		<h3>등록 된 예약이 없습니다.</h3>
								    	</td>
								    </tr>
								</c:if>
						    </tbody>
						</table>
						<!-- panel & page -->
                        <div class="bootstrap-pagination mt-3" id="page">
						    <nav>
						        <ul class="pagination justify-content-center">
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == 1}">disabled</c:if>
						                    onclick="if(${currentPage} > 1) location.href='${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=1'">처음</button>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == 1}">disabled</c:if>
						                    onclick="if(${currentPage} > 1) location.href='${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=${currentPage - 1}'">이전</button>
						            </li>
						            <li class="page-item active">
						                <div class="page-link">${currentPage}</div>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage >= lastPage || totalRows <= 10}">disabled</c:if>
						                    onclick="if(${currentPage} < ${lastPage}) location.href='${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=${currentPage + 1}'">다음</button>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage >= lastPage || totalRows <= 10}">disabled</c:if>
						                    onclick="if(${currentPage} < ${lastPage}) location.href='${pageContext.request.contextPath}/room/roomRsvList?date=${rsvDate}&currentPage=${lastPage}'">마지막</button>
						            </li>
						        </ul>
						    </nav>
						</div>						
						
						<!-- 정보 모달 구조 -->
						<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel" aria-hidden="true">
						    <div class="modal-dialog" role="document">
						        <div class="modal-content">
						            <div class="modal-header">
						                <h5 class="modal-title" id="infoModalLabel">회의 정보</h5>
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						                    <span aria-hidden="true">&times;</span>
						                </button>
						            </div>
						            <div class="modal-body">
						                <p id="modalName"></p>
						                <p id="modalReason"></p>
						                <p id="modalUsers"></p>                
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
<!-- 부트스트랩 JS, Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
    // 페이지 로드 시 기본값 설정
    let today = new Date();
    let year = today.getFullYear();
    let month = ('0' + (today.getMonth() + 1)).slice(-2);
    let day = ('0' + today.getDate()).slice(-2);
    let dateString = year + '-' + month + '-' + day;

    // 기본 날짜값 설정
    if (!$('#dateInput').val()) {
        $('#dateInput').val(dateString);
    }

    // 날짜 입력 변경 시 폼 제출
    $('#dateInput').on('change', function() {
        $('#dateForm').submit();
    });

    // 제목 클릭 시 정보 모달 열기
    $('table').on('click', '.info-link', function(e) {
        e.preventDefault();
        let name = $(this).data('name');
        let reason = $(this).data('reason');
        let users = $(this).data('users');

        // 모달에 값 설정
        $('#modalName').text("회의실: " + name);
        $('#modalReason').text("목적: " + reason);
        $('#modalUsers').text("참석 인원: " + users);

        // 모달 열기
        $('#infoModal').modal('show');
    });
});
</script>
</body>
</html>