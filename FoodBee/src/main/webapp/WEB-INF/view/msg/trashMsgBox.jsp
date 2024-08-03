<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>FoodBee : 휴지통</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<div id="main-wrapper">
		<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
		
		<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	  	<div class="content-body">
	  		
	  		<div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">쪽지함</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">휴지통</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->
            
            <div class="container-fluid">
               <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="email-left-box">
                                <a href="${pageContext.request.contextPath}/msg/addMsg" class="btn btn-primary btn-block">새 쪽지 쓰기</a>
                                    <div class="mail-list mt-4">
                                    <a href="#" class="list-group-item border-0 text-primary p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>휴지통</b> 
                                    <span class="badge badge-primary badge-sm float-right m-t-5" id="msgCntAll">${msgCntAll}</span>
                                    </a> 
                                    </div>
                                    
                                    <h5 class="mt-5 m-b-10"></h5>
                                    <div class="list-group mail-list">
                                    	 <button class="btn btn-info btn-block" id="toMsgBox">쪽지함으로 복구</button> 
                                    </div>
                                </div>
                                <div class="email-right-box">
                                    
                                    <div class="email-list m-t-15">
													<!-- Table Headers -->
			                            <div class="table-responsive">
			                                <table class="table">
			                                    <thead>
			                                        <tr>
			                                            <th scope="col"><input type="checkbox" id="selectAll"></th>
			                                            <th scope="col">보낸이</th>
			                                            <th scope="col">받는이</th>
			                                            <th scope="col">제목</th>
			                                            <th scope="col">휴지통 이동 일시</th>
			                                        </tr>
			                                    </thead>
			                                    <tbody id="messageList">
			                                        <!-- Example Row -->
			                                        
			                                        <!-- Additional rows will be added here -->
			                                    </tbody>
			                                </table>
			                            </div>
                                     
                             
                                
                                    </div>
                                    <!-- panel & page -->
                                  	<div class="bootstrap-pagination">
                                    <nav>
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item"><button type="button" id="first" class="page-link">처음</button>
                                            </li>
                                            <li class="page-item"><button type="button" class="page-link" id="pre">이전</button>
                                            </li>
                                            <li class="page-item active"><div class="page-link" id="currentPage"></div>
                                            </li>
                                            <li class="page-item"><button type="button" class="page-link" id="next">다음</button>
                                            </li>
                                            <li class="page-item"><button type="button" class="page-link" id="last">마지막</button>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                              	<div class="text-right m-t-15">
		       						<button class="btn btn-danger m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10 send-btn" type="button" id="deleteMsg"><i class="ti-close m-r-5 f-s-12"></i> 쪽지 삭제</button>
		   						</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
	
          </div>
       </div>

   </div>
	 	 	
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
 	<!-- end -->
 	
         
        <!--**********************************
            Content body end
        ***********************************-->
        


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
                    $('#currentPage').text(currentPage);
                    $('#messageList').empty();
                    if (json.msgList.length === 0) {
                        $('#messageList').append(
                            '<tr>'+
                            '<td colspan="6" style="text-align:center;">쪽지가 없습니다</td>'+
                            '</tr>')
                       
                    } else {
                        json.msgList.forEach(function(item) {
                            console.log(item);
                            $('#messageList').append('<tr>' +
                                    '<td><input type="checkbox" name="msgNo" value="'+ item.msgNo +'"></td>'+
                                    '<td id="senderName">'+ item.senderName + '</td>'+
                                    '<td>'+ item.receiverName + '</td>'+
                                    '<td><a href="${pageContext.request.contextPath}/msg/msgOne?msgNo='+
                                            item.msgNo +'">'+ item.title + '</a></td>'+
                                    '<td>'+ item.updateDatetime + '</td>'+
                                    '</tr>'
                                );
                        });
                    }
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
            $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
            $('#next').closest('li').toggleClass('disabled', currentPage === lastPage || lastPage === 0);
            $('#first').closest('li').toggleClass('disabled', currentPage === 1);
            $('#last').closest('li').toggleClass('disabled', currentPage === lastPage || lastPage === 0);
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
			$('#messageList input[name="msgNo"]:checked').each(function() {
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
			$('#messageList input[name="msgNo"]:checked').each(function() {
				selectedMsgNos.push($(this).val());
				console.log(selectedMsgNos[0]);
	            // 현재 체크된 체크박스의 행을 찾기 >> .closest () -> 첫번째 부모 엘리먼트 찾기
	            let row = $(this).closest('tr');
	            // 해당 행의 senderName 값을 가져오기
	            let senderName = row.find('#senderName').text();
	            console.log(empName);
	            console.log(senderName);
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
		
		
	});

</script>
</body>
</html>