<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
    
<!-- theme meta -->
<meta name="theme-name" content="quixlab" />
<title>home</title>
  

</head>
<body>
	<div id="main-wrapper">
		<jsp:include page="./header.jsp"></jsp:include>
		
		<jsp:include page="./sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	  	<div class="content-body">
			세션값
			<div>empNo : ${emp.empNo}</div>
			<div>empName : ${emp.empName}</div>
			<div>dptNo : ${emp.dptNo}</div>
			<div>rankName : ${emp.rankName}</div>
			<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
	 	</div>
 	</div>
 	<jsp:include page="./footer.jsp"></jsp:include>
 	

 
</body>

</html>