<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	// 2. model 호출
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao categoryDao = new CategoryDao();
	Category category = categoryDao.categoryOne(categoryNo); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCategoryForm</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
		<style>
			body {
				padding: 4.5em;
				background: #f5f5f5
			}
			table {
			 	border: 1px #a39485 solid;
				font-size: .9em;
				box-shadow: 0 2px 5px rgba(0,0,0,.25);
				border-collapse: collapse;
				border-radius: 5px;
				margin-left: auto; 
				margin-right: auto;
				width: 50%;
			}
			a {
				text-decoration: none;
			}
			button {
				border: 0;
			}
			input {
				width: 100%;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
		
		<div Style="text-align:center; padding: 4.0em;">
			<h3>카테고리 수정</h3>
			<form method ="post" action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp?categoryNo=<%=categoryNo%>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<th>categoryName</th>
						<td>
							<input type="text" name="categoryName" value="<%=category.getCategoryName()%>">
						</td>
					</tr>
				</table>
				<button type="submit">수정</button>
			</form>
		</div>
	</body>
</html>