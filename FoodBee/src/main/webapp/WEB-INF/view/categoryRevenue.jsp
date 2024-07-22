<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
<h1>2024년 매출현황</h1>
<!-- 연도 선택을 위한 셀렉트 박스 -->
<select id="selectYear" onchange="fetchTotalData()">
    <option value="2022">2022년</option>
    <option value="2023">2023년</option>
    <option value="2024" selected>2024년</option>
</select>

<div id="categoryButtons">
    <button onclick="fetchTotalData()">전체</button>
    <button onclick="fetchCategoryData('간편식')">간편식</button>
    <button onclick="fetchCategoryData('쌀/곡물')">쌀/곡물</button>
    <button onclick="fetchCategoryData('육/수산')">육/수산</button>
    <button onclick="fetchCategoryData('음료/주류')">음료/주류</button>
    <button onclick="fetchCategoryData('청과')">청과</button>
</div>
<canvas id="lineChart" style="width:100%;max-width:700px"></canvas>
<script>
//전체 데이터를 담을 변수
let allData = [];
const colors = {
	    "간편식": "red",
	    "쌀/곡물": "orange",
	    "육/수산": "yellow",
	    "음료/주류": "green",
	    "청과": "blue"
	};
// 전체 데이터를 가져오는 함수
function fetchTotalData() {
    const selectedYear = document.getElementById('selectYear').value;

    $.ajax({
        url: "${pageContext.request.contextPath}/getTotalRevenue",
        method: 'POST',
        dataType: 'json',
        data: { year: selectedYear },
        success: function(data) {
            console.log(selectedYear + " 전체 데이터:", data);
            allData = data;
            updateChart(allData);
        },
        error: function(xhr, status, error) {
            console.error(selectedYear + " 전체 데이터 AJAX 에러:", error);
        }
    });
}

// 카테고리별 데이터를 가져오는 함수
function fetchCategoryData(category) {
    const selectedYear = document.getElementById('selectYear').value;

    $.ajax({
        url: "${pageContext.request.contextPath}/getCategoryRevenue",
        method: 'POST',
        dataType: 'json',
        data: { year: selectedYear, category: category },
        success: function(data) {
            console.log(category + " 카테고리 데이터:", data);
            updateChart(data);
        },
        error: function(xhr, status, error) {
            console.error(category + " 카테고리 데이터 AJAX 에러:", error);
        }
    });
}

// 차트 업데이트 함수
function updateChart(data) {
    if (data && data.length > 0) {
        // 데이터를 가공하여 카테고리별로 매출 데이터 분리
        const categories = [...new Set(data.map(item => item.categoryName))];
        const months = [...new Set(data.map(item => item.referenceMonth))].sort();
        const revenueData = categories.map(category => {
            return months.map(month => {
                const record = data.find(item => item.categoryName === category && item.referenceMonth === month);
                return record ? record.revenue : 0;
            });
        });

        console.log("Categories:", categories);
        console.log("Revenue Data:", revenueData);
        console.log("Months:", months);

        // 차트 생성 코드
        const ctx = document.getElementById('lineChart').getContext('2d');
        const lineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: months,
                datasets: categories.map((category, index) => ({
                    label: category,
                    data: revenueData[index],
                    fill: false,
                    borderColor: colors[category],
                    tension: 0.1
                }))
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: '월'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: '매출액'
                        }
                    }
                }
            }
        });
    } else {
        console.error('데이터가 비어 있습니다.');
    }
}


// 페이지 로드 시 초기 데이터 호출 (전체 카테고리 데이터로)
$(document).ready(function() {
    fetchTotalData(); // 페이지 로드 시 선택된 연도의 전체 카테고리 데이터를 먼저 받아옴
});
</script>
</body>
</html>