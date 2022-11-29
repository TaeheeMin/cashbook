<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	String redirectUrl = "/admin/helpListAll.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String commentMemo = request.getParameter("commentMemo");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Comment comment = new Comment();
	comment.setCommentMemo(commentMemo);
	comment.setHelpNo(helpNo);
	comment.setMemberId(memberId);
	
	// 2. model 호출
	CommentDao commentDao = new CommentDao();
	int insertRow = commentDao.insertComment(comment);

	if(insertRow == 1){
		msg = URLEncoder.encode("등록 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>