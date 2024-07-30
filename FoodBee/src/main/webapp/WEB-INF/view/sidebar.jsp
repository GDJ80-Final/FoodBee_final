<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	   	<!--**********************************
            Sidebar start
        ***********************************-->
        <div class="nk-sidebar">           
            <div class="nk-nav-scroll">
                <ul class="metismenu" id="menu">
                    <li class="nav-label">MENU</li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                           <i class="icon-envelope menu-icon"></i> <span class="nav-text">쪽지함</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/msg/receivedMsgBox">받은 쪽지함</a></li>
                            <li><a href="${pageContext.request.contextPath}/msg/sentMsgBox">보낸 쪽지함</a></li>
                            <li><a href="${pageContext.request.contextPath}/msg/trashMsgBox">휴지통 쪽지함</a></li>
                            
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">사원</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/emp/empList">사원 조회</a></li>
                            <li><a href="${pageContext.request.contextPath}/emp/addEmp">사원 초대</a></li>
                        </ul>
                    </li>
            
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-screen-tablet menu-icon"></i><span class="nav-text">일정</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/calendar/schedule">Calender</a></li>
                            <li><a href="${pageContext.request.contextPath}/calendar/scheduleList">일정 조회</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-note menu-icon"></i><span class="nav-text">결재</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/approval/forms/basicForm">기안 작성</a></li>
                            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">내 문서함</a>
                                <ul aria-expanded="false">
                                    <li><a href="${pageContext.request.contextPath}/approval/draftBox">기안함</a></li>
                                    <li><a href="${pageContext.request.contextPath}/approval/inBox">수신 참조함</a></li>
                                    <li><a href="${pageContext.request.contextPath}/approval/approvalBox">결재함</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                 	<li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-notebook menu-icon"></i><span class="nav-text">근태 관리</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/attendance/attendancePersonal">근태 조회</a></li>
                            <li><a href="${pageContext.request.contextPath}/attendance/attendanceTeamMember">팀내 근태 조회</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">예약</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/room/roomList" aria-expanded="false">회의실 조회</a></li>
                            <li><a href="${pageContext.request.contextPath}/room/myRoomRsvList" aria-expanded="false">예약 조회</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-graph menu-icon"></i> <span class="nav-text">매출</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/revenue/monthRevenue">전체 조회</a></li>
                            <li><a href="${pageContext.request.contextPath}/revenue/categoryRevenue">품목별 조회</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">커뮤니티</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="${pageContext.request.contextPath}/community/notice/noticeList">공지사항</a></li>
                            <li><a href="${pageContext.request.contextPath}/community/board/boardList">사내 익명게시판</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!--**********************************
            Sidebar end
        ***********************************-->
                          