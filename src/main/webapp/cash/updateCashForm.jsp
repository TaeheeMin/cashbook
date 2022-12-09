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
		<link  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/NewFile.css">
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
 		<!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">
	
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
	
		<div class="wrapper">
		
   			<main>
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
		</main>
  			<!-- 사이드바 -->
			<jsp:include page="/inc/member.jsp"></jsp:include>
		</div>
	</body>
</html>