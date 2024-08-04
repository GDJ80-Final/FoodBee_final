<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule List</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<style>
	 #calendar{
		width:20%;
	 }
    #page{
    	align-items: center;
    	margin-top: 10px;
    }
     #searchBody {
     	display:flex;
    }
    #searchBtn{
    	margin-left: 3px;
    }
	#searchText{
		width: 50%
	}
	th {
	    font-weight: bold;
	}
</style>
</head>
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
                 <li class="breadcrumb-item"><a href="javascript:void(0)">일정</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">일정조회</a></li>
             </ol>
         </div>
   	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 			<!-- 여기서부터 내용시작 -->
						<div class="group1 mb-3">
							<a href="schedule"  class="btn btn-primary btn-block" id="calendar">달력📅</a>
						</div>
				
						<ul class="nav nav-tabs mb-3">
                            <li class="nav-item"><a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false" id="personBtn">내 일정</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false" id="teamBtn">팀 일정</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="roomBtn">회의 일정</a>
                            </li>
                        </ul>
					
						<div id="searchBody">
							<input type="text" id="searchText" class="form-control mb-3" placeholder="내 일정 검색어를 입력해주세요" aria-label="Search Dashboard">
							<button id="searchBtn" class="btn btn-danger btn-sm mb-3">검색</button>
						</div>
						
						<div class="table-body" class="table-responsive">
							<table id="noticeTable" class="table header-border">
								<thead id="tableHeader">
									<!-- 버튼클릭시 변경되게 -->
								</thead>
								<tbody id="tableBody">
									<!-- 여기도 버튼 클릭하면 변경되게 -->
								</tbody>
							</table>
						</div>
						<input type="hidden" id="hiddenPage" value="person">
						<!--히든 구역을 이용해서 페이징 상태를 저장해둔다 -->
						 <!-- panel & page -->
						<div class="bootstrap-pagination mt-3" id="page">
					         <nav>
					             <ul class="pagination justify-content-center">
					                 <li class="page-item"><button type="button" id="first" class="page-link">FIRST</button>
					                 </li>
					                 <li class="page-item"><button type="button" class="page-link" id="pre">이전</button>
					                 </li>
					                 <li class="page-item active"><div class="page-link" id="currentPage"></div>
					                 </li>
					                 <li class="page-item"><button type="button" class="page-link" id="next">다음</button>
					                 </li>
					                 <li class="page-item"><button type="button" class="page-link" id="last">LAST</button>
					                 </li>
					             </ul>
					         </nav>
					     </div>
						<br>
						</div>
					<!-- 여기가 내용끝! --> 		
	                </div>
	            </div>
	        </div>
		</div>
	</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<script>
    let currentPage = 1;
    let lastPage = 1;

    <!--1. 페이지 맨 처음 접속 시 실행-->
    $(document).ready(function() {
        // 페이지 로드 시 기본적으로 개인 일정 데이터를 로드
        <!--2. 페이지 맨 처음 접속 시 실행 loadPersonSchedule 라는 함수에 currentPage 값 주면서 실행-->
        <!-- currentPage 값은 현재 맨 위에 전역변수 1 -->
        loadPersonSchedule(currentPage);
        
        <!--히든필드를 가져와서 -->
        let hiddenFieldValue = $('#hiddenPage').val();
        console.log(hiddenFieldValue);
        
        // 검색 버튼 클릭 시
        $("#searchBtn").click(function() {
            let search = $("#searchText").val();
            
            if (hiddenFieldValue === "person") {
				  console.log("person");
				  loadPersonSchedule(1, search); //검색하면 1페이지 유지 ->그 다음 넘김
		      } else if (hiddenFieldValue === "team") {
				  console.log("team");
		          loadTeamSchedule(1, search);
		      } else if (hiddenFieldValue === "room") {
				  console.log("room");
		          loadroomSchedule(1, search);
		      }
            console.log("검색기능-=>" + search);
        });
       
     	// 개인 일정 버튼 클릭 시
        $("#personBtn").click(function() {
            loadPersonSchedule(1);
            $("#searchText").attr("placeholder", "내 일정 검색어를 입력해주세요");
        });

        // 팀 일정 버튼 클릭 시
        $("#teamBtn").click(function() {
            loadTeamSchedule(1);
            $("#searchText").attr("placeholder", "팀 일정 검색어를 입력해주세요");
        });

        // 회의실 일정 버튼 클릭 시
        $("#roomBtn").click(function() {
            loadroomSchedule(1);

            $("#searchText").attr("placeholder", "회의실 일정 검색어를 입력해주세요");
        });
        
        <!-- 3. 개인 일정 리스트 가져옴 -->
        function loadPersonSchedule(currentPage, search) { //currentPag옆에 검색값이 하나 더 들어와준다
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/personalScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}",
                    search: search
                },
                success: function(json) {
  					console.log('personBtn curreptPage : ' + currentPage);
  					$('#currentPage').text(currentPage);
  			        <!-- 4. updateTableForPersonal 함수 실행, ajax통신으로 가져온 데이터 값(json) 던져줌-->
                    updateTableForPersonal(json);
              
                },
                error: function() {
                    alert("개인일정 데이터를 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 팀 일정 리스트 가져옴 -->
        function loadTeamSchedule(currentPage, search) {
            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/teamScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    dptNo: "${dptNo}",
                    search: search
                },
                success: function(json) {
                    console.log("AJAX Data:", json); // 응답 데이터 확인
  					console.log('teamBtn curreptPage : ' + currentPage);
  					$('#currentPage').text(currentPage);
  			        <!-- updateTableForTeam 함수 실행, ajax통신으로 가져온 데이터 값(json) 던져줌-->
                    updateTableForTeam(json);
                },
                error: function() {
                    alert("팀일정 데이터를 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 회의실 일정 리스트 가져옴 -->
        function loadroomSchedule(currentPage, search) {
      	  $.ajax({
                url: "${pageContext.request.contextPath}/calendar/roomScheduleList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}",
                    dptNo: "${dptNo}",
                    search: search
                },
                success: function(json) {
  					console.log(' roomBtn curreptPage : ' + currentPage);
  					$('#currentPage').text(currentPage);
  			        <!-- updateTableForRoom 함수 실행, ajax통신으로 가져온 데이터 값(json) 던져줌-->
                    updateTableForRoom(json);
                },
                error: function() {
                    alert("회의실 일정을 가져올 수 없습니다.");
                }
            });
        }
        
        <!-- 4. json 받은 값으로 페이지 재구성 (개인 일정 리스트 화면에 붙여주기) -->
        // 개인일정 리스트 
        function updateTableForPersonal(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.personLastPage;
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
            
            if(json.personalList == ""){
            	tableBody.append("<tr><td colspan='4'>개인일정이 없습니다.</td></tr>");
            }else{
            $.each(json.personalList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.scheduleOrder + "</td>" +
                        "<td><a href='" + "${pageContext.request.contextPath}/calendar/scheduleOne?scheduleNo=" + item.scheduleNo + "'>" + item.title + "</a></td>" +
                        "<td>" + item.startDatetime + "</td>" +
                        "<td>" + item.endDatetime + "</td>" +
                        "</tr>");
                
                    tableBody.append(newRow);
            	});
            }
            $("#tableBody").show();
        }
        <!-- json 받은 값으로 페이지 재구성 (팀 일정 리스트 화면에 붙여주기) -->
        // 팀일정 리스트
       function updateTableForTeam(json) {
    	   lastPage = json.teamLastPage;
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
	        
	       if(json.teamListAll == ""){
           	tableBody.append("<tr><td colspan='5'>팀일정이 없습니다.</td></tr>");
           }else{
	       $.each(json.teamListAll, function(index, item) {
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
	           
	           let detailTitle = item.title;
	           switch(item.title) {
	               case '휴가내역':
	                   detailTitle = item.empName + "님 휴가일정";
	                   break;
	               case '출장내역':
	                   detailTitle = item.empName + "님 출장일정";
	                   break;
	               default:
	                   detailTitle = item.title; // 예외 처리로 기본값 설정
	           }
	           console.log("url==>"+ detailUrl);
	           
	           let newRow = $("<tr>" +
	                   "<td>" + item.category + "</td>" +
	                   "<td><a href='" + detailUrl + "'>" + detailTitle + "</a></td>" +
	                   "<td>" + item.startDate + "</td>" +
	                   "<td>" + item.endDate + "</td>" +
	                   "<td>" + item.empName + "</td>" +
	                   "</tr>");
	           
	           tableBody.append(newRow);
       			});
           }
             $("#tableBody").show();
       }
       <!-- json 받은 값으로 페이지 재구성 (회의실 일정 리스트 화면에 붙여주기) -->
        // 회의실 일정 리스트
        function updateTableForRoom(json) {
        	lastPage = json.roomLastPage;
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
                    <th>유형</th>
                    <th>제목</th>
                    <th>회의실</th>
                    <th>시작시간</th>
                    <th>종료시간</th>
                    <th>예약자이름</th>
                </tr>
            `);
            if(json.roomListAll == ""){
               	tableBody.append("<tr><td colspan='6'>회의일정이 없습니다.</td></tr>");
            }else{
            $.each(json.roomListAll, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.category + "</td>" +
                        "<td><a href='" + "${pageContext.request.contextPath}/calendar/roomRsvOne?rsvNo=" + item.rsvNo + "'>" + item.meetingTitle + "</a></td>" +
                        "<td>" + item.roomName + "("+item.roomPlace+")" + "</td>" +
                        "<td>" + item.startDatetime + "</td>" +
                        "<td>" + item.endDatetime + "</td>" +
                        "<td>" + item.empName + "</td>" +
                        "</tr>");
                  
                tableBody.append(newRow);
           		});
            }
            
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
         <!-- prop은 설정의 속성-->
      // 현재 페이지가 1이면 '이전' 및 '처음' 버튼 비활성화
         $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
         $('#first').closest('li').toggleClass('disabled', currentPage === 1);

         // lastPage가 0이면 '다음' 및 '마지막' 버튼 비활성화
         if (lastPage === 0) {
             $('#next').closest('li').addClass('disabled');
             $('#last').closest('li').addClass('disabled');
         } else {
             // 현재 페이지가 마지막 페이지와 같으면 '다음' 및 '마지막' 버튼 비활성화
             $('#next').closest('li').toggleClass('disabled', currentPage === lastPage);
             $('#last').closest('li').toggleClass('disabled', currentPage === lastPage);
         }
       }
    });
</script>
</body>
</html>