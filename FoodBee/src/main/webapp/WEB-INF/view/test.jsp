<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Test</h1>
	
	<h5>테스트</h5>
	
<script>
	
	const CustomerService = [];
	const Development = [];
	const Finance = [];
	const HumanResources = [];
	const Marketing = [];
	const Production = [];
	const QualityManagement = [];
	const Research = [];
	const Sales = [];
	
	const year = [];
	const colors = {
				CustomerService: "blue", Development: "red", Finance: "green", HumanResources: "yellow", Marketing: "orange",
				Production: "pink", QualityManagement: "purple", Research: "gray", Sales: "black"
				};

	
	 // 서버에서 데이터를 가져옴
    $.ajax({
        async: false,
        url: '/chart/rest/getPureChart',
        method: 'post',
        success: function(json) {        	
            json.forEach(function(item) {
                if (!year.includes(item.year)) {
                    year.push(item.year); // 년도는 항상 추가
                }
                if (item.year < 1995) { // 1995년 이전 데이터만 처리
                    if (item.dname === 'Customer Service') {
                        CustomerService.push(item.pure);
                    } else if (item.dname === 'Development') {
                        Development.push(item.pure);
                    } else if (item.dname === 'Finance') {
                        Finance.push(item.pure);
                    } else if (item.dname === 'Human Resources') {
                        HumanResources.push(item.pure);
                    } else if (item.dname === 'Marketing') {
                        Marketing.push(item.pure);
                    } else if (item.dname === 'Production') {
                        Production.push(item.pure);
                    } else if (item.dname === 'Quality Management') {
                        QualityManagement.push(item.pure);
                    } else if (item.dname === 'Research') {
                        Research.push(item.pure);
                    } else if (item.dname === 'Sales') {
                        Sales.push(item.pure);
                    }
                } else {
                    // 1995년 이후 데이터는 null로 채우기
                    if (item.dname === 'Customer Service') {
                        CustomerService.push(null);
                    } else if (item.dname === 'Development') {
                        Development.push(null);
                    } else if (item.dname === 'Finance') {
                        Finance.push(null);
                    } else if (item.dname === 'Human Resources') {
                        HumanResources.push(null);
                    } else if (item.dname === 'Marketing') {
                        Marketing.push(null);
                    } else if (item.dname === 'Production') {
                        Production.push(null);
                    } else if (item.dname === 'Quality Management') {
                        QualityManagement.push(null);
                    } else if (item.dname === 'Research') {
                        Research.push(null);
                    } else if (item.dname === 'Sales') {
                        Sales.push(null);
                    }
                }
            });
        }
    });

	new Chart("PureChart", {
	  type: "line", // 그래프 타입 : 라인
	  data: {
	    labels: year,  // x축을 year로 지정
	    datasets: [{ // y축 [배열]
	    	label: "CustomerService", // 데이터를 구분하기 위함
	        data: CustomerService, // 차트에 사용할 데이터를 설정 
	        borderColor: colors.CustomerService, // 색상
	        fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Development",// 데이터를 구분하기 위함
	    	data: Development, // 차트에 사용할 데이터를 설정 
			borderColor: colors.Development, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Finance",// 데이터를 구분하기 위함
	    	data: Finance, // 차트에 사용할 데이터를 설정 
			borderColor: colors.Finance, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "HumanResources",// 데이터를 구분하기 위함
	    	data: HumanResources, // 차트에 사용할 데이터를 설정
			borderColor: colors.HumanResources, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Marketing",// 데이터를 구분하기 위함
	    	data: Marketing, // 차트에 사용할 데이터를 설정
			borderColor: colors.Marketing, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Production",// 데이터를 구분하기 위함
	    	data: Production, // 차트에 사용할 데이터를 설정 
			borderColor: colors.Production, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "QualityManagement",// 데이터를 구분하기 위함
	    	data: QualityManagement, // 차트에 사용할 데이터를 설정 
			borderColor: colors.QualityManagement, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Research",// 데이터를 구분하기 위함
	    	data: Research, // 차트에 사용할 데이터를 설정 
			borderColor: colors.Research, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }, { 
	    	label: "Sales",// 데이터를 구분하기 위함
	    	data: Sales, // 차트에 사용할 데이터를 설정 
			borderColor: colors.Sales, // 색상
			fill: false // 선 그래프의 아래 영역을 채우지 않도록 설정하는 옵션
	    }]
	  },
	  options: {
	    legend: {display: true},
	    title: {
            display: true,
            text: "년도 별 /순 유입" // 차트제목
        }
	  }
	});
	
</script>
</body>
</html>