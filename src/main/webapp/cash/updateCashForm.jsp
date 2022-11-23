<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
 	
			
	// Model : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	// 하나값을 가져와서 그걸로 폼 작서 
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<table border="1">
				<tr>
					<td>categoryNo</td>
					<td>
						<!--  카테고리 수정도 가능해야하니까 카테고리도 가져와야힘 -->
						<select name="catagoryNo" >
							<%
								// 카테고리 넘버
								for(Category c : categoryList) {
									%>
										<option value="<%=c.getCategoryNo()%>">
											[<%=c.getCategoryKind()%>] <%=c.getCategoryName()%>
										</option>
									<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td>
						<input type="text" name="cashDate" value="" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name="cashPrice" value="">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="5" cols="10" name="cashMemo"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan ="2">
						<button type="submit">UPDATE</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>