<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	
	<button type="button" name="deleteMsg" id="deleteMsg">삭제</button>
	<button type="button" name="toMsgBox" id="toMsgBox">쪽지함으로 복구</button>
	<table border="1">
		<thead>
			<tr>
				<td>선택</td>
				<td>쪽지번호</td>
				<td>보낸이</td>
				<td>받은이</td>
				<td>제목</td>
				<td>휴지통 이동 일시</td>
			</tr>
		</thead>
		<tbody id="msgTableBody">
		<c:forEach var="m" items="${list}">
			<tr>
				<td><input type="checkbox" name="msgNo" value="${m.msgNo}"></td>
				<td>${m.msgOrder}</td>
				<td id="senderName">${m.senderName}</td>
				<td>${m.receiverName }</td>
				<td><a href="${pageContext.request.contextPath}/msg/msgOne?msgNo=${m.msgNo}">${m.title}</a></td>
				<td>${m.updateDatetime}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
<script>
	$(document).ready(function(){
		//세션에 empName 이랑 senderNamevalue가 똑같으면 내가 보낸 사람 => 즉 updateToMsgBox 실행 
		//그렇지 않다면 updateToMsgBoxRecipient 실행 
		$('#toMsgBox').click(function(){
			let empName = '${empName}';
			let selectedMsgNos = [];
			let selectedResult = [];
			$('#msgTableBody input[name="msgNo"]:checked').each(function() {
				selectedMsgNos.push($(this).val());
				console.log(selectedMsgNos[0]);
	            // 현재 체크된 체크박스의 행을 찾기 >> .closest () -> 첫번째 부모 엘리먼트 찾기
	            let row = $(this).closest('tr');
	            // 해당 행의 senderName 값을 가져오기
	            let senderName = row.find('#senderName').text();
	            
	            if (empName === senderName) {
	            	selectedResult.push('true');
	            } else {
	            	selectedResult.push('false');
	            }
	        })
	        if(selectedMsgNos.length > 0){
	        	$.ajax({
				url: '${pageContext.request.contextPath}/msg/toMsgBox',
				method: 'post',
				traditional:true, 
				data:{
					   msgNos:selectedMsgNos,
					   results:selectedResult
				},
				success:function(){
					alert('쪽지가 쪽지함으로 복구되었습니다.')
					location.reload();
				   }
				})
	        }else{
	        	alert('복구할 쪽지를 선택해주세요.');
	        }
			
		})
		
		
		//쪽지 삭제
		$('#deleteMsg').click(function(){
			let empName = '${empName}';
			let selectedMsgNos = [];
			let selectedResult = [];
			$('#msgTableBody input[name="msgNo"]:checked').each(function() {
				selectedMsgNos.push($(this).val());
				console.log(selectedMsgNos[0]);
	            
	            let row = $(this).closest('tr');
	            // 해당 행의 senderName 값을 가져오기
	            let senderName = row.find('#senderName').text();
	            
	            if (empName === senderName) {
	            	selectedResult.push('true');
	            } else {
	            	selectedResult.push('false');
	            }
	        })
	        if(selectedMsgNos.length > 0){
	        	$.ajax({
					url: '${pageContext.request.contextPath}/msg/deleteMsg',
					method: 'post',
					traditional:true, 
					data:{
						   msgNos:selectedMsgNos,
						   results:selectedResult
					},
					success:function(){
						alert('쪽지가 삭제되었습니다.')
						location.reload();
					   }
					})
	        }else{
	        	alert('삭제할 쪽지를 선택해주세요.');
	        }
			
		})
	})

</script>
</body>
</html>