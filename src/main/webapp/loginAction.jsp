<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	//1. 요정분석 : 로그인 사용할 아이디와 비밀번호 입력받아 사용
	request.setCharacterEncoding("utf-8");
	// 작성 확인
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")){
		System.out.println("1.로그인실패");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	String id = request.getParameter("memberId");
	String pw = request.getParameter("memberPw");
		
	// c
	//모델 호출시 매개값, 메서드로 들어가려면 묶어주는게 필요하니까 이걸로 묶어서 param으로 메서드들어감
	Member paramMember = new Member();
	paramMember.setMemberId(id);
	paramMember.setMemberPw(pw);
	
	// 분리된 m(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member returnMember = memberDao.login(paramMember);
	// 메서드에서 결과값(resultMember)을 returnMember에 넣어서 가져옴

	// 로그인 확인 -> 페이지 이동
	String redirectUrl = "/loginForm.jsp";
	if(returnMember != null) { // 로그인 결과있음
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