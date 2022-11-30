<%@page import="javax.print.attribute.standard.NumberOfDocuments"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println("로그인중");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	
	int count = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage); // 구하기
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Form</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	
	    <!-- Favicon -->
	    <link href="img/favicon.ico" rel="icon">
	
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="resources/css/style.css" rel="stylesheet">
		
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
	</head>
	
	<body>
		<div class="container-xxl position-relative bg-white d-flex p-0">
	        <!-- Sign In Start -->
	        <div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
	                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
	                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
	                        <div class="d-flex align-items-center justify-content-between mb-3">
	                            <a href="<%=request.getContextPath() %>/main.jsp" class="">
	                                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>CashBook</h3>
	                            </a>
	                            <h3>로그인</h3>
	                        </div>
	                        
	                        <form action="<%=request.getContextPath()%>/loginAction.jsp">
		                        <div class="form-floating mb-3">
		                            <input type="text" class="form-control" name="memberId" id="floatingInput" placeholder="ID">
		                            <label for="floatingInput">ID</label>
		                        </div>
		                        
		                        <div class="form-floating mb-4">
		                            <input type="password" class="form-control" name="memberPw" id="floatingPassword" placeholder="Password">
		                            <label for="floatingPassword">Password</label>
		                        </div>
		                        
		                        <button type="submit" class="btn btn-primary py-3 w-100 mb-4">로그인</button>
		                        <p class="text-center mb-0">아직 회원이 아니신가요? <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a></p>
	                        </form>
                    	</div>
                	</div>
            	</div>
        	</div>
        	<!-- Sign In End -->
		</div>

	    <!-- JavaScript Libraries -->
	    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="resources/lib/chart/chart.min.js"></script>
	    <script src="resources/lib/easing/easing.min.js"></script>
	    <script src="resources/lib/waypoints/waypoints.min.js"></script>
	    <script src="resources/lib/owlcarousel/owl.carousel.min.js"></script>
	    <script src="resources/lib/tempusdominus/js/moment.min.js"></script>
	    <script src="resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
	    <script src="resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
	
	    <!-- Template Javascript -->
	    <script src="resources/js/main.js"></script>
	</body>
</html>