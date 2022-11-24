<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	// 필요정보 받아오기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("day"));
	 
	// 방어코드
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+ month + "&day="+date);
		return;
	}
	
	// 한 날짜 값을 가져와서 그걸로 폼 값 넣어주고 수정 진행
	CashDao cashDao = new CashDao();
	Cash cashOne = cashDao.cashOne(loginMember.getMemberId(), cashNo);
			
	// Model : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
 
 /*
 	Cash paramCash = new Cash();
	paramCash.setCsahNo(csahNo);
	paramCash.setMemberId(memberId);

	CashDao cashDao = new CashDao();
	Cash resultCash = cashDao.oneCash(paramCash);
	
	// Category 정보 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	*/
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
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<input type="hidden" name="cashNo" value="<%=cashNo %>">
			<input type="hidden" name="year" value="<%=year %>">
			<input type="hidden" name="month" value="<%=month %>">
			<input type="hidden" name="date" value="<%=date %>">
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
						<!--  카테고리 수정도 가능해야하니까 카테고리도 가져와야힘 -->
						<select name="catagoryNo" >
							<%
								// 카테고리 넘버
								for(Category c : categoryList) {
									System.out.println(cashOne.getCategoryNo());
									%>
										<option value="<%=cashOne.getCategoryNo()%>">
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
						<input type="text" name="cashDate" value="<%=cashOne.getCashDate()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name="cashPrice" value="<%=cashOne.getCsahPrice() %>">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="5" cols="10" name="cashMemo" ><%=cashOne.getCsahMemo() %></textarea>
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