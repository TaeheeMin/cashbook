<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	String rdirectUrl = "/admin/adminMain.jsp";
	String msg = URLEncoder.encode("관리자 페이지입니다.","utf-8");
	
	// 로그인 세션 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		rdirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+rdirectUrl);
		return;
	}
	// 2. model
	// 최근 공지 5개, 최근멤버 5명
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
	</head>
	
	<body>
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/adminMain.jsp">관리자 페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=1">공지관리</a></li> <!-- notice 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li> <!-- category 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">회원관리</a></li>
			<li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
		</ul>
		<div>
			<!-- adbmin 컨텐츠 내용 -->
			
		</div>
	</body>
</html>