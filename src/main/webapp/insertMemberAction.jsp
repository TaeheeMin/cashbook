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
	paramMember.setMemberId("memberId");
	paramMember.setMemberPw("memberPw");
	paramMember.setMemberName("memberName");
	
	// 분리된 m(모델)을 호출
	MemberDao memberDao = new MemberDao();
	
	// 중복확인, insert 두 개 필요 -> 중복 false면 insert실행
	String msg = URLEncoder.encode("ID 중복! 확인해주세요","utf-8");
	String redirectUrl = "/insertMemberForm.jsp?msg="+msg;
	
	if(memberDao.memeberIdCheck(paramMember.getMemberId())){
		// 중복 존재 -> 가입 폼으로 다시 이동
		System.out.println("아이디 중복");
	} else if(memberDao.insertMemeber(paramMember)) {
		// 회원 가입 성공 -> 로그인 폼으로 이동
		msg = URLEncoder.encode("회원가입 성공","utf-8");
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