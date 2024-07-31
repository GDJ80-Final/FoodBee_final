<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
    
<!-- theme meta -->
<meta name="theme-name" content="quixlab" />
<title>home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
#stopwatch {
    font-size: 20px; /* 폰트 크기 */
    color: black; /* 글자 색상 */
    margin-top: 10px; /* 위쪽 여백 */
    display: block; /* 항상 표시되도록 설정 */
}
</style>
</head>
<body>
	<div id="main-wrapper">
		<jsp:include page="./header.jsp"></jsp:include>
		
		<jsp:include page="./sidebar.jsp"></jsp:include>
	        <!--**********************************
	            Content body start
	        ***********************************-->
	  	<div class="content-body">
			세션값
			<div>empNo : ${emp.empNo}</div>
			<div>empName : ${emp.empName}</div>
			<div>dptNo : ${emp.dptNo}</div>
			<div>rankName : ${emp.rankName}</div>
			<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
			<br>
			<button type="button" id="attendanceStartButton">출근</button>
            <button type="button" id="attendanceEndButton">퇴근</button>
            <!-- 스톱워치 표시 영역 -->
            <div id="stopwatch">경과 시간: 00시간 00분 00초</div>
	 	</div>
 	</div>
 	<jsp:include page="./footer.jsp"></jsp:include>
 	
	<script>
    let stopwatchInterval;
    let elapsedTime = 0;

    function checkAttendanceStatus() {
        const attendanceDate = localStorage.getItem('attendanceDate');
        const currentDate = new Date().toISOString().split('T')[0];

        if (attendanceDate !== currentDate) {
            document.getElementById('attendanceStartButton').style.display = 'inline';
            document.getElementById('attendanceEndButton').style.display = 'inline';
            localStorage.removeItem('attendanceDate');
            document.getElementById('stopwatch').innerText = '경과 시간: 00시간 00분 00초';
            elapsedTime = 0;
            clearInterval(stopwatchInterval);
        }
    }

    window.onload = function() {
        checkAttendanceStatus();
    };

    document.getElementById('attendanceStartButton').onclick = function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/attendance/attendanceStartTime',
            method: 'POST',
            success: function(response) {
                alert("출근 시간이 등록되었습니다.");
                const today = new Date().toISOString().split('T')[0];
                localStorage.setItem('attendanceDate', today);
                startStopwatch();
            },
            error: function(xhr, status, error) {
                alert("출근 등록에 실패했습니다.");
                console.error(error);
            }
        });
    };

    document.getElementById('attendanceEndButton').onclick = function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/attendance/attendanceEndTime',
            method: 'POST',
            success: function(response) {
                alert("퇴근 시간이 등록되었습니다.");
                clearInterval(stopwatchInterval);
                document.getElementById('stopwatch').innerText = '경과 시간: 00시간 00분 00초';
            },
            error: function(xhr, status, error) {
                alert("퇴근 등록에 실패했습니다.");
                console.error(error);
            }
        });
    };

    function startStopwatch() {
        elapsedTime = 0;
        updateStopwatchDisplay();
        stopwatchInterval = setInterval(() => {
            elapsedTime += 1000;
            updateStopwatchDisplay();
        }, 1000);
    }

    function updateStopwatchDisplay() {
        const hours = Math.floor((elapsedTime / (1000 * 60 * 60)) % 24);
        const minutes = Math.floor((elapsedTime / (1000 * 60)) % 60);
        const seconds = Math.floor((elapsedTime / 1000) % 60);
        
        // 2자리 숫자로 포맷팅
        const formattedHours = String(hours).padStart(2, '0');
        const formattedMinutes = String(minutes).padStart(2, '0');
        const formattedSeconds = String(seconds).padStart(2, '0');

        // 스톱워치 텍스트 업데이트
        document.getElementById('stopwatch').innerText = `경과 시간: ${formattedHours}시간 ${formattedMinutes}분 ${formattedSeconds}초`;
        console.log(`Stopwatch Display: ${formattedHours}:${formattedMinutes}:${formattedSeconds}`); // 디버깅
    }
    </script>
 
</body>

</html>