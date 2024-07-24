<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>기안함</h1>
<div>
    <table border="1">
        <tr>
            <th>결재대기</th>
            <th>승인중</th>
            <th>승인완료</th>
            <th>반려</th>
        </tr>
        <tr>
            <td><c:out value="${stateBox.zeroState}"></c:out>건</td>
            <td><c:out value="${stateBox.oneState}"></c:out>건</td>
            <td><c:out value="${stateBox.twoState}"></c:out>건</td>
            <td><c:out value="${stateBox.nineState}"></c:out>건</td>
        </tr>
    </table>
</div>

<button id="allBtn">전체</button>
<button id="zeroBtn">결재대기</button>
<button id="oneBtn">승인중</button>
<button id="twoBtn">승인완료</button>
<button id="nineBtn">반려</button>
<div>
    <table border="1">
        <tr>
            <th>양식유형</th>
            <th>제목</th>
            <th>결재상태</th>
            <th>최종결재일</th>
            <th>작성일 </th>
        </tr>
        <tbody id="tableBody">
            <!-- 여기서 리스트출력 -->
        </tbody>
    </table>
</div>
<input type="hidden" id="hiddenPage" value="all">
<div id="page">
    <button type="button" id="first">First</button>
    <button type="button" id="pre">◁</button>
    <button type="button" id="next">▶</button>
    <button type="button" id="last">Last</button>
</div>

<script>
    let currentPage = 1;
    let lastPage = 1;

    $(document).ready(function() {
        loadAllDocList(currentPage);
        
        <!--히든필드를 가져와서 -->
        let hiddenFieldValue = $('#hiddenPage').val();
        console.log(hiddenFieldValue);
        
        // 전체 버튼 클릭 시 전체 기안 리스트 로드
        $("#allBtn").click(function() {
            loadAllDocList(currentPage);
        });
        //결재대기 버튼 클릭시 결재대기 기안리스트 로드
		$("#zeroBtn").click(function() {
			loadZeroDocList(currentPage);
        });
        //승인중 버튼 클릭시 승인중 기안리스트 로드
		$("#oneBtn").click(function() {
			loadOneDocList(currentPage);        
        });
        //승인완료 버튼 클릭시 승인완료 기안리스트 로드
		$("#twoBtn").click(function() {
			loadtwoDocList(currentPage);
		});
        //반려 버튼 클릭시 반려 기안리스트 로드
		$("#nineBtn").click(function() {
			loadNineDocList(currentPage);
		});
        
    	//전체기안서 데이터 
        function loadAllDocList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/allDocList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(json) {
                    updateAllDocList(json);
                },
                error: function(xhr, status, error) {
                    alert("전체기안서를 가져올 수 없습니다.");
                }
            });
        }
        //결재대기 기안서 데이터
        function loadZeroDocList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/zeroDocList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(json) {
                	updateZeroTypeDocList(json)
                },
                error: function(xhr, status, error) {
                    alert("결재대기상태의 기안서를 가져올 수 없습니다.");
                }
            });
        }
        
     	 //승인중 기안서 데이터
        function loadOneDocList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/oneDocList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(json) {
                	updateOneTypeDocList(json)
                },
                error: function(xhr, status, error) {
                    alert("승인중상태의 기안서를 가져올 수 없습니다.");
                }
            });
        }
     	 //승인완료 기안서데이터
     	  function loadtwoDocList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/twoDocList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(json) {
                	updateTwoTypeDocList(json)
                },
                error: function(xhr, status, error) {
                    alert("승인완료상태의 기안서를 가져올 수 없습니다.");
                }
            });
        }
     	//반려 기안서데이터
     	  function loadNineDocList(currentPage) {
            $.ajax({
                url: "${pageContext.request.contextPath}/approval/nineDocList",
                type: "GET",
                data: {
                    currentPage: currentPage,
                    empNo: "${empNo}"
                },
                success: function(json) {
                	updateNineTypeDocList(json)
                },
                error: function(xhr, status, error) {
                    alert("반려상태의 기안서를 가져올 수 없습니다.");
                }
            });
        }
     	 
     	 
     	 
     	 
		//전체
        function updateAllDocList(json) {
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.allDocList, function(index, item) {
                let approvalStateText = '';
                let approvalStateNo = parseInt(item.approvalStateNo);  // 숫자로 변환
                switch (approvalStateNo) {
                    case 0:
                        approvalStateText = '결재대기';
                        break;
                    case 1:
                        approvalStateText = '승인중';
                        break;
                    case 2:
                        approvalStateText = '승인완료';
                        break;
                    case 9:
                        approvalStateText = '반려';
                        break;
                    default:
                        approvalStateText = '알 수 없음';
                }

                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + approvalStateText + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //결재대기상태
        function updateZeroTypeDocList(json) {
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.zeroDocList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + "결재대기" + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //승인중상태
        function updateOneTypeDocList(json) {
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.oneDocList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + "승인중" + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //승인완료상태
        function updateTwoTypeDocList(json) {
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.twoDocList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + "승인완료" + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //반려상태
        function updateNineTypeDocList(json) {
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.nineDocList, function(index, item) {
                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + "반려" + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
    });
</script>
</body>
</html>