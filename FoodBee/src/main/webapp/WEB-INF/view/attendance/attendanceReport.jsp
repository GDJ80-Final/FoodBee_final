<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 근태보고</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
	                <li class="breadcrumb-item active"><a href="javascript:void(0)">근태 보고</a></li>
	            </ol>
	        </div>
	   	</div>
	
		<div class="container-fluid">
        	<div class="row">
				<div class="col-lg-12">
   					<div class="card">
   					<div class="card-body">
  						<!-- 여기서부터 내용시작 -->
						<form method="post" action="${pageContext.request.contextPath}/attendance/attendanceFinalTime">
							<input type="hidden" name="date" value="${attendanceDTO.date}">
							<table class="table header-border">
							<c:choose>
							    <c:when test="${empty attendanceDTO.date and empty attendanceDTO.updateStartTime and empty attendanceDTO.updateEndTime}">
							        <tr>
							            <td colspan="2" style="text-align:center;">등록된 근무가 없습니다.</td>
							        </tr>
							    </c:when>
							    
							    <c:otherwise>
							        <tr>
							            <th>확인일자</th>
							            <td>${attendanceDTO.date}</td>
							        </tr>
							        <tr>
							            <th>출근 시간</th>
							            <td>${attendanceDTO.updateStartTime}</td>
							        </tr>
							        <tr>
							            <th>퇴근 시간</th>
							            <td>${attendanceDTO.updateEndTime}</td>
							        </tr>
							        <tr>
							            <th>승인자</th>
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
							        </tr>
							    </c:otherwise>
							</c:choose>
							</table>
							<c:if test="${attendanceDTO.date ne null and attendanceDTO.approvalState == 0 or attendanceDTO.approvalState == 9}">
								<div class="text-center" style="margin-bottom: 20px;margin-top: 80px;">
									<button type="button" class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceModify?date=${attendanceDTO.date}'">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="submit" class="btn btn-dark" onclick="showAlert();">확정</button>
								</div>
							</c:if>	
						</form>
					</div>	
					</div>	
				</div>		
			</div>
		</div>		
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>

<script>
	// 알림을 띄우는 함수
	function showAlert() {
	    alert("확정되었습니다.");
	}
</script>
</body>
</html>