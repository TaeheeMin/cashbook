<%@page import="java.lang.StackWalker.Option"%>
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
	
	// 날짜별 내용(상세 내용 다나오면 되겠지?)수정, 삭제, 추가
	request.setCharacterEncoding("utf-8");
	// 값없을때 list로 돌아가는거 작성필요!!!
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("day"));
	System.out.println("date : " + date);
	System.out.println("month : " + month);
	System.out.println("year ; " + year);

	
	// Model : 일별 cash목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// Model : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cash Date List</title>
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
	
	<%
			if(loginMember.getMemberLevel() > 0) {
		%>
				<!-- Sidebar -->
				<jsp:include page="/inc/adminSideMenu.jsp"></jsp:include>
		<%
			} else {
		%>
				<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		<%
			}
		%>
		<div>
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		</div>
		
		<h1><%=year%>년 <%=month+1%> 월 <%=date %>일</h1>
		<div>
			<!-- 입력폼 -->
			<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
				<table class="table table-bordered">
					<tr>
						<td Style="width: 200px;">categoryNo</td>
						<td>
							<select name="catagoryNo">
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
						<td Style="width: 200px;">cashDate</td>
						<td>
							<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td Style="width: 200px;">cashPrice</td>
						<td>
							<input type="text" name="cashPrice">
						</td>
					</tr>
					<tr>
						<td Style="width: 200px;">cashMemo</td>
						<td>
							<textarea rows="5" cols="10" name="cashMemo"></textarea>
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit" class="position-absolute bottom-0 start-50 translate-middle-x">입력</button>
				</div>
			</form>
		</div>
		
		<div Style="padding: 1.0em;">
			<table class="table table-bordered">
				<tr>
					<th>cashDate</th>
					<th>categoryKind</th>
					<th>categoryName</th>
					<th>cashPrice</th>
					<th>cashMemo</th>
					<th>Action</th>
				</tr>
					<%
					//날짜별 수입지출
					for(HashMap<String, Object> m : dateList){
						String cashDate = (String)m.get("cashDate");
						System.out.println((String)m.get("cashDate"));
	
						if(Integer.parseInt(cashDate.substring(8)) == date) {
						int cashNo = (Integer)m.get("cashNo");
					%>
					<tr>
						<td><%=(String)m.get("cashDate")%></td>
						<td>[<%=(String)m.get("categoryKind")%>]</td>
						<td><%=(String)m.get("categoryName")%></td>
						<td><%=(Integer)m.get("cashPrice")%>원</td>
						<td><%=(String)m.get("cashMemo")%></td>
						<td>
							<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year %>&month=<%=month %>&day=<%=date %>">수정</a>
							<a href="<%=request.getContextPath()%>/cash/deleteCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year %>&month=<%=month %>&day=<%=date %>">삭제</a>
						</td>
					</tr>
					<%
						}
					}
					%>
			</table>
		</div>
	</body>
</html>