<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	// 2. model 호출
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao categoryDao = new CategoryDao();
	Category category = categoryDao.categoryOne(categoryNo); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCategoryForm</title>
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
		<%
			if(loginMember.getMemberLevel() > 0) {
		%>
					<div>
						<!-- Sidebar -->
						<jsp:include page="/inc/adminSideMenu.jsp"></jsp:include>
					</div>
		<%
			} else {
		%>
					<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		<%
			}
		%>
		
   		<div class="content">
   			<!-- Navbar -->
   			<jsp:include page="/inc/adminNav.jsp"></jsp:include>
			
		<div Style="text-align:center; padding: 4.0em;">
			<h3>카테고리 수정</h3>
			<form method ="post" action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp?categoryNo=<%=categoryNo%>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<th>categoryName</th>
						<td>
							<input type="text" name="categoryName" value="<%=category.getCategoryName()%>">
						</td>
					</tr>
				</table>
				<button type="submit">수정</button>
			</form>
		</div>
		</div>
	</body>
</html>