package com.gd.foodbee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gd.foodbee.util.AuthorityInterceptor;
import com.gd.foodbee.util.LoginInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer{

	@Autowired
    private AuthorityInterceptor authorityInterceptor;

    @Autowired
    private LoginInterceptor loginInterceptor;
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		// 배포 후 업로드
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///home/ubuntu/upload/");
		// 배포 전 업로드 경로
		 // registry.addResourceHandler("/upload/**")
         //	.addResourceLocations("classpath:/static/upload/");
        
		 registry.addResourceHandler("/css/**")
		 	.addResourceLocations("classpath:/static/css/");
		 registry.addResourceHandler("/js/**")
		 	.addResourceLocations("classpath:/static/js/");
		 registry.addResourceHandler("/plugins/**")
		 	.addResourceLocations("classpath:/static/plugins/");
	}
    
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(loginInterceptor)
			.addPathPatterns("/**")
			.excludePathPatterns("/login", "/logout", "/signup", "/findPw", "/getPw", "/sendEmail", "/css/**", "/js/**", "/upload/**");
		
		registry.addInterceptor(authorityInterceptor)
	        .addPathPatterns(
	            "/attendance/attendanceTeamMember",
	            "/attendance/getAttendanceTeamMemberAll",
	            "/attendance/getAttendanceTeamMemberByStatus",
	            "/attendance/attendanceRejection",
	            "/attendance/attendanceAccept",
	            "/notice/modifyNoticeAction",
	            "/notice/modifyNotice",
	            "/notice/deleteNotice",
	            "/notice/addNoticeAction",
	            "/notice/addNotice",
	            "/board/deleteBoardByAdmin",
	            "/deleteCommentByAdmin",
	            "/emp/addEmp",
	            "/emp/resendEmail",
	            "/emp/resetPw",
	            "/emp/modifyEmpHr",
	            "/approval/forms/revenueForm"
	        );
    }
}
