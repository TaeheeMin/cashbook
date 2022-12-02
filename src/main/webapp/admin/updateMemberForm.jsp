<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/memberList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	// 2. model
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	Member memberOne = memberDao.memberOneByAdmin(memberNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath()%>/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
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
   			<!-- Navbar -->
   			<jsp:include page="/inc/adminNav.jsp"></jsp:include>
		
			<div>
				<h3 Style="text-align:center;">회원 수정</h3>
				<form method="post" action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp">
					<input type="hidden" name="memberNo" value="<%=memberOne.getMemberNo()%>">
					<table class="table table-bordered" Style="width:50%;">
						<tr>
							<td Style="text-align:center;">아이디</td>
							<td>
								<input type="text" name="memberId" readonly="readonly" value="<%=memberOne.getMemberId()%>" style="width: 100%;">
							</td>
						</tr>
						<tr>
							<td Style="text-align:center;">이름</td>
							<td>
								<input type="text" name="memberName" value="<%=memberOne.getMemberName()%>" style="width: 100%;">
							</td>
						</tr>
						<tr>
							<td Style="text-align:center;">회원 레벨</td>
							<td>
							<%
								if(memberOne.getMemberLevel() == 0) {
									%>
									<input type="radio" name="memberLevel" value="0" checked>일반
									<input type="radio" name="memberLevel" value="1">관리자
									<%
								} else {
									%>
									<input type="radio" name="memberLevel" value="0">일반
									<input type="radio" name="memberLevel" value="1" checked>관리자
									<%
								}
							%>
							</td>
							
						</tr>
					</table>
					<div class="position-relative" Style="padding: 1.0em;">
						<button type="submit" class="position-absolute top-100 start-50 translate-middle">수정</button>
					</div>
					
				</form>
			</div>
		</div>
	</body>
</html>