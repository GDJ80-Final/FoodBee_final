<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 부트스트랩 JS, Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
	                <li class="breadcrumb-item active"><a href="javascript:void(0)">내 예약</a></li>
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
									<a href="${pageContext.request.contextPath}/room/roomRsvList" class="nav-link">전체 예약</a>
								</li>
								<li class="nav-item">
									<a href="${pageContext.request.contextPath}/room/myRoomRsvList" class="nav-link active">내 예약</a>
								</li>				
								<c:if test="${rankName eq '팀장'}">
									<li class="nav-item">
										<a href="${pageContext.request.contextPath}/room/cancleRsvList" class="nav-link">예약 취소</a>
									</li>
								</c:if>
							</ul>
							</div>
						</div>		
		
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
						        <c:forEach var="rsv" items="${rsvListByEmpNo}">   
						            <tr>
						                <td>${rsv.rsvDate}</td>
						                <td>${rsv.startTime} ~ ${rsv.endTime}</td>
						                <td>
						                    <a href="#" class="info-link" data-reason="${rsv.meetingReason}" data-users="${rsv.users}" data-name="${rsv.roomName}">
						                        <b>${rsv.meetingTitle}</b>
						                    </a>
						                </td>
						                <td>${rsv.empName}</td>
						                <td>
						                    <form method="post" action="${pageContext.request.contextPath}/room/cancleRoomRsv">
						                        <input type="hidden" name="empNo" value="${rsv.empNo}">
						                        <input type="hidden" name="rsvDate" value="${rsv.rsvDate}">
						                        <input type="hidden" name="startTime" value="${rsv.startTime}">
						                        <button class="btn btn-danger cancel-link" type="button">취소</button>
						                    </form> 
						                </td>
						            </tr>  
						        </c:forEach>
						        	<c:if test="${empty rsvListByEmpNo}">
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
						                    onclick="location.href='${pageContext.request.contextPath}/room/myRoomRsvList?currentPage=1'">처음</button>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == 1}">disabled</c:if>
						                    onclick="location.href='${pageContext.request.contextPath}/room/myRoomRsvList?currentPage=${currentPage - 1}'">이전</button>
						            </li>
						            <li class="page-item active">
						                <div class="page-link">${currentPage}</div>
						            </li>
						            <li class="page-item">
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == lastPage || empty rsvListByEmpNo}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/room/myRoomRsvList?currentPage=${currentPage + 1}'">다음</button>
                                    </li>
                                    <li class="page-item">
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == lastPage || empty rsvListByEmpNo}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/room/myRoomRsvList?currentPage=${lastPage}'">마지막</button>
                                    </li>
						        </ul>
						    </nav>
						</div>
		
						<!-- 예약 취소 모달 구조 -->
						<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
						    <div class="modal-dialog" role="document">
						        <div class="modal-content">
						            <div class="modal-header">
						                <h5 class="modal-title" id="cancelModalLabel">예약 취소</h5>
						                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						                    <span aria-hidden="true">&times;</span>
						                </button>
						            </div>
						            <div class="modal-body">
						                <p>예약을 취소하시겠습니까?</p>
						            </div>
						            <div class="modal-footer">
						                <form method="post" action="${pageContext.request.contextPath}/room/cancleRoomRsv">
						                    <input type="hidden" id="empNo" name="empNo">
						                    <input type="hidden" id="rsvDate" name="rsvDate">
						                    <input type="hidden" id="startTime" name="startTime">
						                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						                    <button type="submit" class="btn btn-primary">확인</button>
						                </form>
						            </div>
						        </div>
						    </div>
						</div>
						
						<!-- 목적과 참석 인원 모달 구조 -->
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

<script>
$(document).ready(function() {
    let today = new Date(); // 오늘 날짜 객체를 가져옴
    today.setHours(0, 0, 0, 0); // 시간을 0으로 설정하여 날짜만 비교

    // 각 예약 항목을 순회하며 날짜를 비교하고 취소 링크를 숨김
    $('table tr').each(function() {
        let rsvDateStr = $(this).find('td:eq(0)').text(); // 첫 번째 td 요소의 텍스트(예약 날짜)를 가져옴
        let rsvDate = new Date(rsvDateStr); // 예약 날짜를 Date 객체로 변환
        rsvDate.setHours(0, 0, 0, 0); // 시간을 0으로 설정하여 날짜만 비교

        if (rsvDate < today) {
            $(this).find('.cancel-link').hide(); // 예약 날짜가 오늘 이전인 경우 취소 링크를 숨김
        } else {
            $(this).find('.cancel-link').on('click', function(e) {
                e.preventDefault();
                let row = $(this).closest('tr');
                let empNo = row.find('input[name="empNo"]').val();
                let rsvDate = row.find('input[name="rsvDate"]').val();
                let startTime = row.find('input[name="startTime"]').val();

                // 모달에 값 설정
                $('#empNo').val(empNo);
                $('#rsvDate').val(rsvDate);
                $('#startTime').val(startTime);

                // 모달 열기
                $('#cancelModal').modal('show');
            });
        }
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