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
<a href="" id="return">돌아가기</a>
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
    	<a href="${pageContext.request.contextPath}/approval/modifyBasicForm?draftDocNo=${basicFormOne.draftDocNo}">수정하기</a>
	</c:if>
	<div id="updateAppral">
			<!-- 중간승인자일 경우 -->
	       	<c:if test="${basicFormOne.midApprovalState == 0 && basicFormOne.midApproverNo eq empNo}">
	       		<a href="updateMidState?draftDocNo=${basicFormOne.draftDocNo}" id="midApproval">중간승인</a> 	
				<form method="post" action="updateMidRejection" id="rejectionForm" >
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${basicFormOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
	       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
	       	<c:if test="${basicFormOne.docApproverState != 9 && basicFormOne.midApprovalState == 1 && basicFormOne.finalApprovalState == 0 && basicFormOne.finalApproverNo eq empNo}">
	       		<a href="updateFinalState?draftDocNo=${basicFormOne.draftDocNo}" id="finalApproval">최종승인</a>
	       		<form method="post" action="updateFinalRejection" id="rejectionForm">
				   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
				   <input type="hidden" name="draftDocNo" value="${basicFormOne.draftDocNo}">
				   <br>
				   <button type="submit">반려</button>
				</form>
	       	</c:if>
      </div>
</div>	
	<script>
		console.log("drafterNo =>"+${basicFormOne.drafterEmpNo});
			$(document).ready(function() {
				
				$("#referrer").hide();
				$("#reset").hide();
				
			    let drafter = '${basicFormOne.drafterEmpNo}';  
			    let drafterName = '${basicFormOne.drafterEmpName}';  
			    let midApprover = '${basicFormOne.midApproverNo}';
			    let midApproverName = '${basicFormOne.midApproverName}';
			    let finalApproverName = '${basicFormOne.finalApproverName}';
			    let finalApprover = '${basicFormOne.finalApproverNo}';
			    let referrerField = '${basicReferrerOne.referrerName}';
			   
			    let name = '${basicFormOne.drafterEmpName}';  
			    let dptName = '${basicFormOne.dptName}';  
			    
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
			    $("#department").val(dptName);
			    $("#midApproverBtn").hide();
			    $("#finalApproverBtn").hide();
			    
			    let drafterSign = '${basicFormOne.drafterSign}';
			    let midApproverSign = '${basicFormOne.midApproverSign}';
			    let finalApproverSign = '${basicFormOne.finalApproverSign}';
			    let midApprovalState = '${basicFormOne.midApprovalState}';
			    let finalApprovalState = '${basicFormOne.finalApprovalState}';
			    
			    if (drafterSign) {
			        $("#drafterSign").html(`<img src="${basicFormOne.drafterSign}">`);
			    } else {
			        $("#drafterSign").text("기안자 서명 없음");
			    }
			
			    if (midApproverSign && midApprovalState == 1) {
			        $("#midApproverSign").html(`<img src="${basicFormOne.midApproverSign}">`);
			    } else {
			        $("#midApproverSign").text("중간 결재자 서명 없음");
			    }
			
			    if (finalApproverSign && finalApprovalState == 1) {
			        $("#finalApproverSign").html(`<img src="${basicFormOne.finalApproverSign}">`);
			    } else {
			        $("#finalApproverSign").text("최종 결재자 서명 없음");
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