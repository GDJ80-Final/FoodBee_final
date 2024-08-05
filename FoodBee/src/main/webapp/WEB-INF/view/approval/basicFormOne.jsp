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
    	#rejectionCheck {
    		display: flex;
		    justify-content: center; /* 중앙 정렬 */
    	}
    	#modalTitle{
    		font-size: 20px;
    		color: black;
    		margin-bottom: 20px;
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
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">기본기안서</a></li>
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
						        <label for="title">제목:</label>
						        <input type="text" id="title" name="title" value="${basicFormOne.title}" readonly="readonly">
						    </div>
						    <div class="form-group">
						        <label for="content">내용:</label>
						        <textarea rows="6" cols="50" id="content" name="content" readonly="readonly">${basicFormOne.content}</textarea>
						    </div>
						    <div class="file-upload">
						        <h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> 첨부파일</h5>
						        <c:choose>
						            <c:when test="${not empty basicFormFileOne}">
						                <c:forEach items="${basicFormFileOne}" var="one">
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
						    <div id="modifyDeleteBtn">						    
								<c:if test="${basicFormOne != null && basicFormOne.docApproverState == 0 && basicFormOne.drafterEmpNo eq empNo}">
							    	<a href="${pageContext.request.contextPath}/approval/modifyBasicForm?draftDocNo=${basicFormOne.draftDocNo}" class="btn btn-info btn-block">수정</a>
							    	<a href="${pageContext.request.contextPath}/approval/deleteDraft?draftDocNo=${basicFormOne.draftDocNo}" class="btn btn-danger btn-block">삭제</a>
								</c:if>
						    </div>
							<div id="updateAppral">
									<!-- 중간승인자일 경우 -->
							       	<c:if test="${basicFormOne.midApprovalState == 0 && basicFormOne.midApproverNo eq empNo}">
							       		<div id="twoBtn">
								       		<a href="updateMidState?draftDocNo=${basicFormOne.draftDocNo}" id="midApproval" class="btn btn-info btn-block">중간승인</a> 
								       		<button id="fakeBtn" class="btn btn-info btn-danger">반려</button>									       		
							       		</div>
							       		<div id="submitForm">
											<form method="post" action="updateMidRejection" id="rejectionForm" >
											   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
											   <button type="submit" class="btn btn-danger btn-block">제출</button>
											   <input type="hidden" name="draftDocNo" value="${basicFormOne.draftDocNo}">
											</form>
										</div>
							       	</c:if>
							       	<!-- 최종승인자일 경우, 중간결재자가 승인한 경우, 기안서가 반려상태가 아닌 경우, 최종승인상태가 승인전인경우 -->
							       	<c:if test="${basicFormOne.docApproverState != 9 && basicFormOne.midApprovalState == 1 && basicFormOne.finalApprovalState == 0 && basicFormOne.finalApproverNo eq empNo}">
							       		<div id="twoBtn">
							       			<a href="updateFinalState?draftDocNo=${basicFormOne.draftDocNo}" id="finalApproval">최종승인</a>
							       			<button id="fakeBtn" class="btn btn-info btn-danger">반려</button>	
							       		</div>
							       		<div id="submitForm">
								       		<form method="post" action="updateFinalRejection" id="rejectionForm">
											   <textarea rows="3" cols="50" name="rejectionReason" placeholder="반려이유를 작성해주세요"></textarea>
								       			<button type="submit" class="btn btn-danger btn-block">제출</button><br>
											   <input type="hidden" name="draftDocNo" value="${basicFormOne.draftDocNo}">
											</form>
										</div>
							       	</c:if>
						      </div>
								<!-- 반려사유 확인버튼 -->
						      	<c:if test="${basicFormOne.midApproverReason != null || basicFormOne.finalApproverReason != null}">
						      		<div id="rejectionCheck">
						      			<button type="button" class="btn btn-warning" id="rejectionBtn">반려사유 확인</button>
						      		</div>						      	
						        </c:if>
						         <!-- 모달창 -->
			                     <div class="modal fade" id="rejectionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			                         <div class="modal-dialog" role="document">
			                             <div class="modal-content">
			                                 <div class="modal-header">
			                                     <h5 class="modal-title" id="exampleModalLabel">반려사유</h5>
			                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                                         <span aria-hidden="true">&times;</span>
			                                     </button>
			                                 </div>
			                                 <div class="modal-body">
			                                     <c:if test="${basicFormOne.midApproverReason != null}">
		                                     			<div id="modalTitle">
		                                     				중간반려 이유
		                                     			</div>
		                                     			<div>		                                     			
		                                     				<c:out value="${basicFormOne.midApproverReason}"></c:out>
		                                     			</div>			
			                                     </c:if>
			                                     <c:if test="${basicFormOne.finalApproverReason != null}">
														<div id="modalTitle">
		                                     				최종반려 이유
		                                     			</div>
		                                     			<div>		
		                                     				<c:out value="${basicFormOne.finalApproverReason}"></c:out>
		                                     			</div>
			                                     </c:if>
			                                 </div>
			                                 <div class="modal-footer">
			                                     <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			                                 </div>
			                             </div>
			                         </div>
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
		console.log("drafterNo =>"+${basicFormOne.drafterEmpNo});
			$(document).ready(function() {
				
			    $('#rejectionBtn').click(function() {
			        $('#rejectionModal').modal('show');
			    });
				 
				 
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
			    
			    $('#fakeBtn').click(function() {
			        $('#submitForm').show();
			    });
			    
			    
			    
			});
	</script>
</body>
</html>