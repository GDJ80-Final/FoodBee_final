<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수신함</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>수신함</h1>
<div>
    <table border="1">
        <tr>
            <th>결재대기</th>
            <th>승인중</th>
            <th>승인완료</th>
            <th>반려</th>
        </tr>
        <tr>
            <td><c:out value="${stateBox.zeroState == null ? 0 : stateBox.zeroState}"></c:out>건</td>
            <td><c:out value="${stateBox.oneState == null ? 0 : stateBox.oneState}"></c:out>건</td>
            <td><c:out value="${stateBox.twoState == null ? 0 : stateBox.twoState}"></c:out>건</td>
            <td><c:out value="${stateBox.nineState == null ? 0 : stateBox.nineState}"></c:out>건</td>
        </tr>
    </table>
</div>
<button>전체</button>
<div>
    <table border="1">
        <tr>
            <th>양식유형</th>
            <th>기안자</th>
            <th>제목</th>
            <th>결재상태</th>
            <th>기안일시</th>
        </tr>
        <tbody id="t">
            <!-- 여기서 리스트출력 -->
        </tbody>
    </table>
<div id="page">
    <button type="button" id="first">First</button>
    <button type="button" id="pre">◁</button>
    <button type="button" id="next">▶</button>
    <button type="button" id="last">Last</button>
</div>
<script>
	let currentPage = 1;
	let lastPage = 1;
	
	$(document).ready(function(){
		loadAllList(currentPage);
		
		function loadAllList(currentPage){
			$.ajax({
				url: "${pageContext.request.contextPath}/approval/inBoxList",
				type: "GET",
				data: {
					currentPage : currentPage,
					empNo: "${empNo}"
				},
				success: function(json){
					updateAllList(json);
				},
				error: function(){
					alert("수신함의 리스트를 가져올 수 없습니다");
				}
			})
		}
		
		function updateAllList(json){
			lastPage = json.listLastPage;
			console.log('lastPage : '+ lastPage);
			
			let tableBody = $("#t");
			tableBody.empty();
			
			$.each(json.referrerList, function(index, item){
				let approvalStateText = '';
                let docApprovalStateNo = parseInt(item.docApproverStateNo);  // 숫자로 변환
                switch (docApprovalStateNo) {
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
                        "<td>" + item.empName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + approvalStateText + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
				tableBody.append(newRow);
			});
			
			$("#tableBody").show();
		}
		
		$('#pre').click(function() {
			console.log('pre click : ' + currentPage);
			if (currentPage > 1) {
				currentPage = currentPage - 1;
				loadAllList(currentPage)
			}
		});

		$('#next').click(function() {
			console.log('next click : ' + currentPage);
			if (currentPage < lastPage) {
				currentPage = currentPage + 1;
				loadAllList(currentPage)
			}
		});

		$('#first').click(function() {
			console.log('first click : ' + currentPage);
			
			if (currentPage > 1) {
				currentPage = 1;
				loadAllList(currentPage)
			}
		});
		
		$('#last').click(function() {
			console.log('last click : ' + currentPage);
			if (currentPage < lastPage) {
				currentPage = lastPage
				loadAllList(currentPage)
			}
		});
		// 버튼 활성화
        function updateBtnState() {
           console.log("update");
           <!-- 현재 페이지와 마지막 페이지 값에 따른 버튼 비활성화 처리-->
           <!-- prop은 설정의 속성-->
             $('#pre').prop('disabled', currentPage === 1);
             $('#next').prop('disabled', currentPage === lastPage);
             $('#first').prop('disabled', currentPage === 1);
             $('#last').prop('disabled', currentPage === lastPage);
         }
	})
</script>
</div>
</body>
</html>
