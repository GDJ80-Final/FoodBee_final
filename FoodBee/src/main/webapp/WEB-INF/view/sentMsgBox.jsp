<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<button type="button" name="readYN" id="all" value="all">전체</button>
	<button type="button" name="readYN" id="Y" value="Y">읽음</button>
	<button type="button" name="readYN" id="N" value="N">안 읽음</button>
	
	<button type="button" name="toTrash" id="toTrash">휴지통</button>
	<table border="1">
		<thead>
			<tr>
				<td>선택</td>
				<td>쪽지번호</td>
				<td>보낸이</td>
				<td>제목</td>
				<td>보낸일시</td>
			</tr>
		</thead>
		<tbody id="msgTableBody">
		
		</tbody>
	</table>
	<div>
    <c:if test="${currentPage > 1}">
        <a href="sentMsgBox?currentPage=1">First</a>
        <a href="sentMsgBox?currentPage=${currentPage - 1}">◁</a>
    </c:if>
    <c:if test="${currentPage < lastPage}">
        <a href="sentMsgBox?currentPage=${currentPage + 1}">▶</a>
        <a href="sentMsgBox?currentPage=${lastPage}">Last</a>
    </c:if>
</div>
<script>
	//탭 분리 
   $(document).ready(function(){
	   //읽음/안읽음 여부에 따라 받은 쪽지함 분기
	   function loadMsg(readYN){
		   $.ajax({
			   url : '${pageContext.request.contextPath}/sentMsgBox',
			   type: 'post',
			   data :{
				   readYN : readYN
		   			},
		   		success:function(json){
			   console.log(json)
			   $('#msgTableBody').empty();
			   json.forEach(function(item){
				   console.log(item)
				   $('#msgTableBody').append('<tr>' +
						   	'<td><input type="checkbox" value="'+item.msgNo+'"></td>'+
							'<td>'+ item.msgNo + '</td>'+
							'<td>'+ item.empName + '</td>'+
							'<td><a href="${pageContext.request.contextPath}/msgOne?msgNo='+
									item.msgNo +'">'+ item.title + '</a></td>'+
							'<td>'+ item.createDateTime + '</td>'+
							'</tr>' 
				   );
			   })
		   }
	   });
	   };
	  
	   
	   $('#all').click(function(){
		   loadMsg("all");
		   //전체목록
	   });
	   
	   $('#Y').click(function(){
		   loadMsg("Y");
		   //읽은 쪽지 
	   });
	   
	   $('#N').click(function(){
		   loadMsg("N");
		   //안읽은 쪽지
	   });
	   
		// 페이지 첫 로드 시 전체 목록 불러오기
       loadMsg("all"); 
	
	   
   })
</script>
</body>
</html>