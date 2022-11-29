<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	//1.controller
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/help/helpList.jsp?msg=";
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo+"<-helpNo");
	
	// 2. model 호출
	HelpDao helpDao = new HelpDao();
	int deleteRow = helpDao.deleteHelp(helpNo);
	
	if(deleteRow == 1){
		msg = URLEncoder.encode("삭제 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>