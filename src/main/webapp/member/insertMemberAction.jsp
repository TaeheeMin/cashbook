<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1. controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String pw1 = request.getParameter("memberPw1");
	String pw2 = request.getParameter("memberPw2");
	String memberName = request.getParameter("memberName");
	String memberPw = null;
	String msg = null;
	String redirectUrl = "/member/insertMemberForm.jsp?msg="+msg;
	
	// 작성 확인
	if(memberId == null || pw1 == null || pw2 == null || memberName == null || 
		memberId.equals("") || pw1.equals("") || pw2.equals("") || memberName.equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg="+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// 비밀번호 확인
	if(pw1.equals(pw2)){
		memberPw = pw1;
	} else {
		msg = URLEncoder.encode("비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg="+msg);
		return;
	} // 비밀번호 불일치시 메세지, 폼이동
	
	// 객체생성 -> 모델 호출시 매개값
	Member insertMember = new Member();
	insertMember.setMemberId(memberId);
	insertMember.setMemberPw(memberPw);
	insertMember.setMemberName(memberName);

	// 2. model
	// 분리된 m(모델)을 호출 -> 중복확인, insert 두 개 필요
	MemberDao memberDao = new MemberDao();
	int checkRow = memberDao.memeberIdCheck(memberId);
	System.out.println("insertMemberAction checkRow : " + checkRow);
	
	if(checkRow == 1){
		msg = URLEncoder.encode("ID 중복! 확인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	int resultRow = memberDao.insertMemeber(insertMember);
	System.out.println("insertMemberAction resultRow : " + resultRow);
	if(resultRow == 1){
		// 회원 가입 성공 -> 로그인 폼으로 이동
		msg = URLEncoder.encode("회원가입 성공","utf-8");
		redirectUrl = "/loginForm.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>