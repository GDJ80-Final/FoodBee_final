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
	<a href="${pageContext.request.contextPath}/approval/draftBox">돌아가기</a>
	<jsp:include page="./forms/commonForm.jsp"></jsp:include>
	<div class="form-section">
	    <div class="form-group">
	        <label for="monthYear">지출년월</label>
	        <input type="text" id="monthYear" value="${chargeDetailOne[0].description}" readonly="readonly">
	    </div>
	    <div class="form-group">
	        <label for="title">제목:</label>
	        <input type="text" id="title" name="title" value="${chargeOne.title}" readonly="readonly">
	    </div>
	    <div class="form-group">
	        <label for="content">내역:</label>
	        <div id="categoryContainer">
	        	<c:forEach items="${chargeDetailOne}" var="detail">
		            <div class="category-row" style="display: flex; align-items: center;">
		                <label for="expenditure">적요:</label>
		                <input type="text" class="expenditureInput" placeholder="지출내용" style="margin-right: 20px;" value="${detail.typeName}">
		                <label for="charge">금액:</label>
		                <input type="text" class="chargeInput" placeholder="금액 입력" value="${detail.amount}">원
		                <label for="note" style="margin-left: 20px;">비고:</label>
		                <textarea style="width: 400px; margin-top: 20px;" placeholder="상세내용">${detail.text}</textarea>
		            </div>
	            </c:forEach>
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
	        <c:if test="${chargeOne != null && chargeOne.docApproverState == 0 && chargeOne.drafterEmpNo eq empNo}">
	            <a href="${pageContext.request.contextPath}/approval/modifyChargeForm?draftDocNo=${chargeOne.draftDocNo}">수정하기</a>
	        </c:if>
	    </div>
	    <div id="updateAppral">
	        <!-- 중간승인자일 경우 -->
	        <c:if test="${chargeOne.midApprovalState == 0 && chargeOne.midApproverNo eq empNo}">
	            <a href="updateMidState?draftDocNo=${chargeOne.draftDocNo}" id="midApproval">중간승인</a>
	            <form method="post" action="updateMidRejection" id="rejectionForm">
	                <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
	                <input type="hidden" name="draftDocNo" value="${chargeOne.draftDocNo}">
	                <br>
	                <button type="submit">반려</button>
	            </form>
	        </c:if>
	        <!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
	        <c:if test="${chargeOne.docApproverState != 9 && chargeOne.midApprovalState == 1 && chargeOne.finalApprovalState == 0 && chargeOne.finalApproverNo eq empNo}">
	            <a href="updateFinalState?draftDocNo=${chargeOne.draftDocNo}" id="finalApproval">최종승인</a>
	            <form method="post" action="updateFinalRejection" id="rejectionForm">
	                <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
	                <input type="hidden" name="draftDocNo" value="${chargeOne.draftDocNo}">
	                <br>
	                <button type="submit">반려</button>
	            </form>
	        </c:if>
	    </div>
	</div>
	<script>
		$(document).ready(function() {
			
			$("#referrer").hide();
			$("#reset").hide();
			
		    let drafter = '${chargeOne.drafterEmpNo}';  
		    let drafterName = '${chargeOne.drafterEmpName}';  
		    let midApprover = '${chargeOne.midApproverNo}';
		    let midApproverName = '${chargeOne.midApproverName}';
		    let finalApproverName = '${chargeOne.finalApproverName}';
		    let finalApprover = '${chargeOne.finalApproverNo}';
		    //수신 참조자
		    let referrerField = '${chargeReferrer.referrerName}';
		    document.getElementById("referrerField").innerHTML = referrerField;
		    //수신자가 없는경우
		    if(referrerField === null || referrerField === '') {
		    	referrerField = "수신자 없음";
		    }
		    //이름
		    let name = '${chargeOne.drafterEmpName}';  
		    //부서번호
		    let dptNo = '${chargeOne.dptNo}';  
		
		    $("#drafterEmpNo").val(drafter);
		    $("#drafterEmpNoField").val(drafterName+"("+drafter+")");
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
		    let drafterSign = '${chargeOne.drafterSign}';
		    let midApproverSign = '${chargeOne.midApproverSign}';
		    let finalApproverSign = '${chargeOne.finalApproverSign}';
		    let midApprovalState = '${chargeOne.midApprovalState}';
		    let finalApprovalState = '${chargeOne.finalApprovalState}';
		
		    if (drafterSign) {
		        $("#drafterSign").html(`<img src="${chargeOne.drafterSign}">`);
		    } else {
		        $("#drafterSign").text("기안자 서명 없음");
		    }
		
		    if (midApproverSign && midApprovalState == 1) {
		        $("#midApproverSign").html(`<img src="${chargeOne.midApproverSign}">`);
		    } else {
		        $("#midApproverSign").text("중간결재 서명전");
		    }
		
		    if (finalApproverSign && finalApprovalState == 1) {
		        $("#finalApproverSign").html(`<img src="${chargeOne.finalApproverSign}">`);
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