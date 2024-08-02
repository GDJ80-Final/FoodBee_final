<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
 <head>
   <style>
    #calendar {
      width: 100%; /* 화면 너비에 맞추기 */
      min-height: 1200px;
      margin: 0 auto;
    }
    .list-group {
      width: 100%;
      display: flex;
      flex-direction: column;
      margin-top: 100px;
    }  
    
	#circle1{
		color:pink;
	}
	
	#circle2{
		color:#86E57F;
	}
	
	.fc-toolbar-title {
      font-size: 35px !important; 
    }
    .fc-event {
      color: ivory !important;
      cursor: pointer !important;
  	}
  	.fc-day-header.fc-sun {
    color: #FF0000; 
	}
	
	.fc-day-header.fc-sat {
	    color: #0000FF; 
	}
   </style>
 </head>
 <!-- CalnedarApI호출 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <!-- CalendarAPI script! -->    
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
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
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">캘린더</a></li>
             </ol>
         </div>
   	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
			 	<div class="card">
			 		<div class="card-body">	
			 		<!-- 여기서부터 내용시작 -->
			 		
				     <div class="row">
		                <div class="col-md-2">
		                  <div class="list-group" id="list-tab" role="tablist">
		                    <a class="list-group-item list-group-item-action active" id="addEvent" data-toggle="list" href="#" role="tab" aria-controls="settings">➕일정추가</a>
		                    <a class="list-group-item list-group-item-action" id="allList" data-toggle="list" href="#" role="tab" aria-controls="settings">일정리스트</a>
		                  </div>
		                </div>
		                <div class="col-md-9">
			                <ul class="nav nav-tabs mb-3">
	                            <li class="nav-item">
		                            <a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false" id="allEvents">
		                            	전체
		                            </a>
	                            </li>
	                            <li class="nav-item">
	                            	<a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false" id="personalEvents">
	                            		<span id="circle1">
	                            			▶
	                            		</span>
	                            		개인일정
	                            	</a>
	                            </li>
	                            <li class="nav-item">
	                            	<a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="teamEvents">
	                            		<span id="circle2">
	                            			▶
	                            		</span>
	                            		팀일정
	                            	</a>
	                            </li>
	                        </ul>
		                    <div id='calendar'>
		                    	<!-- 캘린더 테이블자리 -->
		                    </div>
		                </div>
		              </div>

					    <!-- 개인 일정 모달 -->
					    <div class="modal fade" id="person" tabindex="-1" aria-labelledby="personalModalLabel" aria-hidden="true">
					      <div class="modal-dialog">
					        <div class="modal-content">
					          <div class="modal-header">
					            <h5 class="modal-title" id="personalModalLabel">내 일정</h5>
					          </div>
					          <div class="modal-body">
					            제목: <p id="personTitle"></p>
					            메모: <p id="personMemo"></p>
								<a id="modifyLink" href="#">수정</a>
								<a id="deleteBtn" href="#">삭제</a>
					          </div>
					        </div>
					      </div>
					    </div>
					    
					    <!-- 팀 일정 모달 -->
					  	<div class="modal fade" id="team" tabindex="-1" aria-labelledby="teamModalLabel" aria-hidden="true">
					      <div class="modal-dialog">
					        <div class="modal-content">
					          <div class="modal-header">
					            <h5 class="modal-title" id="teamModalLabel">팀 일정</h5>
					          </div>
					          <div class="modal-body">
					            제목: <p id="teamTitle"></p>
					            메모: <p id="teamMemo"></p>
					          </div>
					        </div>
					      </div>
					    </div>
					
					    <!-- 회의 일정 모달 -->
					    <div class="modal fade" id="meeting" tabindex="-1" aria-labelledby="meetingModalLabel" aria-hidden="true">
					      <div class="modal-dialog">
					        <div class="modal-content">
					          <div class="modal-header">
					            <h5 class="modal-title" id="meetingModalLabel">회의</h5>
					          </div>
					          <div class="modal-body">
					            <p>예약자: <span id="meetingEmp"></span></p>
					            <p>회의실: <span id="meetingRoom"></span>  
					           <!--  <button id="meetingLocation">위치</button></p>
					             <p>회의실 장소: <span id="meetingPlace" style="display:none;"></span></p> -->
					            <p>시작시간: <span id="meetingStartTime"></span></p>
					            <p>종료시간: <span id="meetingEndTime"></span></p>
					          </div>
					        </div>
					      </div>
					    </div>
					    
					    <!-- 팀원 휴가내역 모달-->
					    <div class="modal fade" id="dayOff" tabindex="-1" aria-labelledby="DayOffModalLabel" aria-hidden="true">
					      <div class="modal-dialog">
					        <div class="modal-content">
					          <div class="modal-header">
					            <h5 class="modal-title" id="meetingModalLabel">휴가</h5>
					          </div>
					          <div class="modal-body">
					            <p>휴가자: <span id="dayOffEmp"></span></p>
					            <p>휴가시작: <span id="startDate"></span></p>
					            <p>휴가종료: <span id="endDate"></span></p>
					            <p>비상연락처: <span id="contact"></span></p>
					          </div>
					        </div>
					      </div>
					    </div>
					    
					    <!-- 팀원 출장내역 모달 -->
					    <div class="modal fade" id="trip" tabindex="-1" aria-labelledby="tripModalLabel" aria-hidden="true">
					      <div class="modal-dialog">
					        <div class="modal-content">
					          <div class="modal-header">
					            <h5 class="modal-title" id="meetingModalLabel">휴가</h5>
					          </div>
					          <div class="modal-body">
					            <p>출장: <span id="tripEmp"></span></p>
					            <p>출장지: <span id="destination"></span></p>
					            <p>출장시작: <span id="tripStartDate"></span></p>
					            <p>출장종료: <span id="tripEndDate"></span></p>
					            <p>비상연락처: <span id="tripContact"></span></p>
					          </div>
					        </div>
					      </div>
					    </div>
					<!-- 여기가 내용끝! --> 		
                    </div>
                </div>
            </div>
        </div>
	</div>
</div><!-- content-body마지막 -->
</div>
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<!-- 구글캘린더 script -->
 <link href='https://unpkg.com/@fullcalendar/core@4.4.2/main.min.css' rel='stylesheet' />
 <link href='https://unpkg.com/@fullcalendar/daygrid@4.4.2/main.min.css' rel='stylesheet' />
 <script src='https://unpkg.com/@fullcalendar/core@4.4.2/main.min.js'></script>
 <script src='https://unpkg.com/@fullcalendar/daygrid@4.4.2/main.min.js'></script>
 <script src='https://unpkg.com/@fullcalendar/google-calendar@4.4.2/main.min.js'></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const events = [
      // 개인일정
      <c:forEach var="m" items="${list}">
        {
            title: '<c:out value="${m.title}" />',
            start: '<c:out value="${m.startDatetime}" />',
            end: '<c:out value="${m.endDatetime}" />',
            color: '<c:out value="${m.type == '개인' ? '#FF8383' : '#99E000'}" />',
            type: '개인',
            description: '<c:out value="${m.content}" />',
            scheduleNo: '<c:out value="${m.scheduleNo}" />'
        },
      </c:forEach>
      // 팀일정
       <c:forEach var="team" items="${teamList}">
        {
            title: '<c:out value="(팀)${team.title}" />',
            start: '<c:out value="${team.startDatetime}" />',
            end: '<c:out value="${team.endDatetime}" />',
            color: '<c:out value="${team.type == '팀' ? '#99E000' : '#FF8383'}" />',
            type: '팀',
            description: '<c:out value="${team.content}" />',
            scheduleNo: '<c:out value="${team.scheduleNo}" />',
            empNo:'<c:out value="${team.empNo}" />'

        },
      </c:forEach>
      // 회의실 예약리스트
      <c:forEach var="room" items="${roomRsvList}">
        {
          title: '<c:out value="회의" />',
          start: '<c:out value="${room.startDatetime}" />',
          end: '<c:out value="${room.endDatetime}" />',
          <c:if test="${room.type == 'team'}">
            color: '#99E000',
          </c:if>
          <c:if test="${room.type == 'personal'}">
          color: '#FF8383',
       
         </c:if>
          //
          <c:if test="${room.type == 'team'}">
           	type : '팀',
          </c:if>
          <c:if test="${room.type == 'personal'}">
          	type : '개인',
         </c:if>
          rsvEmp: '<c:out value="${room.empName}"/>',
          roomNo: '<c:out value="Bee${room.roomNo}"/>',
          roomPlace:'<c:out value="${room.roomPlace}"/>'
        },
      </c:forEach>
      // 팀원 휴가리스트
      <c:forEach var="off" items="${dayOffList}">
        {
          title: '<c:out value="${off.name}님 휴가" />',
          start: '<c:out value="${off.startDate}" />',
          end: '<c:out value="${off.endDate}" />',
          color: '#99E000',
          type: '팀',
          dayOffEmp: '<c:out value="${off.name}" />',
          contact: '<c:out value="${off.contact}" />'
        },
      </c:forEach>
      // 팀원 출장리스트
        <c:forEach var="trip" items="${businessTripList}">
        {
          title: '<c:out value="${trip.name}님 출장" />',
          start: '<c:out value="${trip.startDate}" />',
          end: '<c:out value="${trip.endDate}" />',
          color: '#99E000',
          type: '팀',
          tripEmp: '<c:out value="${trip.name}" />',
          destination: '<c:out value="${trip.destination}" />',
          tripContact: '<c:out value="${trip.contact}" />'
        },
      </c:forEach>
    ];

    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	 plugins: [ 'dayGrid', 'googleCalendar' ],
    	 googleCalendarApiKey: 'AIzaSyCkYEplmU408e-CUsvLPamYSORLmJZ5OVw',
    	 eventSources: [
             {
               googleCalendarId: 'f7cf9dc87835d6b44c764f1cf414e5ac92fd754500c39c4f7cae518b0799ef7f@group.calendar.google.com'
             },
             {
                 googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com', 
                 className: 'holiday-event' 
              }
           ],
	      initialView: 'dayGridMonth',
	      contentHeight: 'auto',
	      expandRows: true,
	      locale: 'ko', // 한국어 설정
	      eventDidMount: function(info) {
	    	    // 일정이 렌더링된 후 바의 두께를 조정
	    	    info.el.style.height = '22px'; // 바의 높이 조정 (두께 조정)
	    	    info.el.style.borderRadius = '0';
	    	  },
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridDay,listWeek'
	      },
	      expandRows: true,
	      events: events,
	      eventMouseEnter: function(info) {
	        info.el.classList.add('event-highlight'); // 이벤트에 highlight 클래스 추가
	      },
	      eventMouseLeave: function(info) {
	        info.el.classList.remove('event-highlight'); // highlight 클래스 제거
	      },
	      eventClick: function(info) {
	        if (info.event.title === '회의') {
	          $('#meeting').modal('show');
	          document.getElementById('meetingEmp').innerHTML = info.event.extendedProps.rsvEmp;
	          document.getElementById('meetingRoom').innerHTML = info.event.extendedProps.roomNo;
	          document.getElementById('meetingStartTime').innerHTML = info.event.start.toLocaleString();
	          document.getElementById('meetingEndTime').innerHTML = info.event.end.toLocaleString();
	        } else if (info.event.title.includes('님 휴가')) {
	          $('#dayOff').modal('show');
	          document.getElementById('dayOffEmp').innerHTML = info.event.extendedProps.dayOffEmp;
	          document.getElementById('startDate').innerHTML = info.event.start.toLocaleString();
	          document.getElementById('endDate').innerHTML = info.event.end.toLocaleString();
	          document.getElementById('contact').innerHTML = info.event.extendedProps.contact;
	        } else if (info.event.title.includes('님 출장')) {
	       	   $('#trip').modal('show');
	           document.getElementById('tripEmp').innerHTML = info.event.extendedProps.tripEmp;
	           document.getElementById('destination').innerHTML = info.event.extendedProps.destination;
	           document.getElementById('tripStartDate').innerHTML = info.event.start.toLocaleString();
	           document.getElementById('tripEndDate').innerHTML = info.event.end.toLocaleString();
	           document.getElementById('tripContact').innerHTML = info.event.extendedProps.tripContact;
	        } else if(info.event.title.includes('팀')){
	       	  $('#team').modal('show');
	   		  document.getElementById('teamTitle').innerHTML = info.event.title;
	          document.getElementById('teamMemo').innerHTML = info.event.extendedProps.description;
	          document.getElementById('teamModifyLink').href = 'modifySchedule?scheduleNo=' + info.event.extendedProps.scheduleNo;
	          document.getElementById('teamDeleteBtn').href = 'deleteSchedule?scheduleNo=' + info.event.extendedProps.scheduleNo;
	      
	        } else {
	          $('#person').modal('show');
	          document.getElementById('personTitle').innerHTML = info.event.title;
	          document.getElementById('personMemo').innerHTML = info.event.extendedProps.description;
	          document.getElementById('modifyLink').href = 'modifySchedule?scheduleNo=' + info.event.extendedProps.scheduleNo;
	          document.getElementById('deleteBtn').href = 'deleteSchedule?scheduleNo=' + info.event.extendedProps.scheduleNo;
	        }
	      }
	     
	    });
	    
	     document.getElementById('addEvent').addEventListener('click', function() {
	 	    window.location.href = 'addSchedule';
		  	});
	     
	     document.getElementById('allList').addEventListener('click', function() {
	 	    window.location.href = 'scheduleList';
		  	});
	    
	    // 전체 데이터를 백업해 둘 변수
	    let allEvents = calendar.getEvents();
	
	    // 일정 필터링 함수
	   function filterEventsByType(type) {
		    // 기존 이벤트 소스 제거
		    calendar.getEventSources().forEach(source => {
		        // 공휴일 이벤트 소스는 유지
		        if (source.url && source.url.includes('holiday')) {
		            calendar.addEventSource(source);
		        } else {
		            source.remove();
		        }
		    });
		    // 공휴일 소스 추가
		    calendar.addEventSource({
		        googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
		        className: 'holiday-event'
		    });
		
		    // 선택한 타입의 이벤트 필터링
		    if (type === '전체') {
		        calendar.addEventSource(events);
		    } else {
		        const filteredEvents = events.filter(event => event.type === type);
		        calendar.addEventSource(filteredEvents);
		    }
		
		    calendar.render();
		}
	    
	    // 필터링 버튼 클릭 시
	    document.getElementById('allEvents').addEventListener('click', function() {
	      filterEventsByType('전체');
	    });
	
	    document.getElementById('personalEvents').addEventListener('click', function() {
	      filterEventsByType('개인');
	    });
	
	    document.getElementById('teamEvents').addEventListener('click', function() {
	      filterEventsByType('팀');
	    });
	
	    calendar.render();
  });
</script>
</body>
</html>