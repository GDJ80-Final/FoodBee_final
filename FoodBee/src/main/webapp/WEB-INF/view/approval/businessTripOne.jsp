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
<a href="${pageContext.request.contextPath}/approval/draftBox" id="return">돌아가기</a>
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
    		<a href="${pageContext.request.contextPath}/approval/modifyBusinessTripForm?draftDocNo=${businessTripOne.draftDocNo}">수정하기</a>
		</c:if> 
			<!-- 승인하는 부분 -->
		<div id="updateAppral">
			<!-- 중간승인자일 경우 -->
	       	<c:if test="${businessTripOne.midApprovalState == 0 && businessTripOne.midApproverNo eq empNo}">
	       		<a href="updateMidState?draftDocNo=${businessTripOne.draftDocNo}" id="midApproval">중간승인</a> 	
				<form method="post" action="updateMidRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${businessTripOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
	       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
	       	<c:if test="${businessTripOne.docApproverState != 9 && businessTripOne.midApprovalState == 1 && businessTripOne.finalApprovalState == 0 && businessTripOne.finalApproverNo eq empNo}">
	       		<a href="updateFinalState?draftDocNo=${businessTripOne.draftDocNo}" id="finalApproval">최종승인</a>
	       		<form method="post" action="updateFinalRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${businessTripOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
      </div>
	</div>
</div>
	<script>
		$(document).ready(function() {
		    
			$("#referrer").hide();
			$("#reset").hide();
			
		    let drafter = '${businessTripOne.drafterEmpNo}';  
		    let drafterName = '${businessTripOne.drafterEmpName}';  
		    let midApprover = '${businessTripOne.midApproverNo}';
		    let midApproverName = '${businessTripOne.midApproverName}';
		    let finalApproverName = '${businessTripOne.finalApproverName}';
		    let finalApprover = '${businessTripOne.finalApproverNo}';
		    let referrerField = '${businessTripReferrer.referrerName}';
		    //수신자가 없는경우
		    if(referrerField === null || referrerField === '') {
		    	referrerField = "수신자 없음";
		    }
		    let name = '${businessTripOne.drafterEmpName}';  
		    let dptNo = '${businessTripOne.dptNo}';  
		
		    if(${empNo} == drafter){
				$('#return').attr('href', '${pageContext.request.contextPath}/approval/draftBox');
			} else if(${empNo} == midApprover || ${empNo} == finalApprover){
				$('#return').attr('href', '${pageContext.request.contextPath}/approval/approvalBox');
			} else {
				$('#return').attr('href', '${pageContext.request.contextPath}/approval/inBox');
			}
		    
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
		    let drafterSign = '${businessTripOne.drafterSign}';
		    let midApproverSign = '${businessTripOne.midApproverSign}';
		    let finalApproverSign = '${businessTripOne.finalApproverSign}';
		    let midApprovalState = '${businessTripOne.midApprovalState}';
		    let finalApprovalState = '${businessTripOne.finalApprovalState}';
		    
		    if (drafterSign) {
		        $("#drafterSign").html(`<img src="${businessTripOne.drafterSign}">`);
		    } else {
		        $("#drafterSign").text("기안자 서명 없음");
		    }
		
		    if (midApproverSign && midApprovalState == 1) {
		        $("#midApproverSign").html(`<img src="${businessTripOne.midApproverSign}">`);
		    } else {
		        $("#midApproverSign").text("중간결재 서명전");
		    }
		
		    if (finalApproverSign && finalApprovalState == 1) {
		        $("#finalApproverSign").html(`<img src="${businessTripOne.finalApproverSign}">`);
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