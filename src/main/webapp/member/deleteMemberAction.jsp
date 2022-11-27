<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	//작성 확인
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || 
		request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		String msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// m 들어갈 값
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberId + "<- delmember memberId");
	
	// m 호출
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.deleteMember(memberId, memberPw);
	System.out.println(resultRow + "<- deleMemberAc resultRow");
	
	String msg = URLEncoder.encode("비밀번호 확인","utf-8");
	String redirectUrl = "/member/deleteMemberForm.jsp?msg="+msg;
	if(resultRow == 1){
		//삭제성공
		msg = URLEncoder.encode("삭제성공","utf-8");
		redirectUrl = "/loginForm.jsp?msg="+msg;
		session.invalidate();
		System.out.println("삭제성공");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);

%>
