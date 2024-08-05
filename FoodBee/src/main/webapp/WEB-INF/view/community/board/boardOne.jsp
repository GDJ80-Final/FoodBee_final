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
   
    .error {
        color: red;
        
        margin-top: 10px;
    }
    .error-message {
      color: red;
      display: none; 
    }
</style>
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
                        <li class="breadcrumb-item"><a href="javascript:void(0)">커뮤니티</a></li>
                        <li class="breadcrumb-item"><a href="javascript:void(0)">익명게시판</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">글 상세보기</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->
            
            <div class="container-fluid">
               <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <!-- 내용 시작 -->
                                  <div class="read-content">
                                        <div class="media">                                           
                                            <div class="media-body">
                                                <h5 class="m-b-3 text-primary"><a href="${pageContext.request.contextPath}/community/board/boardList">${m.boardCategory} > </a></h5>  
                                                <h3 class="m-0 mt-2 mb-2">${m.title}</h3>   
                                                <span class="float-left">조회수 :  ${m.view}</span> 
                                                <span class="float-right">${m.createDatetime}</span>                                       
                                            </div>
                                        </div>
                                        <hr style="background:black;">
                                        
                                        
                                        <h5 class="m-b-15"></h5>
                                        <p>${m.content}</p>
                                        <hr>
                                        <div class="media-body">
	                                        
	                                        <div class="text-center mt-3">
		                                        <button type="button" id="likeButton" class="btn mb-1 btn-danger">좋아요<span class="btn-icon-right"><i id="likeCnt" class="fa fa-heart">
		                                         ${m.likeCnt}
		                                        </i></span></button>
		                                        
	                                        </div>  
	                                        
	                                        <div id="post-actions" class="float-left mt-5 mb-5">
												 <button type="button" class="btn btn-primary" id="backToList">돌아가기</button>
					 						</div> 
	                                        <div id="post-actions" class="float-right mt-5 mb-5">
												 <button type="button" class="btn btn-info" id="modifyBoard" data-bs-toggle="modal" data-bs-target="#staticBackdrop">수정</button>
										         <button  type="button" class="btn btn-danger" id="deleteBoard" data-bs-toggle="modal" data-bs-target="#staticBackdrop">삭제</button>
					 						</div>                               
                                        </div>
			           			</div>
			           			
			           			<div class="comments-section mt-5">
								 	<form id="addCommentForm" method="post" action="${pageContext.request.contextPath}/community/board/addComment">
									 	<div class="comment-input">
									 		<input type="hidden" name="boardNo" id="boardNo" value="${m.boardNo}">
										 	<textarea class="form-control h-150px" rows="4" name="content" id="content" placeholder="댓글을 남겨보세요"></textarea>
										 	<div id="contentError" class="error"></div>
										</div>
										
										<div class="mt-2">
										 	<input type="password" name="commentPw" id="commentPw" class="form-inline" placeholder="비밀번호 입력">
										 	<div id="passwordError" class="error"></div>
										 	<div class="float-right"><button class="btn btn-primary mb-3" id="addComment">댓글 등록</button></div>
										</div>

								 	</form>
								 	<div class="table-responsive mt-5">
								 	<table class="table" id="comment">
								 	<!-- 댓글 리스트 출력  -->
								 	
								 	</table>
								 	</div>
                                    <!-- panel & page -->
                                  	<div class="bootstrap-pagination mt-4">
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
				 				</div>
			           			
			           			
                            </div>
                               
                               
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<!-- 비밀번호 확인 모달 -->
			<jsp:include page="./checkPwModal.jsp"></jsp:include>
			<!-- 관리자 사유 입력 모달 -->
			<jsp:include page="./addReasonModal.jsp"></jsp:include>
	 	 	
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
 	<!-- end -->
 	
         
        <!--**********************************
            Content body end
        ***********************************-->
        

<script>

	let currentPage = 1;
	let lastPage = 1;
	let boardNo = $('#boardNo').val();
 	let dptNo = '${dptNo}';
 	let empNo = '${empNo}';
 	let adminAction = '';
 	let commentNo = '';
 	
 	
 	console.log(dptNo);
	
 	
 	// 팀 권한 코드
	let teamAuthCode;
 	
 	
	$(document).ready(function(){
		
		// 만일 세션에 담긴 dptNo로 권한 코드를 구해 G-3(운영팀)일 경우 게시글 강제삭제 버튼 생성
		
		// 팀 권한 코드 구하기
		$.ajax({
			url: '${pageContext.request.contextPath}/auth/getTeamAuth',
			method:'get',
			async: false,
			data:{dptNo : '${emp.dptNo}'},
			success:function(json){
				console.log(json);
				teamAuthCode = json;
			}
		})


	 	if(teamAuthCode == 'G-3'){
	 		// 게시글 강제 삭제 버튼 추가 
	 		 $('#post-actions').append(
	 				 '<button type="button" class="btn btn-secondary" id="deleteBoardByAdmin" data-bs-toggle="modal" data-bs-target="#addReason">관리자 삭제</button>'
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
					$('#currentPage').text(currentPage);
					$('#comment').empty();
					json.commentList.forEach(function(item) {
						console.log(item);
						$('#comment').append('<tr>' +
							'<td style="border-top:1px solid;">' + item.content + 
							'<button type="button" class="float-right btn btn-danger pt-1 pb-1" id="deleteComment" value="'+item.commentNo+'" data-bs-toggle="modal" data-bs-target="#staticBackdrop"> 삭제</button></td>' + 
							'</tr>' +
							'<tr><td style="border-bottom:1px solid;"id="section'+ item.commentOrder +
							'"><span>' + item.createDatetime + '</span>'+
							'</td>'+
							'</tr>'
						);
						// 관리자일 경우에만 "관리자 삭제" 버튼 추가
		                if (teamAuthCode == 'G-3' && item.deleteYN != 'Y') {
		                    $('#section'+item.commentOrder).append('<button type="button" class="float-right btn btn-secondary pt-1 pb-1" id="deleteCommentByAdmin" value="'+item.commentNo+'" data-bs-toggle="modal" data-bs-target="#addReason">관리자 삭제</button>');
		                }
					});
					updateBtnState();
				}
				
			});
		}
	    // 비밀번호 유효성 검사 함수
	    function validatePassword(password) {
	        // 비밀번호 정규식: 숫자 4자
	        const passwordRegex = /^\d{4}$/;
	        return passwordRegex.test(password);
	    }
	    
	    // 비밀번호 유효성검사
	    $('#commentPw').blur(function() {
	        let commentPw = $(this).val().trim();
	        if (!validatePassword(commentPw)) {
	            $('#passwordError').text('비밀번호는 숫자 4자여야 합니다.');
	        } else if(commentPw === ''){
	            $('#passwordError').text('비밀번호를 입력해주세요');
	        }else{
	        	$('#passwordError').text('');
	        }
	    });

	    // 내용 필드 공백검사
	    $('#content').blur(function() {
	        let content = $(this).val().trim();
	        if (content === '') {
	            $('#contentError').text('내용을 입력해 주세요.');
	        } else {
	            $('#contentError').text('');
	        }
	    });
		
	    
	 	// 제출 버튼 클릭 시 전체 유효성 검사
	    $('#addComment').click(function(e) {

	        $('#commentPw').blur();
	        $('#content').blur();

	        // 유효성 검사 확인
	        if ($('.error:contains("입력해 주세요"), .error:contains("비밀번호는 숫자 4자여야 합니다.")').length === 0) {
	            $('#addCommentForm').submit();
	        }else{
	        	 e.preventDefault();
	   			 alert('내용과 비밀번호를 확인해주세요.')
	        }
	    });
	    
	    
	    
	    
	    
	    
	    
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
	        $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
	        $('#next').closest('li').toggleClass('disabled', currentPage === lastPage || lastPage === 0 );
	        $('#first').closest('li').toggleClass('disabled', currentPage === 1);
	        $('#last').closest('li').toggleClass('disabled', currentPage === lastPage || lastPage === 0 );
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
                            alert('비밀번호가 틀렸습니다.')
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
            				$('#errorMessage').text('비밀번호가 일치하지 않습니다.')
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
            console.log(selectedReason)
            if (!selectedReason) {
                alert('사유를 선택해주세요')
            } else {
                
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
	                	},
	                	error: function(jqXHR, textStatus, errorThrown) {
	                        if(jqXHR.status === 403) {
	                            alert('권한이 없습니다.');
	                        }
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
                		},
                		error: function(jqXHR, textStatus, errorThrown) {
                            if(jqXHR.status === 403) {
                                alert('권한이 없습니다.');
                            }
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