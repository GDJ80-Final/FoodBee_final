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
	
	.container {
	    width: 80%;
	    margin: 0 auto;
	    padding: 20px;
	    background-color: #fff;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
</style>
</head>
<body>
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
        <div class="pagination">
            <button class="page-button">Previous</button>
            <div class="page-numbers">
                <button class="page-number active">1</button>
                <button class="page-number">2</button>
                <button class="page-number">3</button>
                <button class="page-number">...</button>
                <button class="page-number">67</button>
                <button class="page-number">68</button>
            </div>
            <button class="page-button">Next</button>
        </div>
        <button class="write-button">글쓰기</button>
    </div>
<script>
	$(document).ready(function(){
		function loadBoardList(category,keyword){
			$.ajax({
				url:'${pageContext.request.contextPath}/community/board/boardList',
				method:'post',
				data:{
					category:category,
					keyword:keyword
				},
				success:function(json){
					$('#boardBody').empty();
					   json.forEach(function(item){
						   console.log(item)
						   $('#boardBody').append('<tr>' +
									'<td>'+ item.boardOrder +'</td>'+
									'<td>'+ item.boardCategory + '</td>'+
									'<td><a href="${pageContext.request.contextPath}/community/board/boardOne?boardNo='+
											item.boardNo +'">'+ item.title +' ['+item.commentCnt+'] '+'</a></td>'+
									'<td>'+ item.createDatetime + '</td>'+
									'<td>'+ item.view + '</td>'+
									'<td>'+ item.likeCnt + '</td>'+
									'</tr>' 
						   );
					 });
				}
			});
		}
		
		$('#all').click(function(){
			loadBoardList("all","");
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			//전체목록
			});
		$('#chat').click(function(){
			loadBoardList("chat","");
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#company').click(function(){
			loadBoardList("company","");
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#question').click(function(){
			loadBoardList("question","");
			$('.tab-button').removeClass('active');
			$(this).addClass('active');
			
			});
		// 페이지 첫 로드 시 전체 목록 불러오기
	    loadBoardList("all",""); 
		
		//검색 누를 시
	    $('#searchButton').click(function(){
			let selectedCategory = $('#category').val();
			let keyword = $('#search').val();
			loadBoardList(selectedCategory, keyword);
		});
	})
</script>
</body>
</html>