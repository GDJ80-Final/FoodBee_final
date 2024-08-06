<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 회의실 목록</title>
<style>
    /* 테이블 헤더 중앙 정렬 스타일 추가 */
    table th, td {
        text-align: center; /* 텍스트 중앙 정렬 */
    }
	/* 이미지 스타일 */
    .room-image {
        width: 350px;      /* 이미지 너비 */
        height: 200px;     /* 이미지 높이 */
        object-fit: cover; /* 비율에 맞게 자르기 */
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
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">회의실 조회</a></li>
             </ol>
         </div>
   	</div>
	<div style="margin-left: 30px;">예약 일자 <input type="date" id="dateInput"></div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">										
					<div class="card-body">	
						<!-- 여기서부터 내용시작 -->
						<table class="table header-border">						
							<tr>
								<th style="width:20%; height:50px;">회의실 명</th>
								<th style="width:35%; height:50px;">이미지</th>
								<th style="width:20%; height:50px;">위치</th>
								<th style="width:15%; height:50px;">수용인원</th>
							</tr>
							<c:forEach var="m" items="${list}">	
								<tr>
									<td style="height:100%;text-align: center;">
										<form action="${pageContext.request.contextPath}/room/roomOne" method="get">
											<input type="hidden" name="roomNo" value="${m.roomNo}">
											<input type="hidden" name="date" id="hiddenDateInput_${m.roomNo}">
											
											<a href="#" onclick="submitForm(this, ${m.roomNo}); return false;">
												<h3>${m.roomName}</h3>
											</a>
										</form>	
									</td>
									<td style="height:100%;">
										<img src="${pageContext.request.contextPath}/upload/room_img/${m.originalFile}" class="room-image">					
									</td>
									<td style="height:200px;">${m.roomPlace}</td>
									<td style="height:200px;">최대 ${m.roomMax}명</td>
								</tr>
							</c:forEach>	
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
// 페이지가 로드되었을 때 실행될 함수
window.onload = function() {
    let today = new Date();
    let year = today.getFullYear();
    let month = ('0' + (today.getMonth() + 1)).slice(-2);
    let day = ('0' + today.getDate()).slice(-2);
    let dateString = year + '-' + month + '-' + day;
    document.getElementById('dateInput').setAttribute('min', dateString);
    dateInput.value = dateString; // 기본값 설정
}

function submitForm(link, roomNo) {
	let form = link.closest('form');
	let dateInput = document.getElementById('dateInput');
    document.getElementById('hiddenDateInput_' + roomNo).value = dateInput.value; // 선택된 날짜 설정
    form.submit(); // 폼 제출
}
</script>
</body>
</html>