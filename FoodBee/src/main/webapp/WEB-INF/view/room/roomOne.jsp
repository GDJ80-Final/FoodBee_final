<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 정보 및 예약</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	/* 타임라인 컨테이너 스타일 */
	#timeline {
	    position: relative;
	    height: 25px; /* 높이 조정 */
	    width: 80%;
	    border: 1px solid #000;
	    background-color: #f1f1f1;
	}
	
	/* 예약 블록 스타일 */
	.time-block {
	    position: absolute;
	    height: 100%;
	    background-color: rgba(255, 0, 0, 0.7);
	    border-left: 1px solid #000; /* 세로 방향 왼쪽 테두리 */
    	border-right: 1px solid #000; /* 세로 방향 오른쪽 테두리 */
	    color: white;
	    text-align: center;
	    line-height: 25px; /* 텍스트 수직 중앙 정렬 (높이에 맞게 조정) */
	    font-size: 10px; /* 폰트 크기 조정 */
	    white-space: nowrap; /* 텍스트가 줄바꿈 없이 표시되도록 함 */
	}
</style>
</head>
<body>
<div id="reserved-times"></div>
<h1>회의실 예약</h1>
<form id="reservationForm" method="post" action="${pageContext.request.contextPath}/room/roomRsv">		
	<input type="hidden" value="${roomNo}" id="roomNo" name="roomNo">
	<input type="date" value="${rsvDate}" id="rsvDate" name="rsvDate" readonly="readonly">
	
	<div>예약된 시간 </div>
	<c:forEach var="m" items="${reservedTimes}">
	    <input type="hidden" value="${m.startDateTime}" id="startDateTime_${m.index}">
	    <input type="hidden" value="${m.endDateTime}" id="endDateTime_${m.index}">	   
	</c:forEach>
	<!-- 타임라인 -->
	<div id="timeline"></div>
	
	<label for="start-time">시작 시간:</label>
    <select id="start-time" name="startTime">
        <option selected="selected">:::선택:::</option>        
    </select>

    <label for="end-time">종료 시간:</label>
    <select id="end-time" name="endTime">
        <option selected="selected">:::선택:::</option>       
    </select>

	<br>		
	<label for="type">유형 :</label>
    <input type="radio" name="type" id="type" value="team"> 팀
    <input type="radio" name="type" id="type" value="personal"> 개인용무

	<table border="1">
		<tr>
			<td style="width:300px; height:50px;">회의실 명</td>
			<td>${roomDTO.roomName}</td>
		</tr>
		<tr>
			<td style="width:25%; height:50px;">이미지</td>
			<td><img src="${pageContext.request.contextPath}/upload/profile_img/20240716004716.jpeg" width="100px"></td>
		</tr>
		<tr>
			<td style="width:25%; height:50px;">위치</td>
			<td>${roomDTO.roomPlace}</td>
		</tr>
		<tr>
			<td style="width:25%; height:50px;">수용인원</td>
			<td>최대 ${roomDTO.roomMax}명</td>
		</tr>			
		<tr>						
			<td style="width:25%; height:50px;">비품</td>
			<td>${roomDTO.info}</td>
		</tr>
		<tr>						
			<td style="width:25%; height:50px;">제목</td>
			<td>
				<input type="text" name="meetingTitle" placeholder="공식적인 제목을 적어주세요." style="width: 500px;">
			</td>		
		</tr>
		<tr>
			<td>목적</td>
			<td colspan="4">
				<textarea style="width: 60%; height: 200px;" placeholder="회의실을 사용하는 목적을 작성해주세요." name="meetingReason"></textarea>
			</td>
		</tr>
		<tr>						
			<td style="height:50px;">참석 인원</td>
			<td>
				<input type="number" name="users"style="width: 30px;">명
			</td>		
		</tr>
	</table>
		<button type="submit">예약</button>
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/room/roomList'">취소</button>		
</form>	

<script>
$(document).ready(function() {
    // 09:00 부터 17:30 까지 30분 단위로 생성
    const availableTimes = [];
    
    for (let hour = 9; hour <= 17; hour++) {
        for (let minute of ['00', '30']) {
            const time = ('0' + hour).slice(-2) + ':' + minute;
            availableTimes.push({ value: time, label: time });
        }
    }

    // 추가로 18:00 시간을 종료 시간에만 추가
    availableTimes.push({ value: '18:00', label: '18:00' });

    const startTimeSelect = $('#start-time');
    const endTimeSelect = $('#end-time');

    // 페이지 로드 시 예약된 시간 가져오기
    const roomNo = $('input[name="roomNo"]').val();
    const rsvDate = $('input[name="rsvDate"]').val();
    let reservedTimes = [];

    fetchReservedTimes(roomNo, rsvDate);

    // 예약된 시간 가져오기
    function fetchReservedTimes(roomNo, rsvDate) {
        $.ajax({
            url: "${pageContext.request.contextPath}/room/getReservedTimes",
            method: 'POST',
            data: {
                roomNo: roomNo,
                rsvDate: rsvDate
            },
            success: function(json) {
                reservedTimes = json; // 예약된 시간 데이터를 전역 변수에 저장
                disableReservedTimes(); // 예약된 시간 비활성화 처리
                renderTimeline(); // 타임라인 렌더링 함수 호출
            },
            error: function(xhr, status, error) {
                console.error('에러 :', error);
            }
        });
    }

    // 예약된 시간 비활성화 처리
    function disableReservedTimes() {
        availableTimes.forEach(function(time) {
            const option = new Option(time.label, time.value);
            let isReserved = false;
            reservedTimes.forEach(function(reserved) {
                if (time.value >= reserved.startTime && time.value < reserved.endTime) {
                    isReserved = true;
                }
            });
            if (isReserved) {
                option.disabled = true; // 예약된 시간 비활성화
            }
            if (time.value !== '18:00') { // 시작 시간에서 18:00을 제외
                startTimeSelect.append(option);
            }
            if (time.value !== '09:00') { // 종료 시간에서 09:00을 제외
                endTimeSelect.append(option.cloneNode(true)); // 종료 시간에도 같은 옵션 추가
            }
        });
    }

    // 예약된 시간 타임라인 렌더링
    function renderTimeline() {
        const timeline = $('#timeline');
        timeline.empty();

        reservedTimes.forEach(timeSlot => {
            const start = timeToPosition(timeSlot.startTime);
            const end = timeToPosition(timeSlot.endTime);
            const block = $('<div class="time-block"></div>').css({
                left: start + '%',
                width: Math.max(end - start, 2) + '%' // 최소 폭 설정
            }).text(timeSlot.startTime + ' ~ ' + timeSlot.endTime);
            timeline.append(block);
        });
    }

    function timeToPosition(time) {
        const [hour, minute] = time.split(':').map(Number);
        const totalMinutes = (hour - 9) * 60 + minute; // 09:00 시작
        return (totalMinutes / (9 * 60)) * 100; // 9시간을 100%로 환산
    }

 	// 종료 시간 선택 시 예약된 종료 시간과 겹치는 경우 경고창 표시
    endTimeSelect.change(function() {
        const endTime = $(this).val();
        const startTime = startTimeSelect.val();

        if (endTime && startTime) {
            reservedTimes.forEach(reserved => {
                // 예약된 시간의 종료 시간이 선택한 종료 시간보다 늦거나 겹치는 경우
                if (endTime > reserved.startTime && endTime <= reserved.endTime) {
                    alert('예약이 불가한 시간입니다.');
                    endTimeSelect.val(':::선택:::'); // 종료 시간 셀렉트 박스를 초기화
                }
            });
        }
    });

    // 시작 시간 변경 시 종료 시간 업데이트
    startTimeSelect.change(function() {
        const startTime = $(this).val();
        if (startTime) {
            const availableEndTimes = availableTimes.filter(time => time.value > startTime);
            updateSelectOptions(endTimeSelect, availableEndTimes);
        }
    });

    // 셀렉트 박스 옵션 업데이트 함수
    function updateSelectOptions(selectElement, options) {
        selectElement.empty();
        options.forEach(option => {
            const opt = new Option(option.label, option.value);
            selectElement.append(opt);
        });
    }
    
    // 예약 버튼 클릭 시 시작시간, 유형 선택 여부 확인
    $('#reservationForm').submit(function(event) {
        if (!$('input[name="type"]:checked').val()) {
            alert('유형을 선택하세요.');
            event.preventDefault(); // 폼 제출 막기
        } else if ($('#start-time').val() === ':::선택:::') {
            alert('시작 시간을 선택하세요.');
            event.preventDefault(); 
        }
    });
});
</script>
</body>
</html>