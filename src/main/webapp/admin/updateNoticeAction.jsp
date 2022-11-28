<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");

	String msg = null;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-noticeNo");
	String noticeMemo = request.getParameter("noticeMemo");
	
	// 작성 확인
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/admin/updateNoticeForm.jsp?noticeNo="+noticeNo+"&msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// model 호출
	NoticeDao noticeDao = new NoticeDao();
	int updateRow = noticeDao.updateNotice(noticeNo, noticeMemo);
	
	if(updateRow == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>