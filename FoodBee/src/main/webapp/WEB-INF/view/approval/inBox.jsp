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
                 <li class="breadcrumb-item active"><a href="javascript:void(0)">수신함</a></li>
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
                            <li class="nav-item"><a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false">전체</a>
                            </li>
                        </ul>
						<div class="table-responsive">
						    <table class="table header-border">
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
					$('#currentPage').text(currentPage);
					updateAllList(json);
				},
				error: function(){
				}
			})
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
		
		function updateAllList(json){
			lastPage = json.listLastPage;
			console.log('수신참조lastPage : '+ lastPage);
			console.log('수신참조 currentPage: '+ currentPage);
			
			let tableBody = $("#t");
			tableBody.empty();
			//버튼 활성화
			updateBtnState();
			
			if(json.referrerList == ""){
            	tableBody.append("<tr><td colspan='5'>수신참조된 기안서가 없습니다</td></tr>");
            }else{
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
                
         		// 상세보기 페이지 URL 설정
                let detailUrl = getDetailUrl(item.tmpName, item.draftDocNo);
				let newRow = $("<tr>" +
                        "<td>" + item.tmpName + "</td>" +
                        "<td>" + item.empName + "</td>" +
                        "<td><a href='" + detailUrl + "'>" + item.title + "</a></td>" +
                        "<td>" + approvalStateText + "</td>" +
                        "<td>" + item.createDatetime + "</td>" +
                        "</tr>");
				tableBody.append(newRow);
				});
           	}
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
	})
</script>
</div>
</body>
</html>
