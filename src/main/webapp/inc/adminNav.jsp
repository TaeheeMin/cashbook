<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
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

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/chart/chart.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/easing/easing.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/waypoints/waypoints.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/tempusdominus/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Template Javascript -->
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>