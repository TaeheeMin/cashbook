<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
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

		<nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
  			<div class="container-fluid">
  			
    			<a href="#" class="navbar-nav me-auto">
          			<h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>CASH BOOK</h3>
           		</a>
    			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
     				<span class="navbar-toggler-icon"></span>
   				</button>
   				
    			<div class="collapse navbar-collapse" id="mynavbar">
      				<ul class="navbar-nav me-auto">
        				<li class="nav-item">
          					<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
        				</li>
        				<li class="nav-item">
         					 <a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">정보수정</a>
        				</li>
        				<li class="nav-item">
          					<a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a>
        				</li>
        				<li class="nav-item">
          					<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
        				</li>
      				</ul>
      				
      				 <div class="nav-item dropdown ms-auto">
		        		<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
		            		<img class="rounded-circle me-lg-2" src="<%=request.getContextPath()%>/img/profile.png" alt="" style="width: 40px; height: 40px;">
		           			<span class="d-none d-lg-inline-flex"><%=loginMember.getMemberName()%></span>
		        		</a>
		        		
		        		<div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
				            <a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="dropdown-item">My Profile</a>
				            <a href="<%=request.getContextPath()%>/help/helpList.jsp" class="dropdown-item">Help</a>
				            <a href="<%=request.getContextPath()%>/logout.jsp" class="dropdown-item">Log Out</a>
		        		</div>
		   			 </div>
    			</div>
 			</div>
		</nav>
		
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