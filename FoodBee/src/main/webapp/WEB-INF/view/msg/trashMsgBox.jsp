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
				<td><input type="checkbox" id="selectAll"></td>
				<td>쪽지번호</td>
				<td>보낸이</td>
				<td>받은이</td>
				<td>제목</td>
				<td>휴지통 이동 일시</td>
			</tr>
		</thead>
		<tbody id="msgTableBody">
		<!-- 동적으로 리스트 추가 -->
		</tbody>
	</table>
	<div id="page">
        <button type="button" id="first">First</button>
        <button type="button" id="pre">◁</button>
        <button type="button" id="next">▶</button>
        <button type="button" id="last">Last</button>
	</div>
<script>
	let currentPage = 1;
	let lastPage = 1;
	
	$(document).ready(function(){
		
		function loadMsg(page){
			$.ajax({
                url : '${pageContext.request.contextPath}/msg/trashMsgBox',
                method: 'post',
                data : {
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
                            '<td id="senderName">'+ item.senderName + '</td>'+
                            '<td>'+ item.receiverName + '</td>'+
                            '<td><a href="${pageContext.request.contextPath}/msg/msgOne?msgNo='+
                                    item.msgNo +'">'+ item.title + '</a></td>'+
                            '<td>'+ item.updateDatetime + '</td>'+
                            '</tr>'
                        );
                    });
					// 페이지 변경 시 전체선택 체크박스는 초기화 
                    $('#selectAll').prop('checked', false);
					
                    updateBtnState();
                }
            });
		}
		
	    // 페이지 첫 로드 시 전체 목록 불러오기
	    loadMsg(currentPage);
	    
		// --- 페이징 ---
		// 페이징 버튼 활성화
        function updateBtnState() {
            console.log("update");
            $('#pre').prop('disabled', currentPage === 1);
            $('#next').prop('disabled', currentPage === lastPage);
            $('#first').prop('disabled', currentPage === 1);
            $('#last').prop('disabled', currentPage === lastPage);
        }
		// 이전 
		$('#pre').click(function() {
			if (currentPage > 1) {
				currentPage = currentPage - 1;
				loadMsg(currentPage);
			}
		});
		// 다음 
		$('#next').click(function() {
			if (currentPage < lastPage) {
				currentPage = currentPage + 1;
				loadMsg(currentPage);
			}
		});
		// 처음 
		$('#first').click(function() {
			if (currentPage > 1) {
				currentPage = 1;
				loadMsg(currentPage);
			}
		});
		// 마지막
		$('#last').click(function() {
			if (currentPage < lastPage) {
				currentPage = lastPage
				loadMsg(currentPage);
			}
		});
		
		// 쪽지 전체 선택 
		$('#selectAll').click(function(){
			// 전체 선택 체크 여부 확인
			let checked = $('#selectAll').is(':checked');
			// 전체 선택 여부 true => checked 속성 true 즉 추가 
			if(checked){
				$('input:checkbox').prop('checked',true);
			}else{
				// 전체 선택 여부 false => checked 속성 false 즉 제거
				$('input:checkbox').prop('checked',false);
			}
		
		});
		
		// 체크박스 클릭 시 전체체크박스 수 와 체크된 값을 비교 
		// 일치하지 않다면 전체체크 checked, false
		// 일치하다면 전체체크되었다는 말이므로 checked,true 
		
		// 리스트가 동적으로 생성되고 있기 때문에 document.on을 쓰는 게 더 적합
		$(document).on('click', 'input[name="msgNo"]', function() {
			let total = $('input[name="msgNo"]').length;
			let checked = $('input[name="msgNo"]:checked').length;

			if(total != checked) {
				$("#selectAll").prop("checked", false);
			}else{
				$("#selectAll").prop("checked", true); 
			}
		});
		
		
		
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
			
		});
		
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
		
		
	})

</script>
</body>
</html>