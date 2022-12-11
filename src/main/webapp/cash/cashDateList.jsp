<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.lang.StackWalker.Option"%>
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
		<%
			if(loginMember.getMemberLevel() > 0) {
		%>
					<div>
						<!-- Sidebar -->
						<jsp:include page="/inc/adminSideMenu.jsp"></jsp:include>
					</div>
		<%
			} else {
		%>
					<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		<%
			}
		%>
		
   		<div class="content">
			<main>
			
			<div class="col-12">
	            <div class="rounded h-100 p-4">
                    <h1 class="display-6"><%=year%>년 <%=month%> 월 <%=date %>일</h1>

	                <div class="table-responsive">
	                    <table class="table">
	                        <thead>
	                            <tr>
	                                <th scope="col">날짜</th>
	                                <th scope="col">종류</th>
	                                <th scope="col">가격</th>
	                                <th scope="col">메모</th>
	                                <th scope="col">수정삭제</th>
	                            </tr>
	                        </thead>
	                        <tbody>
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
									<td>[<%=(String)m.get("categoryKind")%>] <%=(String)m.get("categoryName")%></td>
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
	                          
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	        
	        <div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 50vh;">
	                <div class="col-12 col-sm-8 col-md-6 col-lg-10 col-xl-10">
	                       <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
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
	                </div>
	               </div>
	              </div>
				<!-- 입력폼 -->

		</main>
		</div>
	</body>
</html>