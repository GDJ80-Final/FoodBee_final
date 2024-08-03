<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<style>	
	#addNotice {
	    display: flex;
	    justify-content: flex-end; /* 버튼을 오른쪽으로 정렬 */
	    margin-bottom: 10px;
	}
	#addNotice .btn {
	    width: 150px; /* 버튼의 가로 길이 조정 */
	}
	th {
	    font-weight: bold;
	}
	
</style>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
	<div class="row page-titles mx-0">
         <div class="col p-md-0">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item"><a href="javascript:void(0)">커뮤니티</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항</a></li>
             </ol>
         </div>
   	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		<!-- 여기서부터 내용시작 -->
				 		<div id="addNotice">
							<c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
							   	<a href="addNotice" class="btn btn-info btn-block">공지사항 작성</a>
							</c:if>
						</div>
						<ul class="nav nav-tabs mb-3">
                            <li class="nav-item"><a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false" id="listBtn">전체</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false" id="empBtn">전사공지</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="dptBtn">부서공지</a>
                            </li>
                        </ul>

						<div id="table-body"class="table-responsive">
							<table id="noticeTable" class="table header-border">
							    <thead>
							        <tr>
							            <th>번호</th>
							            <th>공지구분</th>
							            <th>제목</th>
							            <th>작성자</th>
							            <th>작성일자</th>
							        </tr>
							    </thead>
							    <tbody id="noticeTableBody">
							    </tbody>
							</table>
						</div>
						<input type="hidden" id="hiddenPage" value="all">
						<!-- panel & page -->
						<div class="bootstrap-pagination mt-3" id="page">
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
						<!-- 여기가 내용끝! --> 		
                    </div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

let currentPage = 1;
let lastPage = 1;

$(document).ready(function() {
	loadAllNoticeList(currentPage);

    <!--히든필드를 가져와서 -->
    let hiddenFieldValue = $('#hiddenPage').val();
    console.log(hiddenFieldValue);
    
    // 전체공지사항 
    $("#listBtn").click(function() {
        loadAllNoticeList(1);
    });
    //전사원별 공지사항
	$("#empBtn").click(function() {
		loadEmpNoticeList(1);
    });
    //부서별 공지사항
	$("#dptBtn").click(function() {
		loadDptNoticeList(1);       
    });
    
    //전체 공지사항 a-jax
	function loadAllNoticeList(currentPage) {
        $.ajax({
            url: "${pageContext.request.contextPath}/community/notice/allNoticeList",
            type: "GET",
            data: {
                currentPage: currentPage,
                dptNo:"${dptNo}"
            },
            success: function(json) {
            	$('#currentPage').text(currentPage);
            	console.log("Ajax요청성공", json);
            	updateAllNotice(json);
            },
            error: function() {
                alert("전체 공지사항을 가져올 수 없습니다.");
            }
        });
    }
    //전사원별 공지사항
	function loadEmpNoticeList(currentPage) {
        $.ajax({
            url: "${pageContext.request.contextPath}/community/notice/allEmpList",
            type: "GET",
            data: {
                currentPage: currentPage
            },
            success: function(json) {
            	$('#currentPage').text(currentPage);
            	console.log("Ajax요청성공", json);
            	updateEmpNotice(json);
            },
            error: function() {
                alert("전사원별 공지사항을 가져올 수 없습니다.");
            }
        });
    }
    
	//부서별 공지사항
	function loadDptNoticeList(currentPage) {
        $.ajax({
            url: "${pageContext.request.contextPath}/community/notice/allDptList",
            type: "GET",
            data: {
                currentPage: currentPage,
                dptNo:"${dptNo}"
            },
            success: function(json) {
            	$('#currentPage').text(currentPage);
            	console.log("Ajax요청성공", json);
            	updateDptNotice(json);
            },
            error: function() {
                alert("전사원별 공지사항을 가져올 수 없습니다.");
            }
        });
    }
	//전체
	function updateAllNotice(json){
		lastPage = json.lastPage;
		console.log('lastPage : ' + lastPage);
		 <!-- hiddenFieldValue 값을 개인으로 세팅 -->
     	hiddenFieldValue = "allList"
        console.log("hiddenFieldValue : " + hiddenFieldValue);
     	<!-- 버튼 활성화 함수(updateBtnState) 실행 -->
		updateBtnState();
		
		let tableBody = $("#noticeTableBody");
        tableBody.empty();
        
        if(json.list == ""){
        	alert("공지사항이 존재하지 않습니다");
        	tableBody.append("<tr><td colspan='5'>공지사항이 작성되지 않았습니다.</td></tr>");
        }else{
        $.each(json.list, function(index, item) {

            let newRow = $("<tr>" +
                "<td>" + item.noticeNo + "</td>" +
                "<td>" + item.type + "</td>" +
                "<td><a href='" + "${pageContext.request.contextPath}/community/notice/noticeOne?noticeNo=" + item.noticeNo + "'>" + item.title + "</a></td>" +
                "<td>" + item.name + "</td>" +
                "<td>" + item.createDatetime + "</td>" +
                "</tr>");
            tableBody.append(newRow);
        	});
        }
	}
	
	//전사원별
	function updateEmpNotice(json){
		lastPage = json.empLastPage;
		console.log('lastPage : ' + lastPage);
		 <!-- hiddenFieldValue 값을 개인으로 세팅 -->
     	hiddenFieldValue = "empList"
        console.log("hiddenFieldValue : " + hiddenFieldValue);
     	<!-- 버튼 활성화 함수(updateBtnState) 실행 -->
		updateBtnState();
		
		let tableBody = $("#noticeTableBody");
        tableBody.empty();
        
        if(json.allEmpList == ""){
        	alert("전사운별 공지사항이 없습니다");
        	tableBody.append("<tr><td colspan='5'>전사원별 공지사항이 작성되지 않았습니다.</td></tr>");
        }else{
        $.each(json.allEmpList, function(index, item) {
	            let newRow = $("<tr>" +
	                "<td>" + item.noticeNo + "</td>" +
	                "<td>" + item.type + "</td>" +
	                "<td><a href='" + "${pageContext.request.contextPath}/community/notice/noticeOne?noticeNo=" + item.noticeNo + "'>" + item.title + "</a></td>" +
	                "<td>" + item.name + "</td>" +
	                "<td>" + item.createDatetime + "</td>" +
	                "</tr>");
	            tableBody.append(newRow);
       	  	});
       }
	}
	//부서별
	function updateDptNotice(json){
		lastPage = json.dptLastPage;
		console.log('lastPage : ' + lastPage);
		 <!-- hiddenFieldValue 값을 개인으로 세팅 -->
     	hiddenFieldValue = "dptList"
        console.log("hiddenFieldValue : " + hiddenFieldValue);
     	<!-- 버튼 활성화 함수(updateBtnState) 실행 -->
		updateBtnState();
		
		let tableBody = $("#noticeTableBody");
        tableBody.empty();
        
        if(json.allDptList == ""){
        	alert("부서별 공지사항이 없습니다");
        	tableBody.append("<tr><td colspan='5'>부서별 공지사항이 작성되지 않았습니다.</td></tr>");
        }else{
        $.each(json.allDptList, function(index, item) {
            let newRow = $("<tr>" +
                "<td>" + item.noticeNo + "</td>" +
                "<td>" + item.type + "</td>" +
                "<td><a href='" + "${pageContext.request.contextPath}/community/notice/noticeOne?noticeNo=" + item.noticeNo + "'>" + item.title + "</a></td>" +
                "<td>" + item.name + "</td>" +
                "<td>" + item.createDatetime + "</td>" +
                "</tr>");
            tableBody.append(newRow);
        	});
        }
	}
	
	<!-- pre 버튼 클릭 시 동작 -->
    $('#pre').click(function() {
		   console.log('pre click : ' + currentPage);
		 if (currentPage > 1) {
 		  currentPage = currentPage - 1;
 		 if (hiddenFieldValue === "allList") {
	        	loadAllNoticeList(currentPage);
		      } else if (hiddenFieldValue === "empList") {
		    	 loadEmpNoticeList(currentPage);
		      } else if (hiddenFieldValue === "dptList") {
		    	 loadDptNoticeList(currentPage);
		      }
	   }
    });

    <!-- next 버튼 클릭 시 동작 -->
    $('#next').click(function() {
			console.log('next click : ' + currentPage);
			 if (currentPage < lastPage) {
	            currentPage = currentPage + 1;
  	          if (hiddenFieldValue === "allList") {
  	        	loadAllNoticeList(currentPage);
 		      } else if (hiddenFieldValue === "empList") {
 		    	 loadEmpNoticeList(currentPage);
 		      } else if (hiddenFieldValue === "dptList") {
 		    	 loadDptNoticeList(currentPage);
 		      }
	       }
    });
    <!-- first 버튼 클릭 시 동작 -->
    $('#first').click(function() {
			console.log('first click : ' + currentPage);

		  if (currentPage > 1) {
          currentPage = 1;
          if (hiddenFieldValue === "allList") {
	        	loadAllNoticeList(currentPage);
		      } else if (hiddenFieldValue === "empList") {
		    	 loadEmpNoticeList(currentPage);
		      } else if (hiddenFieldValue === "dptList") {
		    	 loadDptNoticeList(currentPage);
		      }
       }
    });
    <!-- last 버튼 클릭 시 동작 -->
    $('#last').click(function() {
  	  
			console.log('last click : ' + currentPage);

			 if (currentPage < lastPage) {
	            currentPage = lastPage
	            if (hiddenFieldValue === "allList") {
	  	        	loadAllNoticeList(currentPage);
	 		      } else if (hiddenFieldValue === "empList") {
	 		    	 loadEmpNoticeList(currentPage);
	 		      } else if (hiddenFieldValue === "dptList") {
	 		    	 loadDptNoticeList(currentPage);
	 		      }
	         }
    });
    
    // 버튼 활성화
    function updateBtnState() {
       console.log("update");
       <!-- 현재 페이지와 마지막 페이지 값에 따른 버튼 비활성화 처리-->
       <!-- prop은 설정의 속성-->
         $('#pre').prop('disabled', currentPage === 1);
         $('#next').prop('disabled', currentPage === lastPage);
         $('#first').prop('disabled', currentPage === 1);
         $('#last').prop('disabled', currentPage === lastPage);
     }
});
</script>
</body>
</html>