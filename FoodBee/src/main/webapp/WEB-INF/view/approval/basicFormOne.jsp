<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>기본기안서</h1>
<a href="draftBox">돌아가기</a>
<jsp:include page="./forms/commonForm.jsp"></jsp:include>
<div class="form-section">
    <div class="form-group">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="${basicFormOne.title}" readonly="readonly">
    </div>
    <div class="form-group">
        <label for="content">내용:</label>
        <textarea id="content" name="content" readonly="readonly">${basicFormOne.content}</textarea>
    </div>
    <div class="file-upload">
        <label for="attachment">첨부파일:</label>
        <c:choose>
            <c:when test="${not empty basicFormFileOne}">
                <c:forEach items="${basicFormFileOne}" var="one">
                    <a href="${pageContext.request.contextPath}/download?file=${one.originalFile}" download="${one.originalFile}">
                        ${one.saveFile}
                    </a>
                    <br>
                </c:forEach>
            </c:when>
            <c:otherwise>
                파일없음
            </c:otherwise>
        </c:choose>
    </div>
    
	<c:if test="${basicFormOne != null && basicFormOne.docApproverState == 0 && basicFormOne.drafterEmpNo eq empNo}">
    	<a href="">수정하기</a>
	</c:if>
</div>	
<script>
console.log("drafterNo =>"+${basicFormOne.drafterEmpNo});
	$(document).ready(function() {
	    let drafter = '${basicFormOne.drafterEmpNo}';  
	    let drafterName = '${basicFormOne.drafterEmpName}';  
	    let midApprover = '${basicFormOne.midApproverNo}';
	    let midApproverName = '${basicFormOne.midApproverName}';
	    let finalApproverName = '${basicFormOne.finalApproverName}';
	    let finalApprover = '${basicFormOne.finalApproverNo}';
	    let referrerField = '${basicReferrerOne.referrerEmpNo}';
	    let referrerName = '${basicReferrerOne.empName}';
	    let name = '${basicFormOne.drafterEmpName}';  
	    let dptNo = '${basicFormOne.dptNo}';  
	
	    document.getElementById("drafter").innerHTML = drafter+"("+drafterName+")";
	    document.getElementById("midApprover").innerHTML = midApprover+"("+midApproverName+")";
	    document.getElementById("finalApprover").innerHTML = finalApprover+"("+finalApproverName+")";
	    document.getElementById("referrerField").innerHTML = referrerField+"("+referrerName+")";
	    $("#name").val(drafterName);
	    $("#department").val(dptNo);
	    
	    let drafterSign = '${basicFormOne.drafterSign}';
	    let midApproverSign = '${basicFormOne.midApproverSign}';
	    let finalApproverSign = '${basicFormOne.finalApproverSign}';
	    
	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${basicFormOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign) {
	        $("#midApproverSign").html(`<img src="${basicFormOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간 결재자 서명 없음");
	    }
	
	    if (finalApproverSign) {
	        $("#finalApproverSign").html(`<img src="${basicFormOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종 결재자 서명 없음");
	    }
	});
</script>
</body>
</html>