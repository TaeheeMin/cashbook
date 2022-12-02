<%@page import="javax.print.attribute.standard.NumberOfDocuments"%>
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
	
	// 2. model : notice List
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	
	int noticeCount = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)noticeCount / (double)rowPerPage);
	System.out.println(noticeCount + "<-noticeCount/" + lastPage + "lastPage" );
	

	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList</title>
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
   			
			<!-- adbmin 컨텐츠 내용 -->
			<h1 Style="text-align:center;"></h1>
			<div>
				<table class="table table-bordered">
					<tr Style="text-align:center;">
						<th>번호</th>
						<th>공지내용</th>
						<th>작성일</th>
						<th>수정삭제</th>
					</tr>
					<%
						for(Notice n : list){
						%>
							<tr>
								<td Style="text-align:center; width:100px;"><%=n.getNoticeNo()%></td>
								<td><%=n.getNoticeMemo() %></td>
								<td style="text-align:center; width:200px;"><%=n.getCreatedate() %></td>
								<td style="text-align:center; width:200px;">
									<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
									<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a>
									<a href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
								</td>
							</tr>
						<%
						}
					%>
				</table>
				
				<div style="text-align:center;">
				<!-- 페이징 -->
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
				</div>
			</div>
			
			<div Style="padding: 4.0em;">
				<!-- 입력폼 -->
				<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
					<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
					<table class="table table-bordered">
						<tr>
							<th style="text-align:center;">공지등록</th>
							<td>
								<textarea rows="5" cols="150" name="noticeMemo"></textarea>
							</td>
					</table>
					<div class="position-relative">
					    <button type="submit" class="position-absolute top-100 start-50 translate-middle">등록</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>