<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 예약 취소 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 부트스트랩 CSS -->
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
	                <li class="breadcrumb-item"><a href="javascript:void(0)">예약</a></li>
	                <li class="breadcrumb-item"><a href="javascript:void(0)">예약 조회</a></li>
	                <li class="breadcrumb-item active"><a href="javascript:void(0)">예약 취소</a></li>
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
									<a href="${pageContext.request.contextPath}/room/roomRsvList" class="nav-link">날짜별 예약</a>
								</li>
								<li class="nav-item">
									<a href="${pageContext.request.contextPath}/room/myRoomRsvList" class="nav-link">내 예약</a>
								</li>				
								<c:if test="${rankName eq '팀장'}">
									<li class="nav-item">
										<a href="${pageContext.request.contextPath}/room/cancleRsvList" class="nav-link active">예약 취소</a>
									</li>
								</c:if>
							</ul>
							</div>
						</div>		
		
						<table class="table header-border">
						    <thead>
						        <tr> 
						            <th>회의실</th>
						            <th>예약일</th>
						            <th>예약시간</th>                
						            <th>제목</th>
						            <th>유형</th>
						            <th>참석인원</th>
						            <th>부서</th>
						            <th>예약자</th>     
						            <th>상태</th>
						        </tr>    
						    </thead>
						    <tbody>
						        <c:forEach var="m" items="${list}">   
						            <tr>
						                <td>${m.roomName}</td>
						                <td>${m.rsvDate}</td>
						                <td>${m.startTime} ~ ${m.endTime}</td>                                                            
						                <td>${m.meetingTitle}</td>
						                <td>${m.type}</td>
						                <td>${m.users} 명</td>
						                <td>${dptName}</td>
						                <td>${m.rankName} ${m.empName}</td>
						                <td>${m.rsvState}</td>
						            </tr>
						            <c:if test="${empty list}">
						            	<td colspan="9">
									    	<h3>취소 된 예약이 없습니다.</h3>
									    </td>
									</c:if>
						        </c:forEach>        	
						    </tbody>
						</table>
						<!-- panel & page -->
						<div class="bootstrap-pagination mt-3" id="page">
						    <nav>
						        <ul class="pagination justify-content-center">
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == 1}">disabled</c:if>
						                    onclick="location.href='${pageContext.request.contextPath}/room/cancleRsvList?currentPage=1'">처음</button>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == 1}">disabled</c:if>
						                    onclick="location.href='${pageContext.request.contextPath}/room/cancleRsvList?currentPage=${currentPage - 1}'">이전</button>
						            </li>
						            <li class="page-item active">
						                <div class="page-link">${currentPage}</div>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == lastPage}">disabled</c:if>
						                    onclick="location.href='${pageContext.request.contextPath}/room/cancleRsvList?currentPage=${currentPage + 1}'">다음</button>
						            </li>
						            <li class="page-item">
						                <button type="button" class="page-link" 
						                    <c:if test="${currentPage == lastPage}">disabled</c:if>
						                    onclick="location.href='${pageContext.request.contextPath}/room/cancleRsvList?currentPage=${lastPage}'">마지막</button>
						            </li>
						        </ul>
						    </nav>
						</div>

					</div>		
					</div>
				</div>						
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
</body>
</html>