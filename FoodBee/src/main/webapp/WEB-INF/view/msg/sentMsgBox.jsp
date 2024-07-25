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
	<a href="${pageContext.request.contextPath}/msg/trashMsgBox">휴지통으로 이동</a>
	<table border="1">
		<thead>
			<tr>
				<td>선택</td>
				<td>쪽지번호</td>
				<td>받는이</td>
				<td>제목</td>
				<td>보낸일시</td>
				<td>읽음여부</td>
			</tr>
		</thead>
		<tbody id="msgTableBody">
		
		</tbody>
	</table>
	<div>
	<div id="page">
        <button type="button" id="first">First</button>
        <button type="button" id="pre">◁</button>
        <button type="button" id="next">▶</button>
        <button type="button" id="last">Last</button>
	</div>
	</div>

<script>

	let currentPage = 1;
	let lastPage = 1;
	
	   $(document).ready(function(){
		   //읽음/안읽음 여부에 따라 받은 쪽지함 분기 + 페이징 추가 
		   let readYN = 'all';
	
	       function loadMsg(readYN, page){
	           $.ajax({
	               url : '${pageContext.request.contextPath}/msg/sentMsgBox',
	               method: 'post',
	               data : {
	                   readYN : readYN,
	                   currentPage : page
	               },
	               success:function(json){
	                   console.log(json);
	
	                   lastPage = json.lastPage;
	                   console.log('Current Page =>', currentPage, 'Last Page =>', lastPage);
	
	                   $('#msgTableBody').empty();
	                   json.msgList.forEach(function(item){
	                       console.log(item);
	                       $('#msgTableBody').append('<tr>' +
	                           '<td><input type="checkbox" name="msgNo" value="'+ item.msgNo +'"></td>'+
	                           '<td>'+ item.msgOrder + '</td>'+
	                           '<td>'+ item.empName + '</td>'+
	                           '<td><a href="${pageContext.request.contextPath}/msg/msgOne?msgNo='+
	                                   item.msgNo +'">'+ item.title + '</a></td>'+
	                           '<td>'+ item.createDatetime + '</td>'+
	                           '<td id="readYN">'+ item.readYN + '</td>'+
	                           '</tr>'
	                       );
	                   });
	
	                   updateBtnState();
	               }
	           });
	       }
			//페이징 버튼 활성화
	       function updateBtnState() {
	           console.log("update");
	           $('#pre').prop('disabled', currentPage === 1);
	           $('#next').prop('disabled', currentPage === lastPage);
	           $('#first').prop('disabled', currentPage === 1);
	           $('#last').prop('disabled', currentPage === lastPage);
	       }
			//이전 
	       $('#pre').click(function() {
	           if (currentPage > 1) {
	               currentPage -= 1;
	               loadMsg(readYN, currentPage);
	           }
	       });
			//다음 
	       $('#next').click(function() {
	           if (currentPage < lastPage) {
	               currentPage += 1;
	               loadMsg(readYN, currentPage);
	           }
	       });
			//첫페이지 이동 
	       $('#first').click(function() {
	           if (currentPage > 1) {
	               currentPage = 1;
	               loadMsg(readYN, currentPage);
	           }
	       });
			//마지막 페이지 
	       $('#last').click(function() {
	           if (currentPage < lastPage) {
	               currentPage = lastPage;
	               loadMsg(readYN, currentPage);
	           }
	       });
		   
		   
	     	//카데고리 분기
	       $('#all').click(function(){
	           readYN = 'all';
	           currentPage = 1;
	           loadMsg(readYN, currentPage); // 전체목록
	       });
	
	       $('#Y').click(function(){
	           readYN = 'Y';
	           currentPage = 1;
	           loadMsg(readYN, currentPage); // 읽은 쪽지
	       });
	
	       $('#N').click(function(){
	           readYN = 'N';
	           currentPage = 1;
	           loadMsg(readYN, currentPage); // 안읽은 쪽지
	       });
	
	       // 페이지 첫 로드 시 전체 목록 불러오기
	       loadMsg(readYN, currentPage);
			
	     	//휴지통 이동
		   $('#toTrash').click(function(){
			   let selectedMsgNos = [];
			  //name이  msgNo+체크된 값만 가져오기 => 배열에 하나씩 넣기 
			  $('[name="msgNo"]:checked').each(function() {
				  selectedMsgNos.push($(this).val());
	        	});
			  console.log(selectedMsgNos[0]);
			   if(selectedMsgNos.length > 0){
				   $.ajax({
					   url: '${pageContext.request.contextPath}/msg/toTrash',
					   method: 'post',
					   traditional:true, 
					   data:{
						   msgNos:selectedMsgNos
					   },
					   success:function(){
						   alert('쪽지가 휴지통으로 이동하였습니다.')
						   loadMsg("all"); // 이동 후 전체 목록 새로고침
					   }
			   })
			   }else {
				   alert('휴지통으로 이동할 쪽지를 선택해주세요.');
			   }
			   
		   });
		
		   
	   })
</script>
</body>
</html>