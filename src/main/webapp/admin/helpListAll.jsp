<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	
	// 2. model
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	int count = helpDao.selectHelpCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage);
	System.out.println(count + "<-count/" + lastPage + "lastPage" );
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>help List All</title>
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
			
		
		<div>
			<table class="table table-bordered">
				<tr>
					<th>문의 내용</th>
					<th>회원ID</th>
					<th>작성일</th>
					<th>답변</th>
					<th>답변 작성일</th>
					<th>수정삭제</th>
				</tr>
				<%
				for(HashMap<String, Object> m : list){
				%>
					<tr>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<%
							if(m.get("commentMemo") != null) {
							%>
								<td><%=m.get("commentMemo")%></td>
								<td><%=m.get("commentCreatedate")%></td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>">답변수정</a>
									<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>"">답변삭제</a>
								</td>
							<%
							} else {
							%>
								<td> </td>
								<td> </td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변등록</a>
								</td>
							<%
							}
							%>
					</tr>
					<%
					}
					%>
			</table>
			<div style="text-align:center;">
				<!-- 페이징 -->
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
		</div>
	</body>
</html>