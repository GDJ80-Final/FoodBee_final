<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회의실 정보 및 예약</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>회의실 예약</h1>
	<form method="post" action="${pageContext.request.contextPath}/roomRsv">		
		<input type="hidden" value="${roomNo}" name="roomNo">
		<input type="date" value="${rsvDate}" name="rsvDate" readonly="readonly">
		<div>예약된 시간 : </div>
		<c:forEach var="m" items="${reservedTimes}">
		    <input type="hidden" value="${m.startDateTime}" id="startDateTime_${m.index}">
		    <input type="hidden" value="${m.endDateTime}" id="endDateTime_${m.index}">
		    <div>${m.startDateTime}~${m.endDateTime}</div>
		</c:forEach>
		
		<label for="start-time">시작 시간:</label>
	    <select id="start-time" name="startTime">
	        <option selected="selected">:::선택:::</option>        
	    </select>
	
	    <label for="end-time">종료 시간:</label>
	    <select id="end-time" name="endTime">
	        <option selected="selected">:::선택:::</option>       
	    </select>
	
	    <label for="selected-times">선택된 시간:</label>
	    <select id="selected-times" name="selectedTimes" multiple>
	    </select>
	    
	    <label for="all-day">종일:</label>
		<input type="checkbox" id="all-day">
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
				<td style="height:200px;">${roomInfo.roomName}</td>				
				<td style="height:200px;">gd
					<!-- <img src="FoodBee/img/${roomInfo.originalFiles}" width="100px"></td>  -->
				<td style="height:200px;">${roomInfo.roomPlace}</td>
				<td style="height:200px;">최대 ${roomInfo.roomMax}명</td>
				<td style="height:200px;">${roomInfo.info}</td>
				
			</tr>
			<tr>
				<td>목적</td>
				<td colspan="4"><textarea style="width: 100%; height: 300px;"></textarea></td>
			</tr>
		</table>
			<button type="submit">예약</button>
			<button type="button"><a href="${pageContext.request.contextPath}/roomList">취소</a></button>
			
	</form>	
<script>
	const startTimeSelect = document.getElementById('start-time');
	const endTimeSelect = document.getElementById('end-time');
	const selectedTimesSelect = document.getElementById('selected-times');
	const allDayCheckbox = document.getElementById('all-day');		
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

	const reservedTimes = [
	    { start: '09:00', end: '10:00' } // 예약된 시간 예시
	    
	];

	// 시간 옵션 생성
	function populateTimeOptions() {
	    availableTimes.forEach(time => {
	        const option = new Option(time.label, time.value);
	        // 예약된 시간 구간 확인
	        const isReserved = reservedTimes.some(reserved => {
	            const reservedStart = reserved.start;
	            const reservedEnd = reserved.end;
	            return time.value >= reservedStart && time.value < reservedEnd;
	        });
	        if (isReserved) {
	            option.disabled = true; // 예약된 시간 비활성화
	        }
	        startTimeSelect.add(option);
	        endTimeSelect.add(option.cloneNode(true)); // 종료 시간에도 같은 옵션 추가
	    });
	}

	populateTimeOptions();

	// 선택된 시간들 업데이트
	updateSelectedTimes();

	// 시작 시간 변경 시 종료 시간 옵션 업데이트
	startTimeSelect.addEventListener('change', function() {
	    const startTimeValue = startTimeSelect.value;
	    const filteredTimes = availableTimes.filter(time => time.value > startTimeValue && !reservedTimes.some(reserved => time.value >= reserved.start && time.value < reserved.end));
	    updateSelectOptions(endTimeSelect, filteredTimes);
	    updateSelectedTimes();
	});

	// 종료 시간 변경 시 선택된 시간들 업데이트
	endTimeSelect.addEventListener('change', updateSelectedTimes);
	
	// 종일 체크박스 처리
	allDayCheckbox.addEventListener('change', function() {
	    if (allDayCheckbox.checked) {
	        startTimeSelect.value = '09:00';
	        endTimeSelect.value = '18:00';
	    }
	    updateSelectedTimes();
	});
	
	// 선택된 시간들 업데이트 함수
	function updateSelectedTimes() {
	    selectedTimesSelect.innerHTML = '';
	    const startTime = startTimeSelect.value;
	    const endTime = endTimeSelect.value;

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
	        selectedTimesSelect.add(option);
	        currentMinute += 30;
	        if (currentMinute >= 60) {
	            currentHour++;
	            currentMinute -= 60;
	        }
	    }
	}
	
	// 셀렉트 박스 옵션 업데이트 함수
	function updateSelectOptions(selectElement, options) {
	    selectElement.innerHTML = '';
	    options.forEach(option => {
	        const opt = new Option(option.label, option.value);
	        selectElement.add(opt);
	    });
	} 
</script>
</body>
</html>