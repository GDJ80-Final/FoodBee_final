<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
	  <!-- Favicon icon -->	
	<link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Pignose Calender -->
    <link href="${pageContext.request.contextPath}/plugins/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <!-- Chartist -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/chartist/css/chartist.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css">
    <!-- Custom Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
<style>
	.logo-link {
	    display: block;
	    
	     
	}
	
	.logo-img {
	    width: 50%;
	    height: 100%;
	    
	    position: absolute;
	    top: 0;
	    left: 0;
	    
	    
	}
	


</style>
</head>
		<!--*******************
        	Preloader start
    	********************-->
	    <div id="preloader">
	        <div class="loader">
	            <svg class="circular" viewBox="25 25 50 50">
	                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
	            </svg>
	        </div>
	    </div>
	    <!--*******************
	        Preloader end
	    ********************-->
        <!--**********************************
            Nav header start
        ***********************************-->
        <div class="nav-header">
        	<div class="brand-logo">
	          <a href="${pageContext.request.contextPath}/home" class="logo-link">
	            
	            
	            <span class="brand-title">
	                <img src="${pageContext.request.contextPath}/upload/img/logo.png" alt="" id="logo" class="logo-img">
	            </span>
	         </a>
            </div>
        </div>
        <!--**********************************
            Nav header end
        ***********************************-->

        <!--**********************************
            Header start
        ***********************************-->
        <div class="header">    
            <div class="header-content clearfix">
                
                <div class="nav-control">
                    <div class="hamburger">
                        <span class="toggle-icon"><i class="icon-menu"></i></span>
                    </div>
                </div>
                <div class="header-left">
                    <div class="input-group icons">
                        <div class="input-group-prepend">
                           
                        </div>
                        <div class="drop-down animated flipInX d-md-none">
                           
                        </div>
                    </div>
                </div>
                <div class="header-right">
                    <ul class="clearfix">
                
                        
                        <!-- 프로필 -->
                        <li class="icons dropdown">
                            <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
                               
                                <img src="" id="profileImg" height="40" width="40" alt="">
                            </div>
                            <div class="drop-down dropdown-profile animated fadeIn dropdown-menu">
                                <div class="dropdown-content-body">
                                    <ul>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/myPage"><i class="icon-user"></i> <span>마이페이지</span></a>
                                        </li>
                                        <li><a href="${pageContext.request.contextPath}/msg/receivedMsgBox"><i class="icon-envelope-open"></i><span>쪽지함</span></a></li>
                                        
                                        <hr class="my-2">
                                        
             
                                        <li><a href="${pageContext.request.contextPath}/logout"><i class="icon-key"></i> <span>로그아웃</span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
        
        <script>
	        $.ajax({
				url:'${pageContext.request.contextPath}/getProfileImg',
				method:'get',
				success:function(json){
					console.log(json);
					
					$("#profileImg").attr('src', '${pageContext.request.contextPath}/upload/profile_img/' + json);
				}
			});
	        
	        
        </script>
   