<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg="+msg;
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	// 2. model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
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
			textarea {
				border: 0.5px #a39485 solid;
				font-size: .9em;
				outline: none;
				padding-left: 10px;
				width: 100%;
			}
			button {
				border: 0;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
		
		<div Style="text-align:center;">
			<!-- adbmin 컨텐츠 내용 -->
			<h2>카테고리 목록</h2>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<th>종류</th>
					<th>이름</th>
					<th>수정 닐짜</th>
					<th>생성일</th>
					<th>수정/삭제</th>
				</tr>
				<%
					for(Category c : categoryList) {
						%>
						<tr>
							<td><%=c.getCategoryNo() %></td>
							<td><%=c.getCategoryKind() %></td>
							<td><%=c.getCategoryName() %></td>
							<td><%=c.getUpdatedate() %></td>
							<td><%=c.getUpdatedate() %></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
							</td>
						</tr>
						<%
					}
				
				%>
			</table>
		</div>
		
		<div Style="text-align:center; padding: 4.0em;">
			<h3>카테고리 추가</h3>
			<form method ="post" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<th Style="width:100px;">categoryKind</th>
						<td>
							<input type="radio" name="categoryKind" value="수입">수입
							<input type="radio" name="categoryKind" value="지출">지출
						</td>
					</tr>
					<tr>
						<th>categoryName</th>
						<td>
							<input type="text" name="categoryName" style="width: 100%;">
						</td>
					</tr>
				</table>
				<button type="submit">입력</button>
			</form>
		</div>
	</body>
</html>