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
<a href="${pageContext.request.contextPath}/approval/draftBox">돌아가기</a>
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
    	<a href="${pageContext.request.contextPath}/approval/modifyDayOffForm?draftDocNo=${dayOffOne.draftDocNo}">수정하기</a>
	</c:if>
	 <div id="updateAppral">
			<!-- 중간승인자일 경우 -->
	       	<c:if test="${dayOffOne.midApprovalState == 0 && dayOffOne.midApproverNo eq empNo}">
	       		<a href="updateMidState?draftDocNo=${dayOffOne.draftDocNo}" id="midApproval">중간승인</a> 	
				<form method="post" action="updateMidRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${dayOffOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
	       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
	       	<c:if test="${dayOffOne.docApproverState != 9 && dayOffOne.midApprovalState == 1 && dayOffOne.finalApprovalState == 0 && dayOffOne.finalApproverNo eq empNo}">
	       		<a href="updateFinalState?draftDocNo=${dayOffOne.draftDocNo}" id="finalApproval">최종승인</a>
	       		<form method="post" action="updateFinalRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${dayOffOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
      </div>
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
			
			    $("#drafterEmpNo").val(drafter);
			    $("#drafterEmpNoField").val(drafterName+"("+drafter+")");
			    $("#midApproverNo").val(midApprover);
			    $("#midApproverNoField").val(midApproverName+"("+midApprover+")");
			    $("#finalApproverNo").val(finalApprover);
			    $("#finalApproverNoField").val(finalApproverName+"("+finalApprover+")");
			    $("#referrerField").val(referrerField);
			    $("#name").val(drafterName);
			    $("#department").val(dptNo);
			    $("#midApproverBtn").hide();
			    $("#finalApproverBtn").hide();
			    
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