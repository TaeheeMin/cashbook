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
	/* 
	// Model : 카테고리 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> categoryList = cashDao.seleCategoryList();
	 */
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<!-- 입력폼 -->
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<table border="1">
				<tr>
					<td>categoryNo</td>
					<td>
						<select name="catagoryNo">
							<%
								/*
								// 카테고리 넘버
								for(Category c : categoryList) {
									%>
										<option value="<%=%>">
										</option>
									<%
								}
							 	*/
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="5" cols="10" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="submit">입력</button>
		</form>
		<table border="1">
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
			%>
				<tr>
					<td>
						<%=(String)m.get("cashDate")%>
					</td>
					<td>
						[<%=(String)m.get("categoryKind")%>]
					</td>
					<td>
						<%=(String)m.get("categoryName")%>
					</td>
					<td>
						<%=(Integer)m.get("cashPrice")%>원
					</td>
					<td>
						<%=(String)m.get("cashMemo")%>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>">수정</a>
						<a href="<%=request.getContextPath()%>">삭제</a>
					</td>
				</tr>
			<%
					}
				}
			%>
		</table>
		
	</body>
</html>