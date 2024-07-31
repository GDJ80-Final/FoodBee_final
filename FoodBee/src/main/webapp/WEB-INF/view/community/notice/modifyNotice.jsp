<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
    <h1>공지사항 수정</h1>

    <form action="modifyNoticeAction" method="post" enctype="multipart/form-data">
       <input type="hidden" name="noticeNo" value="${one[0].noticeNo}">
        <table border="1">
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${one[0].title}"></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><input type="text" name="empName" value="${one[0].empName}" readonly></td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td>
                    <select name="type">
                        <c:choose>
                            <c:when test="${one[0].type == '전사원'}">
                                <option value="전사원" selected>전사원</option>
                                <option value="부서">부서</option>
                            </c:when>
                            <c:when test="${one[0].type == '부서'}">
                                <option value="전사원">전사원</option>
                                <option value="부서" selected>부서</option>
                            </c:when>
                            <c:otherwise>
                                <option value="전사원">전사원</option>
                                <option value="부서">부서</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea rows="7" cols="50" name="content">${one[0].content}</textarea></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    삭제
                    <br>
                    <div id="Xfile">                	
                        <c:forEach items="${one}" var="file">
                            <input type="hidden" value="${one[0].noticeNo}"> 
                           	<span>
                           		${file.originalFile}
                           	</span>
                            <c:if test="${file.originalFile != null}">
                            	<button class="deleteFile" data-file="${file.saveFile}">X</button>
                            </c:if>
                            <br>
                        </c:forEach>
                    </div>
                    추가 
                    <br>
                    <input type="file" name="files" multiple="multiple">
			        <c:if test="${one[0].files == null || one[0].files.isEmpty()}">
			            <input type="file" name="files" multiple="multiple">
			        </c:if>
                </td>
            </tr>
        </table>
        <button type="submit">수정</button>
    </form>
    <a href="noticeOne?noticeNo=${one[0].noticeNo}">돌아가기</a>
</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>    
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $(".deleteFile").click(function(e) {
            e.preventDefault();
            let filename = $(this).data("file");
            let noticeNo = "${one[0].noticeNo}";

            $.ajax({
                url: "${pageContext.request.contextPath}/deleteNoticeFile",
                type: "POST",
                data: {
                    file: filename,
                    noticeNo: noticeNo
                },
                success: function(response) {
                    alert("파일이 삭제되었습니다.");
                    location.reload();
                },
                error: function() {
                    alert("파일 삭제에 실패하였습니다.");
                }
            });
        });
    });
</script>
</body>
</html>