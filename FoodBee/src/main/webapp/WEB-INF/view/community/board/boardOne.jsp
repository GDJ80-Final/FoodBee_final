<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
	rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: auto;
        background-color: white;
        padding: 20px;
        border: 1px solid #ddd;
    }

    h1 {
        text-align: center;
        font-size: 24px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    td {
        padding: 10px;
        border: 1px solid #ddd;
        vertical-align: top;
    }

    .post-actions {
        display: flex;
        justify-content: flex-end;
        margin-top: 10px;
    }

    .button {
        padding: 5px 10px; /* Reduced padding */
        margin-left: 5px; /* Reduced margin */
        border: none;
        cursor: pointer;
        color: white;
        background-color: #55eb42;
        border-radius: 5px;
    }

    .button.delete {
        background-color: red;
    }

    .like-section {
        display: flex;
        justify-content: center;
        margin-top: 10px;
    }

    .like-button {
        background-color: #55eb42;
        border: none;
        padding: 5px 10px; 
        cursor: pointer;
        color: white;
        border-radius: 5px;
        font-size: 50px;
    }
    
    .like-count{
    	font-size: 15px;
    	test-align:center;
    }

    .comments-section {
        margin-top: 20px;
    }

    .comment-input {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .comment-box, .password-box {
        padding: 5px; 
        margin-right: 5px; 
        flex: 1;
    }

    .comment-box {
        flex: 3;
    }

    .comment {
        width: 100%;
        border: 1px solid #ddd;
        background-color: #f9f9f9;
        margin-top: 10px;
    }

    .comment-content {
        padding: 10px;
    }

    .comment-info {
        padding: 10px;
        font-size: 12px;
        color: #888;
        display: flex;
        justify-content: space-between;
    }
    .comment-date{
    	color:black;
    }
    .error-message {
        color: red;
        display: none;
        margin-top: 10px;
    }
</style>
</head>
<body>
	<div class="container">
		<div id="backToList"> << 돌아가기 </div>
		<br>
		<table class="post-details">
				<tr>
					<td>게시글 번호</td>
					<td>${m.boardNo}</td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td>${m.boardCategory}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${m.title}</td>
				</tr>
				<tr>
					<td>내용 </td>
					<td>${m.content}</td>
				</tr>
				<tr>
					<td>조회수</td>
					<td>${m.view}</td>
				</tr>
				<tr>
					<td>좋아요</td>
					<td id="likeCnt">${m.likeCnt}</td>
				</tr>
					
		</table>
		 <div class="post-actions" id="post-actions">
		 	<button type="button" class="button edit" id="modifyBoard" data-bs-toggle="modal" data-bs-target="#staticBackdrop">수정</button>
            <button  type="button" class="button delete" id="deleteBoard" data-bs-toggle="modal" data-bs-target="#staticBackdrop">삭제</button>
		 </div>
		 <div class="like-section">
		 	<button class="like-button" id="likeButton">&#10084;</button>
		 </div>
		 <div class="like-count">${m.likeCnt}</div>
		 <div class="comments-section">
		 	<h2>댓글</h2>
		 	<form method="post" action="${pageContext.request.contextPath}/community/board/addComment">
		 	<div class="comment-input">
		 			<input type="hidden" name="boardNo" id="boardNo" value="${m.boardNo}">
			 		<textarea class="comment-box" name="content" placeholder="댓글입력..."></textarea>
			 		<input type="password" name="commentPw" class="password-box" placeholder="비밀번호 입력">
			 		<button class="button register" id="addComment">댓글 등록</button>
		 	</div>
		 	</form>
		 	<div id="page">
		        <button type="button" id="first">First</button>
		        <button type="button" id="pre">◁</button>
		        <button type="button" id="next">▶</button>
		        <button type="button" id="last">Last</button>
			</div>
		 	<table class="comment" id="comment">
		 	<!-- 댓글 리스트 출력  -->
		 	
		 	</table>
		 </div>
	</div>
	<!-- 비밀번호 확인 모달 -->
	<jsp:include page="./checkPwModal.jsp"></jsp:include>
	<!-- 관리자 사유 입력 모달 -->
	<jsp:include page="./addReasonModal.jsp"></jsp:include>
<script>

	let currentPage = 1;
	let lastPage = 1;
	let boardNo = $('#boardNo').val();
 	let dptNo = '${dptNo}';
 	let empNo = '${empNo}';
 	let adminAction = '';
 	let commentNo = '';
 	console.log(dptNo);
	
 	
 	
 	
 	
	$(document).ready(function(){
		
		// 만일 세션에 담긴 dptNo 가 운영팀일 경우 게시글 강제삭제 버튼 생성


	 	if( dptNo === 'D017' || dptNo === 'D030' || dptNo === 'D043'){
	 		// 게시글 강제 삭제 버튼 추가 
	 		 $('#post-actions').append(
	 				 '<button type="button" class="button delete" id="deleteBoardByAdmin" data-bs-toggle="modal" data-bs-target="#addReason">관리자 삭제</button>'
	 				 );
	    	
	 	}else{
	 		console.log('관리자가 아닙니다.');
	 		
	 	}
		
	    // deleteBoardByAdmin 버튼 클릭 시 adminAction 변수에 "board" 저장
	    $('#post-actions').on('click', '#deleteBoardByAdmin', function() {
	        adminAction = 'board';
	        console.log(adminAction);
	       
	    });
		
		
		//좋아요 버튼 연속 클릭 여부 체크
		let isLikeClicked = false;
		$('#likeButton').click(function(){
			if (isLikeClicked) {
				alert('잠시 후 다시 시도해 주세요.');
				return;
			}else{
				//클릭이 시작되었으므로 true 설정
				isLikeClicked = true;
				$.ajax({
					url:'${pageContext.request.contextPath}/community/board/updateLikeCnt',
					method:'post',
					data:{
						boardNo:'${m.boardNo}'
					},
					success: function(json){
						console.log(json);
						console.log('좋아요 업데이트 완료');
						console.log(isLikeClicked);
						$('#likeCnt').text(json);
						//타임아웃 10분 -> 600000
						console.log(isLikeClicked);
						setTimeout(function() {
							isLikeClicked = false;
						}, 600000);
					}
					//AJAX 요청 성공 시 timeout 설정해서 특정 시간이 지난 후에만 isLikeClicked를 false로 바꿔줌 
					
				
				})
			
			 }
		})
		 
		// 댓글 리스트 출력 + 페이징 
		function loadCommentList(currentPage, boardNo) {
			$.ajax({
				url: '${pageContext.request.contextPath}/community/board/commentList',
				method: 'post',
				data: {
					currentPage: currentPage,
					boardNo: boardNo
				},
				success: function(json) {
					lastPage = json.lastPage;
					console.log('Current Page =>', currentPage, 'Last Page =>', lastPage);
					$('#comment').empty();
					json.commentList.forEach(function(item) {
						console.log(item);
						$('#comment').append('<tr>' +
							'<td class="comment-content"><span>['+ item.commentOrder + ']</span>&nbsp;' + item.content + '</td>' + 
							'</tr>' +
							'<tr><td class="comment-info"><span class="comment-date">' + item.createDatetime + '</span>'+
							'<button type="button" id="deleteComment" value="'+item.commentNo+'" data-bs-toggle="modal" data-bs-target="#staticBackdrop">X</button></td>'+
							'</tr>'
						);
						// 관리자일 경우에만 "관리자 삭제" 버튼 추가
		                if (dptNo === 'D017' || dptNo === 'D030' || dptNo === 'D043') {
		                    $('#comment').append('<tr><td><button type="button" id="deleteCommentByAdmin" value="'+item.commentNo+'" data-bs-toggle="modal" data-bs-target="#addReason">관리자 삭제</button></td></tr>');
		                }
					});
					updateBtnState();
				}
				
			});
		}
		
	    $('#comment').on('click', '#deleteCommentByAdmin', function() {
	        adminAction = 'comment';
	        commentNo = $(this).val();
	        console.log(commentNo);
	        console.log(adminAction);
	       
	    });
		
		
	
		/* 페이징 */
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
				loadCommentList(currentPage,boardNo)
			}
		});
		// 다음 
		$('#next').click(function() {
			if (currentPage < lastPage) {
				currentPage = currentPage + 1;
				loadCommentList(currentPage,boardNo)
			}
		});
		// 처음 
		$('#first').click(function() {
			if (currentPage > 1) {
				currentPage = 1;
				loadCommentList(currentPage,boardNo)
			}
		});
		// 마지막
		$('#last').click(function() {
			if (currentPage < lastPage) {
				currentPage = lastPage
				loadCommentList(currentPage,boardNo)
			}
		});
		/* 페이징 종료 */
		
		// 페이지 첫 로드 시 전체 목록 불러오기
	    loadCommentList(currentPage,boardNo);
		
		$('#backToList').click(function(){
			window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
		})
		
		
		
		
		// -- 비밀번호 확인 모달 --
		
        // 비번확인 후 이동 할 액션 
        let action = '';
		// 댓글 번호 
		let commentNo = '';
    	

        // 수정 버튼 클릭 이벤트
        $('#modifyBoard').click(function() {
            action = 'modify';
        });

        // 삭제 버튼 클릭 이벤트
        $('#deleteBoard').click(function() {
            action = 'delete';
        });
        
     	// 댓글 삭제 전 비번 체크 
		$(document).on('click', '#deleteComment', function() {
			commentNo = $(this).val();
			console.log(commentNo);
			action = 'deleteComment';
		});

        $('#checkPw').click(function() {
            let password = $('#password').val();
			console.log(action);
            if (password && action != 'deleteComment') {
                $.ajax({
                    url: '${pageContext.request.contextPath}/community/board/boardPwCheck',
                    method: 'post',
                    data: {
                        boardNo: boardNo,
                        boardPw: password
                    },
                    success: function(json) {
                        console.log(action);
                        if (json) {
                            if (action === 'modify') {
                                window.location.href = '${pageContext.request.contextPath}/community/board/modifyBoard?boardNo=' + boardNo;
                            } else if (action === 'delete') {
                                if (confirm('삭제하시겠습니까?')) {
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/community/board/deleteBoard',
                                        method: 'post',
                                        data: {
                                            boardNo: boardNo
                                        },
                                        success: function(json) {
                                        	console.log(json);
                                            if (json) {
                                                alert('삭제되었습니다.');
                                                window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
                                            } else {
                                                alert('댓글이 달린 게시글은 삭제할 수 없습니다');
                                            }
                                        }
                                    });
                                }
                            }
                        } else {
                            $('#errorMessage').show();
                        }
                    }
                });
            } else if(password && action === 'deleteComment'){
            	$.ajax({
            		url: '${pageContext.request.contextPath}/community/board/commentPwCheck',
            		method : 'post',
            		data :{
            			commentNo : commentNo,
            			commentPw : password
            		},
            		success:function(json){
            			console.log(json);
            			if(json){
            				if (confirm('삭제하시겠습니까?')){
            					$.ajax({
                                    url: '${pageContext.request.contextPath}/community/board/deleteComment',
                                    method: 'post',
                                    data: {
                                        commentNo : commentNo
                                    },
                                    success: function(json){
                                    	console.log(json);
                                    	if(json){
                                    		alert('삭제되었습니다.');
                                            window.location.href = '${pageContext.request.contextPath}/community/board/boardOne?boardNo='+boardNo;
                                        }else {
                                            alert('댓글을 삭제할수 없습니다. ');
                                        }
                                    }
            					}); // deleteComment
            					
                              }
            			}else{ // 비번 불일치시 에러 메세지 출력 
            				$('#errorMessage').show();
            			}
            		}
            		
            		
            	})
                
            } else {
            	alert('비밀번호를 입력하세요.');
            }
        });
        
     	// 모달이 닫힐 때 입력된 비밀번호 + 오류문구 초기화
        $('#staticBackdrop').on('hidden.bs.modal', function () {
            $('#password').val('');
            $('#errorMessage').hide();
            action = ''; 
        });
     	/* 모달 종료 */
     	
     	
     	/* 관리자 강제삭제 사유 모달   */
     	
        $('#addReasonButton').click(function() {
            let selectedReason = $('#reasonSelect').val();
            if (!selectedReason) {
                $('#errorMessage').show();
            } else {
                $('#errorMessage').hide();
                console.log('선택된 사유:', selectedReason);
                console.log('adminAction :',adminAction);
                if(adminAction === 'board'){
                	$.ajax({
	                	url:'${pageContext.request.contextPath}/community/board/deleteBoardByAdmin',
	                	method : 'post',
	                	data:{
	                		boardNo:boardNo,
	                		empNo:empNo,
	                		deleteReason : selectedReason
	                	},
	                	success:function(json){
	                		console.log(json);
	                		
	                		window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
	                	}
                	});
                }else if(adminAction === 'comment'){
                	$.ajax({
                		url: '${pageContext.request.contextPath}/community/board/deleteCommentByAdmin',
                		method : 'post',
                		data :{
                			commentNo : commentNo,
                			empNo : empNo,
                			deleteReason : selectedReason
                		},
                		success:function(json){
                			console.log(json);
                			window.location.href = '${pageContext.request.contextPath}/community/board/boardOne?boardNo='+boardNo;
                		}
                	}) 
                }
                
                
            }
        });

        // 사유 선택 시 에러 메시지 숨기기
        $('#reasonSelect').change(function() {
            if ($(this).val()) {
                $('#errorMessage').hide();
            }
        });
        
        $('#addReason').on('hidden.bs.modal', function() {
            $('#reasonSelect').val('');
            $('#errorMessage').hide();
            adminAction = ''; // action 초기화
            commentNo = '';   // commentNo 초기화
            console.log('모달 닫힘, 변수 초기화됨');
        });
        /* 관리자 강제삭제 사유 모달 종료   */
     	

	});
</script>

</body>
</html>