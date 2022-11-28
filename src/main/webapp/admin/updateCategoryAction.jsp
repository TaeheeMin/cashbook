<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("수정 실패","utf-8");
	String redirectUrl = "/admin/categoryList.jsp?msg=";

	// 작성 확인
	if((request.getParameter("categoryName") == null || request.getParameter("categoryName").equals(""))){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/admin/updateNoticeForm.jsp?categoryNo="+request.getParameter("categoryNo")+"&msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
		
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	//String categoryKind = request.getParameter("categoryKind");
	//System.out.println(categoryKind+"<-categoryKind");
	
	CategoryDao categoryDao = new CategoryDao();
	int updateRow = categoryDao.updateCategory(categoryNo, categoryName);
	
	if(updateRow == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>