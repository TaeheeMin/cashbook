<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/main.jsp");
%>
<!-- Navbar Start -->
<nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
	<a href="<%=request.getContextPath()%>/admin/admin.jsp" class="navbar-brand d-flex d-lg-none me-4">
		<h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
	</a>

	<a href="#" class="sidebar-toggler flex-shrink-0">
		<i class="fa fa-bars"></i>
	</a>

	<form class="d-none d-md-flex ms-4" >
		<input class="form-control border-0" type="search" placeholder="Search" name="word">
	</form>

	<div class="navbar-nav align-items-center ms-auto">
		<div class="nav-item dropdown ms-auto">
			<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
				<img class="rounded-circle me-lg-2" src="<%=request.getContextPath()%>/img/profile.png" alt="" style="width: 40px; height: 40px;">
				<span class="d-none d-lg-inline-flex"><%=loginMember.getMemberName()%></span>
			</a>

			<div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
				<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="dropdown-item">My Profile</a>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="dropdown-item">Settings</a>
				<a href="<%=request.getContextPath()%>/logout.jsp" class="dropdown-item">Log Out</a>
      				</div>
  				</div>
 			</div>
</nav>
<!-- Navbar End -->