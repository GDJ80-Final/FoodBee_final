<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule List</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>일정 리스트</h1>
<a href="schedule">◀달력📅</a>
<br>
<span>일정검색</span>
<select id="searchType">
    <option value="personal">개인</option>
    <option value="team">팀</option>
    <option value="room">회의실</option>
</select>
<input type="text" id="searchText" placeholder="검색어를 입력해주세요">
<button id="searchBtn">검색</button>
<br>
<button id="personBtn">개인</button>
<button id="teamBtn">팀</button>
<button id="roomBtn">회의실</button>

<div>
    <table border="1" id="scheduleTable">
        <thead id="tableHeader">
            <!-- 버튼클릭시 변경되게 -->
        </thead>
        <tbody id="tableBody">
            <!-- 여기도 버튼 클릭하면 변경되게 -->
        </tbody>
    </table>
</div>
<input type="hidden" id="hiddenPage" value="person">

<div id="page">
    <button type="button" id="first">First</button>
    <button type="button" id="pre">◁</button>
    <button type="button" id="next">▶</button>
    <button type="button" id="last">Last</button>
</div>

<script>
    let currentPage = 1;
    let lastPage = 1;

    <!--1. 페이지 맨 처음 접속 시 실행-->
    $(document).ready(function() {
        // 페이지 로드 시 기본적으로 개인 일정 데이터를 로드
        <!--2. 페이지 맨 처음 접속 시 실행 loadPersonSchedule 라는 함수에 currentPage 값 주면서 실행-->
        <!-- currentPage 값은 현재 맨 위에 전역변수 1 -->
        loadPersonSchedule(currentPage);
        
        <!-- ㅎ-->
        <!--3. ㅎ-->
        let hiddenFieldValue = $('#hiddenPage').val();
        console.log(hiddenFieldValue);
        
        // 검색 버튼 클릭 시
        $("#searchBtn").click(function() {
            let query = $("#searchText").val();
            let type = $("#searchType").val();
         
            searchSchedules(type, query);
        });
        
        function searchSchedules(type, query) {
            $.ajax({
                url: `${pageContext.request.contextPath}/searchSchedules`,
                type: "GET",
                data: {
                    searchType: type,
                    searchQuery: query,
                    currentPage: currentPage
                },
                success: function(response) {
                    if (type === 'personal') {
                        updateTableForPersonal(response);
                    } else if (type === 'team') {
                        updateTableForTeam(response);
                    } else if (type === 'room') {
                        updateTableForRoom(response);
                    }
                },
                error: function() {
                    alert("검색 결과를 가져올 수 없습니다.");
                }
            });
        }
        
        // 개인 일정 버튼 클릭 시
        $("#personBtn").click(function() {
        	loadPersonSchedule(currentPage);
        });

        // 팀 일정 버튼 클릭 시
        $("#teamBtn").click(function() {
        	loadTeamSchedule(currentPage);
        });

        // 회의실 일정 버튼 클릭 시
        $("#roomBtn").click(function() {
        	loadroomSchedule(currentPage);
        });
        
        <!-- 3. 개인 일정 리스트 가져옴 -->
        function loadPersonSchedule(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/personalScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(response) {
  					console.log('personBtn curreptPage : ' + currentPage);

  			        <!-- 4. updateTableForPersonal 함수 실행, ajax통신으로 가져온 데이터 값(response) 던져줌-->
                    updateTableForPersonal(response);
                },
                error: function() {
                    alert("개인일정 데이터를 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 팀 일정 리스트 가져옴 -->
        function loadTeamSchedule(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/teamScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    dptNo: "${dptNo}"
                },
                success: function(response) {
                    console.log("AJAX Data:", response); // 응답 데이터 확인
  					console.log('teamBtn curreptPage : ' + currentPage);
  			        <!-- updateTableForTeam 함수 실행, ajax통신으로 가져온 데이터 값(response) 던져줌-->
                    updateTableForTeam(response);
                },
                error: function() {
                    alert("팀일정 데이터를 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 회의실 일정 리스트 가져옴 -->
        function loadroomSchedule(currentPage) {
      	  $.ajax({
                url: "${pageContext.request.contextPath}/calendar/roomScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    dptNo: "${dptNo}"
                },
                success: function(response) {
  					console.log(' roomBtn curreptPage : ' + currentPage);
  			        <!-- updateTableForRoom 함수 실행, ajax통신으로 가져온 데이터 값(response) 던져줌-->
                    updateTableForRoom(response);
                },
                error: function() {
                    alert("회의실 일정을 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 4. response 받은 값으로 페이지 재구성 (개인 일정 리스트 화면에 붙여주기) -->
        // 개인일정 리스트 
        function updateTableForPersonal(response) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = response.personLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "person"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();

            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $("#tableHeader").html(`
                <tr>
                    <th>일정NO</th>
                    <th>제목</th>
                    <th>시작시간</th>
                    <th>종료시간</th>
                </tr>
            `);
            
            $.each(response.personalList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.scheduleNo + "</td>" +
                        "<td><a href='" + "${pageContext.request.contextPath}/calendar/scheduleOne?scheduleNo=" + item.scheduleNo + "'>" + item.title + "</a></td>" +
                        "<td>" + item.startDatetime + "</td>" +
                        "<td>" + item.endDatetime + "</td>" +
                        "</tr>");
                
                    tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        <!-- response 받은 값으로 페이지 재구성 (팀 일정 리스트 화면에 붙여주기) -->
        // 팀일정 리스트
       function updateTableForTeam(response) {
    	   lastPage = response.teamLastPage;
     	   console.log('lastPage : ' + lastPage);

           <!-- hiddenFieldValue 값을 팀으로 세팅 -->
           hiddenFieldValue = "team"
	       console.log("hiddenFieldValue : " + hiddenFieldValue);
           <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
		   updateBtnState();
	
	       let tableBody = $("#tableBody");
	       tableBody.empty();
	       
	       $("#tableHeader").html(`
	           <tr>
	               <th>카테고리</th>
	               <th>제목</th>
	               <th>시작시간</th>
	               <th>종료시간</th>
	               <th>작성자</th>
	           </tr>
	       `);
	          
	       $.each(response.teamListAll, function(index, item) {
	           // 상세보기 링크 URL 설정
	           console.log("uniqueNo=>" + item.uniqueNo); // 디버깅용 로그
	           let detailUrl;
	           switch(item.category) {
	               case '팀':
	                   detailUrl = "${pageContext.request.contextPath}/calendar/teamScheduleOne?scheduleNo="+item.uniqueNo;
	                   break;
	               case '휴가':
	                   detailUrl = "${pageContext.request.contextPath}/calendar/dayOffScheduleOne?scheduleNo="+item.uniqueNo;
	                   break;
	               case '출장':
	                   detailUrl = "${pageContext.request.contextPath}/businessTripScheduleOne?scheduleNo="+item.uniqueNo;
	                   break;
	           }
	           console.log("url==>"+ detailUrl);
	           
	           let newRow = $("<tr>" +
	                   "<td>" + item.category + "</td>" +
	                   "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
	                   "<td>" + item.startDate + "</td>" +
	                   "<td>" + item.endDate + "</td>" +
	                   "<td>" + item.empName + "</td>" +
	                   "</tr>");
	           
	           tableBody.append(newRow);
       });
       
             $("#tableBody").show();
       }
       <!-- response 받은 값으로 페이지 재구성 (회의실 일정 리스트 화면에 붙여주기) -->
        // 회의실 일정 리스트
        function updateTableForRoom(response) {
        	lastPage = response.roomLastPage;
      	    console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 회의실로 세팅 -->
        	hiddenFieldValue = "room"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();

            let tableBody = $("#tableBody");
            tableBody.empty();
             
            $("#tableHeader").html(`
                <tr>
                  <th>예약NO</th>
                    <th>회의실NO</th>
                    <th>시작시간</th>
                    <th>종료시간</th>
                    <th>예약자이름</th>
                </tr>
            `);

            $.each(response.roomListAll, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.rsvNo + "</td>" +
                        "<td> BEE " + item.roomNo + "</td>" +
                        "<td>" + item.startDatetime + "</td>" +
                        "<td>" + item.endDatetime + "</td>" +
                        "<td>" + item.empName + "</td>" +
                        "</tr>");
                  
                tableBody.append(newRow);
            });
         
            $("#tableBody").show();
        }

        
      <!-- pre 버튼 클릭 시 동작 -->
      $('#pre').click(function() {
		   console.log('pre click : ' + currentPage);
	       if (currentPage > 1) {
		     		 //화면에서 로직대로 진행 된 후(처음엔 1)  
		           //변동 된 '현재 페이지 값'을 가져와서 값 가공 후 
		          // 히든값에 설정 된 개인,팀,회의실에 따라 리스트 가져올 함수 실행
	          currentPage = currentPage - 1;
	          
	          if (hiddenFieldValue === "person") {
				  console.log("person");
		          loadPersonSchedule(currentPage);
		      } else if (hiddenFieldValue === "team") {
				  console.log("team");
		          loadTeamSchedule(currentPage);
		      } else if (hiddenFieldValue === "room") {
				  console.log("room");
		          loadroomSchedule(currentPage);
		      }
	       }
      });

      <!-- next 버튼 클릭 시 동작 -->
      $('#next').click(function() {
			console.log('next click : ' + currentPage);

         if (currentPage < lastPage) {
            currentPage = currentPage + 1;
	          if (hiddenFieldValue === "person") {
				  console.log("person");
		          loadPersonSchedule(currentPage);
		      } else if (hiddenFieldValue === "team") {
				  console.log("team");
		          loadTeamSchedule(currentPage);
		      } else if (hiddenFieldValue === "room") {
				  console.log("room");
		          loadroomSchedule(currentPage);
		      }
         }
      });
      <!-- first 버튼 클릭 시 동작 -->
      $('#first').click(function() {
			console.log('first click : ' + currentPage);

         if (currentPage > 1) {
            currentPage = 1;
	          if (hiddenFieldValue === "person") {
				  console.log("person");
		          loadPersonSchedule(currentPage);
		      } else if (hiddenFieldValue === "team") {
				  console.log("team");
		          loadTeamSchedule(currentPage);
		      } else if (hiddenFieldValue === "room") {
				  console.log("room");
		          loadroomSchedule(currentPage);
		      }
         }
      });
      <!-- last 버튼 클릭 시 동작 -->
      $('#last').click(function() {
    	  
			console.log('last click : ' + currentPage);

         if (currentPage < lastPage) {
            currentPage = lastPage
	          if (hiddenFieldValue === "person") {
				  console.log("person");
		          loadPersonSchedule(currentPage);
		      } else if (hiddenFieldValue === "team") {
				  console.log("team");
		          loadTeamSchedule(currentPage);
		      } else if (hiddenFieldValue === "room") {
				  console.log("room");
		          loadroomSchedule(currentPage);
		      }
         }
      });
      // 버튼 활성화
      function updateBtnState() {
         console.log("update");
         <!-- 현재 페이지와 마지막 페이지 값에 따른 버튼 비활성화 처리-->
           $('#pre').prop('disabled', currentPage === 1);
           $('#next').prop('disabled', currentPage === lastPage);
           $('#first').prop('disabled', currentPage === 1);
           $('#last').prop('disabled', currentPage === lastPage);
       }
      
    });
</script>
</body>
</html>