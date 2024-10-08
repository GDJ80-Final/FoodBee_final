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
    #attendanceTime, #departureTime {
        font-size: 1.2em;
        color: black;
    }
    #contentTitle a {
        font-size: 30px;
        font-weight: bold;
    }

     #calendar {
      width: 40%; /* 화면 너비에 맞추기 */
      min-height: 400px;
      margin: 0 auto;
    }
    #scheduleTable {
        width: 30%; /* 테이블의 너비를 줄입니다. */
    }
    .content-body {
        margin-bottom: 20px;
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
			<!-- 출퇴근 시간 표시 영역 -->
			<div id="attendanceTime" style="display:none;">출근 시간:</div>
			<div id="departureTime" style="display:none;">퇴근 시간:</div>
			<div id="workTime" style="display:none;">근무 시간:</div>
	 	</div>
	 	<!-- 일정 -->
	 	<div class="content-body">
	 		<div id="content-body-calendar">
		 		<div id="contentTitle">
		 			<a href="calendar/scheduleList">일정알림</a>
		 		</div>
		 		<table id="scheduleTable" class="table header-border" border="1">
				    <thead>
				        <tr>
				            <th>유형</th>
				            <th>제목</th>
				            <th>시작일</th>
				            <th>종료일</th>
				            <th>작성자</th>
				        </tr>
				    </thead>
				    <tbody id="tableBody">
				    </tbody>
				</table>
				<div id="calendar"></div>
	 		</div>
	 	</div>
	 	<!-- 결재함 -->
	 	<div class="content-body">
	 		<span id="contentTitle">
	 			<a href="approval/approvalBox">결재함</a>
	 		</span>
	 		<table id="approvalTable" class="table header-border" border="1">
			    <thead>
			        <tr>
			            <th>양식유형</th>
			            <th>기안자</th>
			            <th>제목</th>
			            <th>결재상태</th>
			            <th>기안일시</th>
			        </tr>
			    </thead>
			    <tbody id="approvalTableBody">
			    </tbody>
			</table>
			
	 	</div>
	 	
 	</div>
 	
 	<jsp:include page="./footer.jsp"></jsp:include>
 	
	<script>
	 document.addEventListener('DOMContentLoaded', function() {
         let calendarEl = document.getElementById('calendar');
         let calendar = new FullCalendar.Calendar(calendarEl, {
             initialView: 'dayGridMonth',
             events: [
                 // 여기에 일정을 추가합니다.
                 {
                     title: '회의',
                     start: '2023-08-01',
                     end: '2023-08-02'
                 },
                 {
                     title: '프로젝트 마감',
                     start: '2023-08-10'
                 }
             ]
         });
         calendar.render();
     });
	window.onload = function() {
		let currentEmpNo = "${emp.empNo}"; // 현재 empNo 값을 가져옵니다.
	    let currentDptNo = "${emp.dptNo}";
	    let currentPage = 1;

	    loadTeamSchedule(currentPage);
	    loadApprovalBoxList(currentPage);
	    
	    // 결재함 리스트
        function loadApprovalBoxList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/approvalHomeList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: currentEmpNo
                },
                success: function(json) {
                    console.log("Ajax 요청 성공:", json); 
                    updateApprovalBoxList(json)
                },
                error: function() {
                    console.log("Ajax 요청 실패:", json); 
                }
            });
        }
        // URL 설정 함수
        function getDetailUrl(tmpName, draftDocNo) {
            let detailUrl = "";
            switch(tmpName) {
                case "매출보고":
                    detailUrl = "${pageContext.request.contextPath}/approval/revenueOne?draftDocNo=" + draftDocNo;
                    break;
                case "휴가신청":
                    detailUrl = "${pageContext.request.contextPath}/approval/dayOffOne?draftDocNo=" + draftDocNo;
                    break;
                case "출장신청":
                    detailUrl = "${pageContext.request.contextPath}/approval/businessTripOne?draftDocNo=" + draftDocNo;
                    break;
                case "기본기안서":
                    detailUrl = "${pageContext.request.contextPath}/approval/basicFormOne?draftDocNo=" + draftDocNo;
                    break;
                case "지출결의":
                    detailUrl = "${pageContext.request.contextPath}/approval/chargeOne?draftDocNo=" + draftDocNo;
                    break;
                default:
                    detailUrl = "#";
            }
            return detailUrl;
        }
	    // success함수
        function updateApprovalBoxList(json) {
            let tableBody = $("#approvalTableBody");
            tableBody.empty();
            
            if(json == ""){
            	tableBody.append("<tr><td colspan='5'>결재올라온 기안서가 없습니다</td></tr>");
            }else{
           	json.forEach(function(item) {
                let empNo = currentEmpNo;
                let midApproverNo = item.midApproverNo;
                let finalApproverNo = item.finalApproverNo;
                let approvalState = '';
                let state = '';

                if (empNo == midApproverNo) {
                    approvalState = parseInt(item.midApprovalState);
                } else if (empNo == finalApproverNo) {
                    approvalState = parseInt(item.finalApprovalState);
                }

                switch (approvalState) {
                    case 0:
                        state = '미결';
                        break;
                    case 1:
                        state = '기결';
                        break;
                    default:
                        state = '알 수 없음';
                }
                if (state === '미결') {
                    button = "<button class='badge badge-danger px-2'>승인필요</button>";
                }else{
                	button = "";
                }
                if (state === '미결') { // 미결 상태인 경우에만 추가
                    let button = "<button class='badge badge-danger px-2'>승인필요</button>";
                    let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);

	                    let newRow = $("<tr>" +
	                        "<td>" + item.tmpName + "</td>" +
	                        "<td>" + item.empName + "</td>" +
	                        "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
	                        "<td>" + state + "&nbsp" + button + "</td>" +
	                        "<td>" + item.createDatetime + "</td>" +
	                        "</tr>");
	                    tableBody.append(newRow);
                		}
            		});
       			}
        		$("#tableBody").show();
   		 	}
	    
		// 개인 + 팀 일정 리스트
	    function loadTeamSchedule(currentPage) {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/calendar/personalTeamList',
	            type: "GET",
	            data: {
	                currentPage: currentPage,
	                empNo: currentEmpNo,
	                dptNo: currentDptNo,
	            },
	            success: function(json) {
	                console.log("AJAX Data:", json); // 응답 데이터 확인 ->확인완료
	                updateTablePersoanlTeam(json)

	            },
	            error: function() {
                    alert("개인일정을 가져올 수 없습니다.");
	            }
	        });
	    }
	    //success함수
	    function updateTablePersoanlTeam(json) {
	        let tableBody = $("#tableBody");
	        
	        if (json == "") {
	            tableBody.append("<tr><td colspan='5'>팀일정이 없습니다.</td></tr>");
	        } else {
	            json.forEach(function(item) {
	                let newRow = $("<tr>" +
	                    "<td>" + item.category + "</td>" +
	                    "<td>" + item.title + "</td>" +
	                    "<td>" + item.startDate + "</td>" +
	                    "<td>" + item.endDate + "</td>" +
	                    "<td>" + item.empName + "</td>" +
	                    "</tr>");
	                tableBody.append(newRow);
	            });
	        }
	    }
		
	    // 출퇴근 시간을 초기화하는 함수
	    function resetAttendanceTimes() {
	    	console.log("resetAttendanceTimes 호출됨"); // 디버그용 로그
    	    console.log("DOM 요소 상태:", {
    	        attendanceTimeElem: document.getElementById('attendanceTime'),
    	        departureTimeElem: document.getElementById('departureTime'),
    	        workTimeElem: document.getElementById('workTime'),
    	        attendanceStartButton: document.getElementById('attendanceStartButton'),
    	        attendanceEndButton: document.getElementById('attendanceEndButton'),
    	    }); // DOM 요소 상태 출력
	        localStorage.removeItem('attendanceDate');
	        localStorage.removeItem('startTime');
	        localStorage.removeItem('endTime');
	        
	        const attendanceTimeElem = document.getElementById('attendanceTime');
	        const departureTimeElem = document.getElementById('departureTime');
	        const workTimeElem = document.getElementById('workTime');
	        const attendanceStartButton = document.getElementById('attendanceStartButton');
	        const attendanceEndButton = document.getElementById('attendanceEndButton');
	        
	        console.log(attendanceTimeElem, departureTimeElem, workTimeElem, attendanceStartButton, attendanceEndButton); // 디버그용 로그
	        
	        if (attendanceTimeElem && departureTimeElem && workTimeElem && attendanceStartButton && attendanceEndButton) {
	            attendanceTimeElem.textContent = '출근 시간: 없음';
	            departureTimeElem.textContent = '퇴근 시간: 없음';
	            workTimeElem.textContent = '근무 시간: 0시간 0분';
	            attendanceStartButton.style.display = 'inline-block';
	            attendanceEndButton.style.display = 'inline-block';
	        } else {
	            console.error("하나 이상의 DOM 요소를 찾을 수 없습니다."); // 에러 로그
	        }
	        
	    }

	    // 날짜가 바뀌었는지 확인하는 함수
	    function checkDateChange() {
		    const storedDate = localStorage.getItem('attendanceDate');
		    const currentDate = new Date().toISOString().split('T')[0];
		
		    // 오늘 날짜와 저장된 날짜를 비교
		    if (storedDate !== currentDate) {
		        console.log("날짜가 변경되었습니다. 초기화합니다.");
		        resetAttendanceTimes();
		        localStorage.setItem('attendanceDate', currentDate);
		    } else {
		        console.log("날짜가 동일합니다."); // 디버그용 로그
		        // 오늘 날짜라면 출근/퇴근 시간 표시
		        const startTime = localStorage.getItem('startTime');
		        const endTime = localStorage.getItem('endTime');
		        if (startTime) {
		            document.getElementById('attendanceTime').innerText = '출근 시간: ' + startTime;
		            document.getElementById('attendanceTime').style.display = 'block';
		            document.getElementById('attendanceStartButton').style.display = 'none';
		        }
		        if (endTime) {
		            document.getElementById('departureTime').innerText = '퇴근 시간: ' + endTime;
		            document.getElementById('workTime').innerText = '근무 시간: ' + calculateWorkTime(startTime, endTime);
		            document.getElementById('departureTime').style.display = 'block';
		            document.getElementById('workTime').style.display = 'block';
		            document.getElementById('attendanceEndButton').style.display = 'none';
		        }
		    }
		}

	    // 시간을 한국 시간으로 포맷하는 함수 (연도와 초를 제외)
	    function formatTime(date) {
	        const month = String(date.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 +1)
	        const day = String(date.getDate()).padStart(2, '0'); // 일
	        const hours = String(date.getHours()).padStart(2, '0'); // 시
	        const minutes = String(date.getMinutes()).padStart(2, '0'); // 분
	        
	        return month + '-' + day + ' ' + hours + ':' + minutes; // 형식: MM-DD HH:mm
	    }

	    // 근무 시간 계산 함수
	    function calculateWorkTime(startTime, endTime) {
	        if (startTime && endTime) {
	            const start = new Date(startTime);
	            const end = new Date(endTime);
	            const workTimeInSeconds = (end - start) / 1000;
	            const hours = Math.floor(workTimeInSeconds / 3600);
	            const minutes = Math.floor((workTimeInSeconds % 3600) / 60);
	            return hours + '시간 ' + minutes + '분';
	        }
	        return '0시간 0분';
	    }

	    // 로그인 시 이전 empNo와 비교하여 로컬 스토리지 초기화
	    function checkEmpNoChange() {
	        const storedEmpNo = localStorage.getItem('empNo');
	        if (storedEmpNo && storedEmpNo !== currentEmpNo) {
	            resetAttendanceTimes(); // empNo가 변경되면 기록 초기화
	        }
	        localStorage.setItem('empNo', currentEmpNo); // 현재 empNo 저장
	    }

	    // 출근 버튼 클릭 시
	    document.getElementById('attendanceStartButton').onclick = function() {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/attendance/attendanceStartTime',
	            method: 'POST',
	            success: function(response) {
	                alert("출근 시간이 등록되었습니다.");
	                const now = new Date();
	                let formattedTime = formatTime(now);
	                localStorage.setItem('startTime', formattedTime);
	                localStorage.setItem('attendanceDate', now.toISOString().split('T')[0]);
	                document.getElementById('attendanceTime').innerText = '출근 시간: ' + formattedTime;
	                document.getElementById('attendanceTime').style.display = 'block';
	                document.getElementById('attendanceStartButton').style.display = 'none';
	                console.log("출근 시간:", formattedTime);
	            },
	            error: function(xhr, status, error) {
	                alert("출근 등록에 실패했습니다.");
	                console.error(error);
	            }
	        });
	    };

	    // 퇴근 버튼 클릭 시
	    document.getElementById('attendanceEndButton').onclick = function() {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/attendance/attendanceEndTime',
	            method: 'POST',
	            success: function(response) {
	                alert("퇴근 시간이 등록되었습니다.");
	                const now = new Date();
	                let formattedTime = formatTime(now);
	                localStorage.setItem('endTime', formattedTime);
	                localStorage.setItem('attendanceDate', now.toISOString().split('T')[0]);
	                document.getElementById('departureTime').innerText = '퇴근 시간: ' + formattedTime;
	                document.getElementById('departureTime').style.display = 'block';
	                const workTime = calculateWorkTime(localStorage.getItem('startTime'), formattedTime);
	                document.getElementById('workTime').innerText = '근무 시간: ' + workTime;
	                document.getElementById('workTime').style.display = 'block';
	                document.getElementById('attendanceEndButton').style.display = 'none';
	                console.log("퇴근 시간:", formattedTime);
	            },
	            error: function(xhr, status, error) {
	                alert("퇴근 등록에 실패했습니다.");
	                console.error(error);
	            }
	        });
	    };

	    // 특정 시간에 초기화하는 함수
	    function resetAtSpecificTime(targetHour, targetMinute) {
	        const now = new Date();
	        const targetTime = new Date();
	        targetTime.setHours(targetHour, targetMinute, 0, 0);
	        
	        // 목표 시간이 이미 지난 경우 다음 날 목표 시간으로 설정
	        if (now > targetTime) {
	            targetTime.setDate(targetTime.getDate() + 1);
	        }
	        
	        const msUntilTargetTime = targetTime - now;
	        console.log("msUntilTargetTime: ", msUntilTargetTime); // 디버깅용 로그
	        
	        setTimeout(function() {
	            console.log("특정 시간 초기화 실행"); // 디버깅용 로그
	            resetAttendanceTimes();
	            checkDateChange();
	            setInterval(function() {
	                resetAttendanceTimes();
	                checkDateChange();
	            }, 24 * 60 * 60 * 1000); // 24시간 간격으로 초기화
	        }, msUntilTargetTime);
	    }

	    // 출근 기록을 서버에서 가져오는 함수
	    function loadAttendanceRecord() {
	        const currentEmpNo = "${emp.empNo}";
	        $.ajax({
	            url: '${pageContext.request.contextPath}/attendance/loadAttendanceRecord', // 출근 기록
	            method: 'GET',
	            data: { empNo: currentEmpNo },
	            success: function(response) {
	                console.log("서버 응답:", response); // 응답 확인
	                const { startTime, endTime } = response;
	                if (startTime) {
	                    localStorage.setItem('startTime', startTime);
	                    document.getElementById('attendanceTime').innerText = '출근 시간: ' + startTime;
	                    document.getElementById('attendanceTime').style.display = 'block';
	                    document.getElementById('attendanceStartButton').style.display = 'none';
	                }
	                if (endTime) {
	                    localStorage.setItem('endTime', endTime);
	                    document.getElementById('departureTime').innerText = '퇴근 시간: ' + endTime;
	                    document.getElementById('departureTime').style.display = 'block';
	                    const workTime = calculateWorkTime(startTime, endTime);
	                    document.getElementById('workTime').innerText = '근무 시간: ' + workTime;
	                    document.getElementById('workTime').style.display = 'block';
	                    document.getElementById('attendanceEndButton').style.display = 'none';
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("출근 기록을 가져오는데 실패했습니다.", error);
	            }
	        });
	    }

	    // 날짜 변경 확인 주기 설정
	    function checkDateChangePeriodically() {
	        setInterval(checkDateChange, 60 * 1000); // 1분마다 날짜 변경 확인
	    }

	    resetAttendanceTimes(); // 페이지 로드 시 초기화 함수 호출
	    checkEmpNoChange(); // empNo 변경 확인
	    checkDateChange(); // 페이지 로드 시 날짜 변경 확인
	    resetAtSpecificTime(5, 00); // 특정 시간 (예: 오전 5:00)에 초기화 설정
	    checkDateChangePeriodically(); // 주기적으로 날짜 변경 확인
	    loadAttendanceRecord(); // 출근 기록 로드
	};

    </script>
 
</body>

</html>