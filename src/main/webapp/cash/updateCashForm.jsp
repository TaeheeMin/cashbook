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
			}
			a {
				text-decoration : none;
			}
			button {
				border: 0;
			}
			textarea {
				border: 0.5px #a39485 solid;
				font-size: .9em;
				outline: none;
				padding-left: 10px;
				width: 100%;
			}
			input {
				width: 100%;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		</div>
		
		<h1><%=year%>년 <%=month+1%> 월 <%=date %>일</h1>
		
		<div>
			<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo %>" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="date" value="<%=date%>">
				<table class="table table-bordered">
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
				</table>
				
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit" class="position-absolute top-100 start-50 translate-middle">UPDATE</button>
				</div>
			</form>
		</div>
	</body>
</html>