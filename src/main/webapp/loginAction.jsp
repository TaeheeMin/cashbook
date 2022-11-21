<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	// c
	Member paramMember = new Member(); //모델 호출시 매개값
	
	// 분리된 m(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member returnMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	
	if(returnMember != null) {
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", returnMember);
		redirectUrl = "/cash/cashList.jsp";
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Action</title>
	</head>
	
	<body>
		
	</body>
</html>