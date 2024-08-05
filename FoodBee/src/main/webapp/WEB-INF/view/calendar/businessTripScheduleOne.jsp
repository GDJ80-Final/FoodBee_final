<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 출장상세</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	table {
        width: 100%; 
    }
	th, td {
        border: 1px solid #ddd; /* 테두리 */
        padding: 10px; /* 셀 내부 여백 추가 */
        vertical-align: top; /* 셀 내용 상단 정렬 */
    }
    
    th {
        background-color: #f4f4f4; /* 헤더 셀 배경색 추가 */
    }
    #back{
    	width: 100px;
    	margin-bottom: 10px;
    }
</style>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
	<div class="row page-titles mx-0">
         <div class="col p-md-0">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item"><a href="javascript:void(0)">일정</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">일정조회</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">내일정상세</a></li>
             </ol>
         </div>
   	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		<!-- 여기부터 내용 -->
					<a href="scheduleList" class="btn btn-primary btn-block" id="back">돌아가기</a>
					    <table border="1">
					        <tr>
					            <th>출장자</th>
					            <td>
					                <input type="text" class="form-control input-default" value="<c:out value="${tripHistoryOne.empName}"/>" readonly="readonly">
					            </td>
					        </tr>
					        <tr>
					            <th>출발일</th>
					            <td>
					                <input type="datetime-local" class="form-control input-default" name="startDatetime" value="<c:out value="${tripHistoryOne.formattedStartDate}"/>" readonly="readonly">
					            </td>
					        </tr>
					        <tr>
					            <th>도착일</th>
					            <td>
					                <input type="datetime-local" class="form-control input-default" name="endDatetime" value="<c:out value="${tripHistoryOne.formattedEndDate}"/>" readonly="readonly">
					            </td>
					        </tr>
					        <tr>
					            <th>출장지</th>
					            <td>
					                <input type="text" class="form-control input-default" value="<c:out value="${tripHistoryOne.businessTripDestination}"/>" readonly="readonly">
					            </td>
					        </tr>
					        <tr>
					            <th>비상연락처</th>
					            <td>
					                <input type="text" class="form-control input-default" value="<c:out value="${tripHistoryOne.emergencyContact}"/>" readonly="readonly">
					            </td>
					        </tr>
					        <tr>
					            <th>취소유무</th>
					            <td>
						            <c:if test="${tripHistoryOne.cancleYN == 'N'}">
							      		<input type="text" class="form-control input-default" readonly="readonly" value="취소X">
							      	</c:if>
							      	<c:if test="${tripHistoryOne.cancleYN == 'Y'}">
							      		<input type="text" class="form-control input-default" readonly="readonly" value="취소O">
							      	</c:if>
					            </td>
					        </tr>
					        <c:if test="${tripHistoryOne.cancleYN == 'Y'}">
					            <tr>
					                <th>취소 이유</th>
					                <td>
					                    <input type="text" class="form-control input-default" value="<c:out value="${tripHistoryOne.cancleReason}"/>" readonly="readonly">
					                </td>
					            </tr>
					        </c:if>
					        <tr>
					            <th>목적/사유</th>
					            <td>
					                <textarea rows="4" cols="50" class="form-control h-150px" readonly="readonly"><c:out value="${tripHistoryOne.content}"/></textarea>
					            </td>
					        </tr>
					    </table>
					<!-- 내용끝 -->
				 </div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
</body>
</html>