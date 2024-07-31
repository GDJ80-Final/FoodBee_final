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
<a href="${pageContext.request.contextPath}/approval/draftBox">돌아가기</a>
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
		            <input type="text" class="custom-category-input" value="${detail.typeName}" readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
        <div id="updateAppral">
			<!-- 중간승인자일 경우 -->
	       	<c:if test="${revenueOne.midApprovalState == 0 && revenueOne.midApproverNo eq empNo}">
	       		<a href="updateMidState?draftDocNo=${revenueOne.draftDocNo}" id="midApproval">중간승인</a> 	
				<form method="post" action="updateMidRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${revenueOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
	       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
	       	<c:if test="${revenueOne.docApproverState != 9 && revenueOne.midApprovalState == 1 && revenueOne.finalApprovalState == 0 && revenueOne.finalApproverNo eq empNo}">
	       		<a href="updateFinalState?draftDocNo=${revenueOne.draftDocNo}" id="finalApproval">최종승인</a>
	       		<form method="post" action="updateFinalRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${revenueOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
      </div>
</div> 
	<script>
		$(document).ready(function() {
		    
		    let drafter = '${revenueOne.drafterEmpNo}';
		    console.log(drafter);
		    let drafterName = '${revenueOne.drafterEmpName}';  
		    console.log(drafterName);
		    let midApprover = '${revenueOne.midApproverNo}';
		    let midApproverName = '${revenueOne.midApproverName}';
		    let finalApproverName = '${revenueOne.finalApproverName}';
		    let finalApprover = '${revenueOne.finalApproverNo}';
		    let referrerField = '${revenueReferrer.referrerName}';
		    //수신자가 없는경우
		    if(referrerField === null || referrerField === '') {
		    	referrerField = "수신자 없음";
		    }
		    let name = '${revenueOne.drafterEmpName}';  
		    let dptNo = '${revenueOne.dptNo}';  
		
		    $("#drafterEmpNo").val(drafter);
		    $("#drafterEmpNoField").val(drafter+"("+drafterName+")");
		    $("#midApproverNo").val(midApprover);
		    $("#midApproverNoField").val(midApprover+"("+midApproverName+")");
		    $("#finalApproverNo").val(finalApprover);
		    $("#finalApproverNoField").val(finalApprover+"("+finalApproverName+")");
		    $("#referrerField").val(referrerField);
		    $("#name").val(drafterName);
		    $("#department").val(dptNo);
		    $("#midApproverBtn").hide();
		    $("#finalApproverBtn").hide();
		    
		    
			//사원 결재사인
		    let drafterSign = '${revenueOne.drafterSign}';
		    let midApproverSign = '${revenueOne.midApproverSign}';
		    let finalApproverSign = '${revenueOne.finalApproverSign}';
		    let midApprovalState = '${revenueOne.midApprovalState}';
		    let finalApprovalState = '${revenueOne.finalApprovalState}';
		    
		    if (drafterSign) {
		        $("#drafterSign").html(`<img src="${revenueOne.drafterSign}">`);
		    } else {
		        $("#drafterSign").text("기안자 서명 없음");
		    }
		
		    if (midApproverSign && midApprovalState == 1) {
		        $("#midApproverSign").html(`<img src="${revenueOne.midApproverSign}">`);
		    } else {
		        $("#midApproverSign").text("중간결재 서명전");
		    }
		
		    if (finalApproverSign && finalApprovalState == 1) {
		        $("#finalApproverSign").html(`<img src="${revenueOne.finalApproverSign}">`);
		    } else {
		        $("#finalApproverSign").text("최종결재 서명전");
		    }
		    
		    $('#midApproval').click(function(e) {
		        e.preventDefault();
		       
		        
		        let link = $(this);
		        $.ajax({
		            url: '${pageContext.request.contextPath}/approval/getSign',
		            method: 'GET',
		            data: {
		            	approverNo : midApprover
		            },
		            success: function(json) {
		                window.location.href = link.attr('href');
		            },
		            error: function(xhr, status, error) {
		                alert("결재사인을 등록을 해주세요");
		                window.location.href = '${pageContext.request.contextPath}/myPage';
		            }
		        });
		    });
		    
		    $('#finalApproval').click(function(e) {
		        e.preventDefault();
		       
		        
		        let link = $(this);
		        $.ajax({
		            url: '${pageContext.request.contextPath}/approval/getSign',
		            method: 'GET',
		            data: {
		            	approverNo : finalApprover
		            },
		            success: function(json) {
		                window.location.href = link.attr('href');
		            },
		            error: function(xhr, status, error) {
		                alert("결재사인을 등록을 해주세요");
		                window.location.href = '${pageContext.request.contextPath}/myPage';
		            }
		        });
		    });
		});
	</script>
</body>
</html>