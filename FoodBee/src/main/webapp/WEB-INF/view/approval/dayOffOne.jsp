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
<h1>휴가신청 보고서</h1>
<a href="draftBox">돌아가기</a>
<jsp:include page="./forms/commonForm.jsp"></jsp:include>
    <div class="form-section">
        <div class="form-group">
            <label for="category">유형:</label>
            <input type="radio" id="categoryYear" name="category" value="year" disabled> 연차          
            <input type="radio" id="categoryHalf" name="category" value="half" style="margin-left: 20px;"disabled> 반차
        </div>
        <div class="form-group">
            <label for="remaining">잔여 휴가:</label>
            <label for="period" style="margin-left: 500px;">기간:</label>
            <input type="date" id="period" name="period" value="${dayOffDetailOne.startDate}" disabled> ~
            <input type="date" id="period" name="period" value="${dayOffDetailOne.endDate}" disabled>
        </div>
        <div class="form-group">
            <label for=emergency>비상연락:</label>
            <input type="text" id="emergency" name="emergency" value="${dayOffDetailOne.text}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="${dayOffOne.title}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="content">내용:</label>
            <textarea id="content" name="content">${dayOffOne.content}</textarea>
        </div>
        <div class="file-upload">
            <label for="attachment">첨부파일:</label>
            <c:choose>
	          <c:when test="${not empty dayOffFileOne}">
	              <c:forEach items="${dayOffFileOne}" var="one">
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
    <c:if test="${dayOffOne != null && dayOffOne.docApproverState == 0 && dayOffOne.drafterEmpNo eq empNo}">
    	<a href="">수정하기</a>
	</c:if>
</div>
<script>
$(document).ready(function() {
		 let typeName = '${dayOffDetailOne.typeName}';
	    
	    // Radio button check logic
	    if (typeName === '연차') {
	        $('#categoryYear').prop('checked', true);
	    } else if (typeName === '반차') {
	        $('#categoryHalf').prop('checked', true);
	    }
	    
	    let drafter = '${dayOffOne.drafterEmpNo}';  
	    let drafterName = '${dayOffOne.drafterEmpName}';  
	    let midApprover = '${dayOffOne.midApproverNo}';
	    let midApproverName = '${dayOffOne.midApproverName}';
	    let finalApproverName = '${dayOffOne.finalApproverName}';
	    let finalApprover = '${dayOffOne.finalApproverNo}';
	    let referrerField = '${dayOffReferrer.referrerName}';
	    //수신자가 없는경우
	    if(referrerField === null || referrerField === '') {
	    	referrerField = "수신자 없음";
	    }
	    let name = '${dayOffOne.drafterEmpName}';  
	    let dptNo = '${dayOffOne.dptNo}';  
	
	    document.getElementById("drafter").innerHTML = drafter+"("+drafterName+")";
	    document.getElementById("midApprover").innerHTML = midApprover+"("+midApproverName+")";
	    document.getElementById("finalApprover").innerHTML = finalApprover+"("+finalApproverName+")";
	    document.getElementById("referrerField").innerHTML = referrerField;
	    $("#name").val(drafterName);
	    $("#department").val(dptNo);
	    
    	//사원 결재사인
	    let drafterSign = '${dayOffOne.drafterSign}';
	    let midApproverSign = '${dayOffOne.midApproverSign}';
	    let finalApproverSign = '${dayOffOne.finalApproverSign}';
	    let midApprovalState = '${dayOffOne.midApprovalState}';
	    let finalApprovalState = '${dayOffOne.finalApprovalState}';
	    
	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${dayOffOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign && midApprovalState == 1) {
	        $("#midApproverSign").html(`<img src="${dayOffOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간 결재자 서명전");
	    }
	
	    if (finalApproverSign && finalApprovalState == 1) {
	        $("#finalApproverSign").html(`<img src="${dayOffOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종 결재자 서명전");
	    }
	});
</script>
</body>
</html>