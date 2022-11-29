<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	String redirectUrl = "/help/helpList.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String helpMemo = request.getParameter("helpMemo");
	
	Help help = new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	
	// Model : 문의 등록
	HelpDao helpDao = new HelpDao();
	
	// model 호출
	int insertRow = helpDao.insertHelp(help);
	
	if(insertRow == 1){
		msg = URLEncoder.encode("등록 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		
	</body>
</html>