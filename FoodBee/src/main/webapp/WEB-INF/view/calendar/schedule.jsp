<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
 <head>
   <style>
     #calendar {
       max-width: 90%; /* 화면 너비에 맞추기 */
       min-height: 1500px;
       margin: 0 auto; 
     }
    #btn-wrapper {
   
	  display: flex;
	  justify-content: space-between;
	  margin-bottom: 20px;
	  margin-top:20px;
	}
	
	#btn-left {
	  display: flex;
	  gap: 5px; /* 버튼 간의 간격 조정 */
	  margin-left: 30px;
	}
	
	#btn-right {
	  display: flex;
	  gap: 5px; /* 버튼 간의 간격 조정 */
	  margin-right: 15px;
	}
	
	#btn-left button, #btn-right button {
	  display: inline-block;
	  cursor: pointer;
	  border: 1px solid transparent;
	  border-radius: 4px;
	  padding: 5px 10px; /* 버튼의 패딩 조정 */
	}
	
	#addEvent {
	  background-color: #007bff; /* 버튼 색상 */
	  color: white;
	}
	
	#allList {
	  background-color: #28a745; /* 버튼 색상 */
	  color: white;
	}
	
	#allEvents {
	  background-color: #4C4C4C;
	  color: white;
	}
	
	#personalEvents {
	  background-color: #FFA7A7;
	  color: white;
	}
	
	#teamEvents {
	  background-color: #BCE55C;
	  color: white;
	}
	.fc-toolbar-title {
      font-size: 35px !important; /* 글자 크기 조정 */
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
<!-- 템플릿 헤더/사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<div class="content-body">  
    <div id="btn-wrapper">
		  <div id="btn-left">
		    <button id="addEvent">일정추가</button>
		    <button id="allList">일정리스트</button>
		  </div>
		  <div id="btn-right">
		    <button id="allEvents">전체</button>
		    <button id="personalEvents">개인</button>
		    <button id="teamEvents">팀</button>
		  </div>
	</div>
	<div id='calendar'></div>

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
</div>
</div>
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const events = [
      // 개인일정
      <c:forEach var="m" items="${list}">
        {
            title: '<c:out value="${m.title}" />',
            start: '<c:out value="${m.startDatetime}" />',
            end: '<c:out value="${m.endDatetime}" />',
            color: '<c:out value="${m.type == '개인' ? '#FF6C6C' : '#BCE55C'}" />',
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
            color: '<c:out value="${team.type == '팀' ? '#BCE55C' : '#FF6C6C'}" />',
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
            color: '#BCE55C',
           
          </c:if>
          <c:if test="${room.type == 'personal'}">
          color: '#FF6C6C',
       
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
          color: '#BCE55C',
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
          color: '#BCE55C',
          type: '팀',
          tripEmp: '<c:out value="${trip.name}" />',
          destination: '<c:out value="${trip.destination}" />',
          tripContact: '<c:out value="${trip.contact}" />'
        },
      </c:forEach>
    ];

    const calendarEl = document.getElementById('calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {
    	googleCalendarApiKey: 'AIzaSyCkYEplmU408e-CUsvLPamYSORLmJZ5OVw',
    	  eventSources: [
    	    {
    	      googleCalendarId: '6c76111af4e39f3b3a7c6b38caee5ebaaf698a19f151719f7e0a2f85f9cdd0a4@group.calendar.google.com'
    	    },
    	    {
    	      googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
    	      className: 'ko_event',
    	      color: 'white',
    	      textColor: 'red'
    	    }
    	  ],
      initialView: 'dayGridMonth',
      contentHeight: 'auto',
      expandRows: true,
      nowIndicator: true, // 현재 시간 마크
      dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
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
      // 백업된 전체 데이터를 기반으로 필터링
      const filteredEvents = allEvents.filter(event => event.extendedProps.type === type || type === '전체');
      calendar.removeAllEvents();
      calendar.addEventSource(filteredEvents);
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