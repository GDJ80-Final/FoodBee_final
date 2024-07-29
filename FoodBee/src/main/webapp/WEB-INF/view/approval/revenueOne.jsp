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
<h1>매출보고 기안서</h1>
<a href="draftBox">돌아가기</a>
<jsp:include page="./forms/commonForm.jsp"></jsp:include>
<div class="form-section">
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="${revenueOne.title}" readonly="readonly">
        </div>
        
        <div class="form-group">
   <label for="categoryContainer">내역:</label>
	   <div id="categoryContainer">
	        <c:forEach items="${revenueDetailOne}" var="detail">
		       <div class="category-row" style="display: flex; align-items: center;">
		            <label for="categorySelect">카테고리:</label>
		            <input type="text" class="custom-category-input" value="${detail.description}" readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		            <label for="revenue">매출액:</label>
		            <input type="text" class="revenueInput" value="${detail.amount}" readonly>원
		        </div>
	       </c:forEach>
	    </div>
	</div>
         <div class="file-upload">
             <label for="attachment">첨부파일:</label>
             <c:choose>
	          <c:when test="${not empty revenueFileOne}">
	              <c:forEach items="${revenueFileOne}" var="one">
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
   	 	<c:if test="${revenueOne != null && revenueOne.docApproverState == 0 && revenueOne.drafterEmpNo eq empNo}">
    		<a href="">수정하기</a>
		</c:if> 
        </div>
</div> 
<script>
$(document).ready(function() {
    
    let drafter = '${revenueOne.drafterEmpNo}';  
    let drafterName = '${revenueOne.drafterEmpName}';  
    let midApprover = '${revenueOne.midApproverNo}';
    let midApproverName = '${revenueOne.midApproverName}';
    let finalApproverName = '${revenueOne.finalApproverName}';
    let finalApprover = '${revenueOne.finalApproverNo}';
    let referrerField = '${revenueReferrer.referrerEmpNo}';
    let referrerName = '${revenueReferrer.empName}';
    //수신자가 없는경우
    if(referrerName === null || referrerName === '') {
        referrerName = "수신자 없음";
    }
    let name = '${revenueOne.drafterEmpName}';  
    let dptNo = '${revenueOne.dptNo}';  

    document.getElementById("drafter").innerHTML = drafter+"("+drafterName+")";
    document.getElementById("midApprover").innerHTML = midApprover+"("+midApproverName+")";
    document.getElementById("finalApprover").innerHTML = finalApprover+"("+finalApproverName+")";
    document.getElementById("referrerField").innerHTML = referrerField+"("+referrerName+")";
    $("#name").val(drafterName);
    $("#department").val(dptNo);
    
	//사원 결재사인
    let drafterSign = '${revenueOne.drafterSign}';
    let midApproverSign = '${revenueOne.midApproverSign}';
    let finalApproverSign = '${revenueOne.finalApproverSign}';
    
    if (drafterSign) {
        $("#drafterSign").html(`<img src="${revenueOne.drafterSign}">`);
    } else {
        $("#drafterSign").text("기안자 서명 없음");
    }

    if (midApproverSign) {
        $("#midApproverSign").html(`<img src="${revenueOne.midApproverSign}">`);
    } else {
        $("#midApproverSign").text("중간 결재자 서명 없음");
    }

    if (finalApproverSign) {
        $("#finalApproverSign").html(`<img src="${revenueOne.finalApproverSign}">`);
    } else {
        $("#finalApproverSign").text("최종 결재자 서명 없음");
    }
});
</script>
</body>
</html>