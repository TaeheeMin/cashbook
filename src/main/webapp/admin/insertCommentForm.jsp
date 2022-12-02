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
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	
	// 2. model
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo+"<-helpNo");
	
	Help paramhelp = new Help();
	paramhelp.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help insertComment = helpDao.helpOne(paramhelp);

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert comment</title>
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
				<h3 style="text-align:center;">문의</h3>
				<table class="table table-bordered">
					<tr>
						<td style="width:100px;">작성자</td>
						<td>
							<%=insertComment.getMemberId()%>
						</td>
					</tr>
					<tr>
						<td style="width:100px;">내용</td>
						<td>
							<%=insertComment.getHelpMemo() %>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 입력폼 -->
			<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
				<input type="hidden" value="<%=insertComment.getHelpNo()%>" name="helpNo">
				<table class="table table-bordered">
					<tr>
						<td style="text-align:center;">답변등록</td>
						<td>
							<textarea rows="5" cols="150" name="commentMemo"></textarea>
						</td>
				</table>
				<div class="position-relative">
				    <button type="submit" class="position-absolute top-100 start-50 translate-middle">등록</button>
				</div>
			</form>
		</div>
	</body>
</html>