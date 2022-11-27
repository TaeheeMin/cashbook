<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	request.setCharacterEncoding("utf-8");
	System.out.println(request.getParameter("cashNo")+"<-updateForm cashNo값");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	// 필요정보 받아오기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	String date = request.getParameter("day");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// Model : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	Cash cashOne = cashDao.cashOne(loginMember.getMemberId(), cashNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>update cash form</title>
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
	</head>
	
	<body>
		<h1><%=year%>년 <%=month+1%> 월 <%=date %>일</h1>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
			<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">내정보수정</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
		
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo %>" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<table border="1">
				<tr>
					<td>categoryNo</td>
					<td>
						<select name="categoryNo">
							<%
								for(Category c : categoryList){
							%>
									<option value="<%=c.getCategoryNo()%>">
										<%=c.getCategoryKind()%> <%=c.getCategoryName()%> 
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
						<input type="text" name="cashDate" value="<%=cashOne.getCashDate()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name="cashPrice" value="<%=cashOne.getCashPrice() %>">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="5" cols="100" name="cashMemo" ><%=cashOne.getCashMemo()%></textarea>
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