<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println(memberNo+"<-noticeNo");
	
	// m 호출
	MemberDao memberDao = new MemberDao();
	int deleteRow = memberDao.deleteMemberByAdmin(memberNo);
	
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/memberList.jsp?msg=";
	
	if(deleteRow == 1){
		msg = URLEncoder.encode("삭제 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>
