<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	String redirectUrl = "/admin/categoryList.jsp?msg=";
	System.out.println(request.getParameter("categoryKind"));
	System.out.println(request.getParameter("categoryName"));
	
	// 작성 확인
	if(request.getParameter("categoryKind") == null ||  request.getParameter("categoryName") == null
		|| request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동

	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	// model 호출
	CategoryDao categoryDao = new CategoryDao();
	int insertRow = categoryDao.insertCategory(category);
	
	if(insertRow == 1){
		msg = URLEncoder.encode("등록 성공","utf-8");
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
	}
%>
