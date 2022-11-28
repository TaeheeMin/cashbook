<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	String redirectUrl = "/admin/categoryList.jsp?msg=";
	
	// 작성 확인
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")){
		msg = URLEncoder.encode("삭제실패", "utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	
	// model 호출
	CategoryDao categoryDao = new CategoryDao();
	int deleteRow = categoryDao.deleteCategory(category);
	
	if(deleteRow == 1){
		msg = URLEncoder.encode("삭제 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>