<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-noticeNo");

	// m 호출
	NoticeDao noticeDao = new NoticeDao();
	int deleteRow = noticeDao.deleteNotice(noticeNo);
	
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(deleteRow == 1){
		msg = URLEncoder.encode("삭제 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>