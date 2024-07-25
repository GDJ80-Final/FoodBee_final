<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<td><c:out value="${stateBox.zeroState == null ? 0 : stateBox.zeroState}"></c:out>건</td>
			<td><c:out value="${stateBox.oneState == null ? 0 : stateBox.oneState}"></c:out>건</td>
			<td><c:out value="${stateBox.twoState == null ? 0 : stateBox.twoState}"></c:out>건</td>
			<td><c:out value="${stateBox.nineState == null ? 0 : stateBox.nineState}"></c:out>건</td>
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
			<th>현재상태</th>
			<th>중간결재일</th>
			<th>중간상태</th>
			<th>최종결재일</th>
			<th>최종상태</th>
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
            loadAllDocList(1);
        });
        //결재대기 버튼 클릭시 결재대기 기안리스트 로드
		$("#zeroBtn").click(function() {
			loadZeroDocList(1);
        });
        //승인중 버튼 클릭시 승인중 기안리스트 로드
		$("#oneBtn").click(function() {
			loadOneDocList(1);        
        });
        //승인완료 버튼 클릭시 승인완료 기안리스트 로드
		$("#twoBtn").click(function() {
			loadtwoDocList(1);
		});
        //반려 버튼 클릭시 반려 기안리스트 로드
		$("#nineBtn").click(function() {
			loadNineDocList(1);
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
                error: function() {
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
                error: function() {
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
                error: function() {
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
                error: function() {
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
                error: function() {
                    alert("반려상태의 기안서를 가져올 수 없습니다.");
                }
            });
        }
     	 
     	 //중간승인자&최종승인자의 승인상태값
     	 function getApprovalStateText(stateNo) {
             let stateText = '';
             switch (parseInt(stateNo)) {
                 case 1:
                     stateText = '승인전';
                     break;
                 case 2:
                     stateText = '승인완료';
                     break;
                 case 9:
                     stateText = '반려';
                     break;
                 default:
                     stateText = '알 수 없음';
             }
             return stateText;
         }
     	 
		//전체
        function updateAllDocList(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.allDocLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "allTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();
			
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
                //승인자의 중간상태값, 최종상태값
                let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);	          
   				
                let modifyButton = approvalStateNo === 0 ? `<a href=""><button>수정하기</button></a>` : '';

                let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.title + "</td>" +
                        "<td>" + approvalStateText + 
                        "<br>" + modifyButton + "</td>" +
                        "<td>" + item.midApprovalDatetime + "</td>" +
                        "<td>" + midApprovalState + "</td>" +
                        "<td>" + item.finalApprovalDatetime + "</td>" +
                        "<td>" + finalApprovalState + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //결재대기상태
        function updateZeroTypeDocList(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.zeroDocLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "zeroTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();
			
			
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.zeroDocList, function(index, item) {
            	//중간승인자의 상태값, 최종승인자의 상태값
            	 let midApprovalState = getApprovalStateText(item.midApprovalState);
                 let finalApprovalState = getApprovalStateText(item.finalApprovalState);	
            	
                 let modifyButton = `<a href=""><button>수정하기</button></a>`;
                let newRow = $("<tr>" +
                		 "<td>" + item.tmpName + "</td>" +
                         "<td>" + item.title + "</td>" +
                         "<td>" + "결재대기" + "<br>" + modifyButton + "</td>" +
                         "<td>" + item.midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + item.finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //승인중상태
        function updateOneTypeDocList(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.oneDocLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "oneTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();
			
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.oneDocList, function(index, item) {
            	//중간승인자의 상태값, 최종승인자의 상태값
           	 	let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
            	
                let newRow = $("<tr>" +
                		 "<td>" + item.tmpName + "</td>" +
                         "<td>" + item.title + "</td>" +
                         "<td>" + "승인중" + "</td>" +
                         "<td>" + item.midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + item.finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //승인완료상태
        function updateTwoTypeDocList(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.twoDocLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "twoTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();
			
			
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.twoDocList, function(index, item) {
            	//중간승인자의 상태값, 최종승인자의 상태값
           	 	let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
                
                let newRow = $("<tr>" +
                		 "<td>" + item.tmpName + "</td>" +
                         "<td>" + item.title + "</td>" +
                         "<td>" + "승인완료" + "</td>" +
                         "<td>" + item.midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + item.finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        //반려상태
        function updateNineTypeDocList(json) {
        	<!-- DB 조회해온 last 페이지 순번 -->
        	lastPage = json.nineDocLastPage;
			console.log('lastPage : ' + lastPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
        	hiddenFieldValue = "nineTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
			updateBtnState();
			
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            $.each(json.nineDocList, function(index, item) {
            	//중간승인자의 상태값, 최종승인자의 상태값
           	 	let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
                
                let newRow = $("<tr>" +
                		 "<td>" + item.tmpName + "</td>" +
                         "<td>" + item.title + "</td>" +
                         "<td>" + "반려" + "</td>" +
                         "<td>" + item.midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + item.finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
            });
            
            $("#tableBody").show();
        }
        
        <!-- pre 버튼 클릭 시 동작 -->
        $('#pre').click(function() {
  		   console.log('pre click : ' + currentPage);
  		 if (currentPage > 1) {
     		  currentPage = currentPage - 1;
     		 if (hiddenFieldValue === "allTypeDoc") {
				  console.log("allTypeDoc");
				  loadAllDocList(currentPage);
		      } else if (hiddenFieldValue === "zeroTypeDoc") {
				  console.log("zeroTypeDoc");
				  loadZeroDocList(currentPage);
		      } else if (hiddenFieldValue === "oneTypeDoc") {
				  console.log("oneTypeDoc");
				  loadOneDocList(currentPage);
		      } else if (hiddenFieldValue === "twoTypeDoc") {
				  console.log("twoTypeDoc");
				  loadtwoDocList(currentPage);
		      } else if (hiddenFieldValue === "nineTypeDoc") {
				  console.log("nineTypeDoc");
				  loadNineDocList(currentPage);
		      }
		   }
        });

        <!-- next 버튼 클릭 시 동작 -->
        $('#next').click(function() {
  			console.log('next click : ' + currentPage);

  			 if (currentPage < lastPage) {
  	            currentPage = currentPage + 1;
	  	          if (hiddenFieldValue === "allTypeDoc") {
	 				  console.log("allTypeDoc");
	 				  loadAllDocList(currentPage);
	 		      } else if (hiddenFieldValue === "zeroTypeDoc") {
	 				  console.log("zeroTypeDoc");
	 				  loadZeroDocList(currentPage);
	 		      } else if (hiddenFieldValue === "oneTypeDoc") {
	 				  console.log("oneTypeDoc");
	 				  loadOneDocList(currentPage);
	 		      } else if (hiddenFieldValue === "twoTypeDoc") {
	 				  console.log("twoTypeDoc");
	 				  loadtwoDocList(currentPage);
	 		      } else if (hiddenFieldValue === "nineTypeDoc") {
	 				  console.log("nineTypeDoc");
	 				  loadNineDocList(currentPage);
	 		      }
  	         }
        });
        <!-- first 버튼 클릭 시 동작 -->
        $('#first').click(function() {
  			console.log('first click : ' + currentPage);

  		  if (currentPage > 1) {
              currentPage = 1;
              if (hiddenFieldValue === "allTypeDoc") {
 				  console.log("allTypeDoc");
 				  loadAllDocList(currentPage);
 		      } else if (hiddenFieldValue === "zeroTypeDoc") {
 				  console.log("zeroTypeDoc");
 				  loadZeroDocList(currentPage);
 		      } else if (hiddenFieldValue === "oneTypeDoc") {
 				  console.log("oneTypeDoc");
 				  loadOneDocList(currentPage);
 		      } else if (hiddenFieldValue === "twoTypeDoc") {
 				  console.log("twoTypeDoc");
 				  loadtwoDocList(currentPage);
 		      } else if (hiddenFieldValue === "nineTypeDoc") {
 				  console.log("nineTypeDoc");
 				  loadNineDocList(currentPage);
 		      }
           }
        });
        <!-- last 버튼 클릭 시 동작 -->
        $('#last').click(function() {
      	  
  			console.log('last click : ' + currentPage);

  			 if (currentPage < lastPage) {
  	            currentPage = lastPage
	  	          if (hiddenFieldValue === "allTypeDoc") {
	 				  console.log("allTypeDoc");
	 				  loadAllDocList(currentPage);
	 		      } else if (hiddenFieldValue === "zeroTypeDoc") {
	 				  console.log("zeroTypeDoc");
	 				  loadZeroDocList(currentPage);
	 		      } else if (hiddenFieldValue === "oneTypeDoc") {
	 				  console.log("oneTypeDoc");
	 				  loadOneDocList(currentPage);
	 		      } else if (hiddenFieldValue === "twoTypeDoc") {
	 				  console.log("twoTypeDoc");
	 				  loadtwoDocList(currentPage);
	 		      } else if (hiddenFieldValue === "nineTypeDoc") {
	 				  console.log("nineTypeDoc");
	 				  loadNineDocList(currentPage);
	 		      }
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
    });
</script>
</body>
</html>