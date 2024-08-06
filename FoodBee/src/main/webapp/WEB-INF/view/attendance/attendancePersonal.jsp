<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 근태 조회</title>
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
	                <li class="breadcrumb-item active"><a href="javascript:void(0)">근태 조회</a></li>
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
									<button type="button" class="nav-link active" onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal'">전체</button>
								</li>								
							</ul>
							</div>
						</div>		
						<form method="get" action="${pageContext.request.contextPath}/attendance/attendancePersonal">
						    <label for="startDate"><b>기간 선택 </b></label>
						    <input type="date" id="startDate" name="startDate" value="${param.startDate}">
						    <label for="endDate"> - </label>
						    <input type="date" id="endDate" name="endDate" value="${param.endDate}">
						    <button type="submit" class="btn btn-secondary btn-sm" style="color: white;">조회</button>
						</form>
						
						<table class="table header-border">
							<tr>
								<th>사원번호</th>
								<th>해당일자</th>
								<th>출근시간</th>
								<th>퇴근시간</th>
								<th>승인자</th>
								<th>승인상태</th>
								<th>수정여부</th>
							</tr>
							<c:choose>
						        <c:when test="${empty list}">
						            <tr>
						                <td colspan="7"><h3>등록 된 근무 시간이 없습니다.</h3></td>
						            </tr>
						        </c:when>
						        <c:otherwise>
						            <c:forEach var="m" items="${list}">
						            	<tr>
						                	<td>${m.empNo}</td>
						                    <td>${m.date}</td>
						                    <td><h4>&nbsp;${m.updateStartTime}</h4><span style="font-size:12px;">등록: ${m.startTime}</span></td>
						                    <td><h4>&nbsp;${m.updateEndTime}</h4><span style="font-size:12px;">등록: ${m.endTime}</span></td>
					                        
					                        <!-- 승인자 없을시 없음 -->
					                        <c:choose>
					                            <c:when test="${not empty map.rankName and not empty map.empName}">
					                                <td>${map.rankName} ${map.empName}</td>
					                            </c:when>
					                            <c:otherwise>
					                                <td>없음</td>
					                            </c:otherwise>
					                        </c:choose>
						                    
						                    <!-- 반려일시 버튼 -->
						                    <c:if test="${m.approvalState eq '승인' || m.approvalState eq '미승인' || m.approvalState eq '확정 전'}">
						                        <td>${m.approvalState}</td>
						                    </c:if>
						                    <c:if test="${m.approvalState eq '반려'}">
						                        <td>
						                        	<button type="button" class="btn btn-dark" onclick="showApprovalReason('${m.approvalReason}', '${pageContext.request.contextPath}/attendance/attendanceReport?date=${m.date}')">
													    ${m.approvalState}
													</button>
						                        </td>
						                    </c:if>
						                    
						                    <!-- endTime 미등록 시 X -->
						                    <c:choose>
						                        <c:when test="${empty m.updateEndTime}">
						                            <td>X</td>
						                        </c:when>
						                        <c:otherwise>
						                            <td>${m.updateStatus}</td>
						                        </c:otherwise>
						                    </c:choose>
						                </tr>
						            </c:forEach>
						        </c:otherwise>
						    </c:choose>
						</table>
						<!-- panel & page -->
                        <div class="bootstrap-pagination mt-3" id="page">
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item">
                                     	<!-- 기본값은 currentPage만 만약 startDate와 endDate가 있으면 해당 값도 포함 -->
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == 1}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=1<c:if test="${not empty param.startDate}">&startDate=${param.startDate}</c:if><c:if test="${not empty param.endDate}">&endDate=${param.endDate}</c:if>'">처음</button>
                                    </li>
                                    <li class="page-item">
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == 1}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage - 1}<c:if test="${not empty param.startDate}">&startDate=${param.startDate}</c:if><c:if test="${not empty param.endDate}">&endDate=${param.endDate}</c:if>'">이전</button>
                                    </li>
                                    <li class="page-item active">
                                        <div class="page-link">${currentPage}</div>
                                    </li>
                                    <li class="page-item">
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == lastPage || empty list}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage + 1}<c:if test="${not empty param.startDate}">&startDate=${param.startDate}</c:if><c:if test="${not empty param.endDate}">&endDate=${param.endDate}</c:if>'">다음</button>
                                    </li>
                                    <li class="page-item">
                                        <button type="button" class="page-link" 
                                            <c:if test="${currentPage == lastPage || empty list}">disabled</c:if>
                                            onclick="location.href='${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${lastPage}<c:if test="${not empty param.startDate}">&startDate=${param.startDate}</c:if><c:if test="${not empty param.endDate}">&endDate=${param.endDate}</c:if>'">마지막</button>
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

<script>
function showApprovalReason(reason, redirectUrl) {
    alert('반려사유: ' + reason); // 반려사유를 alert 창으로 표시
    location.href = redirectUrl; // 확인을 누르면 해당 URL로 이동
}
</script>
</body>
</html>