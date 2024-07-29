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
<h1>출장 신청서</h1>
<a href="draftBox">돌아가기</a>
<jsp:include page="./forms/commonForm.jsp"></jsp:include>
<div class="form-section">        
	<div class="form-group">
		<label for=place>출장지:</label>
		<input type="text" id="place" name="place" value="${businessTripDetailOne.typeName}">
		<br>
		<label for="period" style="margin-left: 500px;">기간:</label>
		    <input type="date" id="period" name="period" value="${businessTripDetailOne.startDate}" disabled="disabled"> ~
		    <input type="date" id="period" name="period" value="${businessTripDetailOne.endDate}" disabled="disabled">
		</div>
		<div class="form-group">
		    <label for=emergency>비상연락:</label>
		    <input type="text" id="emergency" name="emergency" value="${businessTripDetailOne.text}" >
		</div>
		<div class="form-group">
		    <label for="title">제목:</label>
		    <input type="text" id="title" name="title" value="${businessTripOne.title}">
		</div>
		<div class="form-group">
		    <label for="content">내용:</label>
		    <textarea id="content" name="content" placeholder="출장 목적을 작성하세요.">${businessTripOne.content}</textarea>
		</div>            
		<div class="file-upload">
		    <label for="attachment">첨부파일:</label>
		    <c:choose>
	          <c:when test="${not empty businessTripFileOne}">
	              <c:forEach items="${businessTripFileOne}" var="one">
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
     	 	<br>
   	 	<c:if test="${businessTripOne != null && businessTripOne.docApproverState == 0 && businessTripOne.drafterEmpNo eq empNo}">
    		<a href="">수정하기</a>
		</c:if> 
	</div>
<script>
	$(document).ready(function() {
	    
	    let drafter = '${businessTripOne.drafterEmpNo}';  
	    let drafterName = '${businessTripOne.drafterEmpName}';  
	    let midApprover = '${businessTripOne.midApproverNo}';
	    let midApproverName = '${businessTripOne.midApproverName}';
	    let finalApproverName = '${businessTripOne.finalApproverName}';
	    let finalApprover = '${businessTripOne.finalApproverNo}';
	    let referrerField = '${businessTripReferrer.referrerEmpNo}';
	    let referrerName = '${businessTripReferrer.empName}';
	    //수신자가 없는경우
	    if(referrerName === null || referrerName === '') {
	        referrerName = "수신자 없음";
	    }
	    let name = '${businessTripOne.drafterEmpName}';  
	    let dptNo = '${businessTripOne.dptNo}';  
	
	    document.getElementById("drafter").innerHTML = drafter+"("+drafterName+")";
	    document.getElementById("midApprover").innerHTML = midApprover+"("+midApproverName+")";
	    document.getElementById("finalApprover").innerHTML = finalApprover+"("+finalApproverName+")";
	    document.getElementById("referrerField").innerHTML = referrerField+"("+referrerName+")";
	    $("#name").val(drafterName);
	    $("#department").val(dptNo);
	    
    	//사원 결재사인
	    let drafterSign = '${businessTripOne.drafterSign}';
	    let midApproverSign = '${businessTripOne.midApproverSign}';
	    let finalApproverSign = '${businessTripOne.finalApproverSign}';
	    
	    if (drafterSign) {
	        $("#drafterSign").html(`<img src="${businessTripOne.drafterSign}">`);
	    } else {
	        $("#drafterSign").text("기안자 서명 없음");
	    }
	
	    if (midApproverSign) {
	        $("#midApproverSign").html(`<img src="${businessTripOne.midApproverSign}">`);
	    } else {
	        $("#midApproverSign").text("중간 결재자 서명 없음");
	    }
	
	    if (finalApproverSign) {
	        $("#finalApproverSign").html(`<img src="${businessTripOne.finalApproverSign}">`);
	    } else {
	        $("#finalApproverSign").text("최종 결재자 서명 없음");
	    }
	});
</script>
</div>	
</body>
</html>