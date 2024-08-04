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

	<div class="row page-titles mx-0">
        <div class="col p-md-0">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:void(0)">매출</a></li>
                <li class="breadcrumb-item active"><a href="javascript:void(0)">품목별 조회</a></li>
            </ol>
        </div>
   	</div>
   	
	<div class="content-body">
		<div class="container-fluid">
        	<div class="row">
				<div class="col-lg-12">
   					<div class="card">
						<div class="card-body ps-5 pe-5">
					    <h1 id="pageTitle">2024년 매출현황</h1>
					    <!-- 연도 선택을 위한 셀렉트 박스 -->
					    <select id="selectYear" onchange="fetchTotalData()">
					        <!-- 연도 옵션은 동적으로 추가될 예정 -->
					    </select>
					    <!-- Nav tabs -->
					    <div class="default-tab">
						    <div id="categoryButtons">
						    <ul class="nav nav-tabs mb-3" role="tablist">
								<li class="nav-item">
						        	<button class="nav-link active" onclick="fetchTotalData(); setActiveButton(this)">전체</button>
						        </li>
						        <li class="nav-item">
						        	<button class="nav-link" onclick="fetchCategoryData('간편식'); setActiveButton(this)">간편식</button>
						        </li>
						        <li class="nav-item">
						        	<button class="nav-link" onclick="fetchCategoryData('쌀/곡물'); setActiveButton(this)">쌀/곡물</button>
						        </li>
						        <li class="nav-item">
						        	<button class="nav-link" onclick="fetchCategoryData('육/수산'); setActiveButton(this)">육/수산</button>
						        </li>
						        <li class="nav-item">
						        	<button class="nav-link" onclick="fetchCategoryData('음료/주류'); setActiveButton(this)">음료/주류</button>
						        </li>
						        <li class="nav-item">
						        	<button class="nav-link" onclick="fetchCategoryData('청과'); setActiveButton(this)">청과</button>
						        </li>
						    </ul>
						    </div>
					    </div>
					   
					    <canvas id="lineChart" style="width:100%;max-width:1200px; height: 500px;"></canvas>
				    	</div>
					</div>
				</div>
			</div>
		</div>							  
	</div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
<script>
let allData = [];
const colors = {
    "간편식": "#7571F9",
    "쌀/곡물": "#ff9696",
    "육/수산": "#9097c4",
    "음료/주류": "#e62739",
    "청과": "#cddcff"
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

//활성화된 버튼의 클래스를 업데이트하는 함수
function setActiveButton(button) {
    // 모든 버튼에서 active 클래스를 제거
    $('.nav-link').removeClass('active');
    // 클릭된 버튼에 active 클래스를 추가
    $(button).addClass('active');
}

$(document).ready(function() {
    fetchAvailableYears();
});
</script>
</body>
</html>