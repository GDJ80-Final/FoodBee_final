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
            <!-- 헤더는 버튼 클릭 시 동적으로 변경됨 -->
        </thead>
        <tbody id="tableBody">
            <!-- 데이터는 버튼 클릭 시 동적으로 변경됨 -->
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

    $(document).ready(function() {
        // 페이지 로드 시 기본적으로 개인 일정 데이터를 로드
        loadPersonalSchedule();
        
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
            loadPersonalSchedule();
        });

        function loadPersonalSchedule() {
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/personalScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(response) {
					console.log('personBtn curreptPage : ' + currentPage);

                    updateTableForPersonal(response);
                },
                error: function() {
                    alert("개인일정 데이터를 가져올 수 없습니다.");
                }
            });
        }

        // 팀 일정 버튼 클릭 시
        $("#teamBtn").click(function() {
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

                    updateTableForTeam(response);
                },
                error: function() {
                    alert("팀일정 데이터를 가져올 수 없습니다.");
                }
            });
        });

        // 회의실 일정 버튼 클릭 시
        $("#roomBtn").click(function() {
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/roomScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    dptNo: "${dptNo}"
                },
                success: function(response) {
					console.log(' roomBtn curreptPage : ' + currentPage);

                    updateTableForRoom(response);
                },
                error: function() {
                    alert("회의실 일정을 가져올 수 없습니다.");
                }
            });
        });

        // 개인일정 리스트 
        function updateTableForPersonal(response) {
        	lastPage = response.personLastPage;
        	hiddenFieldValue = "person"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
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

        // 팀일정 리스트
       function updateTableForTeam(response) {
    	   lastPage = response.teamLastPage;
        	hiddenFieldValue = "team"
       console.log("hiddenFieldValue : " + hiddenFieldValue);
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
                   detailUrl = "${pageContext.request.contextPath}/calendar/businessTripScheduleOne?scheduleNo="+item.uniqueNo;
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

        // 회의실 일정 리스트
        function updateTableForRoom(response) {

        	lastPage = response.roomLastPage;
        	hiddenFieldValue = "room"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
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

      $('#pre').click(function() {
		   console.log('pre click : ' + currentPage);
	       if (currentPage > 1) {
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
           $('#pre').prop('disabled', currentPage === 1);
           $('#next').prop('disabled', currentPage === lastPage);
           $('#first').prop('disabled', currentPage === 1);
           $('#last').prop('disabled', currentPage === lastPage);
       }
      
      
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

                  updateTableForPersonal(response);
              },
              error: function() {
                  alert("개인일정 데이터를 가져올 수 없습니다.");
              }
          });
      }
      
      function loadTeamSchedule() {
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

                  updateTableForTeam(response);
              },
              error: function() {
                  alert("팀일정 데이터를 가져올 수 없습니다.");
              }
          });
      }
      
      function loadroomSchedule() {
    	  $.ajax({
              url: "${pageContext.request.contextPath}/calendar/roomScheduleList",
              type: "GET",
              data: {
                  currentPage: currentPage,
                  dptNo: "${dptNo}"
              },
              success: function(response) {
					console.log(' roomBtn curreptPage : ' + currentPage);

                  updateTableForRoom(response);
              },
              error: function() {
                  alert("회의실 일정을 가져올 수 없습니다.");
              }
          });
      }
      
      
      
    });
</script>
</body>
</html>