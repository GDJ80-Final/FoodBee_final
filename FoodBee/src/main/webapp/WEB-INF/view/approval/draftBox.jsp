<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 메인템플릿 -->
<div id="main-wrapper">
<!-- 템플릿 헤더,사이드바 -->
<jsp:include page="/WEB-INF/view/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/sidebar.jsp"></jsp:include>
<!-- 템플릿 div -->
<div class="content-body">
   <div class="row page-titles mx-0">
         <div class="col p-md-0">
             <ol class="breadcrumb">
                 <li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">내문서함</a></li>
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">기안함</a></li>
             </ol>
         </div>
      </div>
   
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12">
             <div class="card">
                <div class="card-body">   
                <!-- 여기서부터 내용시작 -->
                  <div class="table-responsive mb-3">
                     <table class="table header-border">
                        <tr class="table-info">
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
                  <ul class="nav nav-tabs mb-3">
                            <li class="nav-item"><a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false" id="allBtn">전체</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false" id="zeroBtn">결재대기</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="oneBtn">승인중</a>
                            </li>
                            <li class="nav-item"><a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="twoBtn">승인완료</a>
                            </li>
                             <li class="nav-item"><a href="#navpills-3" class="nav-link" data-toggle="tab" aria-expanded="true" id="nineBtn">반려</a>
                            </li>
                        </ul>
                  <div id="table-body" class="table-responsive">
                      <table class="table header-border">
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
                  <!-- panel & page -->
                  <div class="bootstrap-pagination mt-3" id="page">
                        <nav>
                            <ul class="pagination justify-content-center">
                                <li class="page-item"><button type="button" id="first" class="page-link">처음</button>
                                </li>
                                <li class="page-item"><button type="button" class="page-link" id="pre">이전</button>
                                </li>
                                <li class="page-item active"><div class="page-link" id="currentPage"></div>
                                </li>
                                <li class="page-item"><button type="button" class="page-link" id="next">다음</button>
                                </li>
                                <li class="page-item"><button type="button" class="page-link" id="last">마지막</button>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- 모달창 -->
                     <div class="modal fade" id="rejectionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                         <div class="modal-dialog" role="document">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h5 class="modal-title" id="exampleModalLabel">반려 이유 확인</h5>
                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                         <span aria-hidden="true">&times;</span>
                                     </button>
                                 </div>
                                 <div class="modal-body">
                                     <!-- 반려 이유가 표시될 영역 -->
 
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                 </div>
                             </div>
                         </div>
                     </div>
                  <!-- 여기가 내용끝! -->       
                    </div>
                </div>
            </div>
        </div>
   </div>
</div><!-- content-body마지막 -->
</div><!-- 메인마지막 -->
<!-- 템플릿 footer -->
<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
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
                   console.log("Ajax 요청 성공:", json); 
                   $('#currentPage').text(currentPage);
                    updateAllDocList(json);
                },
                error: function() {
                   console.log("Ajax 요청 실패:", json); 
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
                   $('#currentPage').text(currentPage);
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
                   $('#currentPage').text(currentPage);
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
                   $('#currentPage').text(currentPage);
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
                   $('#currentPage').text(currentPage);
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
                 case 0:
                     stateText = '승인전';
                     break;
                 case 1:
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

      //전체
        function updateAllDocList(json) {
         
         console.log('json : ' +  JSON.stringify(json));
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
            
            
            if(json.allDocList == ""){
               tableBody.append("<tr><td colspan='9'>작성한 기안서가 없습니다</td></tr>");
            }else{
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
                
                //승인날짜 null값 표시
                let midApprovalDatetime = item.midApprovalDatetime;
                if(midApprovalDatetime === null){
                   midApprovalDatetime = "승인전";
                }
                let finalApprovalDatetime = item.finalApprovalDatetime;
                if(finalApprovalDatetime === null){
                   finalApprovalDatetime = "승인전";
                }
                
               
                let modifyButton = approvalStateNo === 0 ? `<button class='badge badge-danger px-2'>수정가능</button>` : '';
                let rejectionButton = approvalStateNo === 9 ? `<button class='badge badge-warning px-2'>이유확인</button>` : '';
                
                // 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
            
                let newRow = $("<tr>" +
                		"<td>" + item.tmpName + "</td>" +
                	    "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                	    "<td>" + approvalStateText + 
                	    "<br><a href='" + detailUrl + "'>" + modifyButton + "</a>" +
                	    "<a href='" + detailUrl + "'>" + rejectionButton + "</a></td>" +
                	    "<td>" + midApprovalDatetime + "</td>" +
                	    "<td>" + midApprovalState + "</td>" +
                	    "<td>" + finalApprovalDatetime + "</td>" +
                	    "<td>" + finalApprovalState + "</td>" +
                	    "<td>" + item.createDatetime + "</td>" +
                	    "</tr>");
                
                      tableBody.append(newRow);

                 });
                  
            	}
            
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
            
            
            if(json.zeroDocList == ""){
               tableBody.append("<tr><td colspan='8'>결재대기상태의 기안서가 없습니다</td></tr>");
            }else{
            $.each(json.zeroDocList, function(index, item) {
               //중간승인자의 상태값, 최종승인자의 상태값
                let midApprovalState = getApprovalStateText(item.midApprovalState);
                 let finalApprovalState = getApprovalStateText(item.finalApprovalState);   
                 
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

                 let modifyButton = approvalStateNo === 0 ? `<button class='badge badge-danger px-2'>수정가능</button>` : '';
                //승인날짜 null값 표시
                 let midApprovalDatetime = item.midApprovalDatetime;
                 if(midApprovalDatetime === null){
                    midApprovalDatetime = "승인전";
                 }
                 let finalApprovalDatetime = item.finalApprovalDatetime;
                 if(finalApprovalDatetime === null){
                    finalApprovalDatetime = "승인전";
                 }
                // 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
                let newRow = $("<tr>" +
                       "<td>" + item.tmpName + "</td>" +
                       "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                         "<td>" + "결재대기" + "<br>" + 
                         "<br><a href='" + detailUrl + "'>" + modifyButton + "</a></td>" +
                         "<td>" + midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
                 });
            }
            
            $("#tableBody").show();
        }
        //승인중상태
        function updateOneTypeDocList(json) {
           <!-- DB 조회해온 last 페이지 순번 -->
           lastPage = json.oneDocLastPage;
         console.log('승인중 lastPage : ' + lastPage);
         console.log('승인중 currentPage:' + currentPage);
            <!-- hiddenFieldValue 값을 개인으로 세팅 -->
           hiddenFieldValue = "oneTypeDoc"
            console.log("hiddenFieldValue : " + hiddenFieldValue);
            <!-- 버튼 활성화 함수(updateBtnState) 실행 -->
         updateBtnState();
         
            let tableBody = $("#tableBody");
            tableBody.empty();
            
            if(json.oneDocList == ""){
               tableBody.append("<tr><td colspan='8'>승인중상태의 기안서가 없습니다</td></tr>");
            }else{
            $.each(json.oneDocList, function(index, item) {
               //중간승인자의 상태값, 최종승인자의 상태값
                  let midApprovalState = getApprovalStateText(item.midApprovalState);
               
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
                //승인날짜 null값 표시
                let midApprovalDatetime = item.midApprovalDatetime;
                if(midApprovalDatetime === null){
                   midApprovalDatetime = "승인전";
                }
                let finalApprovalDatetime = item.finalApprovalDatetime;
                if(finalApprovalDatetime === null){
                   finalApprovalDatetime = "승인전";
                }
                
                // 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
                let newRow = $("<tr>" +
                       "<td>" + item.tmpName + "</td>" +
                       "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                         "<td>" + "승인중" + "</td>" +
                         "<td>" + midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
            });
            }
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
            
            if(json.twoDocList == ""){
               tableBody.append("<tr><td colspan='5'>>승인완료상태의 기안서가 없습니다</td></tr>");
            }else{
            $.each(json.twoDocList, function(index, item) {
               //중간승인자의 상태값, 최종승인자의 상태값
                  let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
                
                //승인날짜 null값 표시
                let midApprovalDatetime = item.midApprovalDatetime;
                if(midApprovalDatetime === null){
                   midApprovalDatetime = "승인전";
                }
                let finalApprovalDatetime = item.finalApprovalDatetime;
                if(finalApprovalDatetime === null){
                   finalApprovalDatetime = "승인전";
                }
                
                // 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
                let newRow = $("<tr>" +
                       "<td>" + item.tmpName + "</td>" +
                       "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                         "<td>" + "승인완료" + "</td>" +
                         "<td>" + midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
               });
            }
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
            
            if(json.nineDocList == ""){
               tableBody.append("<tr><td colspan='8'>반려상태의 기안서가 없습니다</td></tr>");
            }else{
            $.each(json.nineDocList, function(index, item) {
               //중간승인자의 상태값, 최종승인자의 상태값
                  let midApprovalState = getApprovalStateText(item.midApprovalState);
                let finalApprovalState = getApprovalStateText(item.finalApprovalState);
                
                //승인날짜 null값 표시
                let midApprovalDatetime = item.midApprovalDatetime;
                if(midApprovalDatetime === null){
                   midApprovalDatetime = "승인전";
                }
                let finalApprovalDatetime = item.finalApprovalDatetime;
                if(finalApprovalDatetime === null){
                   finalApprovalDatetime = "승인전";
                }
                
                
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
                
                let rejectionButton = approvalStateNo === 9 ? `<button class='badge badge-warning px-2'>이유확인</button>` : '';
                
               // 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
               
                let newRow = $("<tr>" +
                       "<td>" + item.tmpName + "</td>" +
                       "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                         "<td>" + "반려" + 
                         "<br>" + "<a href='" + detailUrl + "'>" + rejectionButton + "</a></td>" +
                         "<td>" + midApprovalDatetime + "</td>" +
                         "<td>" + midApprovalState + "</td>" +
                         "<td>" + finalApprovalDatetime + "</td>" +
                         "<td>" + finalApprovalState + "</td>" +
                         "<td>" + item.createDatetime + "</td>" +
                         "</tr>");
                
                tableBody.append(newRow);
               });
            }
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
        
      //페이징 버튼 활성화
        function updateBtnState() {
            console.log("update");
         // 현재 페이지가 1이면 '이전' 및 '처음' 버튼 비활성화
            $('#pre').closest('li').toggleClass('disabled', currentPage === 1);
            $('#first').closest('li').toggleClass('disabled', currentPage === 1);

            // lastPage가 0이면 '다음' 및 '마지막' 버튼 비활성화
            if (lastPage === 0) {
                $('#next').closest('li').addClass('disabled');
                $('#last').closest('li').addClass('disabled');
            } else {
                // 현재 페이지가 마지막 페이지와 같으면 '다음' 및 '마지막' 버튼 비활성화
                $('#next').closest('li').toggleClass('disabled', currentPage === lastPage);
                $('#last').closest('li').toggleClass('disabled', currentPage === lastPage);
            }
        }
    });
</script>
</body>
</html>