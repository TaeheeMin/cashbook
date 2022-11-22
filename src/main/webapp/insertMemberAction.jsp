<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1. 요청분석
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String pw1 = request.getParameter("memberPw1");
	String pw2 = request.getParameter("memberPw2");
	String memberName = request.getParameter("memberName");
	String memberPw = null;
	
	// 작성 확인
	if(memberId == null || pw1 == null || pw2 == null || memberName == null || 
		memberId.equals("") || pw1.equals("") || pw2.equals("") || memberName.equals("")){
		String insertMsg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+insertMsg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// 비밀번호 확인
	if(pw1.equals(pw2)){
		memberPw = pw1;
	} else {
		String msg = URLEncoder.encode("비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	} // 비밀번호 불일치시 메세지, 폼이동
	
	//모델 호출시 매개값, 메서드로 들어가려면 묶어주는게 필요하니까 이걸로 묶어서 param으로 메서드들어감
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);

	// 분리된 m(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member returnMember = memberDao.login(paramMember);
	
	// 로그인 확인 -> 페이지 이동
	String msg = URLEncoder.encode("ID 중복 확인해주세요","utf-8");
	String redirectUrl = "/insertMemberForm.jsp?msg="+msg;
	if(returnMember != null) { // 로그인 결과있음
		System.out.println("가입 성공");
		session.setAttribute("loginMember", returnMember);
		redirectUrl = "/loginForm.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
	%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		
	</body>
</html>