<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<div class="sidebar pe-4 pb-3">
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
				<nav class="menu">
					<a class="nav-link nav-link" href="<%=request.getContextPath()%>/cash/cashMain.jsp">
						<i class="fa fa-home"></i>
						<span class="menu__text">홈</span>
					</a>
					<a class="nav-link nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
						<i class="fa fa-calendar"></i>
						<span class="menu__text">calendar</span>
					</a>
					<a class="nav-link nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
						<i class="fa fa-envelope"></i>
						<span class="menu__text">고객센터</span>
					</a>
					<a class="nav-link nav-link" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">
					    <i class="fa fa-sliders"></i>
					    <span class="menu__text">my profile</span>
					</a>
					<a class="nav-link nav-link" href="#">
						<i class="fa fa-list"></i>
						<span class="menu__text">미정</span>
					</a>
					<a class="nav-link nav-link" href="#">
						<i class="fa fa-bar-chart"></i>
						<span class="menu__text">미정</span>
					</a>
					<a class="nav-link nav-link" href="<%=request.getContextPath()%>/logout.jsp">
						<i class="fa fa-trophy"></i>
						<span class="menu__text">logout</span>
					</a>
				</nav>
			</div>
		</nav>
    </div>
</div>
