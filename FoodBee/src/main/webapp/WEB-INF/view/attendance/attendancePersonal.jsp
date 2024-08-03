<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 조회</title>
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
						    <label for="startDate">기간 선택</label>
						    <input type="date" id="startDate" name="startDate" value="${param.startDate}">
						    <label for="endDate"> - </label>
						    <input type="date" id="endDate" name="endDate" value="${param.endDate}">
						    <button type="submit">조회</button>
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
						                <td colspan="7" style="text-align:center;">등록된 근무시간이 없습니다.</td>
						            </tr>
						        </c:when>
						        <c:otherwise>
						            <c:forEach var="m" items="${list}">
						            	<tr>
						                	<td>${m.empNo}</td>
						                    <td>${m.date}</td>
						                    <td><b>수정: ${m.updateStartTime}</b><br>등록: ${m.startTime}</td>
						                    <td><b>수정: ${m.updateEndTime}</b><br>등록: ${m.endTime}</td>
						                    <td>
						                        <c:choose>
						                            <c:when test="${not empty map.rankName and not empty map.empName}">
						                                ${map.rankName} ${map.empName}
						                            </c:when>
						                            <c:otherwise>
						                                없음
						                            </c:otherwise>
						                        </c:choose>
						                    </td>
						                    <!-- 승인상태 -->
						                    <c:if test="${m.approvalState eq '승인' || m.approvalState eq '미승인' || m.approvalState eq '등록 전'}">
						                        <td>${m.approvalState}</td>
						                    </c:if>
						                    <c:if test="${m.approvalState eq '반려'}">
						                        <td>
						                        	<button type="button" onclick="showApprovalReason('${m.approvalReason}', '${pageContext.request.contextPath}/attendance/attendanceReport?date=${m.date}')">
													    ${m.approvalState}
													</button>
						                        </td>
						                    </c:if>
						                    
						                    <!-- endTime 미등록 시 X -->
						                    <c:choose>
						                        <c:when test="${empty m.endTime}">
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
						<div>
						    <c:if test="${param.startDate == null || param.endDate == null}">
						        <c:if test="${currentPage > 1}">
						            <a href="${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage - 1}">이전</a>
						        </c:if>
						        <span>페이지 ${currentPage} / ${lastPage}</span>
						        <c:if test="${currentPage < lastPage}">
						            <a href="${pageContext.request.contextPath}/attendance/attendancePersonal?currentPage=${currentPage + 1}">다음</a>
						        </c:if>
						    </c:if>
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