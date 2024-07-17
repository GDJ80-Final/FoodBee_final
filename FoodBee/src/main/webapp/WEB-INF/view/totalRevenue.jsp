<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>월별 매출 차트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
<canvas id="donutChart" style="max-width: 500px;"></canvas>
<div id="monthlyTotal"></div>
<div id="previousMonthTotal"></div><br>
<div>
    <label for="monthSelect">월 선택:</label>
    <select id="monthSelect">
        <option value="1">1월</option>
        <option value="2">2월</option>
        <option value="3">3월</option>
        <option value="4">4월</option>
        <option value="5">5월</option>
        <option value="6">6월</option>
        <option value="7">7월</option>
        <option value="8">8월</option>
        <option value="9">9월</option>
        <option value="10">10월</option>
        <option value="11">11월</option>
        <option value="12">12월</option>
    </select>
</div>
<canvas id="totalChart" style="width:100%;max-width:700px"></canvas>

<script>
$(document).ready(function() {
    const categoryName = [];
    const revenue = [];
    const barColors = ["red", "orange", "yellow", "green", "blue"];
    
    // 차트 생성 함수 (막대형 바 차트)
	function createBarChart(year, month) {
	    new Chart("totalChart", {
	        type: "bar",
	        data: {
	            labels: categoryName,
	            datasets: [{
	                backgroundColor: barColors,
	                data: revenue
	            }]
	        },
	        options: {
	            animation: false, // 애니메이션 비활성화
	            legend: {
	                display: false, // 범례 숨기기
	            },
	            title: {
	                display: true,
	                text: year + '년 ' + month + '월 매출'
	            },
	            scales: {
	                yAxes: [{
	                    ticks: {
	                        beginAtZero: true
	                    }
	                }]
	            }
	        }
	    });
	}
    
    // 차트 생성 함수 (도넛 차트)
    function createDonutChart() {
    	let ctx = document.getElementById('donutChart').getContext('2d');
        let myDonutChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: categoryName,
                datasets: [{
                    backgroundColor: barColors,
                    data: revenue
                }]
            },
            options: {
            	animation: false, // 애니메이션 비활성화
                title: {
                    display: true,
                    text: '카테고리별 매출 비율(%)'
                },
                legend: {
                    display: true,
                    position: 'right'
                },
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            let dataset = data.datasets[tooltipItem.datasetIndex];
                            let total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
                                return previousValue + currentValue;
                            });
                            let currentValue = dataset.data[tooltipItem.index];
                            let percentage = Math.round((currentValue / total) * 100); // 백분율 계산, 소수점 반올림
                            return categoryName[tooltipItem.index] + ': ' + percentage + '%';
                        }
                    }
                }
            }
        });

        // 도넛 차트 범례 설정
        let legendHtml = '';
        categoryName.forEach(function(label, index) {
            legendHtml += '<div><span style="display:inline-block;width:20px;height:10px;background-color:' + barColors[index] + ';margin-right:5px;"></span>' + label + '</div>';
        });
        $('#donutChartLegend').html(legendHtml);
    }

    function fetchData(year, month) {
        let formattedMonth = year + '-' + ('0' + month).slice(-2); // 월을 yyyy-mm 형식으로 포맷
        let formattedPreviousMonth = year + '-' + ('0' + (month - 1 === 0 ? 12 : month - 1)).slice(-2); // 이전 월을 yyyy-mm 형식으로 포맷
        
        console.log("Fetching data for month: " + formattedMonth + " and " + formattedPreviousMonth); // 로그 추가
        $.ajax({
            url: "${pageContext.request.contextPath}/monthRevenue",
            method: 'POST',
            data: { month: formattedMonth }, // 선택된 월을 서버에 전달
            success: function(json) {
                console.log("Data received: ", json); // 로그 추가
                categoryName.length = 0; // 배열 초기화
                revenue.length = 0; // 배열 초기화
                json.forEach(function(item) {
                    categoryName.push(item.categoryName);
                    revenue.push(item.revenue);
                });
                
                console.log(categoryName);
                console.log(revenue);

                // 이전 달 데이터 요청
                $.ajax({
                    url: "${pageContext.request.contextPath}/monthRevenue",
                    method: 'POST',
                    data: { month: formattedPreviousMonth }, // 이전 월을 서버에 전달
                    success: function(previousJson) {
                        console.log("Previous month data received: ", previousJson); // 로그 추가
                        previousMonthRevenue.length = 0; // 배열 초기화
                        previousJson.forEach(function(item) {
                            previousMonthRevenue.push(item.revenue);
                        });

                        // 차트 갱신
                        createBarChart(year, month); // 막대형 바 차트 갱신
                        createDonutChart(); // 도넛 차트 생성

                        // 선택된 월의 매출 합계 업데이트
                        updateMonthlyTotal(revenue.reduce((acc, val) => acc + val, 0), previousMonthRevenue.reduce((acc, val) => acc + val, 0));
                    },
                    error: function(xhr, status, error) {
                        console.error('Previous month AJAX Error:', error); // 에러 로그 추가
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('Current month AJAX Error:', error); // 에러 로그 추가
            }
        });
    }
    // 초기 데이터 호출 (현재 월 기준 전월 데이터)
    const currentDate = new Date();
    let currentYear = currentDate.getFullYear(); // 년도 가져오기
    let currentMonth = currentDate.getMonth(); // 현재 월 데이터 가져오기
    let previousMonthRevenue = []; // 이전 달 매출 데이터 배열
    
    // 이전 달의 값을 기본 선택값으로 설정
    currentMonth = currentMonth === 0 ? 12 : currentMonth; // 1월일 경우 12월로 설정
    $('#monthSelect').val(currentMonth);
    
    // 월 선택 시 데이터 다시 불러오기
    $('#monthSelect').on('change', function() {
        let selectedMonth = $(this).val();
        fetchData(currentYear, selectedMonth); // 선택된 년도와 월에 대한 데이터 요청
    });

    // 페이지 로드 시 초기 데이터 호출
    fetchData(currentYear, currentMonth); // 현재 월의 데이터 요청
    
    // 월별 매출 합계를 업데이트하는 함수
    function updateMonthlyTotal(currentMonthTotal, previousMonthTotal) {
        // 월별 매출 합계를 div에 표시
        $('#monthlyTotal').html('이번 매출 합계: ' + currentMonthTotal + '원<br>' +
                               '저번 매출 합계: ' + previousMonthTotal + '원<br>' +
                               ' 증감액:'+(currentMonthTotal - previousMonthTotal)+'원');
    }
});
</script>
</body>
</html>