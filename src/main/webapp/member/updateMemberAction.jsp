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
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+ msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// m 들어갈 member
	Member paramUpdate = new Member();
	paramUpdate.setMemberId(memberId);
	paramUpdate.setMemberPw(memberPw);
	paramUpdate.setMemberName(memberName);
	
	// 정보 수정 후 세션 이름 변경 위한 member
	Member loginMember = new Member();
	loginMember.setMemberId(memberId);
	loginMember.setMemberName(memberName);

	// m호출
	MemberDao memberDao = new MemberDao();

	String msg = URLEncoder.encode("수정성공","utf-8");
	String redirectUrl = "/member/updateMemberForm.jsp?msg=";
	int resultRow = memberDao.updateMember(paramUpdate);
	if(resultRow == 1){
		// 수정 성공 -> 폼으로 이동
		System.out.println("updateMember 성공");
		session.setAttribute("loginMember", loginMember);
	} else {
		// 수정 실패 -> 폼으로 이동
		msg = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8");
		redirectUrl = "/member/updateMemberForm.jsp?msg=";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>