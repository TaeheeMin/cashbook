<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
// 내용 받아와야함 내용 하나만 받아오면 되는데 notice로 받아오는 이유는 뭘까???
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동

	String noticeMemo = request.getParameter("noticeMemo");
	
	// model 호출
	NoticeDao noticeDao = new NoticeDao();
	int insertRow = noticeDao.insertNotice(noticeMemo);
	
	if(insertRow == 1){
		msg = URLEncoder.encode("등록 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>
