<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	
	// 1.controller
 
	Member loginMember = (Member)session.getAttribute("login");
	// 로그인관리자를 그냥 통으로 가져옴
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
		<title>관리자 페이지</title>
	</head>
	
	<body>
		<ul>
			<li><a href = "">공지관리</a></li>
			<li><a href = "">카테고리관리</a></li>
			<li><a href = "">회원관리(목록, 레벨수정, 강제탈퇴)</a></li>
		</ul>
	</body>
</html>