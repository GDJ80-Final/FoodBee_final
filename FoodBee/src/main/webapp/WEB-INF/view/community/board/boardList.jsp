<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사내 게시판 글 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>

	
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
    .form-row {
       justify-content: center;
    }
    .form-control {
        width: auto;
    }
    .form-control-sm{
    	border:1px solid grey;
    }
    #searchButton {
        margin-left: 5px;
        
        
    }
    .default-tab{
    	cursor:pointer;
    }
</style>
</head>
<body>
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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">익명게시판</a></li>
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
                                <div class="text-right">
                                	<button class="btn btn-info" id="writeButton">글쓰기</button>
                                </div>
                                
			                    <!-- Nav tabs -->
                                <div class="default-tab">
                                    <ul class="nav nav-tabs mb-3" role="tablist">
                                        <li class="nav-item"><a class="nav-link active" data-toggle="tab" id="all">전체</a>
                                        </li>
                                        <li class="nav-item"><a class="nav-link" data-toggle="tab" id="chat">잡담</a>
                                        </li>
                                        <li class="nav-item"><a class="nav-link" data-toggle="tab" id="company">회사 이야기</a>
                                        </li>
                                        <li class="nav-item"><a class="nav-link" data-toggle="tab" id="question">질문</a>
                                        </li>
                                    </ul>
                                   
                                </div>
						      <!--   <div class="btn-group">
						            <button class="btn btn-primary btn-block" id="all">전체</button>
						            <button class="btn btn-primary btn-block" id="chat">잡담</button>
						            <button class="btn btn-primary btn-block" id="company">회사이야기</button>
						            <button class="btn btn-primary btn-block" id="question">질문</button>
						        </div> -->
						       <div class="table-responsive">
						        <table class="table">
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
						       </div>
						        <div class="form-row align-items-center mt-3">
						        	<div class="col-auto my-1">
							            <select name="category" id="category" class="custom-select mr-sm-2">
							                <option value="all">카테고리</option>
							                <option value="chat">잡담</option>
							                <option value="company">회사이야기</option>
							                <option value="question">질문</option>
							            </select>
							        </div>
							        <div class="col-auto my-1">
							        	<input type="text" id="search" class="form-control-sm" placeholder="제목을 입력하세요">
							            <button class="btn btn-info" id="searchButton">검색</button>
							        </div>
							           	
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

	 	 	
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
 	<!-- end -->
 	
         
        <!--**********************************
            Content body end
        ***********************************-->
        
 	






<!-- 템플릿 전 -->
<%-- <div id="main-wrapper">
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
 	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include> --%>
 	
 	
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
                    $('#currentPage').text(currentPage);
					$('#boardBody').empty();
					if (json.boardList.length === 0) {
                        $('#boardBody').append(
                            '<tr>'+
                            '<td colspan="6" style="text-align:center;">글이 존재하지 않습니다</td>'+
                            '</tr>')
                       
                    }else{
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
                    	
                    	
                    }
	
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
											item.boardNo +'" data-board-no="' + item.boardNo + '">'+ '<span class="badge badge-danger">인기</span>&nbsp;&nbsp;' + item.title +'&nbsp;'+' ['+item.commentCnt+'] '+'</a></td>'+
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
			$('.nav-link').removeClass('active');
			$(this).addClass('active');
			//전체목록
			});
		$('#chat').click(function(){
			loadBoardList(currentPage,"chat","")
			$('.nav-link').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#company').click(function(){
			loadBoardList(currentPage,"company","")
			$('.nav-link').removeClass('active');
			$(this).addClass('active');
			
			});
		$('#question').click(function(){
			loadBoardList(currentPage,"question","")
			$('.nav-link').removeClass('active');
			$(this).addClass('active');
			
			});

		
		// --- 페이징 ---
		// 페이징 버튼 활성화
	    function updateBtnState() {
	        console.log("update");
	        $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
	        $('#next').closest('li').toggleClass('disabled', currentPage === lastPage);
	        $('#first').closest('li').toggleClass('disabled', currentPage === 1);
	        $('#last').closest('li').toggleClass('disabled', currentPage === lastPage);
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
	    	let keyword = $('#search').val();
	    	if(keyword === ''){
	    		alert('검색어를 입력해주세요.')
	    		return;
	    	}
			let category = $('#category').val();
			
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