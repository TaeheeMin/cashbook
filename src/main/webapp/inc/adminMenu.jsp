<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <title>관리자 페이지</title>
	    <meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath()%>/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">
	</head>
	
	<body>
		<div class="container-xxl position-relative bg-white d-flex p-0">
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
	                    <a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="nav-link nav-link"><i class="fa fa-laptop me-2"></i>홈</a>
	                    <a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="nav-item nav-link"><i class="fa fa-th me-2"></i>회원관리</a>
	                    <a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>고객센터 관리</a>
	                    <a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="nav-item nav-link"><i class="fa fa-table me-2"></i>카테고리 관리</a>
                        <a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="nav-link nav-link"><i class="far fa-file-alt me-2"></i>공지관리</a>
	                </div>
	            </nav>
	        </div>
		</div>
		
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
	</body>
</html>