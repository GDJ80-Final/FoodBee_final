<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
<h1>공지사항</h1>
<button id="listBtn">전체</button>
<button id="empBtn">전사원</button>
<button id="dptBtn">부서별</button>
<table border="1">
    <thead>
        <tr>
            <th>번호</th>
            <th>유형</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일자</th>
        </tr>
    </thead>
    <tbody id="noticeTableBody">
    </tbody>
</table>
	<input type="hidden" id="hiddenPage" value="all">
	<div id="page">
	    <button type="button" id="first">First</button>
	    <button type="button" id="pre">◁</button>
	    <button type="button" id="next">▶</button>
	    <button type="button" id="last">Last</button>
	</div>
	 <c:if test="${rankName == '팀장' || rankName == 'CEO' || rankName == '부서장' || rankName == '지사장'}">
	   	<a href="addNotice">공지사항 작성</a>
	</c:if>
<!-- 템플릿 footer -->
</div>
</div>
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