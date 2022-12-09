<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<div class="sidebar pe-4 pb-3">
	<!-- Sidebar Start -->
	<div class="sidebar pe-4 pb-3">
		<nav class="navbar bg-light navbar-light">
	        <a href="" class="navbar-brand mx-4 mb-3">
	            <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>CASH BOOK</h3>
	        </a>
	        
	        <div class="d-flex align-items-center ms-4 mb-4">
	            <div class="position-relative">
		            <img class="rounded-circle" src="<%=request.getContextPath()%>/img/profile.png" alt="" style="width: 40px; height: 40px;">
				    <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
				</div>
				<div class="ms-3">
	    			<h6 class="mb-0"><%=loginMember.getMemberName()%>님&nbsp;</h6>
					<span><%=loginMember.getMemberId()%></span>
		    	</div>
			</div>
				
			<div class="navbar-nav w-100">
			    <a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="nav-link nav-link"><i class="menu__icon fa fa-home"></i>홈</a>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="nav-item nav-link"><i class="fa fa-th me-2"></i>회원관리</a>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>고객센터 관리</a>
				<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="nav-item nav-link"><i class="fa fa-table me-2"></i>카테고리 관리</a>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="nav-link nav-link"><i class="far fa-file-alt me-2"></i>공지관리</a>
        	</div>
	    </nav>
	</div>
</div>
		