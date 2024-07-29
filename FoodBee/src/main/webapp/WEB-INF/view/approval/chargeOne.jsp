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
<h1>지출결의서</h1>
<a href="draftBox">돌아가기</a>
<jsp:include page="./forms/commonForm.jsp"></jsp:include>
			<div class="form-section">
	        	<div class="form-group">
	        		<label for="monthYear">지출년월</label>
	        		<input type="text" id="monthYear" value="${chargeDetailOne.description}" readonly="readonly">
	            </div>
	            <div class="form-group">
	                <label for="title">제목:</label>
	                <input type="text" id="title" name="title" value="${chargeOne.title}" readonly="readonly">
	            </div>
	            <div class="form-group">
	                <label for="content">내역:</label>
	                <div id="categoryContainer">
				        <div class="category-row" style="display: flex; align-items: center;">
				            
				            <label for="expenditure">적요:</label>						
				            <input type="text" class="expenditureInput" placeholder="지출내용" style="margin-right: 20px;" value="${chargeDetailOne.typeName}">
				            
				            <label for="charge">금액:</label>
				            <input type="text" class="chargeInput" placeholder="금액 입력" value="${chargeDetailOne.amount}">원
				            
				            <label for="note" style="margin-left: 20px;">비고:</label>
				            <textarea style="width: 400px; margin-top: 20px;" placeholder="상세내용">${chargeOne.content}</textarea>
				        </div>
				    </div>
	            </div>
	            <div class="file-upload">
	                <label for="attachment">첨부파일:</label>
              	 <c:choose>
		          <c:when test="${not empty chargeFileOne}">
		              <c:forEach items="${chargeFileOne}" var="one">
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
   	 	<c:if test="${chargeOne != null && chargeOne.docApproverState == 0 && cchargeOne.drafterEmpNo eq empNo}">
    		<a href="">수정하기</a>
		</c:if> 
       </div>
 <script>
$(document).ready(function() {
    
    let drafter = '${chargeOne.drafterEmpNo}';  
    let drafterName = '${chargeOne.drafterEmpName}';  
    let midApprover = '${chargeOne.midApproverNo}';
    let midApproverName = '${chargeOne.midApproverName}';
    let finalApproverName = '${chargeOne.finalApproverName}';
    let finalApprover = '${chargeOne.finalApproverNo}';
    let referrerField = '${chargeReferrer.referrerEmpNo}';
    let referrerName = '${chargeReferrer.empName}';
    //수신자가 없는경우
    if(referrerName === null || referrerName === '') {
        referrerName = "수신자 없음";
    }
    let name = '${chargeOne.drafterEmpName}';  
    let dptNo = '${chargeOne.dptNo}';  

    document.getElementById("drafter").innerHTML = drafter+"("+drafterName+")";
    document.getElementById("midApprover").innerHTML = midApprover+"("+midApproverName+")";
    document.getElementById("finalApprover").innerHTML = finalApprover+"("+finalApproverName+")";
    document.getElementById("referrerField").innerHTML = referrerField+"("+referrerName+")";
    $("#name").val(drafterName);
    $("#department").val(dptNo);
    
	//사원 결재사인
    let drafterSign = '${chargeOne.drafterSign}';
    let midApproverSign = '${chargeOne.midApproverSign}';
    let finalApproverSign = '${chargeOne.finalApproverSign}';
    
    if (drafterSign) {
        $("#drafterSign").html(`<img src="${chargeOne.drafterSign}">`);
    } else {
        $("#drafterSign").text("기안자 서명 없음");
    }

    if (midApproverSign) {
        $("#midApproverSign").html(`<img src="${chargeOne.midApproverSign}">`);
    } else {
        $("#midApproverSign").text("중간 결재자 서명 없음");
    }

    if (finalApproverSign) {
        $("#finalApproverSign").html(`<img src="${chargeOne.finalApproverSign}">`);
    } else {
        $("#finalApproverSign").text("최종 결재자 서명 없음");
    }
});
</script>
</body>
</html>