<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
 <head>
   <script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   <style>
     #calendar {
       max-width: 700px; 
       height: 600px; 
       margin: 0 auto; 
       font-size: 10px;
     }
     #btn {
       text-align: center; 
       margin-top: 20px;
     }
     #btn button {
       display: inline-block;
       margin: 0 2px;
       cursor: pointer; 
       border: 1px solid transparent; 
       border-radius: 4px; 
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
   </style>
 </head>
  <body>
    <div id="btn">
      <button id="allEvents">전체</button>
      <button id="personalEvents">개인</button>
      <button id="teamEvents">팀</button>
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
            <p>회의실: <span id="meetingRoom"></span></p>
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

    <!-- CalendarAPI script! -->    
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
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
              description: '<c:out value="${m.content}" />'
            },
          </c:forEach>
          // 회의실 예약리스트
          <c:forEach var="room" items="${roomRsvList}">
            {
              title: '<c:out value="회의" />',
              start: '<c:out value="${room.startDatetime}" />',
              end: '<c:out value="${room.endDatetime}" />',
              <c:if test="${room.type == '1'}">
                color: '#BCE55C',
              </c:if>
              type: '팀',
              rsvEmp: '<c:out value="${room.empName}"/>',
              roomNo: '<c:out value="Bee${room.roomNo}"/>'
            },
          </c:forEach>
          // 팀원 휴가리스트
          <c:forEach var="off" items="${dayOffList}">
            {
              title: '<c:out value="${off.name}님휴가" />',
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
              title: '<c:out value="${trip.name}님출장" />',
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
          initialView: 'dayGridMonth',
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
            } else if (info.event.title.includes('님휴가')) {
              $('#dayOff').modal('show');
              document.getElementById('dayOffEmp').innerHTML = info.event.extendedProps.dayOffEmp;
              document.getElementById('startDate').innerHTML = info.event.start.toLocaleString();
              document.getElementById('endDate').innerHTML = info.event.end.toLocaleString();
              document.getElementById('contact').innerHTML = info.event.extendedProps.contact;
            } else if (info.event.title.includes('님출장')) {
           	   $('#trip').modal('show');
               document.getElementById('tripEmp').innerHTML = info.event.extendedProps.tripEmp;
               document.getElementById('destination').innerHTML = info.event.extendedProps.destination;
               document.getElementById('tripStartDate').innerHTML = info.event.start.toLocaleString();
               document.getElementById('tripEndDate').innerHTML = info.event.end.toLocaleString();
               document.getElementById('tripContact').innerHTML = info.event.extendedProps.tripContact;
            } else {
              $('#person').modal('show');
              document.getElementById('personTitle').innerHTML = info.event.title;
              document.getElementById('personMemo').innerHTML = info.event.extendedProps.description;
            }
          }
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