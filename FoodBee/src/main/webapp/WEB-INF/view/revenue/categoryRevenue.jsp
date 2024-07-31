<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
<div id="main-wrapper">
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
	<div class="content-body">
	<div class="container">
	    <h1 id="pageTitle">2024년 매출현황</h1>
	    <!-- 연도 선택을 위한 셀렉트 박스 -->
	    <select id="selectYear" onchange="fetchTotalData()">
	        <!-- 연도 옵션은 동적으로 추가될 예정 -->
	    </select>
	    
	    <div id="categoryButtons">
	        <button onclick="fetchTotalData()">전체</button>
	        <button onclick="fetchCategoryData('간편식')">간편식</button>
	        <button onclick="fetchCategoryData('쌀/곡물')">쌀/곡물</button>
	        <button onclick="fetchCategoryData('육/수산')">육/수산</button>
	        <button onclick="fetchCategoryData('음료/주류')">음료/주류</button>
	        <button onclick="fetchCategoryData('청과')">청과</button>
	    </div>
	    <canvas id="lineChart" style="width:100%;max-width:1200px"></canvas>
	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
let allData = [];
const colors = {
    "간편식": "red",
    "쌀/곡물": "orange",
    "육/수산": "yellow",
    "음료/주류": "green",
    "청과": "blue"
};

function fetchAvailableYears() {
    $.ajax({
        url: "${pageContext.request.contextPath}/revenue/getAvailableYears",
        method: 'GET',
        dataType: 'json',
        success: function(years) {
            console.log("사용 가능한 연도:", years);
            const selectYear = $('#selectYear');
            selectYear.empty();
            years.forEach(year => {
                selectYear.append(new Option(year + '년', year));
            });

            const currentYear = new Date().getFullYear();
            selectYear.val(currentYear);
            fetchTotalData();
        },
        error: function(xhr, status, error) {
            console.error("사용 가능한 연도 데이터 AJAX 에러:", error);
        }
    });
}

function fetchTotalData() {
    const selectedYear = $('#selectYear').val();

    $.ajax({
        url: "${pageContext.request.contextPath}/revenue/getTotalRevenue",
        method: 'POST',
        dataType: 'json',
        data: { year: selectedYear },
        success: function(json) {
            const data = json;
            console.log(selectedYear + " 전체 데이터:", data);
            allData = data;
            updateChart(allData);
            updateTitle(selectedYear);
        },
        error: function(xhr, status, error) {
            console.error(selectedYear + " 전체 데이터 AJAX 에러:", error);
        }
    });
}

function fetchCategoryData(category) {
    const selectedYear = $('#selectYear').val();

    $.ajax({
        url: "${pageContext.request.contextPath}/revenue/getCategoryRevenue",
        method: 'POST',
        dataType: 'json',
        data: { year: selectedYear, category: category },
        success: function(json) {
            const data = json;
            console.log(category + " 카테고리 데이터:", data);
            updateChart(data);
            updateTitle(selectedYear);
        },
        error: function(xhr, status, error) {
            console.error(category + " 카테고리 데이터 AJAX 에러:", error);
        }
    });
}

function updateChart(data) {
    if (data && data.length > 0) {
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

function updateTitle(year) {
    $('#pageTitle').text(year + '년 매출현황');
}

$(document).ready(function() {
    fetchAvailableYears();
});
</script>
</body>
</html>