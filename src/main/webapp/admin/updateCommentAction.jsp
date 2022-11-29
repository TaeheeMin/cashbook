<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	//1.controller
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/helpListAll.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/admin/updateCommentForm.jsp?commentNo="+request.getParameter("commentNo")+"&msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println(commentNo+"<-commentMemo");
	String commentMemo = request.getParameter("commentMemo");
	
	// 2. model 호출
	CommentDao commentDao = new CommentDao();
	int updateRow = commentDao.updateComment(commentMemo, commentNo);
	
	if(updateRow == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>