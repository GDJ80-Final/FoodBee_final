<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodBee : 휴가일정상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
	#twoBtn {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top:10px;
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
					        <th>휴가자</th>
					        <td>
					            <input type="text" class="form-control input-default" value="${dayOffOne.empName}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					        <th>시작일시</th>
					        <td>
					             <input type="datetime-local" class="form-control input-default" name="startDate" value="${dayOffOne.formattedStartDate}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					        <th>종료일시</th>
					        <td>
					            <input type="datetime-local" class="form-control input-default" name="endDate" value="${dayOffOne.formattedEndDate}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					        <th>유형</th>
					        <td>
					            <input type="text" class="form-control input-default" value="${dayOffOne.typeName}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					        <th>사용년도</th>
					        <td>
					            <input type="text" class="form-control input-default" value="${dayOffOne.useYear}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					        <th>비상연락처</th>
					        <td>
					            <input type="text" class="form-control input-default" value="${dayOffOne.emergencyContact}" readonly="readonly">
					        </td>
					    </tr>
					    <tr>
					      <th>취소유무</th>
					      <td>
					      	<c:if test="${dayOffOne.cancleYN == 'N'}">
					      		<input type="text" class="form-control input-default" readonly="readonly" value="취소X">
					      	</c:if>
					      	<c:if test="${dayOffOne.cancleYN == 'Y'}">
					      		<input type="text" class="form-control input-default" readonly="readonly" value="취소O">
					      	</c:if>
					      </td>
					  	</tr>
						<c:if test="${dayOffOne.cancleYN == 'Y'}">
					      <tr>
					          <th>취소 이유</th>
					          <td>
					              <input type="text" class="form-control input-default" value="<c:out value="${dayOffOne.cancleReason}"/>" readonly="readonly">
					          </td>
					      </tr>
					  	</c:if>
					  	<tr>
					        <th>사유/목적</th>
					        <td>
					        	<textarea rows="4" cols="50" class="form-control h-150px" readonly="readonly" ><c:out value="${dayOffOne.content}"/></textarea>
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