<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	//1.controller
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/helpListAll.jsp?msg=";
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println(commentNo+"<-commentNo");
	
	// 2. model 호출
	CommentDao commentDao = new CommentDao();
	int deleteRow = commentDao.deleteComment(commentNo);
	
	if(deleteRow == 1){
		msg = URLEncoder.encode("삭제 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>