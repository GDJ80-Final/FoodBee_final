<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인일정 수정</title>
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
    #oneBtn {
        display: flex;
        justify-content: center;
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
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">일정수정</a></li>
             </ol>
         </div>
   	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
				 	<!-- 여기부터 내용 -->
			 		<a href="scheduleOne?scheduleNo=<c:out value='${one.scheduleNo}'/>" class="btn btn-primary btn-block" id="back">돌아가기</a>
						<form method="post" action="modifyScheduleAction">
						    <table>
						        <tr>
						            <th>작성자</th>
						            <td>
						                <input type="text" class="form-control input-default" value="<c:out value='${one.empName}' />" readonly="readonly">
						            </td>
						        </tr>
						        <tr>
						            <th>시작일시</th>
						            <td>
						                <input type="datetime-local" class="form-control input-default" name="startDatetime" value="<c:out value='${one.startDatetime}' />">
						            </td>
						        </tr>
						        <tr>
						            <th>종료일시</th>
						            <td>
						                <input type="datetime-local" class="form-control input-default" name="endDatetime" value="<c:out value='${one.endDatetime}' />">
						            </td>
						        </tr>
						        <tr>
						            <th>제목</th>
						            <td>
						                <input type="text" name="title" class="form-control input-default" value="<c:out value='${one.title}' />">
						            </td>
						        </tr>
						        <tr>
						            <th>메모</th>
						            <td>
						                <textarea name="content" class="form-control h-150px" rows="5" cols="50"><c:out value='${one.content}' /></textarea>
						            </td>
						        </tr>
						    </table>
						    <input type="hidden" name="empNo" value='<c:out value="${one.empNo}" />'>
						    <input type="hidden" name="scheduleNo" value='<c:out value="${one.scheduleNo}" />'>
						    <div id="oneBtn">						    
						    	<button type="submit" class="btn btn-info mt-3">수정</button>
						    </div>
						</form>
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