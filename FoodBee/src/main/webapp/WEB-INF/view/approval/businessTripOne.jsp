<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    	
        .form-section {
            padding: 20px;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            width: 80px;
            margin-right: 10px;
        }
		img {
			width:160px;
			height:130px;
		}

        a {
        	text-decoration-line: none;
        
        }
        .common-section table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .common-section th, .common-section td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            height : 60px;
        }

        .form-section {
            padding: 20px;
        }
         .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            width: 80px;
            margin-right: 10px;
        }
        .form-group input[type="text"], .form-group textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .form-group input[type="text"]:first-child {
            margin-right: 20px;
        }
        .sign td {
       		height : 130px;
        
        }

		.add-file-button {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #333;
            color: #fff;
            cursor: pointer;
        }
        .add-file-button:hover {
            background-color: #555;
        }
    	#fileInputsContainer {
	        display: flex;
	        flex-direction: column; 
    	}

    	.remove-file-button {
        margin-left: 10px; /* Add space between file input and delete button */
    	}
	
	    .error{
        	margin-top:5px;
        	color:red;
        }
        
         #updateAppral {
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	    }
	    
	    #updateAppral a, #updateAppral button {
	        width: 200px;
	        margin: 5px 0;
	        padding: 10px;
	    }
	    
	    #updateAppral textarea {
	        margin-top: 10px;
	        width: 400px;
	    }
	    
	    #twoBtn{
	    	display:flex;
	    	gap:10px;
	    }
	    #submitForm {
        	display: none; 
    	}
    	#modifyDeleteBtn {
		    display: flex;
		    justify-content: center; /* 중앙 정렬 */
		    gap: 10px; /* 버튼 간의 간격 */
		    margin-top: 20px; /* 버튼 상단 여백 (선택적) */
		}
    	#modifyDeleteBtn a{
    		width: 200px;
	        margin: 5px 0;
	        padding: 10px;
    	}
    	
</style>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
	<div class="row page-titles mx-0">
         <div class="col p-md-0">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">기안함</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">출장기안서</a></li>
             </ol>
         </div>
   	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		<!-- 여기서부터 내용시작 -->
			 			<!-- 공통폼 -->
						<jsp:include page="./forms/commonForm.jsp"></jsp:include>
						<div class="form-section">        
							<div class="form-group">
								<label for=place>출장지:</label>
								<input type="text" id="place" name="place" value="${businessTripDetailOne.typeName}" readonly="readonly">
								<br>
								<label for="period" style="margin-left: 500px;">기간:</label>
								    <input type="date" id="period" name="period" value="${businessTripDetailOne.startDate}" disabled="disabled"> ~
								    <input type="date" id="period" name="period" value="${businessTripDetailOne.endDate}" disabled="disabled">
							</div>
								<div class="form-group">
								    <label for=emergency>비상연락:</label>
								    <input type="text" id="emergency" name="emergency" value="${businessTripDetailOne.text}" readonly="readonly">
								</div>
								<div class="form-group">
								    <label for="title">제목:</label>
								    <input type="text" id="title" name="title" value="${businessTripOne.title}" readonly="readonly">
								</div>
								<div class="form-group">
								    <label for="content">내용:</label>
								    <textarea id="content" name="content" placeholder="출장 목적을 작성하세요." readonly="readonly">${businessTripOne.content}</textarea>
								</div>            
								<div class="file-upload">
								     <h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5>
								    <c:choose>
							          <c:when test="${not empty businessTripFileOne}">
							              <c:forEach items="${businessTripFileOne}" var="one">
							                  <a href="${pageContext.request.contextPath}/draftDoc/download?file=${one.originalFile}&saveFile=${one.saveFile}">
							                      ${one.saveFile}
							                  </a>
							                  <br>
							              </c:forEach>
							          </c:when>
							          <c:otherwise>
							              <span class="badge badge-danger mb-3">파일없음</span>
							          </c:otherwise>
						     	 	</c:choose>      
					     	 	</div>
				     	 	<br>
				     	 		<div id="modifyDeleteBtn">
							   	 	<c:if test="${businessTripOne != null && businessTripOne.docApproverState == 0 && businessTripOne.drafterEmpNo eq empNo}">
							   	 		<a href="${pageContext.request.contextPath}/approval/deleteDraft?draftDocNo=${businessTripOne.draftDocNo}" class="btn btn-danger btn-block">삭제</a>
							    		<a href="${pageContext.request.contextPath}/approval/modifyBusinessTripForm?draftDocNo=${businessTripOne.draftDocNo}" class="btn btn-info btn-block">수정하기</a>
									</c:if> 
				     	 		</div>
								<!-- 승인하는 부분 -->
								<div id="updateAppral">
									<!-- 중간승인자일 경우 -->
							       	<c:if test="${businessTripOne.midApprovalState == 0 && businessTripOne.midApproverNo eq empNo}">
							       		<div id="twoBtn">
								       		<a href="updateMidState?draftDocNo=${businessTripOne.draftDocNo}" id="midApproval" class="btn btn-info btn-block">중간승인</a> 	
							       		 	<button id="fakeBtn" class="btn btn-info btn-danger">반려</button>
							       		</div>
							       		<div id="submitForm">
											<form method="post" action="updateMidRejection" id="rejectionForm">
											   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
											   <button type="submit" class="btn btn-danger btn-block">제출</button>
											   <input type="hidden" name="draftDocNo" value="${businessTripOne.draftDocNo}">											   
											</form>
							       		</div>
							       	</c:if>
							       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
							       	<c:if test="${businessTripOne.docApproverState != 9 && businessTripOne.midApprovalState == 1 && businessTripOne.finalApprovalState == 0 && businessTripOne.finalApproverNo eq empNo}">
							       		<div id="twoBtn">
							       			<a href="updateFinalState?draftDocNo=${businessTripOne.draftDocNo}" id="finalApproval" class="btn btn-info btn-block">최종승인</a>
							       			<button id="fakeBtn" class="btn btn-info btn-danger">반려</button>
							       		</div>
							       		<div id="submitForm">
								       		<form method="post" action="updateFinalRejection" id="rejectionForm">
											   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
											   <button type="submit" class="btn btn-danger btn-block">제출</button>
											   <input type="hidden" name="draftDocNo" value="${businessTripOne.draftDocNo}">
											</form>
							       		</div>
							       	</c:if>
						      </div>
						</div>
						<!-- 여기가 내용끝! --> 		
                    </div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
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
		    let dptName = '${businessTripOne.dptName}';  
		
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
		    $('#fakeBtn').click(function() {
		        $('#submitForm').show();
		    });
		});
	</script>
</body>
</html>