<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사내 게시판 글 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	body {
	    font-family: Arial, sans-serif;
	    background-color: #f9f9f9;
	    margin: 0;
	    padding: 0;
	}
	
	
	h1 {
	    text-align: center;
	    color: #38d642; 
	}
	
	.tab-menu {
	    display: flex;
	    justify-content: center;
	    margin-bottom: 20px;
	}
	
	.tab-button {
	    padding: 10px 20px;
	    margin: 0 5px;
	    border: none;
	    background-color: #e0e0e0;
	    cursor: pointer;
	    color: #38d642;
	    font-weight: bold;
	}
	
	.tab-button.active,
	.tab-button:hover {
	    background-color: #38d642;
	    color: #fff;
	}
	
	.search-bar {
	    display: flex;
	    justify-content: center;
	    margin: 20px 0;
	    width: 50%;
	}
	
	#category {
	    padding: 10px;
	    border: 1px solid #ccc;
	    margin-right: 10px;
	}
	
	#search {
	    padding: 10px;
	    border: 1px solid #ccc;
	    margin-right: 10px;
	    flex: 1;
	}
	
	.search-button {
	    padding: 10px 20px;
	    border: none;
	    background-color: #38d642;
	    color: #fff;
	    cursor: pointer;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-bottom: 20px;
	}
	
	th, td {
	    padding: 10px;
	    border: 1px solid #ccc;
	    text-align: center;
	}
	
	th {
	    background-color: #38d642;
	    color: #fff;
	}
	
	.pagination {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    margin-bottom: 20px;
	}
	
	.page-button, .page-number {
	    padding: 10px 15px;
	    margin: 0 5px;
	    border: 1px solid #ccc;
	    background-color: #fff;
	    cursor: pointer;
	}
	
	.page-number.active, .page-number:hover {
	    background-color: #38d642;
	    color: #fff;
	    border-color: #4b0082;
	}
	
	.write-button {
	    display: block;
	    width: 100px;
	    padding: 10px;
	    margin: 0 auto;
	    border: none;
	    background-color: #38d642;
	    color: #fff;
	    cursor: pointer;
	    text-align: center;
	}
	.most-liked {
    background-color: #f9f9f9; 
    font-weight: bold;
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
		<div class="container">
	        <h1>익명 게시판</h1>
	        <div class="tab-menu">
	            <button class="tab-button" id="all">전체</button>
	            <button class="tab-button" id="chat">잡담</button>
	            <button class="tab-button" id="company">회사이야기</button>
	            <button class="tab-button" id="question">질문</button>
	        </div>
	        <table>
	            <thead>
	                <tr>
	                    <th>번호</th>
	                    <th>카테고리</th>
	                    <th>제목</th>
	                    <th>작성 일자</th>
	                    <th>조회수</th>
	                    <th>좋아요</th>
	                </tr>
	            </thead>
	            <tbody class="most-liked" id="boardBodyMostLiked">
	               
	            </tbody>
	             <tbody id="boardBody">
	               
	            </tbody>
	        </table>
	        <div class="search-bar">
	            <select name="category" id="category">
	                <option value="all">카테고리</option>
	                <option value="chat">잡담</option>
	                <option value="company">회사이야기</option>
	                <option value="question">질문</option>
	            </select>
	            <input type="text" id="search" placeholder="제목을 입력하세요">
	            <button class="search-button" id="searchButton">검색</button>
	        </div>
		 	<div id="page">
		        <button type="button" id="first">First</button>
		        <button type="button" id="pre">◁</button>
		        <button type="button" id="next">▶</button>
		        <button type="button" id="last">Last</button>
			</div>
	        <button class="write-button" id="writeButton">글쓰기</button>
	    </div>
	</div>
</div>
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>

	let currentPage = 1;
	let lastPage = 1;
	let category = "all";
	let keyword = "";
	
	$(document).ready(function(){
		function loadBoardList(page,category,keyword){
			$.ajax({
				url:'${pageContext.request.contextPath}/community/board/boardList',
				method:'post',
				data:{
					category: category,
					keyword: keyword,
					currentPage: page
				},
				success:function(json){
					
                    lastPage = json.lastPage;
                    console.log('Current Page =>', currentPage, 'Last Page =>', lastPage);
                    
					$('#boardBody').empty();
					   json.boardList.forEach(function(item){
						   console.log(item)
						   if(item.deleteYN === 'N'){
							   $('#boardBody').append('<tr>' +
									'<td>'+ item.boardOrder +'</td>'+
									'<td>'+ item.boardCategory + '</td>'+
									'<td><a id="title" href="${pageContext.request.contextPath}/community/board/boardOne?boardNo='+
											item.boardNo +'" data-board-no="' + item.boardNo + '">'+ item.title +'&nbsp;'+' ['+item.commentCnt+'] '+'</a></td>'+
									'<td>'+ item.createDatetime + '</td>'+
									'<td>'+ item.view + '</td>'+
									'<td>'+ item.likeCnt + '</td>'+
									'</tr>' 
						  	 	 );
						   }else if(item.deleteYN === 'Y'){
							   // 관리자에 의해 삭제된 글일 경우 disabled로 상세보기 하지 못하게 막기 
							   $('#boardBody').append('<tr>' +
										'<td>'+ item.boardOrder +'</td>'+
										'<td>'+ item.boardCategory + '</td>'+
										'<td>'+ item.title +'</td>'+
										'<td>'+ item.createDatetime + '</td>'+
										'<td>'+ item.view + '</td>'+
										'<td>'+ item.likeCnt + '</td>'+
										'</tr>' 
							  	 );
						   }
						   
					 	});
					   
					   	updateBtnState()
					}
				});
			}
		/* 인기글 리스트 상단에 뽑기 */
		function loadMostLikedList(){
			$.ajax({
				url:'${pageContext.request.contextPath}/community/board/getMostLikedList',
				method : 'post',
				success:function(json){
					   console.log(json);
					   json.forEach(function(item){
						   console.log(item)
							   $('#boardBodyMostLiked').append('<tr>' +
									'<td>'+ item.boardOrder +'</td>'+
									'<td>'+ item.boardCategory + '</td>'+
									'<td><a id="title" href="${pageContext.request.contextPath}/community/board/boardOne?boardNo='+
											item.boardNo +'" data-board-no="' + item.boardNo + '">'+ item.title +'&nbsp;'+' ['+item.commentCnt+'] '+'</a></td>'+
									'<td>'+ item.createDatetime + '</td>'+
									'<td>'+ item.view + '</td>'+
									'<td>'+ item.likeCnt + '</td>'+
									'</tr>' 
						  	 	 );
							});
						}
					});
				}
		
		
		$(document).on('click','#title',function(){
			let boardNo = $(this).data('board-no');
			$.ajax({
				url:'${pageContext.request.contextPath}/community/board/updateViewCnt',
				method : 'post',
				data :{
					boardNo:boardNo
				},
				success:function(json){
					console.log(json)
					console.log('조회수 업데이트 완료')
				}
			})
		})
		
		$('#all').click(function(){
			loadBoardList(currentPage,"all","");
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			//전체목록
			});
		$('#chat').click(function(){
			loadBoardList(currentPage,"chat","")
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#company').click(function(){
			loadBoardList(currentPage,"company","")
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#question').click(function(){
			loadBoardList(currentPage,"question","")
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});

		
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
				loadBoardList(currentPage,category,keyword)
			}
		});
		// 다음 
		$('#next').click(function() {
			if (currentPage < lastPage) {
				currentPage = currentPage + 1;
				loadBoardList(currentPage,category,keyword)
			}
		});
		// 처음 
		$('#first').click(function() {
			if (currentPage > 1) {
				currentPage = 1;
				loadBoardList(currentPage,category,keyword)
			}
		});
		// 마지막
		$('#last').click(function() {
			if (currentPage < lastPage) {
				currentPage = lastPage
				loadBoardList(currentPage,category,keyword)
			}
		});
		
		//검색 누를 시
	    $('#searchButton').click(function(){
			let category = $('#category').val();
			let keyword = $('#search').val();
			loadBoardList(currentPage,category, keyword);
		});
		
	    $('#writeButton').click(function(){
	        window.location.href = '${pageContext.request.contextPath}/community/board/addBoard';
	    });
	    
		// 페이지 첫 로드 시 전체 목록 불러오기
		loadMostLikedList();
	    loadBoardList(currentPage,"all",""); 
	})
</script>
</body>
</html>