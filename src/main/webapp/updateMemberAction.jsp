<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1. 요청분석
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	// 작성 확인
	if(memberId == null || memberPw == null || memberName == null || 
		memberId.equals("") || memberPw.equals("") || memberName.equals("")){
		String msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+ msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// m호출
	MemberDao memberDao = new MemberDao();
	
	// 중복확인, insert 두 개 필요 -> 중복 false면 insert실행
	String msg = URLEncoder.encode("수정성공","utf-8");
	String redirectUrl = "/updateMemberForm.jsp?msg="+msg;
	int resultRow = memberDao.updateMember(memberId, memberPw, memberName);
	if(resultRow == 1){
		// 중복 존재 -> 가입 폼으로 다시 이동
		System.out.println("updateMember 성공");
	} else {
		// 회원 가입 성공 -> 로그인 폼으로 이동
		msg = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8");
		redirectUrl = "/updateMemberForm.jsp?msg="+msg;
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>update member</title>
	</head>
	
	<body>
	
	</body>
</html>