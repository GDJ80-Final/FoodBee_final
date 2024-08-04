<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
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
	    gap: 10px; 
	    justify-content: center; 
	    margin-top: 10px; 
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
                 <li class="breadcrumb-item"><a href="javascript:void(0)">커뮤니티</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항 상세</a></li>
             </ol>
         </div>
   	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
				 <!-- 여기부터 내용 -->
				<a href="noticeList" class="btn btn-primary btn-block" id="back">돌아가기</a>
				<div>
				            <table>
				                <tr>
				                    <th>제목</th> 
				                    <td><input type="text" class="form-control input-default" value="${one[0].title}"></td>
				                </tr>
				                <tr>
				                    <th>작성자</th>
				                    <td><input type="text" class="form-control input-default" value="${one[0].empName}"></td>
				                </tr>
				                <tr>
				                    <th>작성일</th>
				                    <td><input type="text" class="form-control input-default" value="${one[0].createDatetime}"></td>
				                </tr>
				                <tr>
				                    <th>첨부파일</th>
				                    <td>
				                        <c:choose>
				                            <c:when test="${not empty one[0].originalFile}">
				                                <c:forEach items="${one}" var="item">
				                                    <a href="${pageContext.request.contextPath}/download?file=${item.originalFile}&saveFile=${item.saveFile}" class="form-control input-default">
				                                        ${item.saveFile}
				                                    </a>
				                                    <br>
				                                </c:forEach>
				                            </c:when>
				                            <c:otherwise>
				                                <span class="badge badge-danger mb-3">파일없음</span>
				                            </c:otherwise>
				                        </c:choose>
				                    </td>
				                </tr>
				                <tr>
				                    <th>내용</th>
				                    <td>
				                        <textarea rows="4" cols="50" readonly="readonly" class="form-control h-150px">${one[0].content}</textarea> 
				                    </td>
				                </tr>
				            </table>
				            <div id="twoBtn">
					            <c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
								    <form action="deleteNotice" method="post">
						                <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
						                <button type="submit" class="btn btn-danger btn-block">삭제</button>
					            	</form>
								</c:if>
					            <!-- 수정 버튼 추가 -->
					            <c:if test="${one[0].empName == empName}">
					                <form action="modifyNotice" method="get">
					                    <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
					                    <button type="submit" class="btn btn-info btn-block">수정하기</button>
					                </form>
					            </c:if>
				            </div>
						</div>
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