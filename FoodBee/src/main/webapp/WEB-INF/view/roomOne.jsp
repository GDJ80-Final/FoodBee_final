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
</head>
<body>
<div id="reserved-times"></div>
<h1>회의실 예약</h1>
<form method="post" action="${pageContext.request.contextPath}/roomRsv">		
	<input type="hidden" value="${roomNo}" id="roomNo" name="roomNo">
	<input type="date" value="${rsvDate}" id="rsvDate" name="rsvDate" readonly="readonly">
	
	<div>예약된 시간 : </div>
	<c:forEach var="m" items="${reservedTimes}">
	    <input type="hidden" value="${m.startDateTime}" id="startDateTime_${m.index}">
	    <input type="hidden" value="${m.endDateTime}" id="endDateTime_${m.index}">
	    <div>${m.startTime} ~ ${m.endTime}</div>
	</c:forEach>
	
	<label for="start-time">시작 시간:</label>
    <select id="start-time" name="startTime">
        <option selected="selected">:::선택:::</option>        
    </select>

    <label for="end-time">종료 시간:</label>
    <select id="end-time" name="endTime">
        <option selected="selected">:::선택:::</option>       
    </select>
	<!--  
    <label for="selected-times">선택된 시간:</label>
    <select id="selected-times" name="selectedTimes" multiple>
    </select>
    
    <label for="all-day">종일:</label>
	<input type="checkbox" id="all-day">
	-->
	<br>		
	<label for="type">유형 :</label>
    <input type="radio" name="type" id="type" value="team"> 팀
    <input type="radio" name="type" id="type" value="personal"> 개인용무
        
	<table border="1">
		<tr>
			<td style="width:300px; height:50px;">회의실 명</td>
			<td style="width:25%; height:50px;">이미지</td>
			<td style="width:25%; height:50px;">위치</td>
			<td style="width:25%; height:50px;">수용인원</td>
			<td style="width:25%; height:50px;">비품</td>
		</tr>
	
		<tr>
			<td style="height:200px;">${roomDTO.roomName}</td>				
			<td style="height:200px;">picture
				<!-- <img src="FoodBee/img/${roomInfo.originalFiles}" width="100px"></td>  -->
			<td style="height:200px;">${roomDTO.roomPlace}</td>
			<td style="height:200px;">최대 ${roomDTO.roomMax}명</td>
			<td style="height:200px;">${roomDTO.info}</td>
			
		</tr>
		<tr>
			<td>목적</td>
			<td colspan="4"><textarea style="width: 60%; height: 200px;"></textarea></td>
		</tr>
	</table>
		<button type="submit">예약</button>
		<button type="button"><a href="${pageContext.request.contextPath}/roomList">취소</a></button>
		
</form>	
<script>
$(document).ready(function() {
    const availableTimes = [
        { value: '09:00', label: '09:00' },
        { value: '09:30', label: '09:30' },
        { value: '10:00', label: '10:00' },
        { value: '10:30', label: '10:30' },
        { value: '11:00', label: '11:00' },
        { value: '11:30', label: '11:30' },
        { value: '12:00', label: '12:00' },
        { value: '12:30', label: '12:30' },
        { value: '13:00', label: '13:00' },
        { value: '13:30', label: '13:30' },
        { value: '14:00', label: '14:00' },
        { value: '14:30', label: '14:30' },
        { value: '15:00', label: '15:00' },
        { value: '15:30', label: '15:30' },
        { value: '16:00', label: '16:00' },
        { value: '16:30', label: '16:30' },
        { value: '17:00', label: '17:00' },
        { value: '17:30', label: '17:30' },
        { value: '18:00', label: '18:00' }
    ];

    const startTimeSelect = $('#start-time');
    const endTimeSelect = $('#end-time');

    // 페이지 로드 시 예약된 시간 가져오기
    const roomNo = $('input[name="roomNo"]').val();
    const rsvDate = $('input[name="rsvDate"]').val();
    fetchReservedTimes(roomNo, rsvDate);

    // 예약된 시간 가져오기
    function fetchReservedTimes(roomNo, rsvDate) {
        $.ajax({
            url: '/foodbee/controller/getReservedTimes',
            method: 'POST',
            data: {
                roomNo: roomNo,
                rsvDate: rsvDate
            },
            success: function(data) {
                console.log(data); // 데이터 확인
                disableReservedTimes(data);
            },
            error: function(xhr, status, error) {
                console.error('Error fetching reserved times:', error);
            }
        });
    }

    // 예약된 시간 비활성화 처리
    function disableReservedTimes(reservedTimes) {
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

    // 시작 시간 변경 시 종료 시간 업데이트
    startTimeSelect.change(function() {
        const startTime = $(this).val();
        if (startTime) {
            const availableEndTimes = availableTimes.filter(time => time.value > startTime);
            updateSelectOptions(endTimeSelect, availableEndTimes);
        }
    });

    // 종료 시간 변경 시 선택된 시간 업데이트
    endTimeSelect.change(updateSelectedTimes);

    // 선택된 시간들 업데이트
    function updateSelectedTimes() {
        const selectedTimesSelect = $('#selected-times');
        selectedTimesSelect.empty();
        const startTime = startTimeSelect.val();
        const endTime = endTimeSelect.val();

        if (!startTime || !endTime) return;

        const startHour = parseInt(startTime.split(':')[0]);
        const startMinute = parseInt(startTime.split(':')[1]);
        const endHour = parseInt(endTime.split(':')[0]);
        const endMinute = parseInt(endTime.split(':')[1]);

        let currentHour = startHour;
        let currentMinute = startMinute;

        while (currentHour < endHour || (currentHour === endHour && currentMinute <= endMinute)) {
            const time = ('0' + currentHour).slice(-2) + ':' + ('0' + currentMinute).slice(-2);
            const option = new Option(time, time);
            selectedTimesSelect.append(option);
            currentMinute += 30;
            if (currentMinute >= 60) {
                currentHour++;
                currentMinute -= 60;
            }
        }
    }

    // 셀렉트 박스 옵션 업데이트 함수
    function updateSelectOptions(selectElement, options) {
        selectElement.empty();
        options.forEach(option => {
            const opt = new Option(option.label, option.value);
            selectElement.append(opt);
        });
    }
});
</script>
</body>
</html>