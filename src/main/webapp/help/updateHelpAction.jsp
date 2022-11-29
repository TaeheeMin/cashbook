<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	//1.controller
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/help/helpList.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/help/updateHelpForm.jsp?helpNo="+request.getParameter("helpNo")+"&msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo+"<-helpNo");
	String helpMemo = request.getParameter("helpMemo");
	
	// 2. model 호출
	HelpDao helpDao = new HelpDao();
	int updateRow = helpDao.updateHelp(helpMemo, helpNo);
	
	if(updateRow == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>