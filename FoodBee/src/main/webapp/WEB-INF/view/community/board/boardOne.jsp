<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		 <div class="post-actions">
		 	<button class="button edit">수정</button>
            <button class="button delete">삭제</button>
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
<script>

	let currentPage = 1;
	let lastPage = 1;
	let boardNo = $('#boardNo').val();
	
	$(document).ready(function(){
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
							'<tr><td class="comment-info"><span class="comment-date">' + item.createDatetime + '</span></td></tr>'
						);
					});
					updateBtnState();
				}
			});
		}
		
		
	
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
		
		// 페이지 첫 로드 시 전체 목록 불러오기
	    loadCommentList(currentPage,boardNo);
		
		$('#backToList').click(function(){
			window.location.href = '${pageContext.request.contextPath}/community/board/boardList';
		})
	})
</script>

</body>
</html>