<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>FoodBee:쪽지 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
		
		 <div class="content-body">
	        <!--**********************************
	            Content body start
	        ***********************************-->
	        <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">쪽지함</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">상세보기</a></li>
                    </ol>
                </div>
            </div>
            
	         <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="email-left-box">
                                <a href="${pageContext.request.contextPath}/msg/addMsg" class="btn btn-primary btn-block">새 쪽지 쓰기</a>
                                    
                                </div>
                                <div class="email-right-box">
                                    <div class="toolbar" role="toolbar">
                                       
                                    </div>
                                    <div class="read-content">
                                        <div class="media pt-5">
                                            
                                            <div class="media-body">
                                                <h5 class="m-b-3">FROM. ${m.sender}</h5>
                                                <h5 class="m-b-3">TO.
                                                	<c:forEach var="receiver" items="${fn:split(m.receivers, ',')}">
										                <c:set var="name" value="${fn:substringBefore(receiver, '|')}"/>
										                <c:set var="status" value="${fn:substringAfter(receiver,'|')}"/>
                										${name} 
                										<c:choose>
										                    <c:when test="${status == 'Y'}">
										                    	<span class="badge badge-primary badge-sm m-t-5">읽음</span>
										                    </c:when>
										                    <c:otherwise>
										                    	<span class="badge badge-secondary badge-sm m-t-5">안 읽음</span>
										                    </c:otherwise>
                										</c:choose>
            										</c:forEach>
                                                	<%-- TO. ${m.receivers} --%>
                                                </h5>
                                                <p class="m-b-2">보낸 일시 : ${m.createDatetime}</p>
                                            </div>
                                            
                                        </div>
                                        <hr>
                                        <div class="media mb-2">
                                            <div class="media-body"><span class="float-right"></span>
                                                <h4 class="m-0 text-primary">${m.title}</h4>
                                            </div>
                                        </div>
                                        
                                        <h5 class="m-b-15"></h5>
                                        <p>${m.content}</p>
                                        
                 
                                        <hr>
                                        <!-- 첨부파일  -->
                                        <c:set var="originalFiles" value="${fn:split(m.originalFiles, ',')}" />
										<c:set var="saveFiles" value="${fn:split(m.saveFiles, ',')}" />
                                        <h6 class="p-t-15"><i class="fa fa-download mb-2"></i> 첨부파일 </h6>
                                        <!-- 파일 없는 경우 분기 -->
                                        <div class="row m-b-30">
	                                        <c:choose>
										        <c:when test="${empty originalFiles || originalFiles[0] == ''}">
											        <div class="col-auto">
											            <span class="badge badge-danger badge-sm m-t-5">파일 없음</span>
											        </div>
										        </c:when>
										        <c:otherwise>
										            <c:forEach var="file" items="${originalFiles}" varStatus="status">
										                <div class="col-auto">
										                    <a href="${pageContext.request.contextPath}/msg/download?file=${file}&saveFile=${saveFiles[status.index]}" class="text-muted">
										                        ${saveFiles[status.index]}
										                    </a>
										                </div>
										            </c:forEach>
										        </c:otherwise>
										    </c:choose>
			           				   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		<div class="text-center m-t-15">
	       <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10 send-btn" type="button" id="backTo"><i class="ti-close m-r-5 f-s-12"></i> 돌아가기</button>
	    </div>
            <!-- #/ container -->
        </div>
     </div>
     
   </div>
        <!--**********************************
            Content body end
        ***********************************-->
        
     <jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
   
	
<script>
	$(document).ready(function(){
		
		let empName = '${empName}';
		let receivers = '${m.receivers}';
		console.log(receivers);
		let currentState = '${m.readYN}';
		console.log(currentState);
		console.log(empName);
		console.log(receivers);
		
	    let receiverList = receivers.split(',');
	    let readUpdate = false;
	    
	    for (let i = 0; i < receiverList.length; i++) {
	        let receiver = receiverList[i].split('|');
	        let name = receiver[0];
	        let status = receiver[1];
	        
	        console.log('Receiver: ${name}, Status: ${status}');
	        
	        if (name === empName && status === 'N') {
	        	readUpdate = true;
	            break;
	        }
	    }
	    
	    if (readUpdate) {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/msg/updateReadYN',
	            method: 'post',
	            data: {
	                msgNo: '${m.msgNo}'
	            },
	            success: function(json){
	                console.log('읽음 상태 업데이트 완료');
	            }
	        });
	    } else {
	        console.log('업데이트 되지 않음');
	    }
	    
	
		
		
		$('#backTo').click(function(){
			window.location.href = '${pageContext.request.contextPath}/msg/receivedMsgBox';
		});
		
		
	})


</script>
</body>
</html>