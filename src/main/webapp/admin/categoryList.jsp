<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg="+msg;
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	// 2. model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
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
			
		<div Style="text-align:center;">
			<!-- adbmin 컨텐츠 내용 -->
			<h2>카테고리 목록</h2>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<th>종류</th>
					<th>이름</th>
					<th>수정 닐짜</th>
					<th>생성일</th>
					<th>수정/삭제</th>
				</tr>
				<%
					for(Category c : categoryList) {
						%>
						<tr>
							<td><%=c.getCategoryNo() %></td>
							<td><%=c.getCategoryKind() %></td>
							<td><%=c.getCategoryName() %></td>
							<td><%=c.getUpdatedate() %></td>
							<td><%=c.getUpdatedate() %></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
							</td>
						</tr>
						<%
					}
				
				%>
			</table>
		</div>
		
		<div Style="text-align:center; padding: 4.0em;">
			<h3>카테고리 추가</h3>
			<form method ="post" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<th Style="width:100px;">categoryKind</th>
						<td>
							<input type="radio" name="categoryKind" value="수입">수입
							<input type="radio" name="categoryKind" value="지출">지출
						</td>
					</tr>
					<tr>
						<th>categoryName</th>
						<td>
							<input type="text" name="categoryName" style="width: 100%;">
						</td>
					</tr>
				</table>
				<button type="submit">입력</button>
			</form>
		</div>
		</div>
	</body>
</html>