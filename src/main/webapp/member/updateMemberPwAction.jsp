<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");
	String redirectUrl = "/member/updateMemberForm.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")
		|| request.getParameter("memberPw1") == null || request.getParameter("memberPw1").equals("")
		|| request.getParameter("memberPw2") == null || request.getParameter("memberPw2").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/member/updateMemberForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	String memberPw = request.getParameter("memberPw");
	String memberNewPw1 = request.getParameter("memberPw1");
	String memberNewPw2 = request.getParameter("memberPw2");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId+"<-memberId");
	
	// 비밀번호 확인
	String newMemberPw = null;
	if(memberNewPw1.equals(memberNewPw2)){
		newMemberPw = memberNewPw1;
	} else {
		msg = URLEncoder.encode("비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	} // 비밀번호 불일치시 메세지, 폼이동
	
	MemberDao memberDao = new MemberDao();
	int updateRow = memberDao.updatePwMember(memberId, newMemberPw, memberPw);
	System.out.println(updateRow+"<-updateRow");
	if(updateRow == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>
