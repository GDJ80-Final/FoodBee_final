<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전일 근태보고 수정</title>
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
	                <li class="breadcrumb-item"><a href="javascript:void(0)">근태 보고</a></li>
	                <li class="breadcrumb-item active"><a href="javascript:void(0)">근태 수정</a></li>
	            </ol>
	        </div>
	   	</div>
	
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
   					<div class="card">
   					<div class="card-body">
  						<!-- 여기서부터 내용시작 -->
						<form method="post" action="${pageContext.request.contextPath}/attendance/attendanceModifyAction" onsubmit="return validateForm();">
						    <table class="table header-border">
						        <tr>
						            <th style="width: 30%">확인일자</th>
						            <td style="width: 30%"><input type="date" name="date" value="${attendanceDTO.date}" readonly="readonly"></td>
						            <td style="width: 40%"></td>
						        </tr>
						        <tr>
						            <th>출근 시간</th>
						            <td>${attendanceDTO.updateStartTime}</td>
						            <td><input type="datetime" name="updateStartTime" value="${attendanceDTO.updateStartTime}"></td>
						        </tr>
						        <tr>
						            <th>퇴근 시간</th>
						            <td>${attendanceDTO.updateEndTime}</td>
						            <td><input type="datetime" name="updateEndTime" value="${attendanceDTO.updateEndTime}"></td>							            							            
						        </tr>
						        <tr>
						            <th>승인자</th>
						            <td>${map.rankName} ${map.empName}</td>
						            <td></td>
						        </tr>
						        <tr>
						            <th>수정 사유</th>
						            <td style="height:200px;" colspan="2"><textarea name="updateReason" style="width:65%; height:100%;" placeholder="수정 사유를 입력하세요."></textarea></td>
						        </tr>
						    </table>
						    <div class="text-center" style="margin-bottom: 20px;margin-top: 80px;">
							    <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/attendance/attendanceReport'">돌아가기</button>&nbsp;&nbsp;&nbsp;&nbsp;
							    <button type="submit" class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10">수정 완료</button>
						    </div>
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
function validateForm() {
    let updateReason = document.getElementsByName("updateReason")[0].value.trim();
    
    if (updateReason === "") {
        alert("수정 사유를 입력 하세요");
        return false; // 입력 막음
    }
    return true;
}
</script>
</body>
</html>